Content-Type: multipart/mixed; boundary="===============5254654053613137066=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 1/1] atmodem: add ifx support for pin retries query
Date: Tue, 18 Jan 2011 15:22:48 +0100
Message-ID: <1295360568.3873.176.camel@aeonflux>
In-Reply-To: <1295354069-11717-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5254654053613137066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

> Adds ifx support for the remaining pin retries query

since the commit message is essentially the same as the subject line,
you can leave it out. Or better expend the commit message with further
details or example of the command.

> ---
>  drivers/atmodem/sim.c |   84 +++++++++++++++++++++++++++++++++++++++----=
------
>  1 files changed, 67 insertions(+), 17 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index c5f4a44..2219e88 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -56,6 +56,7 @@ static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
>  static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
>  static const char *clck_prefix[] =3D { "+CLCK:", NULL };
>  static const char *huawei_cpin_prefix[] =3D { "^CPIN:", NULL };
> +static const char *xpincnt_prefix[] =3D { "+XPINCNT:", NULL };
>  static const char *none_prefix[] =3D { NULL };
>  =

>  static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> @@ -522,40 +523,89 @@ error:
>  	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
>  }
>  =

> +static void xpincnt_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
> +	const char *final =3D g_at_result_final_response(result);
> +	GAtResultIter iter;
> +	struct ofono_error error;
> +	int retries[OFONO_SIM_PASSWORD_INVALID];
> +	size_t i;
> +	static enum ofono_sim_password_type password_types[] =3D {
> +		OFONO_SIM_PASSWORD_SIM_PIN,
> +		OFONO_SIM_PASSWORD_SIM_PIN2,
> +		OFONO_SIM_PASSWORD_SIM_PUK,
> +		OFONO_SIM_PASSWORD_SIM_PUK2,
> +	};
> +
> +	decode_at_error(&error, final);
> +
> +	if (!ok) {
> +		cb(&error, NULL, cbd->data);
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+XPINCNT:"))
> +		goto error;
> +
> +	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
> +		retries[i] =3D -1;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(password_types); i++) {
> +		int val;
> +
> +		if (!g_at_result_iter_next_number(&iter, &val))
> +			goto error;
> +
> +		retries[password_types[i]]=3D val;

coding style issue. Must be [i]] =3D val, but I also realized that the
Huawei code has the same issue. That needs to be fixed as well.

Btw. the code is 100% identical besides the password_types type array.
Maybe it is a good idea to write a helper function for this.

> +		DBG("retry counter id=3D%d, val=3D%d", password_types[i],
> +						retries[password_types[i]]);
> +	}
> +
> +	cb(&error, retries, cbd->data);
> +
> +	return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +}
> +
>  static void at_pin_retries_query(struct ofono_sim *sim,
>  				ofono_sim_pin_retries_cb_t cb, void *data)
>  {
>  	struct sim_data *sd =3D ofono_sim_get_data(sim);
> -	struct cb_data *cbd;
> -	int retries[OFONO_SIM_PASSWORD_INVALID];
> -	int i;
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
>  =

>  	DBG("");
>  =

> -	switch (sd->vendor) {
> -	case OFONO_VENDOR_HUAWEI:
> -		cbd =3D cb_data_new(cb, data);
> +	if (cbd =3D=3D NULL)
> +		goto error;
>  =

> -		if (cbd =3D=3D NULL) {
> -			CALLBACK_WITH_FAILURE(cb, NULL, data);
> +	switch (sd->vendor) {
> +	case OFONO_VENDOR_IFX:
> +		if (g_at_chat_send(sd->chat, "AT+XPINCNT", xpincnt_prefix,
> +					xpincnt_cb, cbd, g_free) > 0)
>  			return;
> -		}
>  =

> +		break;
> +	case OFONO_VENDOR_HUAWEI:
>  		if (g_at_chat_send(sd->chat, "AT^CPIN?", huawei_cpin_prefix,
>  					huawei_cpin_cb, cbd, g_free) > 0)
>  			return;
>  =

> -		g_free(cbd);
> -
> -		CALLBACK_WITH_FAILURE(cb, NULL, data);
>  		break;
> -
>  	default:
> -		for(i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
> -			retries[i] =3D -1;
> -
> -		CALLBACK_WITH_SUCCESS(cb, retries, data);
> +		break;
>  	}
> +
> +error:
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, NULL, data);
>  }
>  =

>  static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)

The rest looks fine to me.

Regards

Marcel



--===============5254654053613137066==--

