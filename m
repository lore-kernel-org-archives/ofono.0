Content-Type: multipart/mixed; boundary="===============6498534418700278289=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] atmodem: Add support for the PIN counter command
 AT+CPNNUM
Date: Fri, 22 Jul 2011 09:05:41 -0500
Message-ID: <4E2983B5.4090402@gmail.com>
In-Reply-To: <1311351329-1241-5-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6498534418700278289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 07/22/2011 11:15 AM, Philippe Nunes wrote:
> ---
>  drivers/atmodem/sim.c |   95 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 95 insertions(+), 0 deletions(-)
> =

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
> +
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

I know this string is non-standard and the vendor should be ridiculed
publically.  However, it seems to me there's entirely too much code for
this purpose.  Have you considered using sscanf or g_strsplit_set for
this purpose?

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

It is my understanding that SpeedUp also supports AT+BMCPNCNT for CPIN
queries, or are these interchangeable?

> +					at_cpnnum_cb, cbd, g_free) > 0)
> +			return;
> +
> +		break;
>  	default:
>  		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
>  					at_cpinr_cb, cbd, g_free) > 0)

Regards,
-Denis

--===============6498534418700278289==--

