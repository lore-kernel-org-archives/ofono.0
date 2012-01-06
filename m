Content-Type: multipart/mixed; boundary="===============7240333875522568835=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v0 2/3] huawei: Add modem type detection
Date: Fri, 06 Jan 2012 13:43:49 -0800
Message-ID: <1325886229.6454.95.camel@aeonflux>
In-Reply-To: <1325863718-19357-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7240333875522568835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> This plugin is now merged with huaweicdma one.
> Atoms will now be created with GSM or CDMA drivers
> depending on the result of ATI command.
> No SIM atom is created for embedded sim from CDMA
> modems.
> ---
>  plugins/huawei.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++++=
-----
>  1 files changed, 69 insertions(+), 8 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index ae15bf9..a3768c8 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -51,6 +51,9 @@
>  #include <ofono/message-waiting.h>
>  #include <ofono/log.h>
>  =

> +#include <ofono/cdma-netreg.h>
> +#include <ofono/cdma-connman.h>
> +
>  #include <drivers/atmodem/atutil.h>
>  #include <drivers/atmodem/vendor.h>
>  =

> @@ -66,6 +69,7 @@ enum {
>  	SIM_STATE_INVALID_CS =3D		2,
>  	SIM_STATE_INVALID_PS =3D		3,
>  	SIM_STATE_INVALID_PS_AND_CS =3D	4,
> +	SIM_STATE_ROMSIM =3D		240,
>  	SIM_STATE_NOT_EXISTENT =3D	255,
>  };

I really don't wanna random intermix of determining modem type and
dealing with CDMA extensions. This should be nicely split into logical
patches.
 =

> @@ -79,6 +83,7 @@ struct huawei_data {
>  	struct cb_data *online_cbd;
>  	const char *offline_command;
>  	gboolean voice;
> +	gboolean gsm;

So just calling this gsm is a bit to short. Same goes for voice. That
was a mistake and I fixed that upstream now to rename it to have_voice.

>  };
>  =

>  static int huawei_probe(struct ofono_modem *modem)
> @@ -405,7 +410,7 @@ static void rfswitch_support(gboolean ok, GAtResult *=
result, gpointer user_data)
>  	struct ofono_modem *modem =3D user_data;
>  	struct huawei_data *data =3D ofono_modem_get_data(modem);
>  =

> -	if (!ok)
> +	if (!ok || !data->gsm)
>  		data->offline_command =3D "AT+CFUN=3D5";
>  	else
>  		data->offline_command =3D "AT+CFUN=3D7";

This should be a separate patch as well. I think the important part is
to first enhance the plugin to detect GSM. And then on-top of that
handle the difference between GSM and CDMA.

> @@ -414,6 +419,44 @@ static void rfswitch_support(gboolean ok, GAtResult =
*result, gpointer user_data)
>  					cfun_enable, modem, NULL);
>  }
>  =

> +static gboolean parse_ati_result(GAtResult *result)
> +{
> +	GAtResultIter iter;
> +	const char *line;
> +	int num =3D g_at_result_num_response_lines(result);
> +	int i;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	for (i =3D 0; i < num; i++) {
> +		g_at_result_iter_next(&iter, NULL);
> +		line =3D g_at_result_iter_raw_line(&iter);
> +		if (g_str_has_prefix(line, "+GCAP"))
> +			return (g_strrstr(line, "+CGSM") !=3D NULL);

This parsing is more complex than it needs to be. It also parses the
string too many times. Especially since GAtChat does that all for you
already anyway.

Instead of posting an example here, I just pushed a patch so you can see
how easily this can be done.

> +	}
> +
> +	/* By default we consider modem is GSM type */
> +	return TRUE;
> +}
> +
> +static void ati_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct huawei_data *data =3D ofono_modem_get_data(modem);
> +
> +	/* By default we consider modem is GSM type */
> +	if (!ok)
> +		data->gsm =3D TRUE;
> +	else
> +		data->gsm =3D parse_ati_result(result);

I don't like this. We should use have_gsm and have_cdma and not randomly
fallback to one of them. If for some reason ATI does not show any of
them, we should also not do anything either.

More important I do wanna get bug reports if ATI does not carry +GCAP or
has some weird capabilities inside.

