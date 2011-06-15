Content-Type: multipart/mixed; boundary="===============1912988396096922378=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] linktop: reimplemented linktop plugin based on mbm
 with minimum features
Date: Wed, 15 Jun 2011 09:18:01 -0500
Message-ID: <4DF8BF19.8080005@gmail.com>
In-Reply-To: <1308122001-7649-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1912988396096922378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Amit,

<snip>

> @@ -127,93 +178,130 @@ static GAtChat *open_device(struct ofono_modem *mo=
dem,
>  	if (chat =3D=3D NULL)
>  		return NULL;
>  =

> -	if (getenv("OFONO_AT_DEBUG"))
> -		g_at_chat_set_debug(chat, linktop_debug, debug);
> -
>  	return chat;
>  }
>  =

> -static void linktop_disconnect(gpointer user_data)
> +static void linktop_disconnect(gpointer user_data);
> +
> +static gboolean reopen_callback(gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
>  	struct linktop_data *data =3D ofono_modem_get_data(modem);
> +	const char *data_dev;
> +
> +	data_dev =3D ofono_modem_get_string(modem, "DataDevice");
> +	data->data_port =3D create_port(data_dev);
> +	/* retry once if failed */
> +	if (data->data_port =3D=3D NULL) {
> +		if (data->reopen_source > 0)
> +			return FALSE;

Ok, this isn't right.  When mixing logic between two plugins, pay
attention! :)

reopen_callback is called from a GSource.  The way GSources work is that
returning FALSE means that the GSource should not be repeated, and
returning TRUE means it should be.  Since you never reset reopen_source
to 0 anywhere this won't work like you expect...  The reason this works
is probably because the 1 second timeout is enough...

> +
> +		data->reopen_source =3D g_timeout_add_seconds(1,
> +				reopen_callback, modem);
> +		ofono_debug("opening data port failed, retrying...");
> +		return FALSE;
> +	}
>  =

> -	DBG("");
> -
> -	if (data->gc)
> -		ofono_gprs_context_remove(data->gc);
> -
> -	g_at_chat_unref(data->modem);
> -	data->modem =3D NULL;
> -
> -	data->modem =3D open_device(modem, "Modem", "Modem: ");
> -	if (data->modem =3D=3D NULL)
> -		return;
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(data->data_port, linktop_debug, "Data: ");
>  =

> -	g_at_chat_set_disconnect_function(data->modem,
> +	g_at_chat_set_disconnect_function(data->data_port,
>  						linktop_disconnect, modem);
>  =

>  	ofono_info("Reopened GPRS context channel");
>  =

> -	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem=
);
> -
> +	data->gc =3D ofono_gprs_context_create(modem, 0,
> +					"atmodem", data->data_port);
>  	if (data->gprs && data->gc)
>  		ofono_gprs_add_context(data->gprs, data->gc);
> +
> +	data->reopen_source =3D 0;
> +
> +	return FALSE;
>  }
>  =

> -static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +static void linktop_disconnect(gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
> +	struct linktop_data *data =3D ofono_modem_get_data(modem);
>  =

> -	DBG("");
> +	DBG("%p, data->gc %p", modem, data->gc);
>  =

> -	ofono_modem_set_powered(modem, ok);
> +	/* gprs_context has been destructed and needs not reopen */
> +	if (data->gc =3D=3D NULL)
> +		return
> +	=


You have a dangling tab on the line above.

> +	ofono_gprs_context_remove(data->gc);
> +
> +	g_at_chat_unref(data->data_port);
> +	data->data_port =3D NULL;
> +
> +	/* Waiting for the +CGEV: ME DEACT might also work */
> +	if (data->reopen_source > 0)
> +		g_source_remove(data->reopen_source);
> +
> +	data->reopen_source =3D g_timeout_add_seconds(1, reopen_callback, modem=
);
>  }
>  =

