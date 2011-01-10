Content-Type: multipart/mixed; boundary="===============0414058768732907607=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 6/6] atmodem: implement query for remaining pin retries
Date: Mon, 10 Jan 2011 15:44:14 -0600
Message-ID: <4D2B7DAE.5020505@gmail.com>
In-Reply-To: <1294693351-25475-7-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0414058768732907607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> +static void at_pin_retries_query(struct ofono_sim *sim,
> +				ofono_sim_pin_retries_cb_t cb, void *data)
> +{
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +
> +	DBG("");
> +
> +	if (sd->vendor =3D=3D OFONO_VENDOR_HUAWEI) {
> +		struct cb_data *cbd =3D cb_data_new(cb, data);
> +
> +		if (cbd =3D=3D NULL) {
> +			CALLBACK_WITH_FAILURE(cb, NULL, data);
> +
> +			return;
> +		}
> +
> +		if (g_at_chat_send(sd->chat, "AT^CPIN?", huawei_cpin_prefix,
> +					huawei_cpin_cb, cbd, g_free) > 0)
> +			return;
> +
> +		g_free(cbd);
> +
> +		CALLBACK_WITH_FAILURE(cb, NULL, data);
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, NULL, data);

I believe this will cause the core to segfault when running on
non-huawei devices.

> +}

Regards,
-Denis

--===============0414058768732907607==--