> +
> +	data->sim_state =3D SIM_STATE_NOT_EXISTENT;
> +
> +	g_at_chat_send(data->pcui, "AT^RFSWITCH=3D?", rfswitch_prefix,
> +					rfswitch_support, modem, NULL);
> +}
> +
> +
>  static GAtChat *open_device(struct ofono_modem *modem,
>  				const char *key, char *debug)
>  {
> @@ -472,10 +515,7 @@ static int huawei_enable(struct ofono_modem *modem)
>  	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
>  	g_at_chat_send(data->pcui, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
>  =

> -	data->sim_state =3D SIM_STATE_NOT_EXISTENT;

Leave this sim_state assignment at this location. No point in moving
this higher up.

> -
> -	g_at_chat_send(data->pcui, "AT^RFSWITCH=3D?", rfswitch_prefix,
> -					rfswitch_support, modem, NULL);
> +	g_at_chat_send(data->pcui, "ATI", NULL, ati_cb, modem, NULL);
>  =

>  	return -EINPROGRESS;
>  }
> @@ -555,6 +595,7 @@ static void sysinfo_online_cb(gboolean ok, GAtResult =
*result,
>  	case SIM_STATE_INVALID_CS:
>  	case SIM_STATE_INVALID_PS:
>  	case SIM_STATE_INVALID_PS_AND_CS:
> +	case SIM_STATE_ROMSIM:
>  		CALLBACK_WITH_SUCCESS(cb, data->online_cbd->data);

This should be a separate patch together with the state addition.

>  		goto done;
>  	}
> @@ -650,13 +691,21 @@ static void huawei_set_online(struct ofono_modem *m=
odem, ofono_bool_t online,
>  static void huawei_pre_sim(struct ofono_modem *modem)
>  {
>  	struct huawei_data *data =3D ofono_modem_get_data(modem);
> -	struct ofono_sim *sim;
> +	struct ofono_sim *sim =3D NULL;

Please don't do that. I prefer not assigning variables with NULL here.
It is better to change the logic around.

>  =

>  	DBG("%p", modem);
>  =

> -	ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
> -	sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
> +	if (data->gsm =3D=3D TRUE) {
> +		ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
> +		sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
>  					"atmodem", data->pcui);
> +	} else {
> +		ofono_devinfo_create(modem, 0, "cdmamodem", data->pcui);
> +		/* Create sim atom only if sim is not embedded */
> +		if (data->sim_state !=3D SIM_STATE_ROMSIM)
> +			sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
> +						"atmodem", data->pcui);

I am really not sure that it is a good idea to just use the GSM SIM atom
here. The EF structure will be different and we might cause more harm
than doing any good in assuming that we get any proper EF fields.

This is clearly the part where we need detailed information from Huawei
on how this is suppose to work. And how this is suppose to be done for
CDMA in the first place anyway.

> +	}
>  =

>  	if (sim && data->have_sim =3D=3D TRUE)
>  		ofono_sim_inserted_notify(sim, TRUE);
> @@ -670,6 +719,9 @@ static void huawei_post_sim(struct ofono_modem *modem)
>  =

>  	DBG("%p", modem);
>  =

> +	if (data->gsm =3D=3D FALSE)
> +		return;
> +
>  	if (data->voice =3D=3D TRUE) {
>  		ofono_voicecall_create(modem, 0, "huaweimodem", data->pcui);
>  		ofono_audio_settings_create(modem, 0,
> @@ -695,6 +747,15 @@ static void huawei_post_online(struct ofono_modem *m=
odem)
>  =

>  	DBG("%p", modem);
>  =

> +	if (data->gsm =3D=3D FALSE) {
> +		ofono_cdma_netreg_create(modem, 0, "huaweicdmamodem",
> +						data->pcui);
> +
> +		ofono_cdma_connman_create(modem, OFONO_VENDOR_HUAWEI,
> +						"cdmamodem", data->modem);
> +		return;
> +	}
> +
>  	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->pcui);
>  =

>  	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,

Lets do if (data->have_gsm ... and if (data->have_cdma ...) separate
here. I rather no degrade GSM to second class citizen.

Regards

Marcel



--===============7240333875522568835==--

