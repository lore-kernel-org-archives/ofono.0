Content-Type: multipart/mixed; boundary="===============0825479352726726870=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] mbpi: add authentication methods to provisioning
Date: Wed, 18 Jun 2014 17:33:57 -0500
Message-ID: <53A213D5.1030308@gmail.com>
In-Reply-To: <1403042279-20598-4-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0825479352726726870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 06/17/2014 04:57 PM, Philip Paeps wrote:
> Signed-off-by: Philip Paeps <philip@paeps.cx>
> ---
>  include/gprs-provision.h |    1 +
>  plugins/mbpi.c           |   32 ++++++++++++++++++++++++++++++++
>  plugins/provision.c      |    1 +
>  src/gprs.c               |    2 ++

This patch needs to be split up as well.

>  4 files changed, 36 insertions(+)
> =

> diff --git a/include/gprs-provision.h b/include/gprs-provision.h
> index e9eec61..2dd792b 100644
> --- a/include/gprs-provision.h
> +++ b/include/gprs-provision.h
> @@ -35,6 +35,7 @@ struct ofono_gprs_provision_data {
>  	char *apn;
>  	char *username;
>  	char *password;
> +	enum ofono_gprs_auth_method auth_method;
>  	char *message_proxy;
>  	char *message_center;
>  };
> diff --git a/plugins/mbpi.c b/plugins/mbpi.c
> index dff8752..4468174 100644
> --- a/plugins/mbpi.c
> +++ b/plugins/mbpi.c
> @@ -159,6 +159,35 @@ static void usage_start(GMarkupParseContext *context,
>  					"Unknown usage attribute: %s", text);
>  }
>  =

> +static void usage_authmethod(GMarkupParseContext *context,
> +			const gchar **attribute_names,
> +			const gchar **attribute_values,
> +			enum ofono_gprs_auth_method *auth, GError **error)
> +{
> +	const char *text =3D NULL;
> +	int i;
> +
> +	for (i =3D 0; attribute_names[i]; i++)
> +		if (g_str_equal(attribute_names[i], "method") =3D=3D TRUE)
> +			text =3D attribute_values[i];
> +
> +	if (text =3D=3D NULL) {
> +		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
> +					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
> +					"Missing attribute: method");
> +		return;
> +	}
> +
> +	if (strcmp(text, "chap") =3D=3D 0)
> +		*auth =3D OFONO_GPRS_AUTH_METHOD_CHAP;
> +	else if (strcmp(text, "pap") =3D=3D 0)
> +		*auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
> +	else
> +		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
> +					G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
> +					"Unknown auth method: %s", text);
> +}
> +
>  static void apn_start(GMarkupParseContext *context, const gchar *element=
_name,
>  			const gchar **attribute_names,
>  			const gchar **attribute_values,
> @@ -174,6 +203,9 @@ static void apn_start(GMarkupParseContext *context, c=
onst gchar *element_name,
>  	else if (g_str_equal(element_name, "password"))
>  		g_markup_parse_context_push(context, &text_parser,
>  						&apn->password);
> +	else if (g_str_equal(element_name, "auth"))
> +		usage_authmethod(context, attribute_names, attribute_values,
> +						&apn->auth_method, error);

I don't see this element in the DTD definition in
mobile-broadband-provider-info tree.  Has this been proposed / approved
there yet?

>  	else if (g_str_equal(element_name, "mmsc"))
>  		g_markup_parse_context_push(context, &text_parser,
>  						&apn->message_center);
> diff --git a/plugins/provision.c b/plugins/provision.c
> index 99c299e..32dfb6a 100644
> --- a/plugins/provision.c
> +++ b/plugins/provision.c
> @@ -86,6 +86,7 @@ static int provision_get_settings(const char *mcc, cons=
t char *mnc,
>  		DBG("Type: %s", mbpi_ap_type(ap->type));
>  		DBG("Username: '%s'", ap->username);
>  		DBG("Password: '%s'", ap->password);
> +		DBG("Authentication method: '%s'", ap->auth_method ? "chap" : "pap");

What if auth_method element is omitted?  This seems wrong.

>  =

>  		memcpy(*settings + i, ap,
>  			sizeof(struct ofono_gprs_provision_data));
> diff --git a/src/gprs.c b/src/gprs.c
> index 3810267..39a8f2a 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -3024,6 +3024,8 @@ static void provision_context(const struct ofono_gp=
rs_provision_data *ap,
>  	if (ap->password !=3D NULL)
>  		strcpy(context->context.password, ap->password);
>  =

> +	context->context.auth_method =3D ap->auth_method;
> +
>  	strcpy(context->context.apn, ap->apn);
>  	context->context.proto =3D ap->proto;
>  =

> =


Regards,
-Denis

--===============0825479352726726870==--

