Content-Type: multipart/mixed; boundary="===============2477124862978763620=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] ublox: netreg: Also subscribe to UREG URC's
Date: Sun, 29 Sep 2019 21:48:52 +0200
Message-ID: <CAHB-PjmWm=p+xmtQdHmk_+gPtHS5nD8=upes+AAKGKYusUqq2w@mail.gmail.com>
In-Reply-To: <20190929193953.23524-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2477124862978763620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a log showing why this is needed, no CREG for more than 30 minutes
when changing tech from UTRAN to E-UTRAN.

This happens on a L210, but as I understood Jonas, and comments
in the code, the L4xx suffers from similar issues, so I added this for both
L4
and L2.


Sep 23 21:45:37 info : Aux: < \r\n+CIEV: 2,3\r\n
Sep 23 21:59:29 info : Aux: < \r\n+CGREG: 4\r\n
Sep 23 21:59:29 debug : ../git/src/gprs.c:ofono_gprs_status_notify()
/ublox_0 status unknown (4)
Sep 23 21:59:29 debug : ../git/src/gprs.c:ofono_gprs_detached_notify()
/ublox_0
Sep 23 21:59:29 info : Aux: < \r\n+UREG: 0\r\n
Sep 23 21:59:29 info : Aux: < \r\n+CIEV: 9,1\r\n

We get an UREG URC indicating E-UTRAN,.

Sep 23 21:59:29 info : Aux: < \r\n+UREG: 7\r\n
Sep 23 21:59:29 info : Aux: < \r\n+CIEV: 9,2\r\n
Sep 23 21:59:29 info : Aux: < \r\n+CGEV: NW MODIFY 1,0,0\r\n
Sep 23 21:59:31 info : Aux: < \r\n+CIEV: 2,2\r\n
Sep 23 21:59:39 info : Aux: < \r\n+CIEV: 2,3\r\n
Sep 23 21:59:44 info : Aux: < \r\n+CIEV: 2,2\r\n
Sep 23 22:01:38 info : Aux: < \r\n+CIEV: 2,3\r\n
Sep 23 22:01:43 info : Aux: < \r\n+CIEV: 2,2\r\n

CREG After 30+ minutes!! Indicating UTRAN (which is incorrect, but worked
around in another commit)

Sep 23 22:29:39 info : Aux: < \r\n+CREG: 5,"0000","00000000",6\r\n

BR
Richard

Den s=C3=B6n 29 sep. 2019 kl 21:40 skrev <richard.rojfors@gmail.com>:

