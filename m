Content-Type: multipart/mixed; boundary="===============8040188944760948478=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] atmodem: Add support for the PIN counter command
 AT+CPNNUM
Date: Wed, 27 Jul 2011 16:17:13 +0200
Message-ID: <1311776234.8920.69.camel@aeonflux>
In-Reply-To: <1311351329-1241-5-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8040188944760948478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>  drivers/atmodem/sim.c |   95 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 95 insertions(+), 0 deletions(-)

please include an OFONO_AT_DEBUG trace of this AT command.

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index b28f3f8..49f5245 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -667,6 +667,95 @@ static void at_cpinr_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  	cb(&error, retries, cbd->data);
>  }
>  =

> +static gboolean skip_to_field(GAtResultIter *iter, const char *field)
> +{
> +	char *line;
> +	char *offset;
> +	int field_len =3D field ? strlen(field) : 0;
> +
> +	if (iter =3D=3D NULL)
> +		return FALSE;
> +
> +	if (iter->l =3D=3D NULL)
> +		return FALSE;
> +
> +	line =3D iter->l->data;
> +
> +	if (field_len =3D=3D 0) {
> +		iter->line_pos =3D 0;
> +		return TRUE;
> +	}
> +
> +	offset =3D g_strrstr(line, field);
> +	if (offset =3D=3D NULL)
> +		return FALSE;
> +
> +	iter->line_pos =3D (offset - line) + field_len;
> +
> +	return TRUE;
> +}

What is this one doing?

Denis, can you have a look please.

> +static void at_cpnnum_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
> +	GAtResultIter iter;
> +	struct ofono_error error;
> +	int retries[OFONO_SIM_PASSWORD_INVALID];
> +	size_t i;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		cb(&error, NULL, cbd->data);
> +		return;
> +	}
> +
> +	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
> +		retries[i] =3D -1;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	/*
> +	 * Even if this is not really a suffix, we rely on the tag PIN1 to
> +	 * recognize the correct response line.
> +	 */
> +	if (!g_at_result_iter_next(&iter, "PIN1=3D"))
> +		goto error;
> +
> +	if (!g_at_result_iter_next_number(&iter,
> +					&retries[OFONO_SIM_PASSWORD_SIM_PIN]))
> +		goto error;
> +
> +	if (!skip_to_field(&iter, "PUK1=3D"))
> +		goto error;
> +
> +	if (!g_at_result_iter_next_number(&iter,
> +					&retries[OFONO_SIM_PASSWORD_SIM_PUK]))
> +		goto error;
> +
> +	if (!skip_to_field(&iter, "PIN2=3D"))
> +		goto error;
> +
> +	if (!g_at_result_iter_next_number(&iter,
> +					&retries[OFONO_SIM_PASSWORD_SIM_PIN2]))
> +		goto error;
> +
> +	if (!skip_to_field(&iter, "PUK2=3D"))
> +		goto error;
> +
> +	if (!g_at_result_iter_next_number(&iter,
> +					&retries[OFONO_SIM_PASSWORD_SIM_PUK2]))
> +		goto error;
> +
> +	cb(&error, retries, cbd->data);
> +
> +	return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +}
> +
>  static void at_pin_retries_query(struct ofono_sim *sim,
>  					ofono_sim_pin_retries_cb_t cb,
>  					void *data)
> @@ -695,6 +784,12 @@ static void at_pin_retries_query(struct ofono_sim *s=
im,
>  			return;
>  =

>  		break;
> +	case OFONO_VENDOR_SPEEDUP:
> +		if (g_at_chat_send(sd->chat, "AT+CPNNUM", NULL,
> +					at_cpnnum_cb, cbd, g_free) > 0)
> +			return;
> +
> +		break;
>  	default:
>  		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
>  					at_cpinr_cb, cbd, g_free) > 0)

Regards

Marcel



--===============8040188944760948478==--