>  static int linktop_enable(struct ofono_modem *modem)
>  {
>  	struct linktop_data *data =3D ofono_modem_get_data(modem);
> +	const char *modem_dev;
> +	const char *data_dev;
>  =

>  	DBG("%p", modem);
>  =

> -	data->modem =3D open_device(modem, "Modem", "Modem: ");
> -	if (data->modem =3D=3D NULL)
> -		return -EINVAL;
> +	modem_dev =3D ofono_modem_get_string(modem, "ModemDevice");
> +	data_dev =3D ofono_modem_get_string(modem, "DataDevice");
>  =

> -	g_at_chat_set_disconnect_function(data->modem,
> -						linktop_disconnect, modem);
> +	DBG("%s, %s", modem_dev, data_dev);
>  =

> -	data->control =3D open_device(modem, "Control", "Control: ");
> -	if (data->control =3D=3D NULL) {
> -		g_at_chat_unref(data->modem);
> -		data->modem =3D NULL;
> +	if (modem_dev =3D=3D NULL || data_dev =3D=3D NULL)
> +		return -EINVAL;
> +
> +	data->modem_port =3D create_port(modem_dev);
> +	if (data->modem_port =3D=3D NULL)
>  		return -EIO;
> -	}
>  =

> -	g_at_chat_send(data->control, "ATE0 +CMEE=3D1", none_prefix,
> -						NULL, NULL, NULL);
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(data->modem_port, linktop_debug, "Modem: ");
>  =

> -	g_at_chat_send(data->modem, "AT", none_prefix,
> -						NULL, NULL, NULL);
> +	data->data_port =3D create_port(data_dev);
> +	if (data->data_port =3D=3D NULL) {
> +		g_at_chat_unref(data->modem_port);
> +		data->modem_port =3D NULL;
> +
> +		return -EIO;
> +	}
>  =

> -	g_at_chat_send(data->modem, "AT &F", none_prefix,
> -						NULL, NULL, NULL);
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(data->data_port, linktop_debug, "Data: ");
>  =

> -	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
> -					cfun_enable, modem, NULL);
> +	g_at_chat_set_disconnect_function(data->data_port,
> +						linktop_disconnect, modem);
>  =

> +	g_at_chat_send(data->modem_port, "AT&F E0 V1 X4 &C1 +CMEE=3D1", none_pr=
efix,
> +				cfun_enable_cb, modem, NULL);
> +	g_at_chat_send(data->data_port, "AT&F E0 V1 X4 &C1 +CMEE=3D1", none_pre=
fix,
> +				cfun_enable_cb, modem, NULL);

Please obey the 80 characters / line limit

> +	g_at_chat_send(data->modem_port, "AT+CFUN=3D4", none_prefix,
> +				cfun_enable_cb, modem, NULL);
> +	=


You have a dangling tab on the line above...

>  	return -EINPROGRESS;
>  }
>  =

> -static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
>  	struct linktop_data *data =3D ofono_modem_get_data(modem);
>  =

>  	DBG("");
>  =

> -	g_at_chat_unref(data->control);
> -	data->control =3D NULL;
> +	g_at_chat_unref(data->modem_port);
> +	data->modem_port =3D NULL;
> +
> +	g_at_chat_unref(data->data_port);
> +	data->data_port =3D NULL;
>  =

>  	if (ok)
>  		ofono_modem_set_powered(modem, FALSE);
> @@ -225,20 +313,18 @@ static int linktop_disable(struct ofono_modem *mode=
m)
>  =

>  	DBG("%p", modem);
>  =

> -	if (data->modem) {
> -		g_at_chat_cancel_all(data->modem);
> -		g_at_chat_unregister_all(data->modem);
> -		g_at_chat_unref(data->modem);
> -		data->modem =3D NULL;
> +	if (data->reopen_source > 0) {
> +		g_source_remove(data->reopen_source);
> +		data->reopen_source =3D 0;
>  	}
>  =

> -	if (data->control =3D=3D NULL)
> +	if (data->modem_port =3D=3D NULL)
>  		return 0;
>  =

> -	g_at_chat_cancel_all(data->control);
> -	g_at_chat_unregister_all(data->control);
> -	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
> -					cfun_disable, modem, NULL);
> +	g_at_chat_cancel_all(data->modem_port);
> +	g_at_chat_unregister_all(data->modem_port);
> +	g_at_chat_send(data->modem_port, "AT+CFUN=3D4", NULL,
> +					cfun_disable_cb, modem, NULL);
>  =

>  	return -EINPROGRESS;
>  }
> @@ -253,17 +339,37 @@ static void set_online_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>  	cb(&error, cbd->data);
>  }
>  =

