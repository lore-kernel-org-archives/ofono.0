Content-Type: multipart/mixed; boundary="===============2041432482474554235=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] ublox: gprs: React on context deactivation
Date: Tue, 03 Sep 2019 16:10:49 +0200
Message-ID: <CAHB-Pjnvdu+90EHZ3rEotangEsAATeACUFWUenWgywOm6aB6Hw@mail.gmail.com>
In-Reply-To: <20190903140611.1264-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2041432482474554235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

An example log when this happened. In this case ofono thought context 4 was
still activated
even though it was deactivated

12:47:52 info: Aux: < \r\n+CIEV: 9,2\r\n
12:50:37 info: Aux: < \r\n+CIEV: 2,2\r\n
12:50:42 info: Aux: < \r\n+CIEV: 2,1\r\n
12:51:06 info: Aux: < \r\n+CIEV: 2,0\r\n
12:51:08 info: Aux: < \r\n+CGREG: 5,"004B","0000E404",6,"01"\r\n
12:51:08 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
status roaming (5)
12:51:08 info: Aux: < \r\n+UREG: 6\r\n
12:51:08 info: Aux: < \r\n+CIEV: 9,2\r\n
12:51:08 info: Aux: < \r\n+CIEV: 9,1\r\n
12:51:09 info: Aux: < \r\n+CGEV: NW MODIFY 4,0,0\r\n
12:51:16 info: Aux: < \r\n+CREG: 0\r\n
12:51:16 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
status 0 tech -1 lac -1 ci -1
12:51:16 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
0x6f2fe8
12:51:16 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
12:51:16 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
driver_attached: 1
12:51:16 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
12:51:16 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
driver_attached: 0
12:51:16 info: Aux: > AT\r
12:51:16 info: Aux: < \r\n+CIEV: 7,0\r\n
12:51:16 info: Aux: < \r\nOK\r\n
12:51:16 info: Aux: Finally woke up the modem
12:51:16 info: Aux: > AT+CGATT=3D0\r
12:51:16 info: Aux: < \r\n+CGREG: 4\r\n
12:51:16 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
status unknown (4)
12:51:16 info: Aux: < \r\n+UREG: 0\r\n
12:51:16 info: Aux: < \r\n+CIEV: 9,1\r\n
12:51:16 info: Aux: < \r\nOK\r\n
12:51:16 debug: ../git/src/gprs.c:gprs_attach_callback() /ublox_0 error =3D=
 0
12:51:16 info: Aux: > AT+CGREG?\r
12:51:16 info: Aux: < \r\n+CGREG: 2,4\r\n
12:51:16 info: Aux: < \r\nOK\r\n
12:51:16 debug: ../git/src/gprs.c:registration_status_cb() /ublox_0 error 0
status 4
12:51:16 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
status unknown (4)
12:51:27 info: Aux: < \r\n+CREG: 0\r\n
12:51:27 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
status 0 tech -1 lac -1 ci -1
12:51:27 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
(nil)
12:51:27 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
12:51:27 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
driver_attached: 0
12:51:27 info: Aux: < \r\n+CIEV: 2,2\r\n
12:51:30 info: Aux: < \r\n+CTZE: +08,1,"19/09/03,14:51:29"\r\n
12:51:30 debug:
../git/drivers/ubloxmodem/network-registration.c:ctze_notify() tz +08 dst 1
time 19/09/03,14:51:29
12:51:30 debug: ../git/src/network.c:ofono_netreg_time_notify() net time
2019-09-03 14:51:29 utcoff 7200 dst 1
12:51:30 info: Aux: < \r\n+CREG: 5,"0080","00000006",2\r\n
12:51:30 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
status 5 tech 2 lac 128 ci 6
12:51:30 debug: ../git/src/gprs.c:netreg_status_changed() 5 (roaming)
12:51:30 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 0
12:51:30 info: Aux: > AT\r
12:51:30 info: Aux: < \r\n+CIEV: 7,1\r\n
12:51:30 info: Aux: < \r\nOK\r\n
12:51:30 info: Aux: Finally woke up the modem
12:51:30 info: Aux: > AT+COPS=3D3,2\r
12:51:30 info: Aux: < \r\nOK\r\n
12:51:30 info: Aux: > AT+COPS?\r
12:51:30 info: Aux: < \r\n+COPS: 0,2,"24002",2\r\n
12:51:30 info: Aux: < \r\nOK\r\n
12:51:30 debug:
../git/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
numeric got mcc: 240, mnc: 02
12:51:30 info: Aux: > AT+CSQ\r
12:51:30 info: Aux: < \r\n+CSQ: 11,1\r\n
12:51:30 info: Aux: < \r\nOK\r\n
12:51:30 debug: ../git/drivers/atmodem/network-registration.c:csq_cb()
csq_cb: 11
12:51:30 debug: ../git/src/network.c:ofono_netreg_strength_notify()
strength 35
12:51:30 info: Aux: > AT+CGATT=3D1\r
12:51:37 info: Aux: < \r\n+CME ERROR: 148\r\n
12:51:37 debug: ../git/src/gprs.c:gprs_attach_callback() /ublox_0 error =3D=
 1
