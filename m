Content-Type: multipart/mixed; boundary="===============6139737239448526919=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] Enable some atoms for hso modem
Date: Fri, 17 Sep 2010 07:59:13 -0500
Message-ID: <4C936621.3080109@gmail.com>
In-Reply-To: <1284713422-3558-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6139737239448526919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> @@ -257,24 +266,40 @@ static void hso_pre_sim(struct ofono_modem *modem)
>  	ofono_devinfo_create(modem, 0, "atmodem", data->control);
>  	sim =3D ofono_sim_create(modem, OFONO_VENDOR_OPTION_HSO,
>  				"atmodem", data->control);
> +	ofono_voicecall_create(modem, 0, "atmodem", data->app);
>  =


The Option hardware can never do audio, so enabling voice functionality
is not a good idea.

>  	if (sim)
>  		ofono_sim_inserted_notify(sim, TRUE);
>  }
>  =

> +
> +static void hso_post_sim(struct ofono_modem *modem)
> +{
> +	struct hso_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_phonebook_create(modem, 0, "atmodem", data->app);
> +}
> +

This is OK

>  static void hso_post_online(struct ofono_modem *modem)
>  {
>  	struct hso_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_message_waiting *mw;
>  	struct ofono_gprs *gprs;
>  	struct ofono_gprs_context *gc;
>  =

>  	DBG("%p", modem);
>  =

> +	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
> +	ofono_call_settings_create(modem, 0, "atmodem", data->app);
>  	ofono_netreg_create(modem, OFONO_VENDOR_OPTION_HSO,
>  				"atmodem", data->app);
> -
> +	ofono_call_meter_create(modem, 0, "atmodem", data->app);
> +	ofono_call_barring_create(modem, 0, "atmodem", data->app);
> +	ofono_ssn_create(modem, 0, "atmodem", data->app);
> +	ofono_call_volume_create(modem, 0, "atmodem", data->app);
>  	ofono_radio_settings_create(modem, 0, "hsomodem", data->app);
> -
>  	ofono_sms_create(modem, OFONO_VENDOR_OPTION_HSO, "atmodem", data->app);
>  	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
>  				"atmodem", data->app);
> @@ -286,6 +311,10 @@ static void hso_post_online(struct ofono_modem *mode=
m)
>  =

>  	if (gprs && gc)
>  		ofono_gprs_add_context(gprs, gc);
> +
> +	mw =3D ofono_message_waiting_create(modem);
> +	if (mw)
> +		ofono_message_waiting_register(mw);

Same thing here, since voicecalls are not enabled, all the call-*
related atoms are not needed.

Regards,
-Denis

--===============6139737239448526919==--

