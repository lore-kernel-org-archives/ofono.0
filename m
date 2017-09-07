Content-Type: multipart/mixed; boundary="===============3398658376571411783=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] huawei: add LTE support
Date: Thu, 07 Sep 2017 11:40:15 -0500
Message-ID: <7b83ba28-0c4d-6afa-b947-077403b16022@gmail.com>
In-Reply-To: <1504690946-11705-2-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3398658376571411783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 09/06/2017 04:42 AM, Christophe Ronco wrote:
> Huawei LTE modems use AT^SYSCFGEX and AT^SYSINFOEX instead of
> AT^SYSCFG and AT^SYSINFO.
> If we want to be able to attach on LTE with this modem, we must use
> AT^SYSCFGEX to configure rat mode and band. Using AT^SYSCFG, mode any
> means UMTS or GSM.
> ---
>   drivers/huaweimodem/radio-settings.c | 213 ++++++++++++++++++++++++++++=
++++---
>   1 file changed, 197 insertions(+), 16 deletions(-)
> =

> diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/r=
adio-settings.c
> index c34653a..5eb93f6 100644
> --- a/drivers/huaweimodem/radio-settings.c
> +++ b/drivers/huaweimodem/radio-settings.c
> @@ -42,11 +42,13 @@
>   =

>   static const char *none_prefix[] =3D { NULL };
>   static const char *syscfg_prefix[] =3D { "^SYSCFG:", NULL };
> +static const char *syscfgex_prefix[] =3D { "^SYSCFGEX:", NULL };
>   =

>   #define HUAWEI_BAND_ANY 0x3FFFFFFF
>   =

>   struct radio_settings_data {
>   	GAtChat *chat;
> +	ofono_bool_t syscfgex_cap;
>   };
>   =

>   static const struct huawei_band_gsm_table {
> @@ -176,20 +178,81 @@ error:
>   	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
>   }
>   =

> +static void syscfgex_query_mode_cb(gboolean ok, GAtResult *result,
> +					gpointer user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
> +	enum ofono_radio_access_mode mode;
> +	struct ofono_error error;
> +	GAtResultIter iter;
> +	const char *acqorder;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		cb(&error, -1, cbd->data);
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (g_at_result_iter_next(&iter, "^SYSCFGEX:") =3D=3D FALSE)
> +		goto error;
> +
> +	if (g_at_result_iter_next_string(&iter, &acqorder) =3D=3D FALSE)
> +		goto error;
> +
> +	mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
> +	if (strstr(acqorder, "01"))
> +		mode |=3D OFONO_RADIO_ACCESS_MODE_GSM;
> +	if (strstr(acqorder, "02"))
> +		mode |=3D OFONO_RADIO_ACCESS_MODE_UMTS;
> +	if (strstr(acqorder, "03"))
> +		mode |=3D OFONO_RADIO_ACCESS_MODE_LTE;

So what happens if we get back something like "030201" (e.g. =

LTE->WCDMA->GSM)?  We will get a value of '7' being reported to the =

core, which isn't handled by =

src/radio-settings.c:radio_access_mode_to_string().

oFono does not support ordered technology preferences.  Maybe this is =

something we should add in the future, but some firmware doesn't support =

this.

> +
> +	if (mode =3D=3D OFONO_RADIO_ACCESS_MODE_ANY) {
> +		if (strstr(acqorder, "00") =3D=3D NULL) {

strcmp?

> +			DBG("Can't interpret SYSCFGEX mode: %s",
> +							acqorder);
> +			goto error;
> +		}
> +	}
> +
> +	cb(&error, mode, cbd->data);
> +
> +	return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +}
> +
>   static void huawei_query_rat_mode(struct ofono_radio_settings *rs,
>   			ofono_radio_settings_rat_mode_query_cb_t cb, void *data)
>   {
>   	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
>   	struct cb_data *cbd =3D cb_data_new(cb, data);
>   =

> -	if (g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
> -				syscfg_query_mode_cb, cbd, g_free) =3D=3D 0) {
> -		CALLBACK_WITH_FAILURE(cb, -1, data);
> -		g_free(cbd);
> +	if (rsd->syscfgex_cap) {
> +		if (g_at_chat_send(rsd->chat, "AT^SYSCFGEX?",
> +					syscfgex_prefix,
> +					syscfgex_query_mode_cb,
> +					cbd, g_free) =3D=3D 0) {
> +			CALLBACK_WITH_FAILURE(cb, -1, data);
> +			g_free(cbd);

if (rsd->syscfgex_cap && g_at_chat_send(...) > 0)
	return;

if (!rsd->syscfgex_cap && g_at_chat_send(...) > 0)
	return;

CALLBACK...
g_free()

> +		}
> +	} else {
> +		if (g_at_chat_send(rsd->chat, "AT^SYSCFG?",
> +					syscfg_prefix,
> +					syscfg_query_mode_cb,
> +					cbd, g_free) =3D=3D 0) {
> +			CALLBACK_WITH_FAILURE(cb, -1, data);
> +			g_free(cbd);
> +		}
>   	}
>   }
>   =

