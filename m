Content-Type: multipart/mixed; boundary="===============7477768240413799426=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 18:32:36 +0200
Message-ID: <CAHB-PjmvC3chu=xDoqxwekoNrQocvSdLgDsZ229uBUcDz=Q=4A@mail.gmail.com>
In-Reply-To: <20190924160126.26221-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7477768240413799426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

Den tis 24 sep. 2019 kl 18:01 skrev Jonas Bonn <jonas@norrbonn.se>:

> uBlox devices present their USB interfaces well before those interfaces
> are ready to respond to any commands.  The documentation says to monitor
> the 'greeting text' to detect readiness, but this 'greeting text' is not
> actually specified for any device other than the TOBY L4.
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
> ii) it was an inappropriate use of the wakeup_command which is intended
> for devices that may sleep when there is no communication during some
> interval
>
> This patch adds an init sequence that probes the device for readiness
> before continuing with initialization.
> ---
>
> Changed in v2:
> - drop return statement
> - drop superfluous empty line
>
>  plugins/ublox.c | 119 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 105 insertions(+), 14 deletions(-)
>
> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index 9ee38a6b..5be9d4cc 100644
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
>

Shouldn't this should be removed in disable in case its still available..


> +       int init_count;
> +       guint init_cmd;
>  };
>
>  static void ublox_debug(const char *str, void *user_data)
> @@ -223,6 +228,80 @@ fail:
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
> +}
> +
>  static int ublox_enable(struct ofono_modem *modem)
>  {
>         struct ublox_data *data =3D ofono_modem_get_data(modem);
> @@ -250,22 +329,34 @@ static int ublox_enable(struct ofono_modem *modem)
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

Is 500ms enough? What happens if the modem buffers the at commands for a
while
and sends out two "OK"? Won't the second be in the queue and considered
being
the response to the next command?


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

--===============7477768240413799426==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBKb25hcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gdGlzIDI0IHNlcC4g
MjAxOSBrbCAxODowMSBza3JldiBKb25hcyBCb25uICZsdDs8YSBocmVmPSJtYWlsdG86am9uYXNA
bm9ycmJvbm4uc2UiPmpvbmFzQG5vcnJib25uLnNlPC9hPiZndDs6PGJyPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij51
QmxveCBkZXZpY2VzIHByZXNlbnQgdGhlaXIgVVNCIGludGVyZmFjZXMgd2VsbCBiZWZvcmUgdGhv
c2UgaW50ZXJmYWNlczxicj4KYXJlIHJlYWR5IHRvIHJlc3BvbmQgdG8gYW55IGNvbW1hbmRzLsKg
IFRoZSBkb2N1bWVudGF0aW9uIHNheXMgdG8gbW9uaXRvcjxicj4KdGhlICYjMzk7Z3JlZXRpbmcg
dGV4dCYjMzk7IHRvIGRldGVjdCByZWFkaW5lc3MsIGJ1dCB0aGlzICYjMzk7Z3JlZXRpbmcgdGV4
dCYjMzk7IGlzIG5vdDxicj4KYWN0dWFsbHkgc3BlY2lmaWVkIGZvciBhbnkgZGV2aWNlIG90aGVy
IHRoYW4gdGhlIFRPQlkgTDQuPGJyPgo8YnI+CldoYXQgc2VlbXMgdG8gd29yayBpcyB0byBwcm9i
ZSB0aGUgZGV2aWNlIHdpdGggJiMzOTtBVCYjMzk7IGNvbW1hbmRzIHVudGlsIHRoZTxicj4KZGV2
aWNlIHJlc3BvbmRzLCBhbmQgdGhlbiB0byB3YWl0IGFuIGFkZGl0aW9uYWwgc2Vjb25kIGJlZm9y
ZTxicj4KcHJvY2VlZGluZy7CoCBUaGUgVE9CWSBMNCByZWxpYWJseSBzZW5kcyBpdHMgJiMzOTtn
cmVldGluZyB0ZXh0JiMzOTsgKCtBVDogUkVBRFkpPGJyPgp3aXRoaW4gdGhpcyBpbnRlcnZhbC48
YnI+Cjxicj4KSXQgd291bGQgYmUgbW9yZSByaWdvcm91cyB0byBhY3R1YWxseSB3YWl0IGZvciB0
aGUgJiMzOTtSRUFEWSYjMzk7IGluZGljYXRpb248YnI+CmZvciB0aGUgVE9CWSBMNCwgYnV0IHRo
YXQgd291bGQgcmVxdWlyZSBrbm93aW5nIHRoZSBkZXZpY2UgbW9kZWwgYmVmb3JlPGJyPgp0aGUg
ZGV2aWNlIG1vZGVsIGlzIGFjdHVhbGx5IHF1ZXJpZWQuwqAgVGhpcyBpcyBkb2FibGUgdmlhIHRo
ZSBVU0I8YnI+CnByb2R1Y3QgSUQsIGJ1dCBvdmVya2lsbCB3aGVuIHRoZSBhYm92ZSBoZXVyaXN0
aWMgc2VlbXMgdG8gd29yazxicj4KcmVsaWFibHkuPGJyPgo8YnI+CkJlZm9yZSB0aGlzIHBhdGNo
LCB0aGUgdWJsb3ggcGx1Z2luIHdhcyB0cnlpbmcgdG8gYWNoaWV2ZSBzb21ldGhpbmcgbGlrZTxi
cj4KdGhlIGFib3ZlIHdpdGggdGhlIGdfYXRfY2hhdF9zZXRfd2FrZXVwX2NvbW1hbmQoKSBmdW5j
dGlvbiwgYnV0IHRoYXQgaGFkPGJyPgpzb21lIGlzc3Vlczo8YnI+Cjxicj4KaSnCoCBpdCBkaWQg
bm90IHdvcmsgcmVsaWFibHksIGluIHBhcnRpY3VsYXIgZmFpbGluZyBiYWRseSBvbiB0aGUgVE9C
WSBMNDxicj4Kd2l0aCByZXNwb25zZXMgZ2V0dGluZyBvdXQgb2Ygc3luYyB3aXRoIGNvbW1hbmRz
PGJyPgppaSkgaXQgd2FzIGFuIGluYXBwcm9wcmlhdGUgdXNlIG9mIHRoZSB3YWtldXBfY29tbWFu
ZCB3aGljaCBpcyBpbnRlbmRlZDxicj4KZm9yIGRldmljZXMgdGhhdCBtYXkgc2xlZXAgd2hlbiB0
aGVyZSBpcyBubyBjb21tdW5pY2F0aW9uIGR1cmluZyBzb21lPGJyPgppbnRlcnZhbDxicj4KPGJy
PgpUaGlzIHBhdGNoIGFkZHMgYW4gaW5pdCBzZXF1ZW5jZSB0aGF0IHByb2JlcyB0aGUgZGV2aWNl
IGZvciByZWFkaW5lc3M8YnI+CmJlZm9yZSBjb250aW51aW5nIHdpdGggaW5pdGlhbGl6YXRpb24u
PGJyPgotLS08YnI+Cjxicj4KQ2hhbmdlZCBpbiB2Mjo8YnI+Ci0gZHJvcCByZXR1cm4gc3RhdGVt
ZW50PGJyPgotIGRyb3Agc3VwZXJmbHVvdXMgZW1wdHkgbGluZTxicj4KPGJyPgrCoHBsdWdpbnMv
dWJsb3guYyB8IDExOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS08YnI+CsKgMSBmaWxlIGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlv
bnMoLSk8YnI+Cjxicj4KZGlmZiAtLWdpdCBhL3BsdWdpbnMvdWJsb3guYyBiL3BsdWdpbnMvdWJs
b3guYzxicj4KaW5kZXggOWVlMzhhNmIuLjViZTlkNGNjIDEwMDY0NDxicj4KLS0tIGEvcGx1Z2lu
cy91YmxveC5jPGJyPgorKysgYi9wbHVnaW5zL3VibG94LmM8YnI+CkBAIC0yOSw2ICsyOSw3IEBA
PGJyPgrCoCNpbmNsdWRlICZsdDtnbGliLmgmZ3Q7PGJyPgrCoCNpbmNsdWRlICZsdDtnYXRjaGF0
LmgmZ3Q7PGJyPgrCoCNpbmNsdWRlICZsdDtnYXR0dHkuaCZndDs8YnI+CisjaW5jbHVkZSAmbHQ7
ZWxsL2VsbC5oJmd0Ozxicj4KPGJyPgrCoCNkZWZpbmUgT0ZPTk9fQVBJX1NVQkpFQ1RfVE9fQ0hB
TkdFPGJyPgrCoCNpbmNsdWRlICZsdDtvZm9uby9wbHVnaW4uaCZndDs8YnI+CkBAIC02Niw2ICs2
NywxMCBAQCBzdHJ1Y3QgdWJsb3hfZGF0YSB7PGJyPgo8YnI+CsKgIMKgIMKgIMKgIGNvbnN0IHN0
cnVjdCB1YmxveF9tb2RlbCAqbW9kZWw7PGJyPgrCoCDCoCDCoCDCoCBpbnQgZmxhZ3M7PGJyPgor
PGJyPgorwqAgwqAgwqAgwqBzdHJ1Y3QgbF90aW1lb3V0ICppbml0X3RpbWVvdXQ7PGJyPjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlNob3VsZG4mIzM5O3QgdGhpcyBzaG91bGQgYmUg
cmVtb3ZlZCBpbiBkaXNhYmxlIGluIGNhc2UgaXRzIHN0aWxsIGF2YWlsYWJsZS4uPC9kaXY+PGRp
dj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij4KK8KgIMKgIMKgIMKgaW50IGluaXRfY291bnQ7PGJyPgorwqAgwqAg
wqAgwqBndWludCBpbml0X2NtZDs8YnI+CsKgfTs8YnI+Cjxicj4KwqBzdGF0aWMgdm9pZCB1Ymxv
eF9kZWJ1Zyhjb25zdCBjaGFyICpzdHIsIHZvaWQgKnVzZXJfZGF0YSk8YnI+CkBAIC0yMjMsNiAr
MjI4LDgwIEBAIGZhaWw6PGJyPgrCoCDCoCDCoCDCoCBvZm9ub19tb2RlbV9zZXRfcG93ZXJlZCht
b2RlbSwgRkFMU0UpOzxicj4KwqB9PGJyPgo8YnI+CitzdGF0aWMgdm9pZCBpbml0X2NtZF9jYihn
Ym9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIHZvaWQgKnVzZXJfZGF0YSk8YnI+Cit7PGJy
PgorwqAgwqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gdXNlcl9kYXRhOzxicj4K
K8KgIMKgIMKgIMKgc3RydWN0IHVibG94X2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0
YShtb2RlbSk7PGJyPgorPGJyPgorwqAgwqAgwqAgwqBEQkcoJnF1b3Q7JXAmcXVvdDssIG1vZGVt
KTs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGlmICghb2spPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBnb3RvIGZhaWw7PGJyPgorPGJyPgorwqAgwqAgwqAgwqAvKiBXaGVuIHRoZSAmIzM5O2lu
aXQgY29tbWFuZCYjMzk7IHN1Y2NlZWRzLCB3ZSBpbnNlcnQgYW4gYWRkaXRpb25hbDxicj4KK8Kg
IMKgIMKgIMKgICogZGVsYXkgb2YgMSBzZWNvbmQgYmVmb3JlIHByb2NlZWRpbmcgd2l0aCB0aGUg
YWN0dWFsPGJyPgorwqAgwqAgwqAgwqAgKiBpbnRpYWxpemF0aW9uIG9mIHRoZSBkZXZpY2UuwqAg
V2UgcmV1c2UgdGhlIGluaXRfdGltZW91dDxicj4KK8KgIMKgIMKgIMKgICogaW5zdGFuY2UgZm9y
IHRoaXMsIGp1c3QgY2xlYXJpbmcgdGhlIGNvbW1hbmQgdG8gaW5kaWNhdGU8YnI+CivCoCDCoCDC
oCDCoCAqIHRoYXQgYWRkaXRpb25hbCByZXRyaWVzIGFyZW4mIzM5O3QgbmVjZXNzYXJ5Ljxicj4K
K8KgIMKgIMKgIMKgICovPGJyPgorwqAgwqAgwqAgwqBkYXRhLSZndDtpbml0X2NtZCA9IDA7PGJy
PgorwqAgwqAgwqAgwqBkYXRhLSZndDtpbml0X2NvdW50ID0gMDs8YnI+CivCoCDCoCDCoCDCoGxf
dGltZW91dF9tb2RpZnlfbXMoZGF0YS0mZ3Q7aW5pdF90aW1lb3V0LCAxMDAwKTs8YnI+Cis8YnI+
CivCoCDCoCDCoCDCoHJldHVybjs8YnI+Cis8YnI+CitmYWlsOjxicj4KK8KgIMKgIMKgIMKgbF90
aW1lb3V0X3JlbW92ZShkYXRhLSZndDtpbml0X3RpbWVvdXQpOzxicj4KK8KgIMKgIMKgIMKgZGF0
YS0mZ3Q7aW5pdF90aW1lb3V0ID0gTlVMTDs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGdfYXRfY2hh
dF91bnJlZihkYXRhLSZndDthdXgpOzxicj4KK8KgIMKgIMKgIMKgZGF0YS0mZ3Q7YXV4ID0gTlVM
TDs8YnI+CivCoCDCoCDCoCDCoGdfYXRfY2hhdF91bnJlZihkYXRhLSZndDttb2RlbSk7PGJyPgor
wqAgwqAgwqAgwqBkYXRhLSZndDttb2RlbSA9IE5VTEw7PGJyPgorwqAgwqAgwqAgwqBvZm9ub19t
b2RlbV9zZXRfcG93ZXJlZChtb2RlbSwgRkFMU0UpOzxicj4KK308YnI+Cis8YnI+CitzdGF0aWMg
dm9pZCBpbml0X3RpbWVvdXRfY2Ioc3RydWN0IGxfdGltZW91dCAqdGltZW91dCwgdm9pZCAqdXNl
cl9kYXRhKTxicj4KK3s8YnI+CivCoCDCoCDCoCDCoHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0g
PSB1c2VyX2RhdGE7PGJyPgorwqAgwqAgwqAgwqBzdHJ1Y3QgdWJsb3hfZGF0YSAqZGF0YSA9IG9m
b25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoERCRygmcXVv
dDslcCZxdW90OywgbW9kZW0pOzxicj4KKzxicj4KK8KgIMKgIMKgIMKgLyogQXMgbG9uZyBhcyBp
bml0X2NtZCBpcyBzZXQgd2UgbmVlZCB0byBlaXRoZXIga2VlcCByZXRyeWluZzxicj4KK8KgIMKg
IMKgIMKgICogb3IgZmFpbCBldmVyeXRoaW5nIGFmdGVyIGV4Y2Vzc2l2ZSByZXRyaWVzPGJyPgor
wqAgwqAgwqAgwqAgKi88YnI+CivCoCDCoCDCoCDCoGlmIChkYXRhLSZndDtpbml0X2NtZCAmYW1w
OyZhbXA7IGRhdGEtJmd0O2luaXRfY291bnQrKyAmbHQ7IDIwKSB7PGJyPgorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBnX2F0X2NoYXRfcmV0cnkoZGF0YS0mZ3Q7YXV4LCBkYXRhLSZndDtpbml0X2Nt
ZCk7PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBsX3RpbWVvdXRfbW9kaWZ5X21zKHRpbWVv
dXQsIDEwMDApOzxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj4KK8KgIMKg
IMKgIMKgfTxicj4KKzxicj4KK8KgIMKgIMKgIMKgbF90aW1lb3V0X3JlbW92ZShkYXRhLSZndDtp
bml0X3RpbWVvdXQpOzxicj4KK8KgIMKgIMKgIMKgZGF0YS0mZ3Q7aW5pdF90aW1lb3V0ID0gTlVM
TDs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGlmIChkYXRhLSZndDtpbml0X2NtZCkgezxicj4KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgb2Zvbm9fZXJyb3IoJnF1b3Q7ZmFpbGVkIHRvIGluaXQgbW9k
ZW0gYWZ0ZXIgMjAgYXR0ZW1wdHMmcXVvdDspOzxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Z290byBmYWlsOzxicj4KK8KgIMKgIMKgIMKgfTxicj4KKzxicj4KK8KgIMKgIMKgIMKgZ19hdF9j
aGF0X3NlbmQoZGF0YS0mZ3Q7YXV4LCAmcXVvdDtBVEUwJnF1b3Q7LCBub25lX3ByZWZpeCw8YnI+
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoE5VTEwsIE5VTEwsIE5VTEwpOzxicj4KK8KgIMKgIMKgIMKgZ19hdF9jaGF0X3NlbmQoZGF0
YS0mZ3Q7YXV4LCAmcXVvdDtBVCtDTUVFPTEmcXVvdDssIG5vbmVfcHJlZml4LDxicj4KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlVM
TCwgTlVMTCwgTlVMTCk7PGJyPgorPGJyPgorwqAgwqAgwqAgwqBpZiAoZ19hdF9jaGF0X3NlbmQo
ZGF0YS0mZ3Q7YXV4LCAmcXVvdDtBVCtDR01NJnF1b3Q7LCBOVUxMLDxicj4KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcXVlcnlfbW9kZWxfY2IsIG1vZGVt
LCBOVUxMKSAmZ3Q7IDApPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPgor
PGJyPgorZmFpbDo8YnI+CivCoCDCoCDCoCDCoGdfYXRfY2hhdF91bnJlZihkYXRhLSZndDthdXgp
Ozxicj4KK8KgIMKgIMKgIMKgZGF0YS0mZ3Q7YXV4ID0gTlVMTDs8YnI+CivCoCDCoCDCoCDCoGdf
YXRfY2hhdF91bnJlZihkYXRhLSZndDttb2RlbSk7PGJyPgorwqAgwqAgwqAgwqBkYXRhLSZndDtt
b2RlbSA9IE5VTEw7PGJyPgorwqAgwqAgwqAgwqBvZm9ub19tb2RlbV9zZXRfcG93ZXJlZChtb2Rl
bSwgRkFMU0UpOzxicj4KK308YnI+Cis8YnI+CsKgc3RhdGljIGludCB1YmxveF9lbmFibGUoc3Ry
dWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+CsKgezxicj4KwqAgwqAgwqAgwqAgc3RydWN0IHVi
bG94X2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PGJyPgpAQCAtMjUw
LDIyICszMjksMzQgQEAgc3RhdGljIGludCB1YmxveF9lbmFibGUoc3RydWN0IG9mb25vX21vZGVt
ICptb2RlbSk8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdfYXRfY2hhdF9zZW5kKGRhdGEt
Jmd0O21vZGVtLCAmcXVvdDtBVCZhbXA7QzAmcXVvdDssIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwp
Ozxicj4KwqAgwqAgwqAgwqAgfTxicj4KPGJyPgotwqAgwqAgwqAgwqAvKiBUaGUgbW9kZW0gY2Fu
IHRha2UgYSB3aGlsZSB0byB3YWtlIHVwIGlmIGp1c3QgcG93ZXJlZCBvbi4gKi88YnI+Ci3CoCDC
oCDCoCDCoGdfYXRfY2hhdF9zZXRfd2FrZXVwX2NvbW1hbmQoZGF0YS0mZ3Q7YXV4LCAmcXVvdDtB
VFxyJnF1b3Q7LCAxMDAwLCAxMTAwMCk7PGJyPgotPGJyPgotwqAgwqAgwqAgwqBnX2F0X2NoYXRf
c2VuZChkYXRhLSZndDthdXgsICZxdW90O0FURTAmcXVvdDssIG5vbmVfcHJlZml4LDxicj4KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
TlVMTCwgTlVMTCwgTlVMTCk7PGJyPgotwqAgwqAgwqAgwqBnX2F0X2NoYXRfc2VuZChkYXRhLSZn
dDthdXgsICZxdW90O0FUK0NNRUU9MSZxdW90Oywgbm9uZV9wcmVmaXgsPGJyPgotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMLCBO
VUxMLCBOVUxMKTs8YnI+Ci08YnI+Ci3CoCDCoCDCoCDCoGlmIChnX2F0X2NoYXRfc2VuZChkYXRh
LSZndDthdXgsICZxdW90O0FUK0NHTU0mcXVvdDssIE5VTEwsPGJyPgotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBxdWVyeV9tb2RlbF9jYiwgbW9kZW0sIE5V
TEwpICZndDsgMCk8YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUlOUFJPR1JF
U1M7PGJyPgorwqAgwqAgwqAgwqAvKjxicj4KK8KgIMKgIMKgIMKgICogdUJsb3ggZGV2aWNlcyBw
cmVzZW50IHRoZWlyIFVTQiBpbnRlcmZhY2VzIHdlbGwgYmVmb3JlIHRob3NlPGJyPgorwqAgwqAg
wqAgwqAgKiBpbnRlcmZhY2VzIGFyZSBhY3R1YWxseSByZWFkeSB0byB1c2UuwqAgVGhlIHNwZWNz
IHNheSB0byBtb25pdG9yPGJyPgorwqAgwqAgwqAgwqAgKiB0aGUgJiMzOTtncmVldGluZyB0ZXh0
JiMzOTsgdG8gZGV0ZWN0IHdoZXRoZXIgdGhlIGRldmljZSBpcyByZWFkeSB0byB1c2U7PGJyPgor
wqAgwqAgwqAgwqAgKiB1bmZvcnR1bmF0ZWx5LCBvdGhlciB0aGFuIGZvciB0aGUgVE9CWSBMNCwg
dGhlIGdyZWV0aW5nIHRleHQgaXM8YnI+CivCoCDCoCDCoCDCoCAqIG5vdCBhY3R1YWxseSBzcGVj
aWZpZWQuPGJyPgorwqAgwqAgwqAgwqAgKjxicj4KK8KgIMKgIMKgIMKgICogV2hhdCBoYXMgYmVl
biBkZXRlcm1pbmVkIGV4cGVyaW1lbnRhbGx5IHRvIHdvcmsgaXMgdG8gcHJvYmUgd2l0aDxicj4K
K8KgIMKgIMKgIMKgICogYW4gJiMzOTtBVCYjMzk7IGNvbW1hbmQgdW50aWwgaXQgcmVzcG9uZHMg
YW5kIHRoZW4gd2FpdCBhbiBhZGRpdGlvbmFsPGJyPgorwqAgwqAgwqAgwqAgKiBzZWNvbmQgYmVm
b3JlIGNvbnRpbnVpbmcgd2l0aCBkZXZpY2UgaW5pdGlhbGl6YXRpb24uwqAgRXZlbiBmb3I8YnI+
CivCoCDCoCDCoCDCoCAqIHRoZSBUT0JZIEw0IHdoZXJlIG9uZSBzaG91bGQgd2FpdCBmb3IgdGhl
ICYjMzk7K0FUOiBSRUFEWSYjMzk7IFVSQzxicj4KK8KgIMKgIMKgIMKgICogYmVmb3JlIGludGlh
bGl6YXRpb24sIHRoaXMgc2VlbXMgdG8gYmUgc3VmZmljaWVudDsgdGhlICYjMzk7UkVBRFkmIzM5
Ozxicj4KK8KgIMKgIMKgIMKgICogaW5kaWNhdGlvbiBhbHdheXMgYXJyaXZlcyB3aXRoaW4gdGhp
cyB0aW1lLjxicj4KK8KgIMKgIMKgIMKgICo8YnI+CivCoCDCoCDCoCDCoCAqIChJdCB3b3VsZCBi
ZSBtb3JlIHJpZ29yb3VzIHRvIGFjdHVhbGx5IHdhaXQgZm9yIHRoZSAmIzM5O1JFQURZJiMzOTs8
YnI+CivCoCDCoCDCoCDCoCAqIGluZGljYXRpb24sIGJ1dCB0aGF0IHdvdWxkIHJlcXVpcmUga25v
d2luZyB0aGUgZGV2aWNlIG1vZGVsPGJyPgorwqAgwqAgwqAgwqAgKiBiZWZvcmUgdGhlIGRldmlj
ZSBtb2RlbCBpcyBhY3R1YWxseSBxdWVyaWVkLsKgIERvLWFibGUgdmlhPGJyPgorwqAgwqAgwqAg
wqAgKiBVU0IgUHJvZHVjdCBJRCwgYnV0IG92ZXJraWxsIHdoZW4gdGhlIGFib3ZlIHNlZW1zIHRv
IHdvcms8YnI+CivCoCDCoCDCoCDCoCAqIHJlbGlhYmx5Lik8YnI+CivCoCDCoCDCoCDCoCAqLzxi
cj4KPGJyPgotwqAgwqAgwqAgwqBnX2F0X2NoYXRfdW5yZWYoZGF0YS0mZ3Q7YXV4KTs8YnI+Ci3C
oCDCoCDCoCDCoGRhdGEtJmd0O2F1eCA9IE5VTEw7PGJyPgorwqAgwqAgwqAgwqBkYXRhLSZndDtp
bml0X2NvdW50ID0gMDs8YnI+CivCoCDCoCDCoCDCoGRhdGEtJmd0O2luaXRfY21kID0gZ19hdF9j
aGF0X3NlbmQoZGF0YS0mZ3Q7YXV4LCAmcXVvdDtBVCZxdW90Oywgbm9uZV9wcmVmaXgsPGJyPgor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpbml0X2NtZF9jYiwgbW9kZW0sIE5VTEwpOzxicj4KK8KgIMKgIMKgIMKgZGF0YS0mZ3Q7aW5p
dF90aW1lb3V0ID0gbF90aW1lb3V0X2NyZWF0ZV9tcyg1MDAsIGluaXRfdGltZW91dF9jYiwgbW9k
ZW0sPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBOVUxMKTs8YnI+PC9ibG9ja3F1b3Rl
PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXMgNTAwbXMgZW5vdWdoPyBXaGF0IGhhcHBlbnMgaWYgdGhl
IG1vZGVtIGJ1ZmZlcnMgdGhlIGF0IGNvbW1hbmRzIGZvciBhIHdoaWxlPC9kaXY+PGRpdj5hbmQg
c2VuZHMgb3V0IHR3byAmcXVvdDtPSyZxdW90Oz8gV29uJiMzOTt0IHRoZSBzZWNvbmQgYmUgaW4g
dGhlIHF1ZXVlIGFuZCBjb25zaWRlcmVkIGJlaW5nPC9kaXY+PGRpdj50aGUgcmVzcG9uc2UgdG8g
dGhlIG5leHQgY29tbWFuZD88L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFw
eCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+Ci3CoCDCoCDC
oCDCoHJldHVybiAtRUlOVkFMOzxicj4KK8KgIMKgIMKgIMKgcmV0dXJuIC1FSU5QUk9HUkVTUzs8
YnI+CsKgfTxicj4KPGJyPgrCoHN0YXRpYyB2b2lkIGNmdW5fZGlzYWJsZShnYm9vbGVhbiBvaywg
R0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+Ci0tIDxicj4KMi4yMC4x
PGJyPgo8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
PGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5v
cmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRw
czovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiByZWw9Im5vcmVmZXJy
ZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pgo=

--===============7477768240413799426==--

