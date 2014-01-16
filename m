Content-Type: multipart/mixed; boundary="===============6120044000522467613=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Use "internet" apn for auto-created context
Date: Thu, 16 Jan 2014 11:04:56 -0600
Message-ID: <52D81138.5080708@gmail.com>
In-Reply-To: <1389883423-22160-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6120044000522467613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 01/16/2014 08:43 AM, Slava Monich wrote:
> Such an access point has a pretty good chance to actually work.
> ---
>   src/gprs.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/src/gprs.c b/src/gprs.c
> index e379f7b..01ff875 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -2992,8 +2992,13 @@ static void ofono_gprs_finish_register(struct ofon=
o_gprs *gprs)
>   	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
>   	const char *path =3D __ofono_atom_get_path(gprs->atom);
>
> -	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
> -		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
> +	if (gprs->contexts =3D=3D NULL) { /* Automatic provisioning failed */
> +		struct pri_context *context =3D add_context(gprs, NULL,
> +					OFONO_GPRS_CONTEXT_TYPE_INTERNET);
> +		if (context) {
> +			strcpy(context->context.apn, "internet");
> +		}
> +	}

Nope.  This doesn't belong in the core.  If you want to guess wildly, =

please do so in a provisioning plugin.  That is what they're there for. =

  You can have multiple provisioning plugins by the way.

>
>   	if (!g_dbus_register_interface(conn, path,
>   					OFONO_CONNECTION_MANAGER_INTERFACE,
>

Regards,
-Denis

--===============6120044000522467613==--

