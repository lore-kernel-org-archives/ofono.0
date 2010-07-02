Content-Type: multipart/mixed; boundary="===============7702112060752819061=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 05/23] doc: explain debugging options to -d,
 add a pointer in -h to manpage
Date: Fri, 02 Jul 2010 15:43:26 -0500
Message-ID: <4C2E4F6E.3@gmail.com>
In-Reply-To: <7e92d75b6ac64b851bb397ce36caf7bf7cc2911f.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7702112060752819061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

Please remember not to go over 50 characters on your git commit
description header and more than 72 characters on your git commit
description body.

> @@ -110,7 +110,9 @@ static gboolean parse_debug(const char *key, const ch=
ar *value,
>  static GOptionEntry options[] =3D {
>  	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
>  				G_OPTION_ARG_CALLBACK, parse_debug,
> -				"Specify debug options to enable", "DEBUG" },
> +			   "Specify debug options to enable (see the "
> +			   "man page for ofonod(8) for more information).",

I still think mentioning the man page is a bit redundant.

> +			   "DEBUG" },
>  	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
>  				G_OPTION_ARG_NONE, &option_detach,
>  				"Don't run as daemon in background" },

Regards,
-Denis

--===============7702112060752819061==--

