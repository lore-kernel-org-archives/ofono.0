Content-Type: multipart/mixed; boundary="===============8141658252385404340=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add init phonesim stk support
Date: Thu, 08 Jul 2010 14:52:17 -0500
Message-ID: <4C362C71.7050703@gmail.com>
In-Reply-To: <1278586608-6246-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8141658252385404340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> +static void phonesim_csim_envelope_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	GAtResultIter iter;
> +	ofono_stk_envelope_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +	const guint8 *response;
> +	gint rlen, len;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok)
> +		goto error;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CSIM:"))
> +		goto error;
> +
> +	if (!g_at_result_iter_next_number(&iter, &rlen))
> +		goto error;
> +
> +	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
> +		goto error;
> +
> +	if (rlen !=3D len * 2 || len < 2)
> +		goto error;
> +
> +	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
> +		goto error;
> +
> +	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
> +		goto error;
> +
> +	DBG("csim_envelope_cb: %i", len);
> +
> +	cb(&error, response, len - 2, cbd->data);
> +	return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
> +}

Please note that Andrew recently introduced OFONO_ERROR_TYPE_SIM, so you
might want to follow the same conventions.  See drivers/atmodem/stk.c.

Regards,
-Denis

--===============8141658252385404340==--

