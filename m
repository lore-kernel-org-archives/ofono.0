Content-Type: multipart/mixed; boundary="===============6096958281048794927=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] gsmdial: adding support for selection of
 authentication method
Date: Thu, 07 Jan 2021 23:17:11 -0600
Message-ID: <b5cf5c08-a24a-5c93-76a3-3ce6c4599f67@gmail.com>
In-Reply-To: <20210107204017.3382-1-s.e.golubtsov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6096958281048794927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 1/7/21 2:40 PM, s.e.golubtsov(a)gmail.com wrote:
> From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
> =

> Selection capability for authentication method via a command line
> argument has been added
> ---
>   gatchat/gsmdial.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> =


<snip>

> @@ -369,6 +370,17 @@ static void connect_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   	}
>   	g_at_ppp_set_debug(ppp, gsmdial_debug, "PPP");
>   =

> +	GAtPPPAuthMethod auth_method;
> +
> +	if (strcmp(option_auth_method, "PAP") =3D=3D 0)

note that option_auth_method might be NULL and since you're using strcmp, =

passing NULL might result in undefined behavior.

> +		auth_method =3D G_AT_PPP_AUTH_METHOD_PAP;
> +	else if (strcmp(option_auth_method, "NONE") =3D=3D 0)
> +		auth_method =3D G_AT_PPP_AUTH_METHOD_NONE;
> +	else
> +		auth_method =3D G_AT_PPP_AUTH_METHOD_CHAP;
> +
> +	g_at_ppp_set_auth_method(ppp, auth_method);
> +
>   	g_at_ppp_set_credentials(ppp, option_username, option_password);
>   =

>   	g_at_ppp_set_acfc_enabled(ppp, option_acfc);

Note that I still get the following compiler error:

denkenz(a)localhost ~/ofono-master $ make
make --no-print-directory all-am
   CC       gatchat/gsmdial.o
gatchat/gsmdial.c: In function =E2=80=98connect_cb=E2=80=99:
gatchat/gsmdial.c:373:2: error: ISO C90 forbids mixed declarations and code =

[-Werror=3Ddeclaration-after-statement]
   373 |  GAtPPPAuthMethod auth_method;
       |  ^~~~~~~~~~~~~~~~

oFono code must compile with gnu89 dialect of GCC, so all variable declarat=
ions =

must be in the appropriate block.  Please make sure you compile test with =

optimization enabled in order for gcc to catch any errors/warnings.

I went ahead and modified the patch slightly and applied it to take care of=
 this.

Regards,
-Denis
--===============6096958281048794927==--

