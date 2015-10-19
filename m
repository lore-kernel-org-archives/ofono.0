Content-Type: multipart/mixed; boundary="===============8770895478210728896=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3 v3] hfp_ag_bluez5: use codec negotiation
Date: Mon, 19 Oct 2015 09:21:56 -0500
Message-ID: <5624FC84.3000007@gmail.com>
In-Reply-To: <1444975200-19682-3-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8770895478210728896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

<snip>

 >   static void hfp_card_connect(struct ofono_handsfree_card *card,
>   					ofono_handsfree_card_connect_cb_t cb,
>   					void *data)
>   {
> +	int err;
> +	struct ofono_emulator *em =3D ofono_handsfree_card_get_data(card);
> +	struct cb_data *cbd;
> +
>   	DBG("");
> -	ofono_handsfree_card_connect_sco(card);
> +
> +	cbd =3D cb_data_new(cb, data);
> +
> +	/*
> +	 * The emulator core will take care if the remote side supports
> +	 * codec negotiation or not.
> +	 */
> +	err =3D ofono_emulator_start_codec_negotiation(em, 0,
> +					codec_negotiation_done_cb, cbd);

In the case of HF not supporting codec negotiation, you leak cbd here...

> +	if (err < 0) {
> +		CALLBACK_WITH_FAILURE(cb, data);
> +
> +		g_free(cbd);
> +		return;
> +	}
> +
> +	/*
> +	 * We hand over to the emulator core here to establish the
> +	 * SCO connection once the codec is negotiated
> +	 * */
>   }
>

Regards,
-Denis


--===============8770895478210728896==--

