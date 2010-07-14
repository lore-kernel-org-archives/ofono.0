Content-Type: multipart/mixed; boundary="===============4108615009681410678=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbm: poll SIM status when initializing
Date: Wed, 14 Jul 2010 11:40:16 -0500
Message-ID: <4C3DE870.5030604@gmail.com>
In-Reply-To: <1279124912-13663-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4108615009681410678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> @@ -54,6 +55,8 @@ static const char *none_prefix[] =3D { NULL };
>  struct mbm_data {
>  	GAtChat *modem_port;
>  	GAtChat *data_port;
> +	guint sim_poll;
> +	guint sim_polled;
>  	gboolean have_sim;
>  };

Can we rename sim_poll to cpin_poll_source?

Can we rename sim_polled to cpin_poll_retry or cpin_poll_retries?

> -	/* Modem returns error if there is no SIM in slot */
> +	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
> +	if (!ok && result->final_or_pdu &&
> +		!strcmp(result->final_or_pdu, "+CME ERROR: 10") &&
> +		data->sim_polled++ < 5) {
> +		data->sim_poll =3D
> +			g_timeout_add_seconds(1, init_simpin_check, modem);
> +		return;
> +	}
> +

Please note that whenever you have a multi-line if condition like the
one above, the conditions after the if should be indented one more level
than the if body block.  E.g. put an extra indent before !strcmp and
data->sim_polled.

Regards,
-Denis

--===============4108615009681410678==--

