Content-Type: multipart/mixed; boundary="===============7956447383381514370=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] gemalto: support ALS3 in gemalto's plugin
Date: Fri, 16 Mar 2018 11:08:53 -0500
Message-ID: <b30564c9-8a92-4fa9-eb3c-a0f01597f12e@gmail.com>
In-Reply-To: <1521215975-19944-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7956447383381514370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,
<snip>

> @@ -300,29 +322,24 @@ static int gemalto_hardware_monitor_enable(struct o=
fono_modem *modem)
>   	return 0;
>   }
>   =

> -static int gemalto_enable(struct ofono_modem *modem)
> +static void gemalto_initialize(struct ofono_modem *modem)
>   {
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> -	const char *app, *mdm;
> +	const char *mdm;
>   =

> -	DBG("%p", modem);
> +	DBG("");
>   =

> -	app =3D ofono_modem_get_string(modem, "Application");
>   	mdm =3D ofono_modem_get_string(modem, "Modem");
>   =

> -	if (app =3D=3D NULL || mdm =3D=3D NULL)
> -		return -EINVAL;
> +	if (mdm =3D=3D NULL)
> +		return;
>   =

>   	/* Open devices */
> -	data->app =3D open_device(app);
> -	if (data->app =3D=3D NULL)
> -		return -EINVAL;
> -
>   	data->mdm =3D open_device(mdm);
>   	if (data->mdm =3D=3D NULL) {
>   		g_at_chat_unref(data->app);
>   		data->app =3D NULL;
> -		return -EINVAL;
> +		return;
>   	}
>   =

>   	if (getenv("OFONO_AT_DEBUG")) {
> @@ -340,6 +357,67 @@ static int gemalto_enable(struct ofono_modem *modem)
>   			cfun_enable, modem, NULL);
>   =

>   	gemalto_hardware_monitor_enable(modem);
> +}
> +
> +static void gemalto_modem_ready(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +	const char *app =3D ofono_modem_get_string(modem, "Application");
> +
> +	DBG("");
> +
> +	g_at_chat_unregister(data->app, data->modem_ready_id);
> +	g_at_chat_cancel(data->app, data->trial_cmd_id);

Since you're unrefing data->app below, this isn't really necessary.  You =

might want to reset the ids to zero here though.

> +
> +	/*!
> +	 * As the modem wasn't ready to handle AT commands when we opened
> +	 * it, we have to close and reopen the device app.
> +	 */ =

> +	g_at_chat_unref(data->app);
> +
> +	if(app =3D=3D NULL)
> +		return;

Not our coding style.  Also, the "Application" property should not =

disappear under you, so I would leave this check out.

> +
> +	data->app =3D open_device(app);
> +	if (data->app =3D=3D NULL)
> +		return;

You might want to tell the core that the enable operation failed.  So =

ofono_modem_set_powered(modem, FALSE);

> +
> +	gemalto_initialize(modem);
> +}
> +
> +static void gemalto_at_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +
> +	g_at_chat_unregister(data->app, data->modem_ready_id);
> +	gemalto_initialize(modem);

Do you also want to reset modem_ready_id to 0 as well?  And trial_cmd_id

> +}
> +
> +static int gemalto_enable(struct ofono_modem *modem)
> +{
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +	const char *app, *mdm;
> +
> +	DBG("%p", modem);
> +
> +	app =3D ofono_modem_get_string(modem, "Application");
> +	mdm =3D ofono_modem_get_string(modem, "Modem");
> +
> +	if (app =3D=3D NULL || mdm =3D=3D NULL)
> +		return -EINVAL;
> +
> +	/* Open devices */
> +	data->app =3D open_device(app);
> +	if (data->app =3D=3D NULL)
> +		return -EINVAL;
> +
> +	/* Try the AT command. If it doesn't work, wait for ^SYSSTART */
> +	data->modem_ready_id =3D g_at_chat_register(data->app, "^SYSSTART",
> +				gemalto_modem_ready, FALSE, modem, NULL);
> +	data->trial_cmd_id =3D g_at_chat_send(data->app, "ATE0 AT",
> +				none_prefix, gemalto_at_cb, modem, NULL);
>   =

>   	return -EINPROGRESS;
>   }
> @@ -432,6 +510,7 @@ static void gemalto_post_sim(struct ofono_modem *mode=
m)
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
>   	struct ofono_gprs *gprs;
>   	struct ofono_gprs_context *gc;
> +	const char *model =3D ofono_modem_get_string(modem, "Model");
>   =

>   	DBG("%p", modem);
>   =

> @@ -444,6 +523,9 @@ static void gemalto_post_sim(struct ofono_modem *mode=
m)
>   =

>   	if (gprs && gc)
>   		ofono_gprs_add_context(gprs, gc);
> +
> +	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3))
> +		ofono_lte_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);

Over 80 characters here

>   }
>   =

>   static void gemalto_post_online(struct ofono_modem *modem)
> =


Regards,
-Denis

--===============7956447383381514370==--