12:51:37 info: Aux: > AT+COPS=3D3,0\r
12:51:37 info: Aux: < \r\n+CIEV: 2,3\r\n
12:51:37 info: Aux: < \r\n+CREG: 0\r\n
12:51:37 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
status 0 tech -1 lac -1 ci -1
12:51:37 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
(nil)
12:51:37 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
12:51:37 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
driver_attached: 0
12:51:37 info: Aux: < \r\n+CIEV: 7,0\r\n\r\n+CREG: 3\r\n
12:51:37 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
status 3 tech -1 lac -1 ci -1
12:51:37 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
(nil)
12:51:37 debug: ../git/src/gprs.c:netreg_status_changed() 3 (denied)
12:51:37 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
driver_attached: 0
12:51:37 info: Aux: < \r\nOK\r\n
12:51:37 info: Aux: > AT+COPS?\r
12:51:37 info: Aux: < \r\n+COPS: 0\r\n
12:51:37 info: Aux: < \r\nOK\r\n
12:51:37 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
(nil)
12:51:37 info: Aux: > AT+CGREG?\r
12:51:37 info: Aux: < \r\n+CGREG: 2,3\r\n
12:51:37 info: Aux: < \r\nOK\r\n
12:51:37 debug: ../git/src/gprs.c:registration_status_cb() /ublox_0 error 0
status 3
12:51:37 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
status denied (3)
12:51:47 info: Aux: < \r\n+CIEV: 2,1\r\n
12:51:48 info: Aux: < \r\n+CIEV: 2,2\r\n
12:51:49 info: Aux: < \r\n+CIEV: 2,1\r\n
12:51:50 info: Aux: < \r\n+CREG: 0\r\n
12:51:50 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
status 0 tech -1 lac -1 ci -1
12:51:50 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
(nil)
12:51:50 debug: ../git/src/gprs.c:netreg_status_changed() 0 (unregistered)
12:51:50 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 0,
driver_attached: 0
12:51:50 info: Aux: < \r\n+CGREG: 5,"4E85","000003EA",2,"01"\r\n
12:51:50 debug: ../git/src/gprs.c:ofono_gprs_status_notify() /ublox_0
status roaming (5)
12:51:50 info: Aux: < \r\n+UREG: 3\r\n
12:51:50 info: Aux: < \r\n+CIEV: 9,2\r\n
12:51:50 info: Aux: < \r\n+CTZE: +08,1,"19/09/03,14:51:50"\r\n
12:51:50 debug:
../git/drivers/ubloxmodem/network-registration.c:ctze_notify() tz +08 dst 1
time 19/09/03,14:51:50
12:51:50 debug: ../git/src/network.c:ofono_netreg_time_notify() net time
2019-09-03 14:51:50 utcoff 7200 dst 1
12:51:50 info: Aux: < \r\n+CREG: 5,"0E63","8CD17D00",2\r\n
12:51:50 debug: ../git/src/network.c:ofono_netreg_status_notify() /ublox_0
status 5 tech 2 lac 3683 ci 2147483647
12:51:50 debug: ../git/src/gprs.c:netreg_status_changed() 5 (roaming)
12:51:50 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
12:51:50 info: Aux: > AT\r
12:51:50 info: Aux: < \r\n+CIEV: 7,1\r\n
12:51:50 info: Aux: < \r\nOK\r\n
12:51:50 info: Aux: Finally woke up the modem
12:51:50 info: Aux: > AT+COPS=3D3,2\r
12:51:50 info: Aux: < \r\nOK\r\n
12:51:50 info: Aux: > AT+COPS?\r
12:51:50 info: Aux: < \r\n+COPS: 0,2,"24002",2\r\n
12:51:50 info: Aux: < \r\nOK\r\n
12:51:50 debug:
../git/drivers/atmodem/network-registration.c:cops_numeric_cb() Cops
numeric got mcc: 240, mnc: 02
12:51:50 info: Aux: > AT+CSQ\r
12:51:50 info: Aux: < \r\n+CSQ: 8,1\r\n
12:51:50 info: Aux: < \r\nOK\r\n
12:51:50 debug: ../git/drivers/atmodem/network-registration.c:csq_cb()
csq_cb: 8
12:51:50 debug: ../git/src/network.c:ofono_netreg_strength_notify()
strength 25
12:51:50 info: Aux: > AT+COPS=3D3,0\r
12:51:50 info: Aux: < \r\nOK\r\n
12:51:50 info: Aux: > AT+COPS?\r
12:51:50 info: Aux: < \r\n+COPS: 0,0,"3 SE",2\r\n
12:51:50 info: Aux: < \r\nOK\r\n
12:51:50 debug: ../git/drivers/atmodem/network-registration.c:cops_cb()
cops_cb: 3 SE, 240 02 2
12:51:50 debug: ../git/src/network.c:current_operator_callback() 0x6f2440,
(nil)
12:51:50 debug: ../git/src/gprs.c:netreg_status_changed() 5 (roaming)
12:51:50 debug: ../git/src/gprs.c:gprs_netreg_update() attach: 1,
driver_attached: 1
12:51:52 info: Aux: < \r\n+CGEV: ME PDN DEACT 4\r\n
12:51:53 info: Aux: < \r\n+CIEV: 2,2\r\n
12:52:03 info: Aux: < \r\n+CIEV: 2,1\r\n
12:52:08 info: Aux: < \r\n+CIEV: 2,2\r\n
12:52:14 info: Aux: < \r\n+CIEV: 2,1\r\n

Den tis 3 sep. 2019 kl 16:06 skrev <richard.rojfors@gmail.com>:

