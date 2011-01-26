Content-Type: multipart/mixed; boundary="===============1342226652655979280=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 1/6] main: Add basic support for main.conf
Date: Wed, 26 Jan 2011 10:06:06 +0100
Message-ID: <1296032766.1520.83.camel@aeonflux>
In-Reply-To: <1296032186-21497-2-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1342226652655979280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

>  src/main.c  |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  src/ofono.h |   11 ++++++++++
>  2 files changed, 72 insertions(+), 1 deletions(-)
> =

> diff --git a/src/main.c b/src/main.c
> index 3db8819..129d36c 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -41,6 +41,7 @@
>  #define SHUTDOWN_GRACE_SECONDS 10
>  =

>  static GMainLoop *event_loop;
> +struct main_opts main_opts;

please please please don't copy legacy code from BlueZ. We should have
replaced this old main_opts thing for ages now, but we were just lazy to
do so. I think the main_opts is from 2002 or so.

We should go for something like we have in ConnMan:

const char *connman_option_get_string(const char *key)
{
}

And then we can also combine values from command line with values from a
config file if needed.

> +static void parse_config(GKeyFile *config)
> +{
> +	GError *err =3D NULL;
> +	char *str;
> +
> +	if (!config)
> +		return;
> +
> +	str =3D g_key_file_get_string(config, "General", "DisablePlugins", &err=
);

Do you really wants this. The only reason why this was actually in BlueZ
was because of qualification and shipping profile support that is not
officially part of the product.

And we had this before we got the command line options for -P and -p.
They are much more useful and powerful. So until we really need this,
please don't bother with something like DisablePlugins in a
configuration file.

Regards

Marcel



--===============1342226652655979280==--