> From: Richard R=C3=B6jfors <richard@puffinpack.se>
>
> It turns out that both L2xx and L4xx modems are a bit
> buggy when it comes to send CREG URC's when the tech changes.
> Try to overcome this by subscribing to both UREG and CREG,
> and poll the other when any of the URC's are received.
> Protect from doing simultanious polls though.
> ---
>  drivers/ubloxmodem/network-registration.c | 198 ++++++++++++++++------
>  1 file changed, 148 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/ubloxmodem/network-registration.c
> b/drivers/ubloxmodem/network-registration.c
> index 69af4644..ad905fb3 100644
> --- a/drivers/ubloxmodem/network-registration.c
> +++ b/drivers/ubloxmodem/network-registration.c
> @@ -47,11 +47,15 @@
>  static const char *none_prefix[] =3D { NULL };
>  static const char *cmer_prefix[] =3D { "+CMER:", NULL };
>  static const char *ureg_prefix[] =3D { "+UREG:", NULL };
> +static const char *creg_prefix[] =3D { "+CREG:", NULL };
> +
> +#define UBLOX_UPDATING_STATUS 0x01
>
>  struct netreg_data {
>         struct at_netreg_data at_data;
>
>         const struct ublox_model *model;
> +       int flags;
>  };
>
>  struct tech_query {
> @@ -213,13 +217,72 @@ static void ctze_notify(GAtResult *result, gpointer
> user_data)
>         ofono_netreg_time_notify(netreg, &nd->time);
>  }
>
> -static void ublox_query_tech_cb(gboolean ok, GAtResult *result,
> +static int ublox_ureg_state_to_tech(int state)
> +{
> +       switch (state) {
> +       case 1:
> +               return ACCESS_TECHNOLOGY_GSM;
> +       case 2:
> +               return ACCESS_TECHNOLOGY_GSM_EGPRS;
> +       case 3:
> +               return ACCESS_TECHNOLOGY_UTRAN;
> +       case 4:
> +               return ACCESS_TECHNOLOGY_UTRAN_HSDPA;
> +       case 5:
> +               return ACCESS_TECHNOLOGY_UTRAN_HSUPA;
> +       case 6:
> +               return ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
> +       case 7:
> +               return ACCESS_TECHNOLOGY_EUTRAN;
> +       case 8:
> +               return ACCESS_TECHNOLOGY_GSM;
> +       case 9:
> +               return ACCESS_TECHNOLOGY_GSM_EGPRS;
> +       default:
> +               /* Not registered for PS (0) or something unknown (>9)...
> */
> +               return -1;
> +       }
> +}
> +
> +static gboolean is_registered(int status)
> +{
> +       return status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
> +               status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING;
> +}
> +
> +static void ublox_creg_cb(gboolean ok, GAtResult *result,
> +                               gpointer user_data)
> +{
> +       struct tech_query *tq =3D user_data;
> +       struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
> +       int status, lac, ci, tech;
> +
> +       nd->flags &=3D ~UBLOX_UPDATING_STATUS;
> +
> +       if (!ok)
> +               return;
> +
> +       if (at_util_parse_reg(result, "+CREG:", NULL, &status,
> +                               &lac, &ci, &tech, OFONO_VENDOR_GENERIC) =
=3D=3D
> FALSE)
> +               return;
> +
> +       /* The query provided a tech, use that */
> +       if (is_registered(status) && tq->tech !=3D -1)
> +               tech =3D tq->tech;
> +
> +       ofono_netreg_status_notify(tq->netreg, status, lac, ci, tech);
> +}
> +
> +static void ublox_ureg_cb(gboolean ok, GAtResult *result,
>                                                         gpointer user_dat=
a)
>  {
>         struct tech_query *tq =3D user_data;
> +       struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
>         GAtResultIter iter;
>         gint enabled, state;
> -       int tech =3D -1;
> +       int tech =3D tq->tech;
> +
> +       nd->flags &=3D ~UBLOX_UPDATING_STATUS;
>
>         if (!ok)
>                 goto error;
> @@ -235,48 +298,49 @@ static void ublox_query_tech_cb(gboolean ok,
> GAtResult *result,
>         if (!g_at_result_iter_next_number(&iter, &state))
>                 return;
>
> -       switch (state) {
> -       case 0:
> -               /* Not registered for PS, then we have to trust CREG... */
> -               tech =3D tq->tech;
> -               break;
> -       case 1:
> -               tech =3D ACCESS_TECHNOLOGY_GSM;
> -               break;
> -       case 2:
> -               tech =3D ACCESS_TECHNOLOGY_GSM_EGPRS;
> -               break;
> -       case 3:
> -               tech =3D ACCESS_TECHNOLOGY_UTRAN;
> -               break;
> -       case 4:
> -               tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA;
> -               break;
> -       case 5:
> -               tech =3D ACCESS_TECHNOLOGY_UTRAN_HSUPA;
> -               break;
> -       case 6:
> -               tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
> -               break;
> -       case 7:
> -               tech =3D ACCESS_TECHNOLOGY_EUTRAN;
> -               break;
> -       case 8:
> -               tech =3D ACCESS_TECHNOLOGY_GSM;
> -               break;
> -       case 9:
> -               tech =3D ACCESS_TECHNOLOGY_GSM_EGPRS;
> -               break;
> -       default:
> -               /* Not registered for PS or something unknown, trust
> CREG... */
> +       tech =3D ublox_ureg_state_to_tech(state);
> +       if (tech < 0)
> +               /* No valid UREG status, we have to trust CREG... */
>                 tech =3D tq->tech;
> -       }
>
>  error:
>         ofono_netreg_status_notify(tq->netreg,
>                         tq->status, tq->lac, tq->ci, tech);
>  }
>
> +static void ureg_notify(GAtResult *result, gpointer user_data)
> +{
> +       struct ofono_netreg *netreg =3D user_data;
> +       int state;
> +       struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
> +       struct tech_query *tq;
> +       GAtResultIter iter;
> +
> +       if (nd->flags & UBLOX_UPDATING_STATUS)
> +               return;
> +
> +       g_at_result_iter_init(&iter, result);
> +
> +       if (!g_at_result_iter_next(&iter, "+UREG:"))
> +               return;
> +
> +       if (!g_at_result_iter_next_number(&iter, &state))
> +               return;
> +
> +       tq =3D g_new0(struct tech_query, 1);
> +
> +       tq->tech =3D ublox_ureg_state_to_tech(state);
> +       tq->netreg =3D netreg;
> +
> +       if (g_at_chat_send(nd->at_data.chat, "AT+CREG?", creg_prefix,
> +                       ublox_creg_cb, tq, g_free) > 0) {
> +               nd->flags |=3D UBLOX_UPDATING_STATUS;
> +               return;
> +       }
> +
> +       g_free(tq);
> +}
> +
>  static void creg_notify(GAtResult *result, gpointer user_data)
>  {
>         struct ofono_netreg *netreg =3D user_data;
> @@ -284,11 +348,14 @@ static void creg_notify(GAtResult *result, gpointer
> user_data)
>         struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
>         struct tech_query *tq;
>
> +       if (nd->flags & UBLOX_UPDATING_STATUS)
> +               return;
> +
>         if (at_util_parse_reg_unsolicited(result, "+CREG:", &status,
>                         &lac, &ci, &tech, OFONO_VENDOR_GENERIC) =3D=3D FA=
LSE)
>                 return;
>
> -       if (status !=3D 1 && status !=3D 5)
> +       if (!is_registered(status))
>                 goto notify;
>
>         if (ublox_is_toby_l4(nd->model) || ublox_is_toby_l2(nd->model)) {
> @@ -301,13 +368,15 @@ static void creg_notify(GAtResult *result, gpointer
> user_data)
>                 tq->netreg =3D netreg;
>
>                 if (g_at_chat_send(nd->at_data.chat, "AT+UREG?",
> ureg_prefix,
> -                               ublox_query_tech_cb, tq, g_free) > 0)
> +                               ublox_ureg_cb, tq, g_free) > 0) {
> +                       nd->flags |=3D UBLOX_UPDATING_STATUS;
>                         return;
> +               }
>
>                 g_free(tq);
>         }
>
> -       if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
> +       if (tech =3D=3D -1)
>                 tech =3D nd->at_data.tech;
>
>  notify:
> @@ -322,24 +391,56 @@ static void at_cmer_not_supported(struct
> ofono_netreg *netreg)
>         ofono_netreg_remove(netreg);
>  }
>
> +static void ublox_finish_registration(struct ofono_netreg *netreg)
> +{
> +       struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
> +
> +       if (ublox_is_toby_l4(nd->model) || ublox_is_toby_l2(nd->model))
> +               g_at_chat_register(nd->at_data.chat, "+UREG:",
> +                                       ureg_notify, FALSE, netreg, NULL);
> +
> +       g_at_chat_register(nd->at_data.chat, "+CIEV:",
> +                       ciev_notify, FALSE, netreg, NULL);
> +
> +       g_at_chat_register(nd->at_data.chat, "+CREG:",
> +                               creg_notify, FALSE, netreg, NULL);
> +
> +       ofono_netreg_register(netreg);
> +}
> +
> +static void ublox_ureg_set_cb(gboolean ok,
> +                               GAtResult *result, gpointer user_data)
> +{
> +       struct ofono_netreg *netreg =3D user_data;
> +
> +       if (!ok) {
> +               ofono_error("Unable to initialize Network Registration");
> +               ofono_netreg_remove(netreg);
> +               return;
> +       }
> +
> +       ublox_finish_registration(netreg);
> +}
> +
>  static void ublox_cmer_set_cb(gboolean ok,
>                                 GAtResult *result, gpointer user_data)
>  {
>         struct ofono_netreg *netreg =3D user_data;
> -       struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
> +       struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
>
>         if (!ok) {
>                 at_cmer_not_supported(netreg);
>                 return;
>         }
>
> -       g_at_chat_register(nd->chat, "+CIEV:",
> -                       ciev_notify, FALSE, netreg, NULL);
> +       if (ublox_is_toby_l4(nd->model) || ublox_is_toby_l2(nd->model)) {
> +               g_at_chat_send(nd->at_data.chat, "AT+UREG=3D1", none_pref=
ix,
> +                       ublox_ureg_set_cb, netreg, NULL);
>
> -       g_at_chat_register(nd->chat, "+CREG:",
> -                               creg_notify, FALSE, netreg, NULL);
> +               return;
> +       }
>
> -       ofono_netreg_register(netreg);
> +       ublox_finish_registration(netreg);
>  }
>
>  static void ublox_creg_set_cb(gboolean ok,
> @@ -354,12 +455,9 @@ static void ublox_creg_set_cb(gboolean ok,
>                 return;
>         }
>
> -       if (ublox_is_toby_l4(nd->model)) {
> +       if (ublox_is_toby_l4(nd->model))
>                 /* FIXME */
>                 ofono_error("TOBY L4 requires polling of ECSQ");
> -               ofono_error("TOBY L4 wants UREG notifications for"
> -                               " tech updates");
> -       }
>
>         /* Register for network time update reports */
>         if (ublox_is_toby_l2(nd->model)) {
> --
> 2.20.1
>
>

--===============2477124862978763620==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5IZXJlIGlzIGEgbG9nIHNob3dp
bmcgd2h5IHRoaXMgaXMgbmVlZGVkLCBubyBDUkVHIGZvciBtb3JlIHRoYW4gMzAgbWludXRlczwv
ZGl2PjxkaXY+d2hlbiBjaGFuZ2luZyB0ZWNoIGZyb20gVVRSQU4gdG8gRS1VVFJBTi48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PlRoaXMgaGFwcGVucyBvbiBhIEwyMTAsIGJ1dCBhcyBJIHVuZGVy
c3Rvb2QgSm9uYXMsIGFuZCBjb21tZW50czwvZGl2PjxkaXY+aW4gdGhlIGNvZGUsIHRoZSBMNHh4
IHN1ZmZlcnMgZnJvbSBzaW1pbGFyIGlzc3Vlcywgc28gSSBhZGRlZCB0aGlzIGZvciBib3RoIEw0
PC9kaXY+PGRpdj5hbmQgTDIuPGJyPjxicj48YnI+U2VwIDIzIDIxOjQ1OjM3IGluZm8gOiBBdXg6
ICZsdDsgXHJcbitDSUVWOiAyLDNcclxuPGJyPlNlcCAyMyAyMTo1OToyOSBpbmZvIDogQXV4OiAm
bHQ7IFxyXG4rQ0dSRUc6IDRcclxuPGJyPlNlcCAyMyAyMTo1OToyOSBkZWJ1ZyA6IC4uL2dpdC9z
cmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC91YmxveF8wIHN0YXR1cyB1bmtu
b3duICg0KTxicj5TZXAgMjMgMjE6NTk6MjkgZGVidWcgOiAuLi9naXQvc3JjL2dwcnMuYzpvZm9u
b19ncHJzX2RldGFjaGVkX25vdGlmeSgpIC91YmxveF8wPGJyPlNlcCAyMyAyMTo1OToyOSBpbmZv
IDogQXV4OiAmbHQ7IFxyXG4rVVJFRzogMFxyXG48YnI+U2VwIDIzIDIxOjU5OjI5IGluZm8gOiBB
dXg6ICZsdDsgXHJcbitDSUVWOiA5LDFcclxuPGJyPjxicj5XZSBnZXQgYW4gVVJFRyBVUkMgaW5k
aWNhdGluZyBFLVVUUkFOLC48L2Rpdj48ZGl2Pjxicj5TZXAgMjMgMjE6NTk6MjkgaW5mbyA6IEF1
eDogJmx0OyBcclxuK1VSRUc6IDdcclxuPGJyPlNlcCAyMyAyMTo1OToyOSBpbmZvIDogQXV4OiAm
bHQ7IFxyXG4rQ0lFVjogOSwyXHJcbjxicj5TZXAgMjMgMjE6NTk6MjkgaW5mbyA6IEF1eDogJmx0
OyBcclxuK0NHRVY6IE5XIE1PRElGWSAxLDAsMFxyXG48YnI+U2VwIDIzIDIxOjU5OjMxIGluZm8g
OiBBdXg6ICZsdDsgXHJcbitDSUVWOiAyLDJcclxuPGJyPlNlcCAyMyAyMTo1OTozOSBpbmZvIDog
QXV4OiAmbHQ7IFxyXG4rQ0lFVjogMiwzXHJcbjxicj5TZXAgMjMgMjE6NTk6NDQgaW5mbyA6IEF1
eDogJmx0OyBcclxuK0NJRVY6IDIsMlxyXG48YnI+U2VwIDIzIDIyOjAxOjM4IGluZm8gOiBBdXg6
ICZsdDsgXHJcbitDSUVWOiAyLDNcclxuPGJyPlNlcCAyMyAyMjowMTo0MyBpbmZvIDogQXV4OiAm
bHQ7IFxyXG4rQ0lFVjogMiwyXHJcbjxicj48YnI+Q1JFRyBBZnRlciAzMCsgbWludXRlcyEhIElu
ZGljYXRpbmcgVVRSQU4gKHdoaWNoIGlzIGluY29ycmVjdCwgYnV0IHdvcmtlZCBhcm91bmQgaW4g
YW5vdGhlciBjb21taXQpPGJyPjxicj5TZXAgMjMgMjI6Mjk6MzkgaW5mbyA6IEF1eDogJmx0OyBc
clxuK0NSRUc6IDUsJnF1b3Q7MDAwMCZxdW90OywmcXVvdDswMDAwMDAwMCZxdW90Oyw2XHJcbjxi
cj48YnI+PC9kaXY+PGRpdj5CUjwvZGl2PjxkaXY+UmljaGFyZDwvZGl2PjwvZGl2Pjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPkRl
biBzw7ZuIDI5IHNlcC4gMjAxOSBrbCAyMTo0MCBza3JldiAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJp
Y2hhcmQucm9qZm9yc0BnbWFpbC5jb20iPnJpY2hhcmQucm9qZm9yc0BnbWFpbC5jb208L2E+Jmd0
Ozo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQp
O3BhZGRpbmctbGVmdDoxZXgiPkZyb206IFJpY2hhcmQgUsO2amZvcnMgJmx0OzxhIGhyZWY9Im1h
aWx0bzpyaWNoYXJkQHB1ZmZpbnBhY2suc2UiIHRhcmdldD0iX2JsYW5rIj5yaWNoYXJkQHB1ZmZp
bnBhY2suc2U8L2E+Jmd0Ozxicj4KPGJyPgpJdCB0dXJucyBvdXQgdGhhdCBib3RoIEwyeHggYW5k
IEw0eHggbW9kZW1zIGFyZSBhIGJpdDxicj4KYnVnZ3kgd2hlbiBpdCBjb21lcyB0byBzZW5kIENS
RUcgVVJDJiMzOTtzIHdoZW4gdGhlIHRlY2ggY2hhbmdlcy48YnI+ClRyeSB0byBvdmVyY29tZSB0
aGlzIGJ5IHN1YnNjcmliaW5nIHRvIGJvdGggVVJFRyBhbmQgQ1JFRyw8YnI+CmFuZCBwb2xsIHRo
ZSBvdGhlciB3aGVuIGFueSBvZiB0aGUgVVJDJiMzOTtzIGFyZSByZWNlaXZlZC48YnI+ClByb3Rl
Y3QgZnJvbSBkb2luZyBzaW11bHRhbmlvdXMgcG9sbHMgdGhvdWdoLjxicj4KLS0tPGJyPgrCoGRy
aXZlcnMvdWJsb3htb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jIHwgMTk4ICsrKysrKysrKysr
KysrKystLS0tLS08YnI+CsKgMSBmaWxlIGNoYW5nZWQsIDE0OCBpbnNlcnRpb25zKCspLCA1MCBk
ZWxldGlvbnMoLSk8YnI+Cjxicj4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWJsb3htb2RlbS9uZXR3
b3JrLXJlZ2lzdHJhdGlvbi5jIGIvZHJpdmVycy91YmxveG1vZGVtL25ldHdvcmstcmVnaXN0cmF0
aW9uLmM8YnI+CmluZGV4IDY5YWY0NjQ0Li5hZDkwNWZiMyAxMDA2NDQ8YnI+Ci0tLSBhL2RyaXZl
cnMvdWJsb3htb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jPGJyPgorKysgYi9kcml2ZXJzL3Vi
bG94bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzxicj4KQEAgLTQ3LDExICs0NywxNSBAQDxi
cj4KwqBzdGF0aWMgY29uc3QgY2hhciAqbm9uZV9wcmVmaXhbXSA9IHsgTlVMTCB9Ozxicj4KwqBz
dGF0aWMgY29uc3QgY2hhciAqY21lcl9wcmVmaXhbXSA9IHsgJnF1b3Q7K0NNRVI6JnF1b3Q7LCBO
VUxMIH07PGJyPgrCoHN0YXRpYyBjb25zdCBjaGFyICp1cmVnX3ByZWZpeFtdID0geyAmcXVvdDsr
VVJFRzomcXVvdDssIE5VTEwgfTs8YnI+CitzdGF0aWMgY29uc3QgY2hhciAqY3JlZ19wcmVmaXhb
XSA9IHsgJnF1b3Q7K0NSRUc6JnF1b3Q7LCBOVUxMIH07PGJyPgorPGJyPgorI2RlZmluZSBVQkxP
WF9VUERBVElOR19TVEFUVVMgMHgwMTxicj4KPGJyPgrCoHN0cnVjdCBuZXRyZWdfZGF0YSB7PGJy
PgrCoCDCoCDCoCDCoCBzdHJ1Y3QgYXRfbmV0cmVnX2RhdGEgYXRfZGF0YTs8YnI+Cjxicj4KwqAg
wqAgwqAgwqAgY29uc3Qgc3RydWN0IHVibG94X21vZGVsICptb2RlbDs8YnI+CivCoCDCoCDCoCDC
oGludCBmbGFnczs8YnI+CsKgfTs8YnI+Cjxicj4KwqBzdHJ1Y3QgdGVjaF9xdWVyeSB7PGJyPgpA
QCAtMjEzLDEzICsyMTcsNzIgQEAgc3RhdGljIHZvaWQgY3R6ZV9ub3RpZnkoR0F0UmVzdWx0ICpy
ZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+CsKgIMKgIMKgIMKgIG9mb25vX25ldHJlZ190
aW1lX25vdGlmeShuZXRyZWcsICZhbXA7bmQtJmd0O3RpbWUpOzxicj4KwqB9PGJyPgo8YnI+Ci1z
dGF0aWMgdm9pZCB1YmxveF9xdWVyeV90ZWNoX2NiKGdib29sZWFuIG9rLCBHQXRSZXN1bHQgKnJl
c3VsdCw8YnI+CitzdGF0aWMgaW50IHVibG94X3VyZWdfc3RhdGVfdG9fdGVjaChpbnQgc3RhdGUp
PGJyPgorezxicj4KK8KgIMKgIMKgIMKgc3dpdGNoIChzdGF0ZSkgezxicj4KK8KgIMKgIMKgIMKg
Y2FzZSAxOjxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEFDQ0VTU19URUNITk9M
T0dZX0dTTTs8YnI+CivCoCDCoCDCoCDCoGNhc2UgMjo8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiBBQ0NFU1NfVEVDSE5PTE9HWV9HU01fRUdQUlM7PGJyPgorwqAgwqAgwqAgwqBj
YXNlIDM6PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQUNDRVNTX1RFQ0hOT0xP
R1lfVVRSQU47PGJyPgorwqAgwqAgwqAgwqBjYXNlIDQ6PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXR1cm4gQUNDRVNTX1RFQ0hOT0xPR1lfVVRSQU5fSFNEUEE7PGJyPgorwqAgwqAgwqAg
wqBjYXNlIDU6PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQUNDRVNTX1RFQ0hO
T0xPR1lfVVRSQU5fSFNVUEE7PGJyPgorwqAgwqAgwqAgwqBjYXNlIDY6PGJyPgorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gQUNDRVNTX1RFQ0hOT0xPR1lfVVRSQU5fSFNEUEFfSFNVUEE7
PGJyPgorwqAgwqAgwqAgwqBjYXNlIDc6PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gQUNDRVNTX1RFQ0hOT0xPR1lfRVVUUkFOOzxicj4KK8KgIMKgIMKgIMKgY2FzZSA4Ojxicj4K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEFDQ0VTU19URUNITk9MT0dZX0dTTTs8YnI+
CivCoCDCoCDCoCDCoGNhc2UgOTo8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBB
Q0NFU1NfVEVDSE5PTE9HWV9HU01fRUdQUlM7PGJyPgorwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogTm90IHJlZ2lzdGVyZWQgZm9yIFBTICgwKSBvciBz
b21ldGhpbmcgdW5rbm93biAoJmd0OzkpLi4uICovPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gLTE7PGJyPgorwqAgwqAgwqAgwqB9PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyBn
Ym9vbGVhbiBpc19yZWdpc3RlcmVkKGludCBzdGF0dXMpPGJyPgorezxicj4KK8KgIMKgIMKgIMKg
cmV0dXJuIHN0YXR1cyA9PSBORVRXT1JLX1JFR0lTVFJBVElPTl9TVEFUVVNfUkVHSVNURVJFRCB8
fDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdHVzID09IE5FVFdPUktfUkVHSVNUUkFU
SU9OX1NUQVRVU19ST0FNSU5HOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMgdm9pZCB1YmxveF9j
cmVnX2NiKGdib29sZWFuIG9rLCBHQXRSZXN1bHQgKnJlc3VsdCw8YnI+CivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+
Cit7PGJyPgorwqAgwqAgwqAgwqBzdHJ1Y3QgdGVjaF9xdWVyeSAqdHEgPSB1c2VyX2RhdGE7PGJy
PgorwqAgwqAgwqAgwqBzdHJ1Y3QgbmV0cmVnX2RhdGEgKm5kID0gb2Zvbm9fbmV0cmVnX2dldF9k
YXRhKHRxLSZndDtuZXRyZWcpOzxicj4KK8KgIMKgIMKgIMKgaW50IHN0YXR1cywgbGFjLCBjaSwg
dGVjaDs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoG5kLSZndDtmbGFncyAmYW1wOz0gflVCTE9YX1VQ
REFUSU5HX1NUQVRVUzs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGlmICghb2spPGJyPgorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPgorPGJyPgorwqAgwqAgwqAgwqBpZiAoYXRfdXRp
bF9wYXJzZV9yZWcocmVzdWx0LCAmcXVvdDsrQ1JFRzomcXVvdDssIE5VTEwsICZhbXA7c3RhdHVz
LDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFt
cDtsYWMsICZhbXA7Y2ksICZhbXA7dGVjaCwgT0ZPTk9fVkVORE9SX0dFTkVSSUMpID09IEZBTFNF
KTxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj4KKzxicj4KK8KgIMKgIMKg
IMKgLyogVGhlIHF1ZXJ5IHByb3ZpZGVkIGEgdGVjaCwgdXNlIHRoYXQgKi88YnI+CivCoCDCoCDC
oCDCoGlmIChpc19yZWdpc3RlcmVkKHN0YXR1cykgJmFtcDsmYW1wOyB0cS0mZ3Q7dGVjaCAhPSAt
MSk8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlY2ggPSB0cS0mZ3Q7dGVjaDs8YnI+Cis8
YnI+CivCoCDCoCDCoCDCoG9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KHRxLSZndDtuZXRyZWcs
IHN0YXR1cywgbGFjLCBjaSwgdGVjaCk7PGJyPgorfTxicj4KKzxicj4KK3N0YXRpYyB2b2lkIHVi
bG94X3VyZWdfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LDxicj4KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KwqB7PGJyPgrCoCDCoCDC
oCDCoCBzdHJ1Y3QgdGVjaF9xdWVyeSAqdHEgPSB1c2VyX2RhdGE7PGJyPgorwqAgwqAgwqAgwqBz
dHJ1Y3QgbmV0cmVnX2RhdGEgKm5kID0gb2Zvbm9fbmV0cmVnX2dldF9kYXRhKHRxLSZndDtuZXRy
ZWcpOzxicj4KwqAgwqAgwqAgwqAgR0F0UmVzdWx0SXRlciBpdGVyOzxicj4KwqAgwqAgwqAgwqAg
Z2ludCBlbmFibGVkLCBzdGF0ZTs8YnI+Ci3CoCDCoCDCoCDCoGludCB0ZWNoID0gLTE7PGJyPgor
wqAgwqAgwqAgwqBpbnQgdGVjaCA9IHRxLSZndDt0ZWNoOzxicj4KKzxicj4KK8KgIMKgIMKgIMKg
bmQtJmd0O2ZsYWdzICZhbXA7PSB+VUJMT1hfVVBEQVRJTkdfU1RBVFVTOzxicj4KPGJyPgrCoCDC
oCDCoCDCoCBpZiAoIW9rKTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJvcjs8
YnI+CkBAIC0yMzUsNDggKzI5OCw0OSBAQCBzdGF0aWMgdm9pZCB1YmxveF9xdWVyeV90ZWNoX2Ni
KGdib29sZWFuIG9rLCBHQXRSZXN1bHQgKnJlc3VsdCw8YnI+CsKgIMKgIMKgIMKgIGlmICghZ19h
dF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmYW1wO2l0ZXIsICZhbXA7c3RhdGUpKTxicj4KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4KPGJyPgotwqAgwqAgwqAgwqBzd2l0Y2gg
KHN0YXRlKSB7PGJyPgotwqAgwqAgwqAgwqBjYXNlIDA6PGJyPgotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAvKiBOb3QgcmVnaXN0ZXJlZCBmb3IgUFMsIHRoZW4gd2UgaGF2ZSB0byB0cnVzdCBDUkVH
Li4uICovPGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0ZWNoID0gdHEtJmd0O3RlY2g7PGJy
PgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+Ci3CoCDCoCDCoCDCoGNhc2UgMTo8
YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlY2ggPSBBQ0NFU1NfVEVDSE5PTE9HWV9HU007
PGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+Ci3CoCDCoCDCoCDCoGNhc2Ug
Mjo8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlY2ggPSBBQ0NFU1NfVEVDSE5PTE9HWV9H
U01fRUdQUlM7PGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+Ci3CoCDCoCDC
oCDCoGNhc2UgMzo8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlY2ggPSBBQ0NFU1NfVEVD
SE5PTE9HWV9VVFJBTjs8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KLcKg
IMKgIMKgIMKgY2FzZSA0Ojxicj4KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVjaCA9IEFDQ0VT
U19URUNITk9MT0dZX1VUUkFOX0hTRFBBOzxicj4KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPgotwqAgwqAgwqAgwqBjYXNlIDU6PGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0
ZWNoID0gQUNDRVNTX1RFQ0hOT0xPR1lfVVRSQU5fSFNVUEE7PGJyPgotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBicmVhazs8YnI+Ci3CoCDCoCDCoCDCoGNhc2UgNjo8YnI+Ci3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHRlY2ggPSBBQ0NFU1NfVEVDSE5PTE9HWV9VVFJBTl9IU0RQQV9IU1VQQTs8YnI+
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KLcKgIMKgIMKgIMKgY2FzZSA3Ojxi
cj4KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVjaCA9IEFDQ0VTU19URUNITk9MT0dZX0VVVFJB
Tjs8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KLcKgIMKgIMKgIMKgY2Fz
ZSA4Ojxicj4KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVjaCA9IEFDQ0VTU19URUNITk9MT0dZ
X0dTTTs8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KLcKgIMKgIMKgIMKg
Y2FzZSA5Ojxicj4KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVjaCA9IEFDQ0VTU19URUNITk9M
T0dZX0dTTV9FR1BSUzs8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4KLcKg
IMKgIMKgIMKgZGVmYXVsdDo8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIE5vdCByZWdp
c3RlcmVkIGZvciBQUyBvciBzb21ldGhpbmcgdW5rbm93biwgdHJ1c3QgQ1JFRy4uLiAqLzxicj4K
K8KgIMKgIMKgIMKgdGVjaCA9IHVibG94X3VyZWdfc3RhdGVfdG9fdGVjaChzdGF0ZSk7PGJyPgor
wqAgwqAgwqAgwqBpZiAodGVjaCAmbHQ7IDApPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAv
KiBObyB2YWxpZCBVUkVHIHN0YXR1cywgd2UgaGF2ZSB0byB0cnVzdCBDUkVHLi4uICovPGJyPgrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZWNoID0gdHEtJmd0O3RlY2g7PGJyPgotwqAgwqAgwqAg
wqB9PGJyPgo8YnI+CsKgZXJyb3I6PGJyPgrCoCDCoCDCoCDCoCBvZm9ub19uZXRyZWdfc3RhdHVz
X25vdGlmeSh0cS0mZ3Q7bmV0cmVnLDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgdHEtJmd0O3N0YXR1cywgdHEtJmd0O2xhYywgdHEtJmd0O2NpLCB0ZWNoKTs8YnI+CsKg
fTxicj4KPGJyPgorc3RhdGljIHZvaWQgdXJlZ19ub3RpZnkoR0F0UmVzdWx0ICpyZXN1bHQsIGdw
b2ludGVyIHVzZXJfZGF0YSk8YnI+Cit7PGJyPgorwqAgwqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fbmV0
cmVnICpuZXRyZWcgPSB1c2VyX2RhdGE7PGJyPgorwqAgwqAgwqAgwqBpbnQgc3RhdGU7PGJyPgor
wqAgwqAgwqAgwqBzdHJ1Y3QgbmV0cmVnX2RhdGEgKm5kID0gb2Zvbm9fbmV0cmVnX2dldF9kYXRh
KG5ldHJlZyk7PGJyPgorwqAgwqAgwqAgwqBzdHJ1Y3QgdGVjaF9xdWVyeSAqdHE7PGJyPgorwqAg
wqAgwqAgwqBHQXRSZXN1bHRJdGVyIGl0ZXI7PGJyPgorPGJyPgorwqAgwqAgwqAgwqBpZiAobmQt
Jmd0O2ZsYWdzICZhbXA7IFVCTE9YX1VQREFUSU5HX1NUQVRVUyk8YnI+CivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybjs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGdfYXRfcmVzdWx0X2l0ZXJf
aW5pdCgmYW1wO2l0ZXIsIHJlc3VsdCk7PGJyPgorPGJyPgorwqAgwqAgwqAgwqBpZiAoIWdfYXRf
cmVzdWx0X2l0ZXJfbmV4dCgmYW1wO2l0ZXIsICZxdW90OytVUkVHOiZxdW90OykpPGJyPgorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPgorPGJyPgorwqAgwqAgwqAgwqBpZiAoIWdf
YXRfcmVzdWx0X2l0ZXJfbmV4dF9udW1iZXIoJmFtcDtpdGVyLCAmYW1wO3N0YXRlKSk8YnI+CivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoHRxID0g
Z19uZXcwKHN0cnVjdCB0ZWNoX3F1ZXJ5LCAxKTs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoHRxLSZn
dDt0ZWNoID0gdWJsb3hfdXJlZ19zdGF0ZV90b190ZWNoKHN0YXRlKTs8YnI+CivCoCDCoCDCoCDC
oHRxLSZndDtuZXRyZWcgPSBuZXRyZWc7PGJyPgorPGJyPgorwqAgwqAgwqAgwqBpZiAoZ19hdF9j
aGF0X3NlbmQobmQtJmd0O2F0X2RhdGEuY2hhdCwgJnF1b3Q7QVQrQ1JFRz8mcXVvdDssIGNyZWdf
cHJlZml4LDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWJsb3hfY3Jl
Z19jYiwgdHEsIGdfZnJlZSkgJmd0OyAwKSB7PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBu
ZC0mZ3Q7ZmxhZ3MgfD0gVUJMT1hfVVBEQVRJTkdfU1RBVFVTOzxicj4KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuOzxicj4KK8KgIMKgIMKgIMKgfTxicj4KKzxicj4KK8KgIMKgIMKgIMKg
Z19mcmVlKHRxKTs8YnI+Cit9PGJyPgorPGJyPgrCoHN0YXRpYyB2b2lkIGNyZWdfbm90aWZ5KEdB
dFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpPGJyPgrCoHs8YnI+CsKgIMKgIMKg
IMKgIHN0cnVjdCBvZm9ub19uZXRyZWcgKm5ldHJlZyA9IHVzZXJfZGF0YTs8YnI+CkBAIC0yODQs
MTEgKzM0OCwxNCBAQCBzdGF0aWMgdm9pZCBjcmVnX25vdGlmeShHQXRSZXN1bHQgKnJlc3VsdCwg
Z3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KwqAgwqAgwqAgwqAgc3RydWN0IG5ldHJlZ19kYXRhICpu
ZCA9IG9mb25vX25ldHJlZ19nZXRfZGF0YShuZXRyZWcpOzxicj4KwqAgwqAgwqAgwqAgc3RydWN0
IHRlY2hfcXVlcnkgKnRxOzxicj4KPGJyPgorwqAgwqAgwqAgwqBpZiAobmQtJmd0O2ZsYWdzICZh
bXA7IFVCTE9YX1VQREFUSU5HX1NUQVRVUyk8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dHVybjs8YnI+Cis8YnI+CsKgIMKgIMKgIMKgIGlmIChhdF91dGlsX3BhcnNlX3JlZ191bnNvbGlj
aXRlZChyZXN1bHQsICZxdW90OytDUkVHOiZxdW90OywgJmFtcDtzdGF0dXMsPGJyPgrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO2xhYywgJmFtcDtjaSwgJmFtcDt0ZWNo
LCBPRk9OT19WRU5ET1JfR0VORVJJQykgPT0gRkFMU0UpPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCByZXR1cm47PGJyPgo8YnI+Ci3CoCDCoCDCoCDCoGlmIChzdGF0dXMgIT0gMSAmYW1wOyZh
bXA7IHN0YXR1cyAhPSA1KTxicj4KK8KgIMKgIMKgIMKgaWYgKCFpc19yZWdpc3RlcmVkKHN0YXR1
cykpPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIG5vdGlmeTs8YnI+Cjxicj4KwqAg
wqAgwqAgwqAgaWYgKHVibG94X2lzX3RvYnlfbDQobmQtJmd0O21vZGVsKSB8fCB1YmxveF9pc190
b2J5X2wyKG5kLSZndDttb2RlbCkpIHs8YnI+CkBAIC0zMDEsMTMgKzM2OCwxNSBAQCBzdGF0aWMg
dm9pZCBjcmVnX25vdGlmeShHQXRSZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTxi
cj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdHEtJmd0O25ldHJlZyA9IG5ldHJlZzs8YnI+Cjxi
cj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGdfYXRfY2hhdF9zZW5kKG5kLSZndDthdF9k
YXRhLmNoYXQsICZxdW90O0FUK1VSRUc/JnF1b3Q7LCB1cmVnX3ByZWZpeCw8YnI+Ci3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVibG94X3F1ZXJ5X3RlY2hf
Y2IsIHRxLCBnX2ZyZWUpICZndDsgMCk8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHVibG94X3VyZWdfY2IsIHRxLCBnX2ZyZWUpICZndDsgMCkgezxi
cj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmQtJmd0O2ZsYWdzIHw9IFVC
TE9YX1VQREFUSU5HX1NUQVRVUzs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJldHVybjs8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+Cjxicj4KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZ19mcmVlKHRxKTs8YnI+CsKgIMKgIMKgIMKgIH08YnI+Cjxicj4K
LcKgIMKgIMKgIMKgaWYgKChzdGF0dXMgPT0gMSB8fCBzdGF0dXMgPT0gNSkgJmFtcDsmYW1wOyB0
ZWNoID09IC0xKTxicj4KK8KgIMKgIMKgIMKgaWYgKHRlY2ggPT0gLTEpPGJyPgrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB0ZWNoID0gbmQtJmd0O2F0X2RhdGEudGVjaDs8YnI+Cjxicj4KwqBub3Rp
Znk6PGJyPgpAQCAtMzIyLDI0ICszOTEsNTYgQEAgc3RhdGljIHZvaWQgYXRfY21lcl9ub3Rfc3Vw
cG9ydGVkKHN0cnVjdCBvZm9ub19uZXRyZWcgKm5ldHJlZyk8YnI+CsKgIMKgIMKgIMKgIG9mb25v
X25ldHJlZ19yZW1vdmUobmV0cmVnKTs8YnI+CsKgfTxicj4KPGJyPgorc3RhdGljIHZvaWQgdWJs
b3hfZmluaXNoX3JlZ2lzdHJhdGlvbihzdHJ1Y3Qgb2Zvbm9fbmV0cmVnICpuZXRyZWcpPGJyPgor
ezxicj4KK8KgIMKgIMKgIMKgc3RydWN0IG5ldHJlZ19kYXRhICpuZCA9IG9mb25vX25ldHJlZ19n
ZXRfZGF0YShuZXRyZWcpOzxicj4KKzxicj4KK8KgIMKgIMKgIMKgaWYgKHVibG94X2lzX3RvYnlf
bDQobmQtJmd0O21vZGVsKSB8fCB1YmxveF9pc190b2J5X2wyKG5kLSZndDttb2RlbCkpPGJyPgor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnX2F0X2NoYXRfcmVnaXN0ZXIobmQtJmd0O2F0X2RhdGEu
Y2hhdCwgJnF1b3Q7K1VSRUc6JnF1b3Q7LDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdXJlZ19ub3RpZnksIEZBTFNFLCBuZXRy
ZWcsIE5VTEwpOzxicj4KKzxicj4KK8KgIMKgIMKgIMKgZ19hdF9jaGF0X3JlZ2lzdGVyKG5kLSZn
dDthdF9kYXRhLmNoYXQsICZxdW90OytDSUVWOiZxdW90Oyw8YnI+CivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGNpZXZfbm90aWZ5LCBGQUxTRSwgbmV0cmVnLCBOVUxMKTs8YnI+
Cis8YnI+CivCoCDCoCDCoCDCoGdfYXRfY2hhdF9yZWdpc3RlcihuZC0mZ3Q7YXRfZGF0YS5jaGF0
LCAmcXVvdDsrQ1JFRzomcXVvdDssPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBjcmVnX25vdGlmeSwgRkFMU0UsIG5ldHJlZywgTlVMTCk7PGJyPgor
PGJyPgorwqAgwqAgwqAgwqBvZm9ub19uZXRyZWdfcmVnaXN0ZXIobmV0cmVnKTs8YnI+Cit9PGJy
PgorPGJyPgorc3RhdGljIHZvaWQgdWJsb3hfdXJlZ19zZXRfY2IoZ2Jvb2xlYW4gb2ssPGJyPgor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBHQXRSZXN1bHQg
KnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KK3s8YnI+CivCoCDCoCDCoCDCoHN0cnVj
dCBvZm9ub19uZXRyZWcgKm5ldHJlZyA9IHVzZXJfZGF0YTs8YnI+Cis8YnI+CivCoCDCoCDCoCDC
oGlmICghb2spIHs8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9mb25vX2Vycm9yKCZxdW90
O1VuYWJsZSB0byBpbml0aWFsaXplIE5ldHdvcmsgUmVnaXN0cmF0aW9uJnF1b3Q7KTs8YnI+CivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9mb25vX25ldHJlZ19yZW1vdmUobmV0cmVnKTs8YnI+CivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjs8YnI+CivCoCDCoCDCoCDCoH08YnI+Cis8YnI+
CivCoCDCoCDCoCDCoHVibG94X2ZpbmlzaF9yZWdpc3RyYXRpb24obmV0cmVnKTs8YnI+Cit9PGJy
PgorPGJyPgrCoHN0YXRpYyB2b2lkIHVibG94X2NtZXJfc2V0X2NiKGdib29sZWFuIG9rLDxicj4K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgR0F0UmVzdWx0
ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+CsKgezxicj4KwqAgwqAgwqAgwqAgc3Ry
dWN0IG9mb25vX25ldHJlZyAqbmV0cmVnID0gdXNlcl9kYXRhOzxicj4KLcKgIMKgIMKgIMKgc3Ry
dWN0IGF0X25ldHJlZ19kYXRhICpuZCA9IG9mb25vX25ldHJlZ19nZXRfZGF0YShuZXRyZWcpOzxi
cj4KK8KgIMKgIMKgIMKgc3RydWN0IG5ldHJlZ19kYXRhICpuZCA9IG9mb25vX25ldHJlZ19nZXRf
ZGF0YShuZXRyZWcpOzxicj4KPGJyPgrCoCDCoCDCoCDCoCBpZiAoIW9rKSB7PGJyPgrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBhdF9jbWVyX25vdF9zdXBwb3J0ZWQobmV0cmVnKTs8YnI+CsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybjs8YnI+CsKgIMKgIMKgIMKgIH08YnI+Cjxicj4KLcKg
IMKgIMKgIMKgZ19hdF9jaGF0X3JlZ2lzdGVyKG5kLSZndDtjaGF0LCAmcXVvdDsrQ0lFVjomcXVv
dDssPGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjaWV2X25vdGlmeSwg
RkFMU0UsIG5ldHJlZywgTlVMTCk7PGJyPgorwqAgwqAgwqAgwqBpZiAodWJsb3hfaXNfdG9ieV9s
NChuZC0mZ3Q7bW9kZWwpIHx8IHVibG94X2lzX3RvYnlfbDIobmQtJmd0O21vZGVsKSkgezxicj4K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ19hdF9jaGF0X3NlbmQobmQtJmd0O2F0X2RhdGEuY2hh
dCwgJnF1b3Q7QVQrVVJFRz0xJnF1b3Q7LCBub25lX3ByZWZpeCw8YnI+CivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVibG94X3VyZWdfc2V0X2NiLCBuZXRyZWcsIE5VTEwpOzxi
cj4KPGJyPgotwqAgwqAgwqAgwqBnX2F0X2NoYXRfcmVnaXN0ZXIobmQtJmd0O2NoYXQsICZxdW90
OytDUkVHOiZxdW90Oyw8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNyZWdfbm90aWZ5LCBGQUxTRSwgbmV0cmVnLCBOVUxMKTs8YnI+CivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybjs8YnI+CivCoCDCoCDCoCDCoH08YnI+Cjxicj4KLcKgIMKg
IMKgIMKgb2Zvbm9fbmV0cmVnX3JlZ2lzdGVyKG5ldHJlZyk7PGJyPgorwqAgwqAgwqAgwqB1Ymxv
eF9maW5pc2hfcmVnaXN0cmF0aW9uKG5ldHJlZyk7PGJyPgrCoH08YnI+Cjxicj4KwqBzdGF0aWMg
dm9pZCB1YmxveF9jcmVnX3NldF9jYihnYm9vbGVhbiBvayw8YnI+CkBAIC0zNTQsMTIgKzQ1NSw5
IEBAIHN0YXRpYyB2b2lkIHVibG94X2NyZWdfc2V0X2NiKGdib29sZWFuIG9rLDxicj4KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4KwqAgwqAgwqAgwqAgfTxicj4KPGJyPgotwqAg
wqAgwqAgwqBpZiAodWJsb3hfaXNfdG9ieV9sNChuZC0mZ3Q7bW9kZWwpKSB7PGJyPgorwqAgwqAg
wqAgwqBpZiAodWJsb3hfaXNfdG9ieV9sNChuZC0mZ3Q7bW9kZWwpKTxicj4KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgLyogRklYTUUgKi88YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG9mb25v
X2Vycm9yKCZxdW90O1RPQlkgTDQgcmVxdWlyZXMgcG9sbGluZyBvZiBFQ1NRJnF1b3Q7KTs8YnI+
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9mb25vX2Vycm9yKCZxdW90O1RPQlkgTDQgd2FudHMg
VVJFRyBub3RpZmljYXRpb25zIGZvciZxdW90Ozxicj4KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7IHRlY2ggdXBkYXRlcyZxdW90Oyk7PGJyPgot
wqAgwqAgwqAgwqB9PGJyPgo8YnI+CsKgIMKgIMKgIMKgIC8qIFJlZ2lzdGVyIGZvciBuZXR3b3Jr
IHRpbWUgdXBkYXRlIHJlcG9ydHMgKi88YnI+CsKgIMKgIMKgIMKgIGlmICh1YmxveF9pc190b2J5
X2wyKG5kLSZndDttb2RlbCkpIHs8YnI+Ci0tIDxicj4KMi4yMC4xPGJyPgo8YnI+CjwvYmxvY2tx
dW90ZT48L2Rpdj4K

--===============2477124862978763620==--