> From: Richard R=C3=B6jfors <richard@puffinpack.se>
>
> In case a context get deactivated when a AT+CGACT=3D0 is
> not issued, indicate that to gprs core.
> This can happen if the device has an auto activated
> LTE context and modem switches over to for instance UTRAN.
> ---
>  drivers/ubloxmodem/gprs-context.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ubloxmodem/gprs-context.c
> b/drivers/ubloxmodem/gprs-context.c
> index ff78a42a..188c2c62 100644
> --- a/drivers/ubloxmodem/gprs-context.c
> +++ b/drivers/ubloxmodem/gprs-context.c
> @@ -40,6 +40,8 @@
>
>  #include "ubloxmodem.h"
>
> +#define UBLOX_FLAG_DEACTIVATING 0x01
> +
>  static const char *none_prefix[] =3D { NULL };
>  static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
>  static const char *uipaddr_prefix[] =3D { "+UIPADDR:", NULL };
> @@ -57,6 +59,7 @@ struct gprs_context_data {
>         ofono_gprs_context_cb_t cb;
>         void *cb_data;
>         enum netmode networking_mode;
> +       int flags;
>  };
>
>  static void uipaddr_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> @@ -426,6 +429,8 @@ static void cgact_disable_cb(gboolean ok, GAtResult
> *result, gpointer user_data)
>
>         DBG("ok %d", ok);
>
> +       gcd->flags &=3D ~UBLOX_FLAG_DEACTIVATING;
> +
>         if (!ok) {
>                 CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
>                 return;
> @@ -448,6 +453,8 @@ static void ublox_gprs_deactivate_primary(struct
> ofono_gprs_context *gc,
>         gcd->cb =3D cb;
>         gcd->cb_data =3D data;
>
> +       gcd->flags |=3D UBLOX_FLAG_DEACTIVATING;
> +
>         snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", gcd->active_context=
);
>         g_at_chat_send(gcd->chat, buf, none_prefix,
>                         cgact_disable_cb, gc, NULL);
> @@ -473,10 +480,16 @@ static void cgev_notify(GAtResult *result, gpointer
> user_data)
>                 sscanf(event, "%*s %*s %*s %u", &cid);
>         else if (g_str_has_prefix(event, "NW DEACT"))
>                 sscanf(event, "%*s %*s %u", &cid);
> +       else if (!(gcd->flags & UBLOX_FLAG_DEACTIVATING) &&
> +                g_str_has_prefix(event, "ME PDN DEACT"))
> +               /* The modem might consider the ME deactivating without
> +                * an explicit CGACT=3D0 beeing sent
> +                */
> +               sscanf(event, "%*s %*s %*s %u", &cid);
>         else
>                 return;
>
> -       DBG("cid %d", cid);
> +       DBG("cid %d, active cid: %d", cid, gcd->active_context);
>
>         if ((unsigned int) cid !=3D gcd->active_context)
>                 return;
> --
> 2.20.1
>
>

--===============2041432482474554235==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5BbiBleGFtcGxlIGxvZyB3aGVu
IHRoaXMgaGFwcGVuZWQuIEluIHRoaXMgY2FzZSBvZm9ubyB0aG91Z2h0IGNvbnRleHQgNCB3YXMg
c3RpbGwgYWN0aXZhdGVkPC9kaXY+PGRpdj5ldmVuIHRob3VnaCBpdCB3YXMgZGVhY3RpdmF0ZWQ8
YnI+PGJyPjEyOjQ3OjUyIGluZm86IEF1eDogJmx0OyBcclxuK0NJRVY6IDksMlxyXG48YnI+MTI6
NTA6MzcgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogMiwyXHJcbjxicj4xMjo1MDo0MiBpbmZv
OiBBdXg6ICZsdDsgXHJcbitDSUVWOiAyLDFcclxuPGJyPjEyOjUxOjA2IGluZm86IEF1eDogJmx0
OyBcclxuK0NJRVY6IDIsMFxyXG48YnI+MTI6NTE6MDggaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0dS
RUc6IDUsJnF1b3Q7MDA0QiZxdW90OywmcXVvdDswMDAwRTQwNCZxdW90Oyw2LCZxdW90OzAxJnF1
b3Q7XHJcbjxicj4xMjo1MTowOCBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19z
dGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3RhdHVzIHJvYW1pbmcgKDUpPGJyPjEyOjUxOjA4IGlu
Zm86IEF1eDogJmx0OyBcclxuK1VSRUc6IDZcclxuPGJyPjEyOjUxOjA4IGluZm86IEF1eDogJmx0
OyBcclxuK0NJRVY6IDksMlxyXG48YnI+MTI6NTE6MDggaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lF
VjogOSwxXHJcbjxicj4xMjo1MTowOSBpbmZvOiBBdXg6ICZsdDsgXHJcbitDR0VWOiBOVyBNT0RJ
RlkgNCwwLDBcclxuPGJyPjEyOjUxOjE2IGluZm86IEF1eDogJmx0OyBcclxuK0NSRUc6IDBcclxu
PGJyPjEyOjUxOjE2IGRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3Rh
dHVzX25vdGlmeSgpIC91YmxveF8wIHN0YXR1cyAwIHRlY2ggLTEgbGFjIC0xIGNpIC0xPGJyPjEy
OjUxOjE2IGRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpjdXJyZW50X29wZXJhdG9yX2NhbGxi
YWNrKCkgMHg2ZjI0NDAsIDB4NmYyZmU4PGJyPjEyOjUxOjE2IGRlYnVnOiAuLi9naXQvc3JjL2dw
cnMuYzpuZXRyZWdfc3RhdHVzX2NoYW5nZWQoKSAwICh1bnJlZ2lzdGVyZWQpPGJyPjEyOjUxOjE2
IGRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpncHJzX25ldHJlZ191cGRhdGUoKSBhdHRhY2g6IDAs
IGRyaXZlcl9hdHRhY2hlZDogMTxicj4xMjo1MToxNiBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6
bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMCAodW5yZWdpc3RlcmVkKTxicj4xMjo1MToxNiBkZWJ1
ZzogLi4vZ2l0L3NyYy9ncHJzLmM6Z3Byc19uZXRyZWdfdXBkYXRlKCkgYXR0YWNoOiAwLCBkcml2
ZXJfYXR0YWNoZWQ6IDA8YnI+MTI6NTE6MTYgaW5mbzogQXV4OiAmZ3Q7IEFUXHI8YnI+MTI6NTE6
MTYgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogNywwXHJcbjxicj4xMjo1MToxNiBpbmZvOiBB
dXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MToxNiBpbmZvOiBBdXg6IEZpbmFsbHkgd29rZSB1
cCB0aGUgbW9kZW08YnI+MTI6NTE6MTYgaW5mbzogQXV4OiAmZ3Q7IEFUK0NHQVRUPTBccjxicj4x
Mjo1MToxNiBpbmZvOiBBdXg6ICZsdDsgXHJcbitDR1JFRzogNFxyXG48YnI+MTI6NTE6MTYgZGVi
dWc6IC4uL2dpdC9zcmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC91YmxveF8w
IHN0YXR1cyB1bmtub3duICg0KTxicj4xMjo1MToxNiBpbmZvOiBBdXg6ICZsdDsgXHJcbitVUkVH
OiAwXHJcbjxicj4xMjo1MToxNiBpbmZvOiBBdXg6ICZsdDsgXHJcbitDSUVWOiA5LDFcclxuPGJy
PjEyOjUxOjE2IGluZm86IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPjEyOjUxOjE2IGRlYnVnOiAu
Li9naXQvc3JjL2dwcnMuYzpncHJzX2F0dGFjaF9jYWxsYmFjaygpIC91YmxveF8wIGVycm9yID0g
MDxicj4xMjo1MToxNiBpbmZvOiBBdXg6ICZndDsgQVQrQ0dSRUc/XHI8YnI+MTI6NTE6MTYgaW5m
bzogQXV4OiAmbHQ7IFxyXG4rQ0dSRUc6IDIsNFxyXG48YnI+MTI6NTE6MTYgaW5mbzogQXV4OiAm
bHQ7IFxyXG5PS1xyXG48YnI+MTI6NTE6MTYgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOnJlZ2lz
dHJhdGlvbl9zdGF0dXNfY2IoKSAvdWJsb3hfMCBlcnJvciAwIHN0YXR1cyA0PGJyPjEyOjUxOjE2
IGRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvdWJs
b3hfMCBzdGF0dXMgdW5rbm93biAoNCk8YnI+MTI6NTE6MjcgaW5mbzogQXV4OiAmbHQ7IFxyXG4r
Q1JFRzogMFxyXG48YnI+MTI6NTE6MjcgZGVidWc6IC4uL2dpdC9zcmMvbmV0d29yay5jOm9mb25v
X25ldHJlZ19zdGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3RhdHVzIDAgdGVjaCAtMSBsYWMgLTEg
Y2kgLTE8YnI+MTI6NTE6MjcgZGVidWc6IC4uL2dpdC9zcmMvbmV0d29yay5jOmN1cnJlbnRfb3Bl
cmF0b3JfY2FsbGJhY2soKSAweDZmMjQ0MCwgKG5pbCk8YnI+MTI6NTE6MjcgZGVidWc6IC4uL2dp
dC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDAgKHVucmVnaXN0ZXJlZCk8YnI+
MTI6NTE6MjcgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfbmV0cmVnX3VwZGF0ZSgpIGF0
dGFjaDogMCwgZHJpdmVyX2F0dGFjaGVkOiAwPGJyPjEyOjUxOjI3IGluZm86IEF1eDogJmx0OyBc
clxuK0NJRVY6IDIsMlxyXG48YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ1RaRTog
KzA4LDEsJnF1b3Q7MTkvMDkvMDMsMTQ6NTE6MjkmcXVvdDtcclxuPGJyPjEyOjUxOjMwIGRlYnVn
OiAuLi9naXQvZHJpdmVycy91YmxveG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y3R6ZV9u
b3RpZnkoKSB0eiArMDggZHN0IDEgdGltZSAxOS8wOS8wMywxNDo1MToyOTxicj4xMjo1MTozMCBk
ZWJ1ZzogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3RpbWVfbm90aWZ5KCkgbmV0
IHRpbWUgMjAxOS0wOS0wMyAxNDo1MToyOSB1dGNvZmYgNzIwMCBkc3QgMTxicj4xMjo1MTozMCBp
bmZvOiBBdXg6ICZsdDsgXHJcbitDUkVHOiA1LCZxdW90OzAwODAmcXVvdDssJnF1b3Q7MDAwMDAw
MDYmcXVvdDssMlxyXG48YnI+MTI6NTE6MzAgZGVidWc6IC4uL2dpdC9zcmMvbmV0d29yay5jOm9m
b25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3RhdHVzIDUgdGVjaCAyIGxhYyAx
MjggY2kgNjxicj4xMjo1MTozMCBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6bmV0cmVnX3N0YXR1
c19jaGFuZ2VkKCkgNSAocm9hbWluZyk8YnI+MTI6NTE6MzAgZGVidWc6IC4uL2dpdC9zcmMvZ3By
cy5jOmdwcnNfbmV0cmVnX3VwZGF0ZSgpIGF0dGFjaDogMSwgZHJpdmVyX2F0dGFjaGVkOiAwPGJy
PjEyOjUxOjMwIGluZm86IEF1eDogJmd0OyBBVFxyPGJyPjEyOjUxOjMwIGluZm86IEF1eDogJmx0
OyBcclxuK0NJRVY6IDcsMVxyXG48YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmbHQ7IFxyXG5PS1xy
XG48YnI+MTI6NTE6MzAgaW5mbzogQXV4OiBGaW5hbGx5IHdva2UgdXAgdGhlIG1vZGVtPGJyPjEy
OjUxOjMwIGluZm86IEF1eDogJmd0OyBBVCtDT1BTPTMsMlxyPGJyPjEyOjUxOjMwIGluZm86IEF1
eDogJmx0OyBcclxuT0tcclxuPGJyPjEyOjUxOjMwIGluZm86IEF1eDogJmd0OyBBVCtDT1BTP1xy
PGJyPjEyOjUxOjMwIGluZm86IEF1eDogJmx0OyBcclxuK0NPUFM6IDAsMiwmcXVvdDsyNDAwMiZx
dW90OywyXHJcbjxicj4xMjo1MTozMCBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1
MTozMCBkZWJ1ZzogLi4vZ2l0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5j
OmNvcHNfbnVtZXJpY19jYigpIENvcHMgbnVtZXJpYyBnb3QgbWNjOiAyNDAsIG1uYzogMDI8YnI+
MTI6NTE6MzAgaW5mbzogQXV4OiAmZ3Q7IEFUK0NTUVxyPGJyPjEyOjUxOjMwIGluZm86IEF1eDog
Jmx0OyBcclxuK0NTUTogMTEsMVxyXG48YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmbHQ7IFxyXG5P
S1xyXG48YnI+MTI6NTE6MzAgZGVidWc6IC4uL2dpdC9kcml2ZXJzL2F0bW9kZW0vbmV0d29yay1y
ZWdpc3RyYXRpb24uYzpjc3FfY2IoKSBjc3FfY2I6IDExPGJyPjEyOjUxOjMwIGRlYnVnOiAuLi9n
aXQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RyZW5ndGhfbm90aWZ5KCkgc3RyZW5ndGgg
MzU8YnI+MTI6NTE6MzAgaW5mbzogQXV4OiAmZ3Q7IEFUK0NHQVRUPTFccjxicj4xMjo1MTozNyBp
bmZvOiBBdXg6ICZsdDsgXHJcbitDTUUgRVJST1I6IDE0OFxyXG48YnI+MTI6NTE6MzcgZGVidWc6
IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfYXR0YWNoX2NhbGxiYWNrKCkgL3VibG94XzAgZXJyb3Ig
PSAxPGJyPjEyOjUxOjM3IGluZm86IEF1eDogJmd0OyBBVCtDT1BTPTMsMFxyPGJyPjEyOjUxOjM3
IGluZm86IEF1eDogJmx0OyBcclxuK0NJRVY6IDIsM1xyXG48YnI+MTI6NTE6MzcgaW5mbzogQXV4
OiAmbHQ7IFxyXG4rQ1JFRzogMFxyXG48YnI+MTI6NTE6MzcgZGVidWc6IC4uL2dpdC9zcmMvbmV0
d29yay5jOm9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3RhdHVzIDAgdGVj
aCAtMSBsYWMgLTEgY2kgLTE8YnI+MTI6NTE6MzcgZGVidWc6IC4uL2dpdC9zcmMvbmV0d29yay5j
OmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2soKSAweDZmMjQ0MCwgKG5pbCk8YnI+MTI6NTE6Mzcg
ZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDAgKHVucmVn
aXN0ZXJlZCk8YnI+MTI6NTE6MzcgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOmdwcnNfbmV0cmVn
X3VwZGF0ZSgpIGF0dGFjaDogMCwgZHJpdmVyX2F0dGFjaGVkOiAwPGJyPjEyOjUxOjM3IGluZm86
IEF1eDogJmx0OyBcclxuK0NJRVY6IDcsMFxyXG5cclxuK0NSRUc6IDNcclxuPGJyPjEyOjUxOjM3
IGRlYnVnOiAuLi9naXQvc3JjL25ldHdvcmsuYzpvZm9ub19uZXRyZWdfc3RhdHVzX25vdGlmeSgp
IC91YmxveF8wIHN0YXR1cyAzIHRlY2ggLTEgbGFjIC0xIGNpIC0xPGJyPjEyOjUxOjM3IGRlYnVn
OiAuLi9naXQvc3JjL25ldHdvcmsuYzpjdXJyZW50X29wZXJhdG9yX2NhbGxiYWNrKCkgMHg2ZjI0
NDAsIChuaWwpPGJyPjEyOjUxOjM3IGRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpuZXRyZWdfc3Rh
dHVzX2NoYW5nZWQoKSAzIChkZW5pZWQpPGJyPjEyOjUxOjM3IGRlYnVnOiAuLi9naXQvc3JjL2dw
cnMuYzpncHJzX25ldHJlZ191cGRhdGUoKSBhdHRhY2g6IDAsIGRyaXZlcl9hdHRhY2hlZDogMDxi
cj4xMjo1MTozNyBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MTozNyBpbmZvOiBB
dXg6ICZndDsgQVQrQ09QUz9ccjxicj4xMjo1MTozNyBpbmZvOiBBdXg6ICZsdDsgXHJcbitDT1BT
OiAwXHJcbjxicj4xMjo1MTozNyBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MToz
NyBkZWJ1ZzogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygp
IDB4NmYyNDQwLCAobmlsKTxicj4xMjo1MTozNyBpbmZvOiBBdXg6ICZndDsgQVQrQ0dSRUc/XHI8
YnI+MTI6NTE6MzcgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0dSRUc6IDIsM1xyXG48YnI+MTI6NTE6
MzcgaW5mbzogQXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+MTI6NTE6MzcgZGVidWc6IC4uL2dpdC9z
cmMvZ3Bycy5jOnJlZ2lzdHJhdGlvbl9zdGF0dXNfY2IoKSAvdWJsb3hfMCBlcnJvciAwIHN0YXR1
cyAzPGJyPjEyOjUxOjM3IGRlYnVnOiAuLi9naXQvc3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1
c19ub3RpZnkoKSAvdWJsb3hfMCBzdGF0dXMgZGVuaWVkICgzKTxicj4xMjo1MTo0NyBpbmZvOiBB
dXg6ICZsdDsgXHJcbitDSUVWOiAyLDFcclxuPGJyPjEyOjUxOjQ4IGluZm86IEF1eDogJmx0OyBc
clxuK0NJRVY6IDIsMlxyXG48YnI+MTI6NTE6NDkgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjog
MiwxXHJcbjxicj4xMjo1MTo1MCBpbmZvOiBBdXg6ICZsdDsgXHJcbitDUkVHOiAwXHJcbjxicj4x
Mjo1MTo1MCBkZWJ1ZzogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19u
b3RpZnkoKSAvdWJsb3hfMCBzdGF0dXMgMCB0ZWNoIC0xIGxhYyAtMSBjaSAtMTxicj4xMjo1MTo1
MCBkZWJ1ZzogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygp
IDB4NmYyNDQwLCAobmlsKTxicj4xMjo1MTo1MCBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6bmV0
cmVnX3N0YXR1c19jaGFuZ2VkKCkgMCAodW5yZWdpc3RlcmVkKTxicj4xMjo1MTo1MCBkZWJ1Zzog
Li4vZ2l0L3NyYy9ncHJzLmM6Z3Byc19uZXRyZWdfdXBkYXRlKCkgYXR0YWNoOiAwLCBkcml2ZXJf
YXR0YWNoZWQ6IDA8YnI+MTI6NTE6NTAgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ0dSRUc6IDUsJnF1
b3Q7NEU4NSZxdW90OywmcXVvdDswMDAwMDNFQSZxdW90OywyLCZxdW90OzAxJnF1b3Q7XHJcbjxi
cj4xMjo1MTo1MCBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6b2Zvbm9fZ3Byc19zdGF0dXNfbm90
aWZ5KCkgL3VibG94XzAgc3RhdHVzIHJvYW1pbmcgKDUpPGJyPjEyOjUxOjUwIGluZm86IEF1eDog
Jmx0OyBcclxuK1VSRUc6IDNcclxuPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmx0OyBcclxuK0NJ
RVY6IDksMlxyXG48YnI+MTI6NTE6NTAgaW5mbzogQXV4OiAmbHQ7IFxyXG4rQ1RaRTogKzA4LDEs
JnF1b3Q7MTkvMDkvMDMsMTQ6NTE6NTAmcXVvdDtcclxuPGJyPjEyOjUxOjUwIGRlYnVnOiAuLi9n
aXQvZHJpdmVycy91YmxveG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y3R6ZV9ub3RpZnko
KSB0eiArMDggZHN0IDEgdGltZSAxOS8wOS8wMywxNDo1MTo1MDxicj4xMjo1MTo1MCBkZWJ1Zzog
Li4vZ2l0L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3RpbWVfbm90aWZ5KCkgbmV0IHRpbWUg
MjAxOS0wOS0wMyAxNDo1MTo1MCB1dGNvZmYgNzIwMCBkc3QgMTxicj4xMjo1MTo1MCBpbmZvOiBB
dXg6ICZsdDsgXHJcbitDUkVHOiA1LCZxdW90OzBFNjMmcXVvdDssJnF1b3Q7OENEMTdEMDAmcXVv
dDssMlxyXG48YnI+MTI6NTE6NTAgZGVidWc6IC4uL2dpdC9zcmMvbmV0d29yay5jOm9mb25vX25l
dHJlZ19zdGF0dXNfbm90aWZ5KCkgL3VibG94XzAgc3RhdHVzIDUgdGVjaCAyIGxhYyAzNjgzIGNp
IDIxNDc0ODM2NDc8YnI+MTI6NTE6NTAgZGVidWc6IC4uL2dpdC9zcmMvZ3Bycy5jOm5ldHJlZ19z
dGF0dXNfY2hhbmdlZCgpIDUgKHJvYW1pbmcpPGJyPjEyOjUxOjUwIGRlYnVnOiAuLi9naXQvc3Jj
L2dwcnMuYzpncHJzX25ldHJlZ191cGRhdGUoKSBhdHRhY2g6IDEsIGRyaXZlcl9hdHRhY2hlZDog
MTxicj4xMjo1MTo1MCBpbmZvOiBBdXg6ICZndDsgQVRccjxicj4xMjo1MTo1MCBpbmZvOiBBdXg6
ICZsdDsgXHJcbitDSUVWOiA3LDFcclxuPGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmx0OyBcclxu
T0tcclxuPGJyPjEyOjUxOjUwIGluZm86IEF1eDogRmluYWxseSB3b2tlIHVwIHRoZSBtb2RlbTxi
cj4xMjo1MTo1MCBpbmZvOiBBdXg6ICZndDsgQVQrQ09QUz0zLDJccjxicj4xMjo1MTo1MCBpbmZv
OiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MTo1MCBpbmZvOiBBdXg6ICZndDsgQVQrQ09Q
Uz9ccjxicj4xMjo1MTo1MCBpbmZvOiBBdXg6ICZsdDsgXHJcbitDT1BTOiAwLDIsJnF1b3Q7MjQw
MDImcXVvdDssMlxyXG48YnI+MTI6NTE6NTAgaW5mbzogQXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+
MTI6NTE6NTAgZGVidWc6IC4uL2dpdC9kcml2ZXJzL2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRp
b24uYzpjb3BzX251bWVyaWNfY2IoKSBDb3BzIG51bWVyaWMgZ290IG1jYzogMjQwLCBtbmM6IDAy
PGJyPjEyOjUxOjUwIGluZm86IEF1eDogJmd0OyBBVCtDU1Fccjxicj4xMjo1MTo1MCBpbmZvOiBB
dXg6ICZsdDsgXHJcbitDU1E6IDgsMVxyXG48YnI+MTI6NTE6NTAgaW5mbzogQXV4OiAmbHQ7IFxy
XG5PS1xyXG48YnI+MTI6NTE6NTAgZGVidWc6IC4uL2dpdC9kcml2ZXJzL2F0bW9kZW0vbmV0d29y
ay1yZWdpc3RyYXRpb24uYzpjc3FfY2IoKSBjc3FfY2I6IDg8YnI+MTI6NTE6NTAgZGVidWc6IC4u
L2dpdC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19zdHJlbmd0aF9ub3RpZnkoKSBzdHJlbmd0
aCAyNTxicj4xMjo1MTo1MCBpbmZvOiBBdXg6ICZndDsgQVQrQ09QUz0zLDBccjxicj4xMjo1MTo1
MCBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4xMjo1MTo1MCBpbmZvOiBBdXg6ICZndDsg
QVQrQ09QUz9ccjxicj4xMjo1MTo1MCBpbmZvOiBBdXg6ICZsdDsgXHJcbitDT1BTOiAwLDAsJnF1
b3Q7MyBTRSZxdW90OywyXHJcbjxicj4xMjo1MTo1MCBpbmZvOiBBdXg6ICZsdDsgXHJcbk9LXHJc
bjxicj4xMjo1MTo1MCBkZWJ1ZzogLi4vZ2l0L2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lz
dHJhdGlvbi5jOmNvcHNfY2IoKSBjb3BzX2NiOiAzIFNFLCAyNDAgMDIgMjxicj4xMjo1MTo1MCBk
ZWJ1ZzogLi4vZ2l0L3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4
NmYyNDQwLCAobmlsKTxicj4xMjo1MTo1MCBkZWJ1ZzogLi4vZ2l0L3NyYy9ncHJzLmM6bmV0cmVn
X3N0YXR1c19jaGFuZ2VkKCkgNSAocm9hbWluZyk8YnI+MTI6NTE6NTAgZGVidWc6IC4uL2dpdC9z
cmMvZ3Bycy5jOmdwcnNfbmV0cmVnX3VwZGF0ZSgpIGF0dGFjaDogMSwgZHJpdmVyX2F0dGFjaGVk
OiAxPGJyPjEyOjUxOjUyIGluZm86IEF1eDogJmx0OyBcclxuK0NHRVY6IE1FIFBETiBERUFDVCA0
XHJcbjxicj4xMjo1MTo1MyBpbmZvOiBBdXg6ICZsdDsgXHJcbitDSUVWOiAyLDJcclxuPGJyPjEy
OjUyOjAzIGluZm86IEF1eDogJmx0OyBcclxuK0NJRVY6IDIsMVxyXG48YnI+MTI6NTI6MDggaW5m
bzogQXV4OiAmbHQ7IFxyXG4rQ0lFVjogMiwyXHJcbjxicj4xMjo1MjoxNCBpbmZvOiBBdXg6ICZs
dDsgXHJcbitDSUVWOiAyLDFcclxuPGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPkRlbiB0aXMgMyBzZXAu
IDIwMTkga2wgMTY6MDYgc2tyZXYgJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkLnJvamZvcnNA
Z21haWwuY29tIj5yaWNoYXJkLnJvamZvcnNAZ21haWwuY29tPC9hPiZndDs6PGJyPjwvZGl2Pjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAw
LjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6
MWV4Ij5Gcm9tOiBSaWNoYXJkIFLDtmpmb3JzICZsdDs8YSBocmVmPSJtYWlsdG86cmljaGFyZEBw
dWZmaW5wYWNrLnNlIiB0YXJnZXQ9Il9ibGFuayI+cmljaGFyZEBwdWZmaW5wYWNrLnNlPC9hPiZn
dDs8YnI+Cjxicj4KSW4gY2FzZSBhIGNvbnRleHQgZ2V0IGRlYWN0aXZhdGVkIHdoZW4gYSBBVCtD
R0FDVD0wIGlzPGJyPgpub3QgaXNzdWVkLCBpbmRpY2F0ZSB0aGF0IHRvIGdwcnMgY29yZS48YnI+
ClRoaXMgY2FuIGhhcHBlbiBpZiB0aGUgZGV2aWNlIGhhcyBhbiBhdXRvIGFjdGl2YXRlZDxicj4K
TFRFIGNvbnRleHQgYW5kIG1vZGVtIHN3aXRjaGVzIG92ZXIgdG8gZm9yIGluc3RhbmNlIFVUUkFO
Ljxicj4KLS0tPGJyPgrCoGRyaXZlcnMvdWJsb3htb2RlbS9ncHJzLWNvbnRleHQuYyB8IDE1ICsr
KysrKysrKysrKysrLTxicj4KwqAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKTxicj4KPGJyPgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91YmxveG1vZGVtL2dwcnMt
Y29udGV4dC5jIGIvZHJpdmVycy91YmxveG1vZGVtL2dwcnMtY29udGV4dC5jPGJyPgppbmRleCBm
Zjc4YTQyYS4uMTg4YzJjNjIgMTAwNjQ0PGJyPgotLS0gYS9kcml2ZXJzL3VibG94bW9kZW0vZ3By
cy1jb250ZXh0LmM8YnI+CisrKyBiL2RyaXZlcnMvdWJsb3htb2RlbS9ncHJzLWNvbnRleHQuYzxi
cj4KQEAgLTQwLDYgKzQwLDggQEA8YnI+Cjxicj4KwqAjaW5jbHVkZSAmcXVvdDt1YmxveG1vZGVt
LmgmcXVvdDs8YnI+Cjxicj4KKyNkZWZpbmUgVUJMT1hfRkxBR19ERUFDVElWQVRJTkcgMHgwMTxi
cj4KKzxicj4KwqBzdGF0aWMgY29uc3QgY2hhciAqbm9uZV9wcmVmaXhbXSA9IHsgTlVMTCB9Ozxi
cj4KwqBzdGF0aWMgY29uc3QgY2hhciAqY2djb250cmRwX3ByZWZpeFtdID0geyAmcXVvdDsrQ0dD
T05UUkRQOiZxdW90OywgTlVMTCB9Ozxicj4KwqBzdGF0aWMgY29uc3QgY2hhciAqdWlwYWRkcl9w
cmVmaXhbXSA9IHsgJnF1b3Q7K1VJUEFERFI6JnF1b3Q7LCBOVUxMIH07PGJyPgpAQCAtNTcsNiAr
NTksNyBAQCBzdHJ1Y3QgZ3Byc19jb250ZXh0X2RhdGEgezxicj4KwqAgwqAgwqAgwqAgb2Zvbm9f
Z3Byc19jb250ZXh0X2NiX3QgY2I7PGJyPgrCoCDCoCDCoCDCoCB2b2lkICpjYl9kYXRhOzxicj4K
wqAgwqAgwqAgwqAgZW51bSBuZXRtb2RlIG5ldHdvcmtpbmdfbW9kZTs8YnI+CivCoCDCoCDCoCDC
oGludCBmbGFnczs8YnI+CsKgfTs8YnI+Cjxicj4KwqBzdGF0aWMgdm9pZCB1aXBhZGRyX2NiKGdi
b29sZWFuIG9rLCBHQXRSZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KQEAg
LTQyNiw2ICs0MjksOCBAQCBzdGF0aWMgdm9pZCBjZ2FjdF9kaXNhYmxlX2NiKGdib29sZWFuIG9r
LCBHQXRSZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KPGJyPgrCoCDCoCDC
oCDCoCBEQkcoJnF1b3Q7b2sgJWQmcXVvdDssIG9rKTs8YnI+Cjxicj4KK8KgIMKgIMKgIMKgZ2Nk
LSZndDtmbGFncyAmYW1wOz0gflVCTE9YX0ZMQUdfREVBQ1RJVkFUSU5HOzxicj4KKzxicj4KwqAg
wqAgwqAgwqAgaWYgKCFvaykgezxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQ0FMTEJBQ0tf
V0lUSF9GQUlMVVJFKGdjZC0mZ3Q7Y2IsIGdjZC0mZ3Q7Y2JfZGF0YSk7PGJyPgrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCByZXR1cm47PGJyPgpAQCAtNDQ4LDYgKzQ1Myw4IEBAIHN0YXRpYyB2b2lk
IHVibG94X2dwcnNfZGVhY3RpdmF0ZV9wcmltYXJ5KHN0cnVjdCBvZm9ub19ncHJzX2NvbnRleHQg
KmdjLDxicj4KwqAgwqAgwqAgwqAgZ2NkLSZndDtjYiA9IGNiOzxicj4KwqAgwqAgwqAgwqAgZ2Nk
LSZndDtjYl9kYXRhID0gZGF0YTs8YnI+Cjxicj4KK8KgIMKgIMKgIMKgZ2NkLSZndDtmbGFncyB8
PSBVQkxPWF9GTEFHX0RFQUNUSVZBVElORzs8YnI+Cis8YnI+CsKgIMKgIMKgIMKgIHNucHJpbnRm
KGJ1Ziwgc2l6ZW9mKGJ1ZiksICZxdW90O0FUK0NHQUNUPTAsJXUmcXVvdDssIGdjZC0mZ3Q7YWN0
aXZlX2NvbnRleHQpOzxicj4KwqAgwqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQoZ2NkLSZndDtjaGF0
LCBidWYsIG5vbmVfcHJlZml4LDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgY2dhY3RfZGlzYWJsZV9jYiwgZ2MsIE5VTEwpOzxicj4KQEAgLTQ3MywxMCArNDgwLDE2IEBA
IHN0YXRpYyB2b2lkIGNnZXZfbm90aWZ5KEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2Vy
X2RhdGEpPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzc2NhbmYoZXZlbnQsICZxdW90OyUq
cyAlKnMgJSpzICV1JnF1b3Q7LCAmYW1wO2NpZCk7PGJyPgrCoCDCoCDCoCDCoCBlbHNlIGlmIChn
X3N0cl9oYXNfcHJlZml4KGV2ZW50LCAmcXVvdDtOVyBERUFDVCZxdW90OykpPGJyPgrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBzc2NhbmYoZXZlbnQsICZxdW90OyUqcyAlKnMgJXUmcXVvdDssICZh
bXA7Y2lkKTs8YnI+CivCoCDCoCDCoCDCoGVsc2UgaWYgKCEoZ2NkLSZndDtmbGFncyAmYW1wOyBV
QkxPWF9GTEFHX0RFQUNUSVZBVElORykgJmFtcDsmYW1wOzxicj4KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGdfc3RyX2hhc19wcmVmaXgoZXZlbnQsICZxdW90O01FIFBETiBERUFDVCZxdW90Oykp
PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBUaGUgbW9kZW0gbWlnaHQgY29uc2lkZXIg
dGhlIE1FIGRlYWN0aXZhdGluZyB3aXRob3V0PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
KiBhbiBleHBsaWNpdCBDR0FDVD0wIGJlZWluZyBzZW50PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgKi88YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNzY2FuZihldmVudCwgJnF1b3Q7
JSpzICUqcyAlKnMgJXUmcXVvdDssICZhbXA7Y2lkKTs8YnI+CsKgIMKgIMKgIMKgIGVsc2U8YnI+
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybjs8YnI+Cjxicj4KLcKgIMKgIMKgIMKgREJH
KCZxdW90O2NpZCAlZCZxdW90OywgY2lkKTs8YnI+CivCoCDCoCDCoCDCoERCRygmcXVvdDtjaWQg
JWQsIGFjdGl2ZSBjaWQ6ICVkJnF1b3Q7LCBjaWQsIGdjZC0mZ3Q7YWN0aXZlX2NvbnRleHQpOzxi
cj4KPGJyPgrCoCDCoCDCoCDCoCBpZiAoKHVuc2lnbmVkIGludCkgY2lkICE9IGdjZC0mZ3Q7YWN0
aXZlX2NvbnRleHQpPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PGJyPgotLSA8
YnI+CjIuMjAuMTxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============2041432482474554235==--

