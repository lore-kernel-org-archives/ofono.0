Content-Type: multipart/mixed; boundary="===============2753460996243981747=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/5] drivers: support for auth NONE
Date: Tue, 09 Oct 2018 12:41:48 -0500
Message-ID: <9110ae75-3245-7131-8a3e-92fb83fef5ce@gmail.com>
In-Reply-To: <20181006054520.26737-5-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2753460996243981747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

I applied a modified version of this patch, see below:

> diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-co=
ntext.c
> index 79793c92..be256e43 100644
> --- a/drivers/mbimmodem/gprs-context.c
> +++ b/drivers/mbimmodem/gprs-context.c
> @@ -75,9 +75,11 @@ static uint32_t auth_method_to_auth_protocol(enum ofon=
o_gprs_auth_method method)
>   		return 2; /* MBIMAuthProtocolChap */
>   	case OFONO_GPRS_AUTH_METHOD_PAP:
>   		return 1; /* MBIMAuthProtocolPap */
> +	case OFONO_GPRS_AUTH_METHOD_NONE:
> +		return 0; /* MBIMAUthProtocolNone */
>   	}
>   =

> -	return 0;
> +	return 0; /* MBIMAUthProtocolNone */
>   }
>   =

>   static void mbim_deactivate_cb(struct mbim_message *message, void *user)
> @@ -345,6 +347,8 @@ static void mbim_gprs_activate_primary(struct ofono_g=
prs_context *gc,
>   {
>   	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>   	struct mbim_message *message;
> +	const char username =3D NULL;
> +	const char password =3D NULL;

These were changed to const char *

>   =

>   	DBG("cid %u", ctx->cid);
>   =

> @@ -354,6 +358,12 @@ static void mbim_gprs_activate_primary(struct ofono_=
gprs_context *gc,
>   	gcd->active_context =3D ctx->cid;
>   	gcd->proto =3D ctx->proto;
>   =

> +	if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE && ctx->username[=
0])
> +		username =3D ctx->username;
> +
> +	if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE && ctx->password[=
0])
> +		password =3D ctx->password;
> +
>   	message =3D mbim_message_new(mbim_uuid_basic_connect,
>   					MBIM_CID_CONNECT,
>   					MBIM_COMMAND_TYPE_SET);
> @@ -361,8 +371,8 @@ static void mbim_gprs_activate_primary(struct ofono_g=
prs_context *gc,
>   				ctx->cid,
>   				1, /* MBIMActivationCommandActivate */
>   				ctx->apn,
> -				ctx->username[0] ? ctx->username : NULL,
> -				ctx->password[0] ? ctx->password : NULL,
> +				username,
> +				password,
>   				0, /*MBIMCompressionNone */
>   				auth_method_to_auth_protocol(ctx->auth_method),
>   				proto_to_context_ip_type(ctx->proto),
> diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-cont=
ext.c
> index e961afa1..fa8b44b6 100644
> --- a/drivers/mbmmodem/gprs-context.c
> +++ b/drivers/mbmmodem/gprs-context.c
> @@ -394,11 +394,12 @@ static void mbm_gprs_activate_primary(struct ofono_=
gprs_context *gc,
>   	 * Set username and password, this should be done after CGDCONT
>   	 * or an error can occur.  We don't bother with error checking
>   	 * here
> -	 * */
> -	snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
> -			ctx->cid, ctx->username, ctx->password);
> -
> -	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	 */
> +	if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE) {
> +		snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
> +				ctx->cid, ctx->username, ctx->password);
> +		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	}
>   =

>   	return;
>   =


I dropped this part entirely.  The reason is that we can have profiles =

with username/password & without operating on the same CID.  Since the =

setting is permanent on the modem, we need to set it/clear it even when =

AUTH_METHOD_NONE is used.

If you disagree, please send a follow up series.

> diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-cont=
ext.c
> index 18b2bfa4..32facd8c 100644
> --- a/drivers/stemodem/gprs-context.c
> +++ b/drivers/stemodem/gprs-context.c
> @@ -307,10 +307,11 @@ static void ste_gprs_activate_primary(struct ofono_=
gprs_context *gc,
>   	 * or an error can occur.  We don't bother with error checking
>   	 * here
>   	 */
> -	snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
> -			ctx->cid, ctx->username, ctx->password);
> -
> -	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	if (ctx->auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE) {
> +		snprintf(buf, sizeof(buf), "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"",
> +				ctx->cid, ctx->username, ctx->password);
> +		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	}
>   =

>   	return;
>   =


Dropped for the same reason as above

Regards,
-Denis

--===============2753460996243981747==--