> -static void syscfg_modify_mode_cb(gboolean ok, GAtResult *result,
> +static void syscfgxx_modify_mode_cb(gboolean ok, GAtResult *result,
>   							gpointer user_data)
>   {
>   	struct cb_data *cbd =3D user_data;
> @@ -200,12 +263,11 @@ static void syscfg_modify_mode_cb(gboolean ok, GAtR=
esult *result,
>   	cb(&error, cbd->data);
>   }
>   =

> -static void huawei_set_rat_mode(struct ofono_radio_settings *rs,
> +static void syscfg_set_rat_mode(struct radio_settings_data *rsd,
>   				enum ofono_radio_access_mode mode,
>   				ofono_radio_settings_rat_mode_set_cb_t cb,
>   				void *data)
>   {
> -	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
>   	struct cb_data *cbd =3D cb_data_new(cb, data);
>   	char buf[40];
>   	unsigned int value =3D 2, acq_order =3D 0;
> @@ -231,7 +293,7 @@ static void huawei_set_rat_mode(struct ofono_radio_se=
ttings *rs,
>   							value, acq_order);
>   =

>   	if (g_at_chat_send(rsd->chat, buf, none_prefix,
> -					syscfg_modify_mode_cb, cbd, g_free) > 0)
> +			syscfgxx_modify_mode_cb, cbd, g_free) > 0)
>   		return;
>   =

>   error:
> @@ -239,7 +301,55 @@ error:
>   	g_free(cbd);
>   }
>   =

> -static void syscfg_modify_band_cb(gboolean ok, GAtResult *result,
> +static void syscfgex_set_rat_mode(struct radio_settings_data *rsd,
> +				enum ofono_radio_access_mode mode,
> +				ofono_radio_settings_rat_mode_set_cb_t cb,
> +				void *data)
> +{
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[50];
> +	char *atcmd =3D "AT^SYSCFGEX=3D\"%s\",40000000,2,4,40000000,,";
> +	char *acqorder =3D "030201";
> +
> +	switch (mode) {
> +	case OFONO_RADIO_ACCESS_MODE_ANY:
> +		acqorder =3D "00";
> +		break;
> +	case OFONO_RADIO_ACCESS_MODE_GSM:
> +		acqorder =3D "01";
> +		break;
> +	case OFONO_RADIO_ACCESS_MODE_UMTS:
> +		acqorder =3D "02";
> +		break;
> +	case OFONO_RADIO_ACCESS_MODE_LTE:
> +		acqorder =3D "03";
> +		break;
> +	}
> +
> +	snprintf(buf, sizeof(buf), atcmd, acqorder);
> +
> +	if (g_at_chat_send(rsd->chat, buf, none_prefix,
> +			syscfgxx_modify_mode_cb, cbd, g_free) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	g_free(cbd);
> +}
> +
> +static void huawei_set_rat_mode(struct ofono_radio_settings *rs,
> +				enum ofono_radio_access_mode mode,
> +				ofono_radio_settings_rat_mode_set_cb_t cb,
> +				void *data)
> +{
> +	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
> +
> +	if (rsd->syscfgex_cap)
> +		syscfgex_set_rat_mode(rsd, mode, cb, data);
> +	else
> +		syscfg_set_rat_mode(rsd, mode, cb, data);
> +}
> +
> +static void syscfgxx_modify_band_cb(gboolean ok, GAtResult *result,
>   							gpointer user_data)
>   {
>   	struct cb_data *cbd =3D user_data;
> @@ -250,13 +360,54 @@ static void syscfg_modify_band_cb(gboolean ok, GAtR=
esult *result,
>   	cb(&error, cbd->data);
>   }
>   =

> -static void huawei_set_band(struct ofono_radio_settings *rs,
> +static void syscfgex_set_band(struct radio_settings_data *rsd,
> +					enum ofono_radio_band_gsm band_gsm,
> +					enum ofono_radio_band_umts band_umts,
> +					ofono_radio_settings_band_set_cb_t cb,
> +					void *data)
> +{
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[50];
> +	char *atcmd =3D "AT^SYSCFGEX=3D\"99\",%x,2,4,40000000,,";
> +	unsigned int huawei_band;
> +
> +	if (band_gsm =3D=3D OFONO_RADIO_BAND_GSM_ANY
> +			&& band_umts =3D=3D OFONO_RADIO_BAND_UMTS_ANY) {
> +		huawei_band =3D HUAWEI_BAND_ANY;
> +	} else {
> +		unsigned int huawei_band_gsm;
> +		unsigned int huawei_band_umts;
> +
> +		huawei_band_gsm =3D band_gsm_to_huawei(band_gsm);
> +
> +		if (!huawei_band_gsm)
> +			goto error;
> +
> +		huawei_band_umts =3D band_umts_to_huawei(band_umts);
> +
> +		if (!huawei_band_umts)
> +			goto error;
> +
> +		huawei_band =3D huawei_band_gsm | huawei_band_umts;
> +	}
> +
> +	snprintf(buf, sizeof(buf), atcmd, huawei_band);
> +
> +	if (g_at_chat_send(rsd->chat, buf, none_prefix,
> +			syscfgxx_modify_band_cb, cbd, g_free) > 0)
> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	g_free(cbd);
> +}
> +
> +static void syscfg_set_band(struct radio_settings_data *rsd,
>   					enum ofono_radio_band_gsm band_gsm,
>   					enum ofono_radio_band_umts band_umts,
>   					ofono_radio_settings_band_set_cb_t cb,
>   					void *data)
>   {
> -	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
>   	struct cb_data *cbd =3D cb_data_new(cb, data);
>   	char buf[40];
>   	unsigned int huawei_band;
> @@ -284,7 +435,7 @@ static void huawei_set_band(struct ofono_radio_settin=
gs *rs,
>   	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D16,3,%x,2,4", huawei_band);
>   =

>   	if (g_at_chat_send(rsd->chat, buf, none_prefix,
> -					syscfg_modify_band_cb, cbd, g_free) > 0)
> +			syscfgxx_modify_band_cb, cbd, g_free) > 0)

Was something wrong with the previous indentation?

>   		return;
>   =

>   error:
> @@ -292,6 +443,20 @@ error:
>   	g_free(cbd);
>   }
>   =

> +static void huawei_set_band(struct ofono_radio_settings *rs,
> +					enum ofono_radio_band_gsm band_gsm,
> +					enum ofono_radio_band_umts band_umts,
> +					ofono_radio_settings_band_set_cb_t cb,
> +					void *data)
> +{
> +	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
> +
> +	if (rsd->syscfgex_cap)
> +		syscfgex_set_band(rsd, band_gsm, band_umts, cb, data);
> +	else
> +		syscfg_set_band(rsd, band_gsm, band_umts, cb, data);
> +}
> +
>   static void syscfg_query_band_cb(gboolean ok, GAtResult *result,
>   					gpointer user_data)
>   {
> @@ -364,6 +529,22 @@ static void syscfg_support_cb(gboolean ok, GAtResult=
 *result,
>   	ofono_radio_settings_register(rs);
>   }
>   =

> +static void syscfgex_support_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	struct ofono_radio_settings *rs =3D user_data;
> +	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
> +
> +	if (!ok) {
> +		g_at_chat_send(rsd->chat, "AT^SYSCFG=3D?", syscfg_prefix,
> +					syscfg_support_cb, rs, NULL);
> +		return;
> +	}
> +
> +	rsd->syscfgex_cap =3D 1;
> +	ofono_radio_settings_register(rs);
> +}
> +
>   static int huawei_radio_settings_probe(struct ofono_radio_settings *rs,
>   					unsigned int vendor, void *data)
>   {
> @@ -378,8 +559,8 @@ static int huawei_radio_settings_probe(struct ofono_r=
adio_settings *rs,
>   =

>   	ofono_radio_settings_set_data(rs, rsd);
>   =

> -	g_at_chat_send(rsd->chat, "AT^SYSCFG=3D?", syscfg_prefix,
> -					syscfg_support_cb, rs, NULL);
> +	g_at_chat_send(rsd->chat, "AT^SYSCFGEX=3D?", syscfgex_prefix,
> +					syscfgex_support_cb, rs, NULL);
>   =

>   	return 0;
>   }
> @@ -400,8 +581,8 @@ static struct ofono_radio_settings_driver driver =3D {
>   	.remove			=3D huawei_radio_settings_remove,
>   	.query_rat_mode		=3D huawei_query_rat_mode,
>   	.set_rat_mode		=3D huawei_set_rat_mode,
> -	.query_band             =3D huawei_query_band,
> -	.set_band               =3D huawei_set_band,
> +	.query_band		=3D huawei_query_band,
> +	.set_band		=3D huawei_set_band,

You might also want to support
query_available_rats method now.

>   };
>   =

>   void huawei_radio_settings_init(void)
> =


Regards,
-Denis

--===============3398658376571411783==--

