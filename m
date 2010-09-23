Content-Type: multipart/mixed; boundary="===============0705897195144345815=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Support multiple -p and -P option
Date: Thu, 23 Sep 2010 11:18:53 +0900
Message-ID: <1285208333.20811.64.camel@localhost.localdomain>
In-Reply-To: <1285168276-2809-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0705897195144345815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  src/main.c   |   12 ++++++------
>  src/ofono.h  |    2 +-
>  src/plugin.c |   28 ++++++++++++++++++----------
>  3 files changed, 25 insertions(+), 17 deletions(-)
> =

> diff --git a/src/main.c b/src/main.c
> index 20bf0d7..9cf32eb 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -93,8 +93,8 @@ static void system_bus_disconnected(DBusConnection *con=
n, void *user_data)
>  }
>  =

>  static gchar *option_debug =3D NULL;
> -static gchar *option_plugin =3D NULL;
> -static gchar *option_noplugin =3D NULL;
> +static gchar **option_plugin;
> +static gchar **option_noplugin;
>  static gboolean option_detach =3D TRUE;
>  static gboolean option_version =3D FALSE;
>  =

> @@ -113,9 +113,9 @@ static GOptionEntry options[] =3D {
>  	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
>  				G_OPTION_ARG_CALLBACK, parse_debug,
>  				"Specify debug options to enable", "DEBUG" },
> -	{ "plugin", 'p', 0, G_OPTION_ARG_STRING, &option_plugin,
> +	{ "plugin", 'p', 0, G_OPTION_ARG_STRING_ARRAY, &option_plugin,
>  				"Specify plugins to load", "NAME" },
> -	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
> +	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING_ARRAY, &option_noplugin,
>  				"Specify plugins not to load", "NAME" },
>  	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
>  				G_OPTION_ARG_NONE, &option_detach,

in general I am fine with this, but we need to be a bit more consistent
across projects and across options here.

So if we do it like this then we have to also make this work for ConnMan
and then also the --debug option should be able to handle multiple
options. Besides the magic of separating via : and , which is already
supported and documented there.

Regards

Marcel



--===============0705897195144345815==--

