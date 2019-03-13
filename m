Content-Type: multipart/mixed; boundary="===============1764360757819976937=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 05/14] ublox: query device model
Date: Wed, 13 Mar 2019 21:24:58 +0100
Message-ID: <e49ce5f2-1d14-b1fe-eecb-60826e7aaa15@norrbonn.se>
In-Reply-To: <a9a855a2-a762-2061-173c-92c751bfc21f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1764360757819976937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for the review.  I'm a bit baffled by some of the warnings you =

are seeing... DOS line endings?  Where did those come from... I don't =

see them here.

Nonetheless, I'll send a quick resubmission that passes checkpatch.pl =

and we'll take it from there.

Thanks,
Jonas

On 13/03/2019 19:37, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 03/12/2019 06:09 AM, Jonas Bonn wrote:
>> This patch adds a call to CGMM into the modem_enable path in order to
>> establish the specific device model.=C2=A0 From this device model string=
, a
>> model-specific capabilities structure can be selected.
>> ---
>> =C2=A0 plugins/ublox.c | 107 ++++++++++++++++++++++++++++++++++---------=
-----
>> =C2=A0 1 file changed, 77 insertions(+), 30 deletions(-)
>>
> =

> Have you tried running checkpatch.pl on these?=C2=A0 There are too many =

> coding style violations for me to fix.
> =

> Here's a small sample:
> =

> ERROR: "foo* bar" should be "foo *bar"
> #138: FILE: plugins/ublox.c:64:
> +=C2=A0=C2=A0=C2=A0 const struct ublox_model* model;
> =

> ERROR: DOS line endings
> #147: FILE: plugins/ublox.c:158:
> +static void query_model_cb(gboolean ok, GAtResult *result, gpointer =

> user_data)^M$
> =

> ERROR: DOS line endings
> #149: FILE: plugins/ublox.c:160:
> +^Istruct ofono_modem* modem =3D user_data;^M$
> =

> ERROR: "foo* bar" should be "foo *bar"
> #149: FILE: plugins/ublox.c:160:
> +=C2=A0=C2=A0=C2=A0 struct ofono_modem* modem =3D user_data;
> =

> =

> =

