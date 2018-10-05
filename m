Content-Type: multipart/mixed; boundary="===============8193823724310162341=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] plugins/provisioning and mbpi: support for auth NONE
Date: Thu, 04 Oct 2018 23:07:33 -0500
Message-ID: <98c9532e-b453-db8c-e163-ffbaa19ffee5@gmail.com>
In-Reply-To: <20181004052052.19203-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8193823724310162341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/04/2018 12:20 AM, Giacinto Cifelli wrote:
> support of 'none' in file-provisioning and in mbpi.
> The default authentication method is set to 'none'.
> ---
>   plugins/file-provision.c | 7 +++++--
>   plugins/mbpi.c           | 5 ++++-
>   2 files changed, 9 insertions(+), 3 deletions(-)
> =

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

Not sure why this is here

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
> index ae92c762..d101085f 100644
> --- a/plugins/mbpi.c
> +++ b/plugins/mbpi.c
> @@ -148,11 +148,14 @@ static void authentication_start(GMarkupParseContex=
t *context,
>   		return;
>   	}
>   =

> +	/* select default authentication method */
> +	*auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +
>   	if (strcmp(text, "chap") =3D=3D 0)
>   		*auth_method =3D OFONO_GPRS_AUTH_METHOD_CHAP;
>   	else if (strcmp(text, "pap") =3D=3D 0)
>   		*auth_method =3D OFONO_GPRS_AUTH_METHOD_PAP;
> -	else
> +	else if (strcmp(text, "none") !=3D 0)

Please study the serviceproviders.2.dtd which is part of the =

mobile-broadband-provider-info project.  'none' is not a valid value.

It looks like mbpi assumes that authentication tag can either be =

omitted, but if present it has to specify chap or pap.  So if empty we =

can probably assume 'none'.  Of course there's nothing preventing the =

entry from having a username/password and no authentication tag.  In =

which case we should assume chap.

Unfortunately authentication_start method might not have all the =

information available to make the above decisions, so you might need =

extra fixup code elsewhere to actually sanitize auth_method based on =

username/password presence.

>   		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
>   					G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
>   					"Unknown authentication method: %s",
> =


Regards,
-Denis

--===============8193823724310162341==--

