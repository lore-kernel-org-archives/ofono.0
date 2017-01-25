Content-Type: multipart/mixed; boundary="===============4533442340563435232=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: send authentication credentials
Date: Wed, 25 Jan 2017 10:10:42 -0600
Message-ID: <84af9113-4e2c-7b1a-557f-340749cffe2e@gmail.com>
In-Reply-To: <20170125111947.12403-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4533442340563435232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Piotr,

On 01/25/2017 05:19 AM, Piotr Haber wrote:
> Pass authentication method, user and password
> to QMI WDS service.
> ---
>  drivers/qmimodem/gprs-context.c | 24 ++++++++++++++++++++++++
>  drivers/qmimodem/wds.h          |  7 +++++++
>  2 files changed, 31 insertions(+)

Really nice to have this one.  Just a couple of small nitpicks:

>
> diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-cont=
ext.c
> index a39db5e8..2250eef9 100644
> --- a/drivers/qmimodem/gprs-context.c
> +++ b/drivers/qmimodem/gprs-context.c
> @@ -151,6 +151,7 @@ static void qmi_activate_primary(struct ofono_gprs_co=
ntext *gc,
>  	struct cb_data *cbd =3D cb_data_new(cb, user_data);
>  	struct qmi_param *param;
>  	uint8_t ip_family;
> +	uint8_t auth;
>
>  	DBG("cid %u", ctx->cid);
>
> @@ -178,6 +179,29 @@ static void qmi_activate_primary(struct ofono_gprs_c=
ontext *gc,
>
>  	qmi_param_append_uint8(param, QMI_WDS_PARAM_IP_FAMILY, ip_family);
>
> +	switch (ctx->auth_method) {
> +	case OFONO_GPRS_AUTH_METHOD_CHAP:
> +		auth =3D QMI_WDS_AUTHENTICATION_CHAP;
> +		break;
> +	case OFONO_GPRS_AUTH_METHOD_PAP:
> +		auth =3D QMI_WDS_AUTHENTICATION_PAP;
> +		break;
> +	default:
> +		auth =3D QMI_WDS_AUTHENTICATION_NONE;
> +		break;
> +	}

Add an empty line here for me please.  See doc/coding-style.txt item M1.

> +	qmi_param_append_uint8(param, QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE,
> +					auth);
> +
> +	if (ctx->username && strlen(ctx->username)) {

ctx->username is an array, so this condition will always be true. =

strlen can be replaced by looking at ctx->username[0] and seeing if it =

is a nul char.  e.g.:

if (ctx->username[0] !=3D '\0')
	qmi_param_append(...)

> +		qmi_param_append(param, QMI_WDS_PARAM_USERNAME,
> +					strlen(ctx->username), ctx->username);
> +        }

No {} needed here.  So please remove them.  And that would be more =

consistent with the password handling below.

> +
> +	if (ctx->password && strlen(ctx->password))

Same comment as above:

if (ctx->password[0] !=3D '\0')
	....

> +		qmi_param_append(param, QMI_WDS_PARAM_PASSWORD,
> +					strlen(ctx->password), ctx->password);
> +
>  	if (qmi_service_send(data->wds, QMI_WDS_START_NET, param,
>  					start_net_cb, cbd, NULL) > 0)
>  		return;
> diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
> index 0da34ab9..4843f925 100644
> --- a/drivers/qmimodem/wds.h
> +++ b/drivers/qmimodem/wds.h
> @@ -30,6 +30,13 @@
>  /* Start WDS network interface */
>  #define QMI_WDS_PARAM_APN			0x14	/* string */
>  #define QMI_WDS_PARAM_IP_FAMILY			0x19	/* uint8 */
> +#define QMI_WDS_PARAM_USERNAME			0x17	/* string */
> +#define QMI_WDS_PARAM_PASSWORD			0x18	/* string */
> +#define QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE	0x16	/* uint8 */
> +
> +#define QMI_WDS_AUTHENTICATION_NONE		0x0
> +#define QMI_WDS_AUTHENTICATION_PAP		0x1
> +#define QMI_WDS_AUTHENTICATION_CHAP		0x2
>
>  #define QMI_WDS_RESULT_PKT_HANDLE		0x01	/* uint32 */
>
>

Regards,
-Denis

--===============4533442340563435232==--

