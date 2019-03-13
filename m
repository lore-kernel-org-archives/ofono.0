Content-Type: multipart/mixed; boundary="===============2581251340265419510=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/14] ublox: query device model
Date: Wed, 13 Mar 2019 13:37:02 -0500
Message-ID: <a9a855a2-a762-2061-173c-92c751bfc21f@gmail.com>
In-Reply-To: <20190312111008.29258-6-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2581251340265419510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/12/2019 06:09 AM, Jonas Bonn wrote:
> This patch adds a call to CGMM into the modem_enable path in order to
> establish the specific device model.  From this device model string, a
> model-specific capabilities structure can be selected.
> ---
>   plugins/ublox.c | 107 ++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 77 insertions(+), 30 deletions(-)
> =


Have you tried running checkpatch.pl on these?  There are too many =

coding style violations for me to fix.

Here's a small sample:

ERROR: "foo* bar" should be "foo *bar"
#138: FILE: plugins/ublox.c:64:
+	const struct ublox_model* model;

ERROR: DOS line endings
#147: FILE: plugins/ublox.c:158:
+static void query_model_cb(gboolean ok, GAtResult *result, gpointer =

user_data)^M$

ERROR: DOS line endings
#149: FILE: plugins/ublox.c:160:
+^Istruct ofono_modem* modem =3D user_data;^M$

ERROR: "foo* bar" should be "foo *bar"
#149: FILE: plugins/ublox.c:160:
+	struct ofono_modem* modem =3D user_data;



> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index 32cf1e61..efb0afbc 100644
> --- a/plugins/ublox.c
> +++ b/plugins/ublox.c
> @@ -42,9 +42,10 @@
>   #include <ofono/lte.h>
>   #include <ofono/voicecall.h>
>   =

> -#include <drivers/atmodem/atutil.h>
>   #include <drivers/atmodem/vendor.h>
>   =

> +#include <drivers/ubloxmodem/ubloxmodem.h>
> +
>   static const char *none_prefix[] =3D { NULL };
>   =

>   enum supported_models {
> @@ -59,6 +60,8 @@ struct ublox_data {
>   	GAtChat *aux;
>   	int model_id;
>   	enum ofono_vendor vendor_family;
> +
> +	const struct ublox_model* model;
>   };
>   =

>   static void ublox_debug(const char *str, void *user_data)
> @@ -152,38 +155,79 @@ static void cfun_enable(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   	ofono_modem_set_powered(modem, TRUE);
>   }
>   =

> -static int ublox_enable(struct ofono_modem *modem)
> +static void query_model_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
>   {
> +	struct ofono_modem* modem =3D user_data;
>   	struct ublox_data *data =3D ofono_modem_get_data(modem);
> -	const char *model_str =3D NULL;
> +	struct ofono_error error;
> +	const char *model;
> +	const struct ublox_model* m;
> +	const char* model_str;
>   =

> -	DBG("%p", modem);
> +	decode_at_error(&error, g_at_result_final_response(result));
>   =

> -	model_str =3D ofono_modem_get_string(modem, "Model");
> -	if (model_str =3D=3D NULL)
> -		return -EINVAL;
> +	if (!ok)
> +		goto fail;
>   =

> -	/*
> -	 * Toby L2 devices are more complex and special than previously
> -	 * supported U-Blox devices. So they need a vendor of their own.
> -	 */
> -	data->model_id =3D atoi(model_str);
> -
> -	data->vendor_family =3D OFONO_VENDOR_UBLOX;
> -
> -	switch (data->model_id) {
> -	case SARA_G270:
> -	case TOBYL2_COMPATIBLE_MODE:
> -	case TOBYL2_HIGH_THROUGHPUT_MODE:
> -		break;
> -	case TOBYL2_MEDIUM_THROUGHPUT_MODE:
> -		DBG("low/medium throughtput profile unsupported");
> -		break;
> -	default:
> -		DBG("unknown ublox model id %d", data->model_id);
> -		return -EINVAL;
> +	if (at_util_parse_attr(result, "", &model) =3D=3D FALSE) {
> +		ofono_error("Failed to query modem model");
> +		goto fail;
>   	}
>   =

> +	m =3D ublox_model_from_name(model);
> +	if (!m->name) {

So you just potentially crashed here

> +		ofono_error("Unrecognized model: %s", model);
> +		goto fail;
> +	}
> +
> +	data->model =3D m;
> +
> +	DBG("Model: %s", data->model->name);
> +
> +	if (data->model->flags & UBLOX_F_TOBY_L2) {
> +		model_str =3D ofono_modem_get_string(modem, "Model");
> +		if (!model_str)
> +			goto fail;
> +
> +		/*
> +		 * Toby L2 devices are more complex and special than previously
> +		 * supported U-Blox devices. So they need a vendor of their own.
> +		 */
> +		data->model_id =3D atoi(model_str);
> +

atoi is generally considered harmful.  Use strtoul instead

> +		switch (data->model_id) {
> +		case TOBYL2_COMPATIBLE_MODE:
> +		case TOBYL2_HIGH_THROUGHPUT_MODE:
> +			break;
> +		case TOBYL2_MEDIUM_THROUGHPUT_MODE:
> +			DBG("low/medium throughtput profile unsupported");
> +			break;
> +		default:
> +			DBG("unknown ublox model id %d", data->model_id);
> +			goto fail;
> +		}
> +	} else {
> +		data->vendor_family =3D OFONO_VENDOR_UBLOX;
> +	}
> +
> +	if (g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
> +					cfun_enable, modem, NULL))
> +		return;
> +
> +fail:
> +	g_at_chat_unref(data->aux);
> +	data->aux =3D NULL;
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +	ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static int ublox_enable(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
>   	data->aux =3D open_device(modem, "Aux", "Aux: ");
>   	/* If this is a serial modem then the device may be behind
>   	 * the 'Device' attribute instead...
> @@ -199,7 +243,6 @@ static int ublox_enable(struct ofono_modem *modem)
>   		g_at_chat_set_slave(data->modem, data->aux);
>   		g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", none_prefix,
>   						NULL, NULL, NULL);
> -
>   		g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
>   	}
>   =

> @@ -209,10 +252,14 @@ static int ublox_enable(struct ofono_modem *modem)
>   	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
>   					NULL, NULL, NULL);
>   =

> -	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
> -					cfun_enable, modem, NULL);
> +	if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
> +				query_model_cb, modem, NULL) > 0)
> +		return -EINPROGRESS;
>   =

> -	return -EINPROGRESS;
> +	g_at_chat_unref(data->aux);
> +	data->aux =3D NULL;
> +
> +	return -EINVAL;
>   }
>   =

>   static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_=
data)
> =


Regards,
-Denis

--===============2581251340265419510==--