> +static void set_offline_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_modem_online_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +
> +	if (ok) {
> +		struct linktop_data *data =3D cbd->user;
> +
> +		data->gc =3D NULL;
> +		data->gprs =3D NULL;
> +	}
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +	cb(&error, cbd->data);
> +}
> +
>  static void linktop_set_online(struct ofono_modem *modem, ofono_bool_t o=
nline,
>  				ofono_modem_online_cb_t cb, void *user_data)
>  {
>  	struct linktop_data *data =3D ofono_modem_get_data(modem);
> -	GAtChat *chat =3D data->control;
> +	GAtChat *chat =3D data->modem_port;
>  	struct cb_data *cbd =3D cb_data_new(cb, user_data);
>  	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
>  =

>  	DBG("modem %p %s", modem, online ? "online" : "offline");
>  =

> -	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
> +	cbd->user =3D data;
> +
> +	if (g_at_chat_send(chat, command, NULL,
> +				online ? set_online_cb : set_offline_cb, cbd, g_free))

Please obey the 80 characters / line limit

>  		return;
>  =

>  	g_free(cbd);
> @@ -278,11 +384,10 @@ static void linktop_pre_sim(struct ofono_modem *mod=
em)
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_devinfo_create(modem, 0, "atmodem", data->control);
> -	sim =3D ofono_sim_create(modem, 0, "atmodem", data->control);
> -	ofono_voicecall_create(modem, 0, "stemodem", data->control);
> +	ofono_devinfo_create(modem, 0, "atmodem", data->modem_port);
> +	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem_port);
>  =

> -	if (sim)
> +	if (data->have_sim && sim)
>  		ofono_sim_inserted_notify(sim, TRUE);
>  }
>  =

> @@ -292,35 +397,29 @@ static void linktop_post_sim(struct ofono_modem *mo=
dem)
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_radio_settings_create(modem, 0, "stemodem", data->control);
> -	ofono_phonebook_create(modem, 0, "atmodem", data->control);
> -	ofono_sms_create(modem, 0, "atmodem", data->control);
> +	ofono_radio_settings_create(modem, 0, "stemodem", data->modem_port);
> +	ofono_phonebook_create(modem, 0, "atmodem", data->modem_port);
> +	ofono_sms_create(modem, 0, "atmodem", data->modem_port);
>  }
>  =

>  static void linktop_post_online(struct ofono_modem *modem)
>  {
>  	struct linktop_data *data =3D ofono_modem_get_data(modem);
>  	struct ofono_message_waiting *mw;
> -	struct ofono_gprs *gprs;
> -	struct ofono_gprs_context *gc;
>  =

>  	DBG("%p", modem);
>  =

> -	ofono_ussd_create(modem, 0, "atmodem", data->control);
> -	ofono_call_forwarding_create(modem, 0, "atmodem", data->control);
> -	ofono_call_settings_create(modem, 0, "atmodem", data->control);
> -	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->control);
> -	ofono_call_meter_create(modem, 0, "atmodem", data->control);
> -	ofono_call_barring_create(modem, 0, "atmodem", data->control);
> -	ofono_call_volume_create(modem, 0, "atmodem", data->control);
> -	ofono_cbs_create(modem, 0, "atmodem", data->control);
> -
> -	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
> -					"atmodem", data->control);
> -	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
> -
> -	if (gprs && gc)
> -		ofono_gprs_add_context(gprs, gc);
> +	ofono_netreg_create(modem, 0, "atmodem", data->modem_port);
> +	ofono_cbs_create(modem, 0, "atmodem", data->modem_port);
> +	ofono_ussd_create(modem, 0, "atmodem", data->modem_port);
> +
> +	data->gprs =3D ofono_gprs_create(modem, 0,
> +					"atmodem", data->modem_port);
> +	data->gc =3D ofono_gprs_context_create(modem, 0,
> +					"atmodem", data->data_port);
> +
> +	if (data->gprs && data->gc)
> +		ofono_gprs_add_context(data->gprs, data->gc);

I suggest that you move creation of gprs and gc to post_sim above.  This
also means you can stop tracking the lifetime of data->gprs in
set_offline_cb

>  =

>  	mw =3D ofono_message_waiting_create(modem);
>  =


Regards,
-Denis

--===============1912988396096922378==--

