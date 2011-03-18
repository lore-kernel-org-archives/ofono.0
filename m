Content-Type: multipart/mixed; boundary="===============7129736503898464849=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/9] emulator: add CKPD support
Date: Fri, 18 Mar 2011 15:25:42 -0500
Message-ID: <4D83BFC6.6030101@gmail.com>
In-Reply-To: <1300388148-925-7-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7129736503898464849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/17/2011 01:55 PM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> ---
>  src/emulator.c |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> =

> diff --git a/src/emulator.c b/src/emulator.c
> index ce3fabd..1d4fbc6 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -387,6 +387,34 @@ fail:
>  	}
>  }
>  =

> +static void ckpd_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +	{
> +		GAtResultIter iter;
> +		int key;
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "");
> +
> +		if (g_at_result_iter_next_number(&iter, &key) =3D=3D FALSE)
> +			goto fail;
> +
> +		if (key !=3D 200)
> +			goto fail;
> +
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +	}
> +
> +	default:
> +fail:
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +		break;
> +	}
> +}

Do you have a plan on what to do with these key presses?

> +
>  static void emulator_add_indicator(struct ofono_emulator *em, const char=
* name,
>  					int min, int max, int dflt)
>  {
> @@ -462,6 +490,8 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
>  		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
>  		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
>  		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
> +	} else if (em->type =3D=3D OFONO_EMULATOR_TYPE_HSP) {
> +		g_at_server_register(em->server, "+CKPD", ckpd_cb, em, NULL);
>  	}
>  =

>  	__ofono_atom_register(em->atom, emulator_unregister);

Regards,
-Denis

--===============7129736503898464849==--