>> diff --git a/plugins/ublox.c b/plugins/ublox.c
>> index 32cf1e61..efb0afbc 100644
>> --- a/plugins/ublox.c
>> +++ b/plugins/ublox.c
>> @@ -42,9 +42,10 @@
>> =C2=A0 #include <ofono/lte.h>
>> =C2=A0 #include <ofono/voicecall.h>
>> -#include <drivers/atmodem/atutil.h>
>> =C2=A0 #include <drivers/atmodem/vendor.h>
>> +#include <drivers/ubloxmodem/ubloxmodem.h>
>> +
>> =C2=A0 static const char *none_prefix[] =3D { NULL };
>> =C2=A0 enum supported_models {
>> @@ -59,6 +60,8 @@ struct ublox_data {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GAtChat *aux;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int model_id;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum ofono_vendor vendor_family;
>> +
>> +=C2=A0=C2=A0=C2=A0 const struct ublox_model* model;
>> =C2=A0 };
>> =C2=A0 static void ublox_debug(const char *str, void *user_data)
>> @@ -152,38 +155,79 @@ static void cfun_enable(gboolean ok, GAtResult =

>> *result, gpointer user_data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, TRUE);
>> =C2=A0 }
>> -static int ublox_enable(struct ofono_modem *modem)
>> +static void query_model_cb(gboolean ok, GAtResult *result, gpointer =

>> user_data)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem* modem =3D user_data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ublox_data *data =3D ofono_modem_g=
et_data(modem);
>> -=C2=A0=C2=A0=C2=A0 const char *model_str =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 struct ofono_error error;
>> +=C2=A0=C2=A0=C2=A0 const char *model;
>> +=C2=A0=C2=A0=C2=A0 const struct ublox_model* m;
>> +=C2=A0=C2=A0=C2=A0 const char* model_str;
>> -=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +=C2=A0=C2=A0=C2=A0 decode_at_error(&error, g_at_result_final_response(r=
esult));
>> -=C2=A0=C2=A0=C2=A0 model_str =3D ofono_modem_get_string(modem, "Model");
>> -=C2=A0=C2=A0=C2=A0 if (model_str =3D=3D NULL)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 if (!ok)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Toby L2 devices are more complex and special=
 than previously
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * supported U-Blox devices. So they need a ven=
dor of their own.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 data->model_id =3D atoi(model_str);
>> -
>> -=C2=A0=C2=A0=C2=A0 data->vendor_family =3D OFONO_VENDOR_UBLOX;
>> -
>> -=C2=A0=C2=A0=C2=A0 switch (data->model_id) {
>> -=C2=A0=C2=A0=C2=A0 case SARA_G270:
>> -=C2=A0=C2=A0=C2=A0 case TOBYL2_COMPATIBLE_MODE:
>> -=C2=A0=C2=A0=C2=A0 case TOBYL2_HIGH_THROUGHPUT_MODE:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -=C2=A0=C2=A0=C2=A0 case TOBYL2_MEDIUM_THROUGHPUT_MODE:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("low/medium throughtput =
profile unsupported");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -=C2=A0=C2=A0=C2=A0 default:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("unknown ublox model id =
%d", data->model_id);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 if (at_util_parse_attr(result, "", &model) =3D=3D FA=
LSE) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_error("Failed to query=
 modem model");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 m =3D ublox_model_from_name(model);
>> +=C2=A0=C2=A0=C2=A0 if (!m->name) {
> =

> So you just potentially crashed here
> =

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_error("Unrecognized mo=
del: %s", model);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 data->model =3D m;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("Model: %s", data->model->name);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (data->model->flags & UBLOX_F_TOBY_L2) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 model_str =3D ofono_modem_ge=
t_string(modem, "Model");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!model_str)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 fail;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Toby L2 devices are =
more complex and special than previously
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * supported U-Blox dev=
ices. So they need a vendor of their own.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->model_id =3D atoi(mode=
l_str);
>> +
> =

> atoi is generally considered harmful.=C2=A0 Use strtoul instead
> =

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (data->model_id) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TOBYL2_COMPATIBLE_MODE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TOBYL2_HIGH_THROUGHPUT_=
MODE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TOBYL2_MEDIUM_THROUGHPU=
T_MODE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG(=
"low/medium throughtput profile unsupported");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG(=
"unknown ublox model id %d", data->model_id);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->vendor_family =3D OFON=
O_VENDOR_UBLOX;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (g_at_chat_send(data->aux, "AT+CFUN=3D4", none_pr=
efix,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfun_enable, modem, NULL))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +fail:
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->aux);
>> +=C2=A0=C2=A0=C2=A0 data->aux =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->modem);
>> +=C2=A0=C2=A0=C2=A0 data->modem =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 ofono_modem_set_powered(modem, FALSE);
>> +}
>> +
>> +static int ublox_enable(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ublox_data *data =3D ofono_modem_get_data(mod=
em);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->aux =3D open_device(modem, "Aux", "=
Aux: ");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If this is a serial modem then the dev=
ice may be behind
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the 'Device' attribute instead...
>> @@ -199,7 +243,6 @@ static int ublox_enable(struct ofono_modem *modem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_set_sla=
ve(data->modem, data->aux);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_send(da=
ta->modem, "ATE0 +CMEE=3D1", none_prefix,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 NULL, NULL, NULL);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_send(da=
ta->modem, "AT&C0", NULL, NULL, NULL, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -209,10 +252,14 @@ static int ublox_enable(struct ofono_modem *modem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "ATE0 +CMEE=3D1=
", none_prefix,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL, NULL);
>> -=C2=A0=C2=A0=C2=A0 g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfun_enable, modem, NULL);
>> +=C2=A0=C2=A0=C2=A0 if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 query_model_cb, modem, NULL) > 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINPROGRESS;
>> -=C2=A0=C2=A0=C2=A0 return -EINPROGRESS;
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->aux);
>> +=C2=A0=C2=A0=C2=A0 data->aux =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0 }
>> =C2=A0 static void cfun_disable(gboolean ok, GAtResult *result, gpointer =

>> user_data)
>>
> =

> Regards,
> -Denis

--===============1764360757819976937==--

