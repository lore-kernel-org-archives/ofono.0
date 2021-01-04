Content-Type: multipart/mixed; boundary="===============2137414635739403532=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gsmdial: add support for different authentication methods
 selection
Date: Mon, 04 Jan 2021 11:18:29 -0600
Message-ID: <806c65c0-7088-47a5-9a16-2e5aeccedc70@gmail.com>
In-Reply-To: <20210101211215.28129-1-s.e.golubtsov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2137414635739403532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 1/1/21 3:12 PM, s.e.golubtsov(a)gmail.com wrote:
> From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
> =

> Selection capability for authentication method via a command line
> argument has been added
> ---
>   gatchat/gsmdial.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> =


denkenz(a)localhost ~/ofono-master $ make
make --no-print-directory all-am
   CC       gatchat/gsmdial.o
gatchat/gsmdial.c: In function =E2=80=98connect_cb=E2=80=99:
gatchat/gsmdial.c:373:2: error: ISO C90 forbids mixed declarations and code =

[-Werror=3Ddeclaration-after-statement]
   373 |  GAtPPPAuthMethod auth_method =3D G_AT_PPP_AUTH_METHOD_CHAP;
       |  ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [Makefile:4078: gatchat/gsmdial.o] Error 1
make: *** [Makefile:2376: all] Error 2


> diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
> index 60e4f245..0407f97c 100644
> --- a/gatchat/gsmdial.c
> +++ b/gatchat/gsmdial.c
> @@ -53,6 +53,7 @@ static gint option_cid =3D 0;
>   static gchar *option_apn =3D NULL;
>   static gint option_offmode =3D 0;
>   static gboolean option_legacy =3D FALSE;
> +static gchar *option_auth_method;
>   static gchar *option_username =3D NULL;
>   static gchar *option_password =3D NULL;
>   static gchar *option_pppdump =3D NULL;
> @@ -369,6 +370,14 @@ static void connect_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   	}
>   	g_at_ppp_set_debug(ppp, gsmdial_debug, "PPP");
>   =

> +	GAtPPPAuthMethod auth_method =3D G_AT_PPP_AUTH_METHOD_CHAP;
> +	if (strcmp(option_auth_method, "PAP") =3D=3D 0) {
> +		auth_method =3D G_AT_PPP_AUTH_METHOD_PAP;
> +	} else if (strcmp(option_auth_method, "NONE") =3D=3D 0) {
> +		auth_method =3D G_AT_PPP_AUTH_METHOD_NONE;
> +	}
> +	g_at_ppp_set_auth_method(ppp, auth_method);
> +

Also please refer to doc/coding-style.txt item M1.

>   	g_at_ppp_set_credentials(ppp, option_username, option_password);
>   =

>   	g_at_ppp_set_acfc_enabled(ppp, option_acfc);
> @@ -677,6 +686,10 @@ static GOptionEntry options[] =3D {
>   				"Use ATD*99***<cid>#" },
>   	{ "bluetooth", 'b', 0, G_OPTION_ARG_NONE, &option_bluetooth,
>   				"Use only ATD*99" },
> +	{ "auth", 'A', 0, G_OPTION_ARG_STRING, &option_auth_method,
> +				"Specify the authentication method for the PPP"
> +				" connection: CHAP, PAP or NONE. CHAP is used"
> +				" by default." },
>   	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
>   				"Specify PPP username" },
>   	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_password,
> =


Regards,
-Denis
--===============2137414635739403532==--

