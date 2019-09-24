Content-Type: multipart/mixed; boundary="===============1141145652694910334=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH 3/3] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 18:18:12 +0200
Message-ID: <CAHB-Pjmu_MZ+6TnMQy5ywATUGA1wsjrRAqGNdhekzx6X6t3ZNQ@mail.gmail.com>
In-Reply-To: <20190924113332.31729-3-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1141145652694910334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

Den tis 24 sep. 2019 kl 13:33 skrev Jonas Bonn <jonas@norrbonn.se>:

> uBlox devices present their USB interfaces well before those interfaces
> are ready to respond to any commands.  The documentation says to monitor
> the 'greeting text' to detect readiness, but this 'greeting text' is not
> actually specified for any device other than the TOBY L4.
>

....and in that case we could not restart ofono....


>
> What seems to work is to probe the device with 'AT' commands until the
> device responds, and then to wait an additional second before
> proceeding.  The TOBY L4 reliably sends its 'greeting text' (+AT: READY)
> within this interval.
>
> It would be more rigorous to actually wait for the 'READY' indication
> for the TOBY L4, but that would require knowing the device model before
> the device model is actually queried.  This is doable via the USB
> product ID, but overkill when the above heuristic seems to work
> reliably.
>
> Before this patch, the ublox plugin was trying to achieve something like
> the above with the g_at_chat_set_wakeup_command() function, but that had
> some issues:
>
> i)  it did not work reliably, in particular failing badly on the TOBY L4
> with responses getting out of sync with commands
>

I have seen this for L2 as well. I have a local patch which is ugly so I
did not push it here, where I flushed the commands.
It seems like the L2 buffers up the command and replies to all of the
later. Since we times out and forgets about commands
and don't use echo we get out of sync and model detection fails.



> ii) it was an inappropriate use of the wakeup_command which is intended
> for devices that may sleep when there is no communication during some
> interval
>

+1, very annoying since it happens after some URCs too.

Gah saw you had a new version sent out, will review the code there.

BR
Richard


