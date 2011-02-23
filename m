Content-Type: multipart/mixed; boundary="===============0663600189845208786=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] emulator: add CMER support
Date: Wed, 23 Feb 2011 14:13:16 -0600
Message-ID: <4D656A5C.4010103@gmail.com>
In-Reply-To: <1298487626-16827-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0663600189845208786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 02/23/2011 01:00 PM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  src/emulator.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 105 insertions(+), 2 deletions(-)

I applied this patch, but one comment below:

> =

> diff --git a/src/emulator.c b/src/emulator.c
> index f0ca8c8..ca36c0e 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -43,6 +43,8 @@ struct ofono_emulator {
>  	GAtServer *server;
>  	GAtPPP *ppp;
>  	guint source;
> +	int events_mode;
> +	gboolean events_ind;
>  	GSList *indicators;
>  };
>  =

> @@ -251,6 +253,103 @@ fail:
>  	}
>  }
>  =

> +static void cmer_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +	char buf[32];
> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
> +		sprintf(buf, "+CMER: %d,0,0,%d,0", em->events_mode,
> +						em->events_ind);
> +		g_at_server_send_info(em->server, buf, TRUE);
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +
> +	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
> +		sprintf(buf, "+CMER: (0,3),(0),(0),(0,1),(0)");
> +		g_at_server_send_info(em->server, buf, TRUE);
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +	{
> +		GAtResultIter iter;
> +		int mode;
> +		int ind =3D em->events_ind;
> +		int val;
> +
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "");
> +
> +		/* mode */
> +		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
> +			goto fail;
> +
> +		if ((mode !=3D 0) && (mode !=3D 3))
> +			goto fail;
> +
> +		/* keyp */
> +		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE) {
> +			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
> +				goto done;
> +			goto fail;
> +		}

From what I understand you're trying to enable something like:

+CMER=3D3,,1 right?

So this code does accomplish this, but it also allows silliness like this:

+CMER=3D3,"foobar",,1

You might want to make a special version of next_number that would
actually check that either the number is given, or the field is empty.

> +
> +		if (val !=3D 0)
> +			goto fail;
> +
> +		/* disp */
> +		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE) {
> +			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
> +				goto done;
> +			goto fail;
> +		}
> +
> +		if (val !=3D 0)
> +			goto fail;
> +
> +		/* ind */
> +		if (g_at_result_iter_next_number(&iter, &ind) =3D=3D FALSE) {
> +			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
> +				goto done;
> +			goto fail;
> +		}
> +
> +		if ((ind !=3D 0) && (ind !=3D 1))
> +			goto fail;
> +
> +		/* bfr */
> +		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE) {
> +			if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
> +				goto done;
> +			goto fail;
> +		}
> +
> +		if (val !=3D 0)
> +			goto fail;
> +
> +		/* check that bfr is last parameter */
> +		if (g_at_result_iter_skip_next(&iter) =3D=3D TRUE)
> +			goto fail;
> +
> +done:
> +		em->events_mode =3D mode;
> +		em->events_ind =3D ind;
> +
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +
> +		break;
> +	}
> +
> +	default:
> +fail:
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +		break;
> +	}
> +}
> +
>  static void emulator_add_indicator(struct ofono_emulator *em, const char=
* name,
>  					int min, int max, int dflt)
>  {
> @@ -324,6 +423,7 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
>  		emulator_add_indicator(em, OFONO_EMULATOR_IND_BATTERY, 0, 5, 5);
>  =

>  		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
> +		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
>  	}
>  =

>  	__ofono_atom_register(em->atom, emulator_unregister);
> @@ -364,6 +464,7 @@ struct ofono_emulator *ofono_emulator_create(struct o=
fono_modem *modem,
>  		return NULL;
>  =

>  	em->type =3D type;
> +	em->events_mode =3D 3;	/* default mode is forwarding events */
>  =

>  	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
>  							emulator_remove, em);
> @@ -546,8 +647,10 @@ void ofono_emulator_set_indicator(struct ofono_emula=
tor *em,
>  =

>  		ind->value =3D value;
>  =

> -		sprintf(buf, "+CIEV: %d,%d", i, ind->value);
> -		g_at_server_send_info(em->server, buf, TRUE);
> +		if (em->events_mode =3D=3D 3 && em->events_ind) {
> +			sprintf(buf, "+CIEV: %d,%d", i, ind->value);
> +			g_at_server_send_info(em->server, buf, TRUE);
> +		}
>  =

>  		return;
>  	}

Regards,
-Denis

--===============0663600189845208786==--

