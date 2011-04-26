Content-Type: multipart/mixed; boundary="===============5744071157934637079=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] emulator: add AT+CMEE support for HFP
Date: Tue, 26 Apr 2011 14:18:18 -0500
Message-ID: <4DB71A7A.608@gmail.com>
In-Reply-To: <1303299295-4080-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5744071157934637079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 04/20/2011 06:34 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  src/emulator.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 73 insertions(+), 1 deletions(-)
> =

> diff --git a/src/emulator.c b/src/emulator.c
> index 9b4647b..cffda21 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -51,6 +51,7 @@ struct ofono_emulator {
>  	int r_features;
>  	int events_mode;
>  	gboolean events_ind;
> +	unsigned char cme_error_ind;

Please name this cmee_mode;

>  	GSList *indicators;
>  	guint callsetup_source;
>  	gboolean clip;
> @@ -569,6 +570,52 @@ fail:
>  	};
>  }
>  =

> +static void cmee_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +	GAtResultIter iter;
> +	int val;
> +	char buf[16];
> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "");
> +
> +		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
> +			goto fail;
> +
> +		if (val < 0 && val > 1)
> +			goto fail;
> +
> +		em->cme_error_ind =3D val;
> +
> +		sprintf(buf, "+CMEE: %d", em->cme_error_ind);
> +		g_at_server_send_info(em->server, buf, TRUE);

The CMEE set command should not result in the current mode being
printed, right?

> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +
> +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
> +		sprintf(buf, "+CMEE: %d", em->cme_error_ind);
> +		g_at_server_send_info(em->server, buf, TRUE);
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +
> +	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
> +		/* HFP only support 0 and 1 */
> +		sprintf(buf, "+CMEE: (0,1)");
> +		g_at_server_send_info(em->server, buf, TRUE);
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
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
> @@ -656,6 +703,7 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
>  		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
>  		g_at_server_register(em->server, "+CLIP", clip_cb, em, NULL);
>  		g_at_server_register(em->server, "+CCWA", ccwa_cb, em, NULL);
> +		g_at_server_register(em->server, "+CMEE", cmee_cb, em, NULL);
>  	}
>  =

>  	__ofono_atom_register(em->atom, emulator_unregister);
> @@ -699,6 +747,7 @@ struct ofono_emulator *ofono_emulator_create(struct o=
fono_modem *modem,
>  	/* TODO: Check real local features */
>  	em->l_features =3D 32;
>  	em->events_mode =3D 3;	/* default mode is forwarding events */
> +	em->cme_error_ind =3D 0;	/* CME ERROR disabled by default */
>  =

>  	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
>  							emulator_remove, em);
> @@ -727,7 +776,23 @@ void ofono_emulator_send_final(struct ofono_emulator=
 *em,
>  		break;
>  =

>  	case OFONO_ERROR_TYPE_CME:
> -		sprintf(buf, "+CME ERROR: %d", final->error);
> +		/* default string */
> +		sprintf(buf, "ERROR");

What exactly is this for?  The default case goes to failure label anyway

> +
> +		switch (em->cme_error_ind) {
> +		case 1:
> +			sprintf(buf, "+CME ERROR: %d", final->error);
> +			break;
> +
> +		case 2:
> +			sprintf(buf, "+CME ERROR: %s",
> +						telephony_error_to_str(final));
> +			break;
> +
> +		default:
> +			goto failure;
> +		}
> +
>  		g_at_server_send_ext_final(em->server, buf);
>  		break;
>  =

> @@ -738,6 +803,13 @@ void ofono_emulator_send_final(struct ofono_emulator=
 *em,
>  	case OFONO_ERROR_TYPE_CEER:
>  	case OFONO_ERROR_TYPE_SIM:
>  	case OFONO_ERROR_TYPE_FAILURE:
> +failure:
> +		if (final->error =3D=3D 30) {
> +			g_at_server_send_final(em->server,
> +					G_AT_SERVER_RESULT_NO_CARRIER);
> +			break;
> +		}

What is this magic trying to do?  If you really want to send a NO
CARRIER, then I suggest using the g_at_server_send_final directly from
the callback.  Unless you want to do this for voicecalls...?  If so,
then inventing a new ofono error type might be better.  Drop this change
for now.

> +
>  		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
>  		break;
>  	};

Regards,
-Denis

--===============5744071157934637079==--

