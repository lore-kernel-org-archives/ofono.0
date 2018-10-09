Content-Type: multipart/mixed; boundary="===============6779192055531325076=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] plugins/provisioning and mbpi: support for auth NONE
Date: Tue, 09 Oct 2018 12:38:31 -0500
Message-ID: <c58d346a-8c62-8223-2977-468e382b7c3d@gmail.com>
In-Reply-To: <20181006054520.26737-4-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6779192055531325076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/06/2018 12:45 AM, Giacinto Cifelli wrote:
> support of 'none' in file-provisioning:
> the default authentication method is set to NONE
> =

> support of 'none' in mbpi:
> the default method remains CHAP, but it is overridden by NONE after
> parsing the entire key for the apn and detecting no username/password
> ---
>   plugins/file-provision.c | 7 +++++--
>   plugins/mbpi.c           | 6 ++++++
>   2 files changed, 11 insertions(+), 2 deletions(-)
> =


I broke this up into two separate commits, also:

> diff --git a/plugins/file-provision.c b/plugins/file-provision.c
> index d4846a65..3a1a5a68 100644
> --- a/plugins/file-provision.c
> +++ b/plugins/file-provision.c
> @@ -93,18 +93,21 @@ static int config_file_provision_get_settings(const c=
har *mcc,
>   	if (value !=3D NULL)
>   		(*settings)[0].password =3D value;
>   =

> -	(*settings)[0].auth_method =3D OFONO_GPRS_AUTH_METHOD_CHAP;
> +	/* select default authentication method */
> +	(*settings)[0].auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +
>   	value =3D g_key_file_get_string(key_file, setting_group,
>   					"internet.AuthenticationMethod", NULL);
>   =

>   	if (value !=3D NULL) {
> +

This part was dropped

>   		if (g_strcmp0(value, "chap") =3D=3D 0)
>   			(*settings)[0].auth_method =3D
>   						OFONO_GPRS_AUTH_METHOD_CHAP;
>   		else if (g_strcmp0(value, "pap") =3D=3D 0)
>   			(*settings)[0].auth_method =3D
>   						OFONO_GPRS_AUTH_METHOD_PAP;
> -		else
> +		else if (g_strcmp0(value, "none") !=3D 0)
>   			DBG("Unknown auth method: %s", value);
>   =

>   		g_free(value);
> diff --git a/plugins/mbpi.c b/plugins/mbpi.c
> index ae92c762..433f1b55 100644
> --- a/plugins/mbpi.c
> +++ b/plugins/mbpi.c
> @@ -325,6 +325,8 @@ static void apn_handler(GMarkupParseContext *context,=
 struct gsm_data *gsm,
>   	ap->apn =3D g_strdup(apn);
>   	ap->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
>   	ap->proto =3D OFONO_GPRS_PROTO_IP;
> +
> +	/* pre-select default authentication method */
>   	ap->auth_method =3D OFONO_GPRS_AUTH_METHOD_CHAP;
>   =

>   	g_markup_parse_context_push(context, &apn_parser, ap);
> @@ -395,6 +397,10 @@ static void gsm_end(GMarkupParseContext *context, co=
nst gchar *element_name,
>   	if (ap =3D=3D NULL)
>   		return;
>   =

> +	/* select authentication method NONE if fit */
> +	if (!ap->username || !ap->password)
> +		ap->auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +
>   	if (gsm->allow_duplicates =3D=3D FALSE) {
>   		GSList *l;
>   =

> =


Regards,
-Denis

--===============6779192055531325076==--

