Content-Type: multipart/mixed; boundary="===============0619182925900650245=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] ubloxmodem: support authentication
Date: Thu, 17 Mar 2016 11:25:20 -0500
Message-ID: <56EADA70.1060402@gmail.com>
In-Reply-To: <1458229430-31435-3-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0619182925900650245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/17/2016 10:43 AM, Dragos Tatulea wrote:
> If username and password specified, issue an UAUTHREQ
> command with the configured authentication method, selected cid
> and credentials.
> ---
>   drivers/ubloxmodem/gprs-context.c | 62 ++++++++++++++++++++++++++++++++=
++++---
>   1 file changed, 58 insertions(+), 4 deletions(-)
>

Applied, but...

> diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-=
context.c
> index a3d9743..ec09a53 100644
> --- a/drivers/ubloxmodem/gprs-context.c
> +++ b/drivers/ubloxmodem/gprs-context.c
> @@ -230,10 +230,44 @@ static void cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>   	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
>   }
>
> -static void ublox_send_cgdcont(struct ofono_gprs_context *gc, const char=
 *apn)
> +#define UBLOX_MAX_USER_LEN 50
> +#define UBLOX_MAX_PASS_LEN 50
> +
> +static void ublox_send_uauthreq(struct ofono_gprs_context *gc,
> +				const char *username, const char *password,
> +				enum ofono_gprs_auth_method auth_method)
> +
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[UBLOX_MAX_USER_LEN + UBLOX_MAX_PASS_LEN + 32];
> +	unsigned auth;
> +
> +	switch (auth_method) {
> +	case OFONO_GPRS_AUTH_METHOD_PAP:
> +		auth =3D 1;
> +		break;
> +	case OFONO_GPRS_AUTH_METHOD_CHAP:
> +		auth =3D 2;
> +		break;
> +	default:
> +		ofono_error("Unsupported auth type %u", auth_method);
> +		return;
> +	}
> +
> +	snprintf(buf, sizeof(buf), "AT+UAUTHREQ=3D%u,%u,\"%s\",\"%s\"",
> +			gcd->active_context, auth, username, password);
> +
> +	/* If this failed, we will see it during context activation. */
> +	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +}
> +
> +static void ublox_send_cgdcont(struct ofono_gprs_context *gc, const char=
 *apn,
> +				const char *username, const char *password,
> +				enum ofono_gprs_auth_method auth_method)
>   {
>   	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>   	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
> +	size_t u_len, p_len;
>   	int len;
>
>   	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
> @@ -243,10 +277,29 @@ static void ublox_send_cgdcont(struct ofono_gprs_co=
ntext *gc, const char *apn)
>   		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"", apn);
>
>   	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> -				cgdcont_cb, gc, NULL) > 0)
> -		return;
> +				cgdcont_cb, gc, NULL) =3D=3D 0)
> +		goto error;
> +
> +	u_len =3D strlen(username);
> +	p_len =3D strlen(password);
> +
> +	if (u_len && p_len) {
> +		if (u_len >=3D UBLOX_MAX_USER_LEN ||
> +			p_len >=3D UBLOX_MAX_PASS_LEN) {
> +			ofono_error("Toby L2: user or password length too big");
> +
> +			goto error;
> +		}
>
> +		ublox_send_uauthreq(gc, username, password, auth_method);
> +	}
> +
> +	return;
> +
> +error:
>   	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> +
> +	return;

I silently squished this spurious return.

>   }
>
>   static void ublox_gprs_activate_primary(struct ofono_gprs_context *gc,
> @@ -274,7 +327,8 @@ static void ublox_gprs_activate_primary(struct ofono_=
gprs_context *gc,
>   	gcd->cb =3D cb;
>   	gcd->cb_data =3D data;
>
> -	ublox_send_cgdcont(gc, ctx->apn);
> +	ublox_send_cgdcont(gc, ctx->apn, ctx->username, ctx->password,
> +				ctx->auth_method);
>   }
>
>   static void cgact_disable_cb(gboolean ok, GAtResult *result, gpointer u=
ser_data)
>

Regards,
-Denis

--===============0619182925900650245==--

