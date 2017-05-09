Content-Type: multipart/mixed; boundary="===============8132881052611097149=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: pri_set_apn not exclusively a DBus method
Date: Tue, 09 May 2017 11:37:35 -0500
Message-ID: <4efbb019-1b6e-c69b-37d9-c1ee9e9fe8ce@gmail.com>
In-Reply-To: <1494341557-3118-2-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8132881052611097149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 05/09/2017 09:52 AM, Christophe Ronco wrote:
> pri_set_apn is called by ofono_gprs_cid_activated() when attached
> using LTE technology.
> This patch avoid calling DBUS functions in this case. Without
> this patch we have a crash in ofono process in this case.
>
> diff --git a/src/gprs.c b/src/gprs.c
> index c5e7709..9c6d282 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1027,14 +1027,28 @@ static DBusMessage *pri_set_apn(struct pri_contex=
t *ctx, DBusConnection *conn,
>  {
>  	GKeyFile *settings =3D ctx->gprs->settings;
>
> -	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH)
> -		return __ofono_error_invalid_format(msg);
> +	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH) {
> +		if (msg)
> +			return __ofono_error_invalid_format(msg);
>
> -	if (g_str_equal(apn, ctx->context.apn))
> -		return dbus_message_new_method_return(msg);
> +		DBG("APN %s too long", apn);
> +		return NULL;
> +	}
>
> -	if (is_valid_apn(apn) =3D=3D FALSE)
> -		return __ofono_error_invalid_format(msg);
> +	if (g_str_equal(apn, ctx->context.apn)) {
> +		if (msg)
> +			return dbus_message_new_method_return(msg);
> +
> +		return NULL;

Returning NULL on a success path doesn't really make any sense.

> +	}
> +
> +	if (is_valid_apn(apn) =3D=3D FALSE) {
> +		if (msg)
> +			return __ofono_error_invalid_format(msg);
> +
> +		DBG("APN %s invalid", apn);
> +		return NULL;
> +	}
>
>  	strcpy(ctx->context.apn, apn);
>
>

Anyway, I have now fixed this in =

d9cb969dcff649d33f97ceddac57163dfc9602db.  Let me know if I broke something.

Regards,
-Denis

--===============8132881052611097149==--