> This patch adds an init sequence that probes the device for readiness
> before continuing with initialization.
> ---
>  plugins/ublox.c | 121 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 107 insertions(+), 14 deletions(-)
>
> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index 9ee38a6b..656dc553 100644
> --- a/plugins/ublox.c
> +++ b/plugins/ublox.c
> @@ -29,6 +29,7 @@
>  #include <glib.h>
>  #include <gatchat.h>
>  #include <gattty.h>
> +#include <ell/ell.h>
>
>  #define OFONO_API_SUBJECT_TO_CHANGE
>  #include <ofono/plugin.h>
> @@ -66,6 +67,10 @@ struct ublox_data {
>
>         const struct ublox_model *model;
>         int flags;
> +
> +       struct l_timeout *init_timeout;
> +       int init_count;
> +       guint init_cmd;
>  };
>
>  static void ublox_debug(const char *str, void *user_data)
> @@ -223,6 +228,82 @@ fail:
>         ofono_modem_set_powered(modem, FALSE);
>  }
>
> +static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
> +{
> +       struct ofono_modem *modem =3D user_data;
> +       struct ublox_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       if (!ok)
> +               goto fail;
> +
> +       /* When the 'init command' succeeds, we insert an additional
> +        * delay of 1 second before proceeding with the actual
> +        * intialization of the device.  We reuse the init_timeout
> +        * instance for this, just clearing the command to indicate
> +        * that additional retries aren't necessary.
> +        */
> +       data->init_cmd =3D 0;
> +       data->init_count =3D 0;
> +       l_timeout_modify_ms(data->init_timeout, 1000);
> +
> +       return;
> +
> +fail:
> +       l_timeout_remove(data->init_timeout);
> +       data->init_timeout =3D NULL;
> +
> +       g_at_chat_unref(data->aux);
> +       data->aux =3D NULL;
> +       g_at_chat_unref(data->modem);
> +       data->modem =3D NULL;
> +       ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static void init_timeout_cb(struct l_timeout *timeout, void *user_data)
> +{
> +       struct ofono_modem *modem =3D user_data;
> +       struct ublox_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       /* As long as init_cmd is set we need to either keep retrying
> +        * or fail everything after excessive retries
> +        */
> +       if (data->init_cmd && data->init_count++ < 20) {
> +               g_at_chat_retry(data->aux, data->init_cmd);
> +               l_timeout_modify_ms(timeout, 1000);
> +               return;
> +       }
> +
> +       l_timeout_remove(data->init_timeout);
> +       data->init_timeout =3D NULL;
> +
> +       if (data->init_cmd) {
> +               ofono_error("failed to init modem after 20 attempts");
> +               goto fail;
> +       }
> +
> +       g_at_chat_send(data->aux, "ATE0", none_prefix,
> +                                       NULL, NULL, NULL);
> +       g_at_chat_send(data->aux, "AT+CMEE=3D1", none_prefix,
> +                                       NULL, NULL, NULL);
> +
> +       if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
> +                               query_model_cb, modem, NULL) > 0)
> +               return;
> +
> +fail:
> +       g_at_chat_unref(data->aux);
> +       data->aux =3D NULL;
> +       g_at_chat_unref(data->modem);
> +       data->modem =3D NULL;
> +       ofono_modem_set_powered(modem, FALSE);
> +       return;
> +}
> +
> +
>  static int ublox_enable(struct ofono_modem *modem)
>  {
>         struct ublox_data *data =3D ofono_modem_get_data(modem);
> @@ -250,22 +331,34 @@ static int ublox_enable(struct ofono_modem *modem)
>                 g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL,
> NULL);
>         }
>
> -       /* The modem can take a while to wake up if just powered on. */
> -       g_at_chat_set_wakeup_command(data->aux, "AT\r", 1000, 11000);
> -
> -       g_at_chat_send(data->aux, "ATE0", none_prefix,
> -                                       NULL, NULL, NULL);
> -       g_at_chat_send(data->aux, "AT+CMEE=3D1", none_prefix,
> -                                       NULL, NULL, NULL);
> -
> -       if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
> -                               query_model_cb, modem, NULL) > 0)
> -               return -EINPROGRESS;
> +       /*
> +        * uBlox devices present their USB interfaces well before those
> +        * interfaces are actually ready to use.  The specs say to monitor
> +        * the 'greeting text' to detect whether the device is ready to
> use;
> +        * unfortunately, other than for the TOBY L4, the greeting text is
> +        * not actually specified.
> +        *
> +        * What has been determined experimentally to work is to probe wi=
th
> +        * an 'AT' command until it responds and then wait an additional
> +        * second before continuing with device initialization.  Even for
> +        * the TOBY L4 where one should wait for the '+AT: READY' URC
> +        * before intialization, this seems to be sufficient; the 'READY'
> +        * indication always arrives within this time.
> +        *
> +        * (It would be more rigorous to actually wait for the 'READY'
> +        * indication, but that would require knowing the device model
> +        * before the device model is actually queried.  Do-able via
> +        * USB Product ID, but overkill when the above seems to work
> +        * reliably.)
> +        */
>
> -       g_at_chat_unref(data->aux);
> -       data->aux =3D NULL;
> +       data->init_count =3D 0;
> +       data->init_cmd =3D g_at_chat_send(data->aux, "AT", none_prefix,
> +                                       init_cmd_cb, modem, NULL);
> +       data->init_timeout =3D l_timeout_create_ms(500, init_timeout_cb,
> modem,
> +                                                       NULL);
>
> -       return -EINVAL;
> +       return -EINPROGRESS;
>  }
>
>  static void cfun_disable(gboolean ok, GAtResult *result, gpointer
> user_data)
> --
> 2.20.1
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============1141145652694910334==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBKb25hcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gdGlzIDI0IHNlcC4g
MjAxOSBrbCAxMzozMyBza3JldiBKb25hcyBCb25uICZsdDs8YSBocmVmPSJtYWlsdG86am9uYXNA
bm9ycmJvbm4uc2UiPmpvbmFzQG5vcnJib25uLnNlPC9hPiZndDs6PGJyPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij51
QmxveCBkZXZpY2VzIHByZXNlbnQgdGhlaXIgVVNCIGludGVyZmFjZXMgd2VsbCBiZWZvcmUgdGhv
c2UgaW50ZXJmYWNlczxicj4KYXJlIHJlYWR5IHRvIHJlc3BvbmQgdG8gYW55IGNvbW1hbmRzLsKg
IFRoZSBkb2N1bWVudGF0aW9uIHNheXMgdG8gbW9uaXRvcjxicj4KdGhlICYjMzk7Z3JlZXRpbmcg
dGV4dCYjMzk7IHRvIGRldGVjdCByZWFkaW5lc3MsIGJ1dCB0aGlzICYjMzk7Z3JlZXRpbmcgdGV4
dCYjMzk7IGlzIG5vdDxicj4KYWN0dWFsbHkgc3BlY2lmaWVkIGZvciBhbnkgZGV2aWNlIG90aGVy
IHRoYW4gdGhlIFRPQlkgTDQuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pi4u
Li5hbmQgaW4gdGhhdCBjYXNlIHdlIGNvdWxkIG5vdCByZXN0YXJ0IG9mb25vLi4uLjwvZGl2Pjxk
aXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7
cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KV2hhdCBzZWVtcyB0byB3b3JrIGlzIHRvIHByb2JlIHRo
ZSBkZXZpY2Ugd2l0aCAmIzM5O0FUJiMzOTsgY29tbWFuZHMgdW50aWwgdGhlPGJyPgpkZXZpY2Ug
cmVzcG9uZHMsIGFuZCB0aGVuIHRvIHdhaXQgYW4gYWRkaXRpb25hbCBzZWNvbmQgYmVmb3JlPGJy
Pgpwcm9jZWVkaW5nLsKgIFRoZSBUT0JZIEw0IHJlbGlhYmx5IHNlbmRzIGl0cyAmIzM5O2dyZWV0
aW5nIHRleHQmIzM5OyAoK0FUOiBSRUFEWSk8YnI+CndpdGhpbiB0aGlzIGludGVydmFsLjxicj4K
PGJyPgpJdCB3b3VsZCBiZSBtb3JlIHJpZ29yb3VzIHRvIGFjdHVhbGx5IHdhaXQgZm9yIHRoZSAm
IzM5O1JFQURZJiMzOTsgaW5kaWNhdGlvbjxicj4KZm9yIHRoZSBUT0JZIEw0LCBidXQgdGhhdCB3
b3VsZCByZXF1aXJlIGtub3dpbmcgdGhlIGRldmljZSBtb2RlbCBiZWZvcmU8YnI+CnRoZSBkZXZp
Y2UgbW9kZWwgaXMgYWN0dWFsbHkgcXVlcmllZC7CoCBUaGlzIGlzIGRvYWJsZSB2aWEgdGhlIFVT
Qjxicj4KcHJvZHVjdCBJRCwgYnV0IG92ZXJraWxsIHdoZW4gdGhlIGFib3ZlIGhldXJpc3RpYyBz
ZWVtcyB0byB3b3JrPGJyPgpyZWxpYWJseS48YnI+Cjxicj4KQmVmb3JlIHRoaXMgcGF0Y2gsIHRo
ZSB1YmxveCBwbHVnaW4gd2FzIHRyeWluZyB0byBhY2hpZXZlIHNvbWV0aGluZyBsaWtlPGJyPgp0
aGUgYWJvdmUgd2l0aCB0aGUgZ19hdF9jaGF0X3NldF93YWtldXBfY29tbWFuZCgpIGZ1bmN0aW9u
LCBidXQgdGhhdCBoYWQ8YnI+CnNvbWUgaXNzdWVzOjxicj4KPGJyPgppKcKgIGl0IGRpZCBub3Qg
d29yayByZWxpYWJseSwgaW4gcGFydGljdWxhciBmYWlsaW5nIGJhZGx5IG9uIHRoZSBUT0JZIEw0
PGJyPgp3aXRoIHJlc3BvbnNlcyBnZXR0aW5nIG91dCBvZiBzeW5jIHdpdGggY29tbWFuZHM8YnI+
PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIHNlZW4gdGhpcyBmb3IgTDIg
YXMgd2VsbC4gSSBoYXZlIGEgbG9jYWwgcGF0Y2ggd2hpY2ggaXMgdWdseSBzbyBJIGRpZCBub3Qg
cHVzaCBpdCBoZXJlLCB3aGVyZSBJIGZsdXNoZWQgdGhlIGNvbW1hbmRzLjwvZGl2PjxkaXY+SXQg
c2VlbXMgbGlrZSB0aGUgTDIgYnVmZmVycyB1cCB0aGUgY29tbWFuZCBhbmQgcmVwbGllcyB0byBh
bGwgb2YgdGhlIGxhdGVyLiBTaW5jZSB3ZSB0aW1lcyBvdXQgYW5kIGZvcmdldHMgYWJvdXQgY29t
bWFuZHM8L2Rpdj48ZGl2PmFuZCBkb24mIzM5O3QgdXNlIGVjaG8gd2UgZ2V0IG91dCBvZiBzeW5j
IGFuZCBtb2RlbCBkZXRlY3Rpb24gZmFpbHMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoDwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4
IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij4KaWkpIGl0IHdhcyBhbiBpbmFwcHJvcHJpYXRlIHVzZSBvZiB0aGUgd2FrZXVw
X2NvbW1hbmQgd2hpY2ggaXMgaW50ZW5kZWQ8YnI+CmZvciBkZXZpY2VzIHRoYXQgbWF5IHNsZWVw
IHdoZW4gdGhlcmUgaXMgbm8gY29tbXVuaWNhdGlvbiBkdXJpbmcgc29tZTxicj4KaW50ZXJ2YWw8
YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+KzEsIHZlcnkgYW5ub3lpbmcgc2lu
Y2UgaXQgaGFwcGVucyBhZnRlciBzb21lIFVSQ3MgdG9vLjxicj48L2Rpdj48ZGl2PsKgPC9kaXY+
PGRpdj5HYWggc2F3IHlvdSBoYWQgYSBuZXcgdmVyc2lvbiBzZW50IG91dCwgd2lsbCByZXZpZXcg
dGhlIGNvZGUgdGhlcmUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CUjwvZGl2PjxkaXY+Umlj
aGFyZDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdi
KDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgpUaGlzIHBhdGNoIGFkZHMgYW4g
aW5pdCBzZXF1ZW5jZSB0aGF0IHByb2JlcyB0aGUgZGV2aWNlIGZvciByZWFkaW5lc3M8YnI+CmJl
Zm9yZSBjb250aW51aW5nIHdpdGggaW5pdGlhbGl6YXRpb24uPGJyPgotLS08YnI+CsKgcGx1Z2lu
cy91YmxveC5jIHwgMTIxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLTxicj4KwqAxIGZpbGUgY2hhbmdlZCwgMTA3IGluc2VydGlvbnMoKyksIDE0IGRlbGV0
aW9ucygtKTxicj4KPGJyPgpkaWZmIC0tZ2l0IGEvcGx1Z2lucy91YmxveC5jIGIvcGx1Z2lucy91
YmxveC5jPGJyPgppbmRleCA5ZWUzOGE2Yi4uNjU2ZGM1NTMgMTAwNjQ0PGJyPgotLS0gYS9wbHVn
aW5zL3VibG94LmM8YnI+CisrKyBiL3BsdWdpbnMvdWJsb3guYzxicj4KQEAgLTI5LDYgKzI5LDcg
QEA8YnI+CsKgI2luY2x1ZGUgJmx0O2dsaWIuaCZndDs8YnI+CsKgI2luY2x1ZGUgJmx0O2dhdGNo
YXQuaCZndDs8YnI+CsKgI2luY2x1ZGUgJmx0O2dhdHR0eS5oJmd0Ozxicj4KKyNpbmNsdWRlICZs
dDtlbGwvZWxsLmgmZ3Q7PGJyPgo8YnI+CsKgI2RlZmluZSBPRk9OT19BUElfU1VCSkVDVF9UT19D
SEFOR0U8YnI+CsKgI2luY2x1ZGUgJmx0O29mb25vL3BsdWdpbi5oJmd0Ozxicj4KQEAgLTY2LDYg
KzY3LDEwIEBAIHN0cnVjdCB1YmxveF9kYXRhIHs8YnI+Cjxicj4KwqAgwqAgwqAgwqAgY29uc3Qg
c3RydWN0IHVibG94X21vZGVsICptb2RlbDs8YnI+CsKgIMKgIMKgIMKgIGludCBmbGFnczs8YnI+
Cis8YnI+CivCoCDCoCDCoCDCoHN0cnVjdCBsX3RpbWVvdXQgKmluaXRfdGltZW91dDs8YnI+CivC
oCDCoCDCoCDCoGludCBpbml0X2NvdW50Ozxicj4KK8KgIMKgIMKgIMKgZ3VpbnQgaW5pdF9jbWQ7
PGJyPgrCoH07PGJyPgo8YnI+CsKgc3RhdGljIHZvaWQgdWJsb3hfZGVidWcoY29uc3QgY2hhciAq
c3RyLCB2b2lkICp1c2VyX2RhdGEpPGJyPgpAQCAtMjIzLDYgKzIyOCw4MiBAQCBmYWlsOjxicj4K
wqAgwqAgwqAgwqAgb2Zvbm9fbW9kZW1fc2V0X3Bvd2VyZWQobW9kZW0sIEZBTFNFKTs8YnI+CsKg
fTxicj4KPGJyPgorc3RhdGljIHZvaWQgaW5pdF9jbWRfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3Vs
dCAqcmVzdWx0LCB2b2lkICp1c2VyX2RhdGEpPGJyPgorezxicj4KK8KgIMKgIMKgIMKgc3RydWN0
IG9mb25vX21vZGVtICptb2RlbSA9IHVzZXJfZGF0YTs8YnI+CivCoCDCoCDCoCDCoHN0cnVjdCB1
YmxveF9kYXRhICpkYXRhID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0pOzxicj4KKzxicj4K
K8KgIMKgIMKgIMKgREJHKCZxdW90OyVwJnF1b3Q7LCBtb2RlbSk7PGJyPgorPGJyPgorwqAgwqAg
wqAgwqBpZiAoIW9rKTxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBmYWlsOzxicj4K
Kzxicj4KK8KgIMKgIMKgIMKgLyogV2hlbiB0aGUgJiMzOTtpbml0IGNvbW1hbmQmIzM5OyBzdWNj
ZWVkcywgd2UgaW5zZXJ0IGFuIGFkZGl0aW9uYWw8YnI+CivCoCDCoCDCoCDCoCAqIGRlbGF5IG9m
IDEgc2Vjb25kIGJlZm9yZSBwcm9jZWVkaW5nIHdpdGggdGhlIGFjdHVhbDxicj4KK8KgIMKgIMKg
IMKgICogaW50aWFsaXphdGlvbiBvZiB0aGUgZGV2aWNlLsKgIFdlIHJldXNlIHRoZSBpbml0X3Rp
bWVvdXQ8YnI+CivCoCDCoCDCoCDCoCAqIGluc3RhbmNlIGZvciB0aGlzLCBqdXN0IGNsZWFyaW5n
IHRoZSBjb21tYW5kIHRvIGluZGljYXRlPGJyPgorwqAgwqAgwqAgwqAgKiB0aGF0IGFkZGl0aW9u
YWwgcmV0cmllcyBhcmVuJiMzOTt0IG5lY2Vzc2FyeS48YnI+CivCoCDCoCDCoCDCoCAqLzxicj4K
K8KgIMKgIMKgIMKgZGF0YS0mZ3Q7aW5pdF9jbWQgPSAwOzxicj4KK8KgIMKgIMKgIMKgZGF0YS0m
Z3Q7aW5pdF9jb3VudCA9IDA7PGJyPgorwqAgwqAgwqAgwqBsX3RpbWVvdXRfbW9kaWZ5X21zKGRh
dGEtJmd0O2luaXRfdGltZW91dCwgMTAwMCk7PGJyPgorPGJyPgorwqAgwqAgwqAgwqByZXR1cm47
PGJyPgorPGJyPgorZmFpbDo8YnI+CivCoCDCoCDCoCDCoGxfdGltZW91dF9yZW1vdmUoZGF0YS0m
Z3Q7aW5pdF90aW1lb3V0KTs8YnI+CivCoCDCoCDCoCDCoGRhdGEtJmd0O2luaXRfdGltZW91dCA9
IE5VTEw7PGJyPgorPGJyPgorwqAgwqAgwqAgwqBnX2F0X2NoYXRfdW5yZWYoZGF0YS0mZ3Q7YXV4
KTs8YnI+CivCoCDCoCDCoCDCoGRhdGEtJmd0O2F1eCA9IE5VTEw7PGJyPgorwqAgwqAgwqAgwqBn
X2F0X2NoYXRfdW5yZWYoZGF0YS0mZ3Q7bW9kZW0pOzxicj4KK8KgIMKgIMKgIMKgZGF0YS0mZ3Q7
bW9kZW0gPSBOVUxMOzxicj4KK8KgIMKgIMKgIMKgb2Zvbm9fbW9kZW1fc2V0X3Bvd2VyZWQobW9k
ZW0sIEZBTFNFKTs8YnI+Cit9PGJyPgorPGJyPgorc3RhdGljIHZvaWQgaW5pdF90aW1lb3V0X2Ni
KHN0cnVjdCBsX3RpbWVvdXQgKnRpbWVvdXQsIHZvaWQgKnVzZXJfZGF0YSk8YnI+Cit7PGJyPgor
wqAgwqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gdXNlcl9kYXRhOzxicj4KK8Kg
IMKgIMKgIMKgc3RydWN0IHVibG94X2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YSht
b2RlbSk7PGJyPgorPGJyPgorwqAgwqAgwqAgwqBEQkcoJnF1b3Q7JXAmcXVvdDssIG1vZGVtKTs8
YnI+Cis8YnI+CivCoCDCoCDCoCDCoC8qIEFzIGxvbmcgYXMgaW5pdF9jbWQgaXMgc2V0IHdlIG5l
ZWQgdG8gZWl0aGVyIGtlZXAgcmV0cnlpbmc8YnI+CivCoCDCoCDCoCDCoCAqIG9yIGZhaWwgZXZl
cnl0aGluZyBhZnRlciBleGNlc3NpdmUgcmV0cmllczxicj4KK8KgIMKgIMKgIMKgICovPGJyPgor
wqAgwqAgwqAgwqBpZiAoZGF0YS0mZ3Q7aW5pdF9jbWQgJmFtcDsmYW1wOyBkYXRhLSZndDtpbml0
X2NvdW50KysgJmx0OyAyMCkgezxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ19hdF9jaGF0
X3JldHJ5KGRhdGEtJmd0O2F1eCwgZGF0YS0mZ3Q7aW5pdF9jbWQpOzxicj4KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgbF90aW1lb3V0X21vZGlmeV9tcyh0aW1lb3V0LCAxMDAwKTs8YnI+CivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjs8YnI+CivCoCDCoCDCoCDCoH08YnI+Cis8YnI+CivC
oCDCoCDCoCDCoGxfdGltZW91dF9yZW1vdmUoZGF0YS0mZ3Q7aW5pdF90aW1lb3V0KTs8YnI+CivC
oCDCoCDCoCDCoGRhdGEtJmd0O2luaXRfdGltZW91dCA9IE5VTEw7PGJyPgorPGJyPgorwqAgwqAg
wqAgwqBpZiAoZGF0YS0mZ3Q7aW5pdF9jbWQpIHs8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oG9mb25vX2Vycm9yKCZxdW90O2ZhaWxlZCB0byBpbml0IG1vZGVtIGFmdGVyIDIwIGF0dGVtcHRz
JnF1b3Q7KTs8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZmFpbDs8YnI+CivCoCDC
oCDCoCDCoH08YnI+Cis8YnI+CivCoCDCoCDCoCDCoGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2F1
eCwgJnF1b3Q7QVRFMCZxdW90Oywgbm9uZV9wcmVmaXgsPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCBOVUxMLCBOVUxM
KTs8YnI+CivCoCDCoCDCoCDCoGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2F1eCwgJnF1b3Q7QVQr
Q01FRT0xJnF1b3Q7LCBub25lX3ByZWZpeCw8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIE5VTEwsIE5VTEwpOzxicj4K
Kzxicj4KK8KgIMKgIMKgIMKgaWYgKGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2F1eCwgJnF1b3Q7
QVQrQ0dNTSZxdW90OywgTlVMTCw8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHF1ZXJ5X21vZGVsX2NiLCBtb2RlbSwgTlVMTCkgJmd0OyAwKTxicj4K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj4KKzxicj4KK2ZhaWw6PGJyPgorwqAg
wqAgwqAgwqBnX2F0X2NoYXRfdW5yZWYoZGF0YS0mZ3Q7YXV4KTs8YnI+CivCoCDCoCDCoCDCoGRh
dGEtJmd0O2F1eCA9IE5VTEw7PGJyPgorwqAgwqAgwqAgwqBnX2F0X2NoYXRfdW5yZWYoZGF0YS0m
Z3Q7bW9kZW0pOzxicj4KK8KgIMKgIMKgIMKgZGF0YS0mZ3Q7bW9kZW0gPSBOVUxMOzxicj4KK8Kg
IMKgIMKgIMKgb2Zvbm9fbW9kZW1fc2V0X3Bvd2VyZWQobW9kZW0sIEZBTFNFKTs8YnI+CivCoCDC
oCDCoCDCoHJldHVybjs8YnI+Cit9PGJyPgorPGJyPgorPGJyPgrCoHN0YXRpYyBpbnQgdWJsb3hf
ZW5hYmxlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPGJyPgrCoHs8YnI+CsKgIMKgIMKgIMKg
IHN0cnVjdCB1YmxveF9kYXRhICpkYXRhID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0pOzxi
cj4KQEAgLTI1MCwyMiArMzMxLDM0IEBAIHN0YXRpYyBpbnQgdWJsb3hfZW5hYmxlKHN0cnVjdCBv
Zm9ub19tb2RlbSAqbW9kZW0pPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnX2F0X2NoYXRf
c2VuZChkYXRhLSZndDttb2RlbSwgJnF1b3Q7QVQmYW1wO0MwJnF1b3Q7LCBOVUxMLCBOVUxMLCBO
VUxMLCBOVUxMKTs8YnI+CsKgIMKgIMKgIMKgIH08YnI+Cjxicj4KLcKgIMKgIMKgIMKgLyogVGhl
IG1vZGVtIGNhbiB0YWtlIGEgd2hpbGUgdG8gd2FrZSB1cCBpZiBqdXN0IHBvd2VyZWQgb24uICov
PGJyPgotwqAgwqAgwqAgwqBnX2F0X2NoYXRfc2V0X3dha2V1cF9jb21tYW5kKGRhdGEtJmd0O2F1
eCwgJnF1b3Q7QVRcciZxdW90OywgMTAwMCwgMTEwMDApOzxicj4KLTxicj4KLcKgIMKgIMKgIMKg
Z19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7YXV4LCAmcXVvdDtBVEUwJnF1b3Q7LCBub25lX3ByZWZp
eCw8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoE5VTEwsIE5VTEwsIE5VTEwpOzxicj4KLcKgIMKgIMKgIMKgZ19hdF9jaGF0X3Nl
bmQoZGF0YS0mZ3Q7YXV4LCAmcXVvdDtBVCtDTUVFPTEmcXVvdDssIG5vbmVfcHJlZml4LDxicj4K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgTlVMTCwgTlVMTCwgTlVMTCk7PGJyPgotPGJyPgotwqAgwqAgwqAgwqBpZiAoZ19hdF9jaGF0
X3NlbmQoZGF0YS0mZ3Q7YXV4LCAmcXVvdDtBVCtDR01NJnF1b3Q7LCBOVUxMLDxicj4KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcXVlcnlfbW9kZWxfY2Is
IG1vZGVtLCBOVUxMKSAmZ3Q7IDApPGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4g
LUVJTlBST0dSRVNTOzxicj4KK8KgIMKgIMKgIMKgLyo8YnI+CivCoCDCoCDCoCDCoCAqIHVCbG94
IGRldmljZXMgcHJlc2VudCB0aGVpciBVU0IgaW50ZXJmYWNlcyB3ZWxsIGJlZm9yZSB0aG9zZTxi
cj4KK8KgIMKgIMKgIMKgICogaW50ZXJmYWNlcyBhcmUgYWN0dWFsbHkgcmVhZHkgdG8gdXNlLsKg
IFRoZSBzcGVjcyBzYXkgdG8gbW9uaXRvcjxicj4KK8KgIMKgIMKgIMKgICogdGhlICYjMzk7Z3Jl
ZXRpbmcgdGV4dCYjMzk7IHRvIGRldGVjdCB3aGV0aGVyIHRoZSBkZXZpY2UgaXMgcmVhZHkgdG8g
dXNlOzxicj4KK8KgIMKgIMKgIMKgICogdW5mb3J0dW5hdGVseSwgb3RoZXIgdGhhbiBmb3IgdGhl
IFRPQlkgTDQsIHRoZSBncmVldGluZyB0ZXh0IGlzPGJyPgorwqAgwqAgwqAgwqAgKiBub3QgYWN0
dWFsbHkgc3BlY2lmaWVkLjxicj4KK8KgIMKgIMKgIMKgICo8YnI+CivCoCDCoCDCoCDCoCAqIFdo
YXQgaGFzIGJlZW4gZGV0ZXJtaW5lZCBleHBlcmltZW50YWxseSB0byB3b3JrIGlzIHRvIHByb2Jl
IHdpdGg8YnI+CivCoCDCoCDCoCDCoCAqIGFuICYjMzk7QVQmIzM5OyBjb21tYW5kIHVudGlsIGl0
IHJlc3BvbmRzIGFuZCB0aGVuIHdhaXQgYW4gYWRkaXRpb25hbDxicj4KK8KgIMKgIMKgIMKgICog
c2Vjb25kIGJlZm9yZSBjb250aW51aW5nIHdpdGggZGV2aWNlIGluaXRpYWxpemF0aW9uLsKgIEV2
ZW4gZm9yPGJyPgorwqAgwqAgwqAgwqAgKiB0aGUgVE9CWSBMNCB3aGVyZSBvbmUgc2hvdWxkIHdh
aXQgZm9yIHRoZSAmIzM5OytBVDogUkVBRFkmIzM5OyBVUkM8YnI+CivCoCDCoCDCoCDCoCAqIGJl
Zm9yZSBpbnRpYWxpemF0aW9uLCB0aGlzIHNlZW1zIHRvIGJlIHN1ZmZpY2llbnQ7IHRoZSAmIzM5
O1JFQURZJiMzOTs8YnI+CivCoCDCoCDCoCDCoCAqIGluZGljYXRpb24gYWx3YXlzIGFycml2ZXMg
d2l0aGluIHRoaXMgdGltZS48YnI+CivCoCDCoCDCoCDCoCAqPGJyPgorwqAgwqAgwqAgwqAgKiAo
SXQgd291bGQgYmUgbW9yZSByaWdvcm91cyB0byBhY3R1YWxseSB3YWl0IGZvciB0aGUgJiMzOTtS
RUFEWSYjMzk7PGJyPgorwqAgwqAgwqAgwqAgKiBpbmRpY2F0aW9uLCBidXQgdGhhdCB3b3VsZCBy
ZXF1aXJlIGtub3dpbmcgdGhlIGRldmljZSBtb2RlbDxicj4KK8KgIMKgIMKgIMKgICogYmVmb3Jl
IHRoZSBkZXZpY2UgbW9kZWwgaXMgYWN0dWFsbHkgcXVlcmllZC7CoCBEby1hYmxlIHZpYTxicj4K
K8KgIMKgIMKgIMKgICogVVNCIFByb2R1Y3QgSUQsIGJ1dCBvdmVya2lsbCB3aGVuIHRoZSBhYm92
ZSBzZWVtcyB0byB3b3JrPGJyPgorwqAgwqAgwqAgwqAgKiByZWxpYWJseS4pPGJyPgorwqAgwqAg
wqAgwqAgKi88YnI+Cjxicj4KLcKgIMKgIMKgIMKgZ19hdF9jaGF0X3VucmVmKGRhdGEtJmd0O2F1
eCk7PGJyPgotwqAgwqAgwqAgwqBkYXRhLSZndDthdXggPSBOVUxMOzxicj4KK8KgIMKgIMKgIMKg
ZGF0YS0mZ3Q7aW5pdF9jb3VudCA9IDA7PGJyPgorwqAgwqAgwqAgwqBkYXRhLSZndDtpbml0X2Nt
ZCA9IGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2F1eCwgJnF1b3Q7QVQmcXVvdDssIG5vbmVfcHJl
Zml4LDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaW5pdF9jbWRfY2IsIG1vZGVtLCBOVUxMKTs8YnI+CivCoCDCoCDCoCDCoGRh
dGEtJmd0O2luaXRfdGltZW91dCA9IGxfdGltZW91dF9jcmVhdGVfbXMoNTAwLCBpbml0X3RpbWVv
dXRfY2IsIG1vZGVtLDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVMTCk7PGJyPgo8
YnI+Ci3CoCDCoCDCoCDCoHJldHVybiAtRUlOVkFMOzxicj4KK8KgIMKgIMKgIMKgcmV0dXJuIC1F
SU5QUk9HUkVTUzs8YnI+CsKgfTxicj4KPGJyPgrCoHN0YXRpYyB2b2lkIGNmdW5fZGlzYWJsZShn
Ym9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+Ci0t
IDxicj4KMi4yMC4xPGJyPgo8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpv
Zm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8
YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiBy
ZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pgo=

--===============1141145652694910334==--

