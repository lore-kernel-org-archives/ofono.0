Content-Type: multipart/mixed; boundary="===============5311612497491880839=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] gemalto: add PLS8 support
Date: Wed, 30 Aug 2017 13:54:20 -0500
Message-ID: <d5e0cb7e-1f2d-3632-772d-65d2d6c204d0@gmail.com>
In-Reply-To: <1504110605-22509-1-git-send-email-sebastian.arnd@gemalto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5311612497491880839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On 08/30/2017 11:30 AM, Sebastian Arnd wrote:
> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 011713e..dcd8f14 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -67,6 +67,7 @@ struct gemalto_data {
>   	GAtChat *mdm;
>   	struct ofono_sim *sim;
>   	gboolean have_sim;
> +	gboolean have_net;
>   	struct at_util_sim_state_query *sim_state_query;
>   	struct gemalto_hardware_monitor *hm;
>   };
> @@ -101,18 +102,31 @@ static void gemalto_debug(const char *str, void *us=
er_data)
>   	ofono_info("%s%s", prefix, str);
>   }
>   =

> -static GAtChat *open_device(const char *device)
> +static GAtChat *open_device(const char *device, char *device_debug_name)
>   {
>   	GAtSyntax *syntax;
>   	GIOChannel *channel;
>   	GAtChat *chat;
> +	GHashTable *options;
>   =

>   	DBG("Opening device %s", device);
>   =

> -	channel =3D g_at_tty_open(device, NULL);
> +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +	if (options =3D=3D NULL)
> +		return NULL;
> +	/*
> +	 * The modem does not answer when the "Baud" attibute is missing
> +	 * The supplied value is not making any change. But the "Baud"
> +	 * paramenter is needed.
> +	 */
> +	g_hash_table_insert(options, "Baud", "115200");
> +
> +	channel =3D g_at_tty_open(device, options);
> +	g_hash_table_destroy(options);
>   	if (channel =3D=3D NULL)
>   		return NULL;
>   =

> +

We do not allow double empty lines anywhere.  Even if this were allowed, =

such whitespace changes are not related to the current commit and should =

be submitted separately.

>   	syntax =3D g_at_syntax_new_gsm_permissive();
>   	chat =3D g_at_chat_new(channel, syntax);
>   	g_at_syntax_unref(syntax);
> @@ -121,6 +135,9 @@ static GAtChat *open_device(const char *device)
>   	if (chat =3D=3D NULL)
>   		return NULL;
>   =

> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, gemalto_debug, device_debug_name);
> +
>   	return chat;
>   }
>   =

> @@ -299,47 +316,54 @@ static int gemalto_hardware_monitor_enable(struct o=
fono_modem *modem)
>   	return 0;
>   }
>   =

> +

No double-empty lines please

>   static int gemalto_enable(struct ofono_modem *modem)
>   {
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> -	const char *app, *mdm;
> +	const char *app, *mdm, *net;
>   =

>   	DBG("%p", modem);
>   =

>   	app =3D ofono_modem_get_string(modem, "Application");
>   	mdm =3D ofono_modem_get_string(modem, "Modem");
> +	net =3D ofono_modem_get_string(modem, "NetworkInterface");
>   =

> -	if (app =3D=3D NULL || mdm =3D=3D NULL)
> +	if (net !=3D NULL)
> +		data->have_net =3D TRUE;
> +	else
> +		data->have_net =3D FALSE;
> +
> +	if (app =3D=3D NULL || (mdm =3D=3D NULL && !data->have_net))
>   		return -EINVAL;
>   =

>   	/* Open devices */
> -	data->app =3D open_device(app);
> +	data->app =3D open_device(app, "App");
>   	if (data->app =3D=3D NULL)
>   		return -EINVAL;
>   =

> -	data->mdm =3D open_device(mdm);
> -	if (data->mdm =3D=3D NULL) {
> -		g_at_chat_unref(data->app);
> -		data->app =3D NULL;
> -		return -EINVAL;
> -	}
> -
> -	if (getenv("OFONO_AT_DEBUG")) {
> -		g_at_chat_set_debug(data->app, gemalto_debug, "App");
> -		g_at_chat_set_debug(data->mdm, gemalto_debug, "Mdm");
> +	/* Mdm device is only requiered when there is no net interface */
> +	if (!data->have_net) {
> +		data->mdm =3D open_device(mdm, "Mdm");
> +		if (data->mdm =3D=3D NULL) {
> +			g_at_chat_unref(data->app);
> +			data->app =3D NULL;
> +			return -EINVAL;
> +		}

With accordance to doc/coding-style.txt, item M1, please add an empty =

line here

> +		g_at_chat_send(data->mdm, "ATE0", none_prefix,
> +						NULL, NULL, NULL);
> +		g_at_chat_send(data->mdm, "AT&C0", none_prefix,
> +						NULL, NULL, NULL);
>   	}
>   =

> -	g_at_chat_send(data->mdm, "ATE0", none_prefix, NULL, NULL, NULL);
> -	g_at_chat_send(data->app, "ATE0 +CMEE=3D1", none_prefix,
> -			NULL, NULL, NULL);
> -	g_at_chat_send(data->mdm, "AT&C0", none_prefix, NULL, NULL, NULL);
> +	g_at_chat_send(data->app, "ATE0", none_prefix, NULL, NULL, NULL);
> +	g_at_chat_send(data->app, "AT+CMEE=3D1", none_prefix, NULL, NULL, NULL);
>   	g_at_chat_send(data->app, "AT&C0", none_prefix, NULL, NULL, NULL);
> -
>   	g_at_chat_send(data->app, "AT+CFUN=3D4", none_prefix,
> -			cfun_enable, modem, NULL);
> +						cfun_enable, modem, NULL);
>   =

>   	gemalto_hardware_monitor_enable(modem);
>   =

> +

No double empty lines please

>   	return -EINPROGRESS;
>   }
>   =

> @@ -402,7 +426,8 @@ static void gemalto_set_online(struct ofono_modem *mo=
dem, ofono_bool_t online,
>   =

>   	DBG("modem %p %s", modem, online ? "online" : "offline");
>   =

> -	if (g_at_chat_send(data->app, command, NULL, set_online_cb, cbd, g_free=
))
> +	if (g_at_chat_send(data->app, command, NULL,
> +					set_online_cb, cbd, g_free))

Okay, but this should really be a separate commit to specifically =

address the '> 80 characters / line' issue.

>   		return;
>   =

>   	CALLBACK_WITH_FAILURE(cb, cbd->data);
> @@ -419,7 +444,8 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
>   =

>   	ofono_devinfo_create(modem, 0, "atmodem", data->app);
>   	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
> -	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
> +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION,
> +							"atmodem", data->app);
>   =

>   	if (sim && data->have_sim =3D=3D TRUE)
>   		ofono_sim_inserted_notify(sim, TRUE);
> @@ -438,7 +464,12 @@ static void gemalto_post_sim(struct ofono_modem *mod=
em)
>   	ofono_sms_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);
>   =

>   	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
> -	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
> +
> +	if (data->have_net)
> +		gc =3D ofono_gprs_context_create(modem, 0,
> +						"gemaltowwanmodem", data->app);

"gemaltomodem" would be better, unless you guys planning on multiple =

variants?

> +	else
> +		gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
>   =

>   	if (gprs && gc)
>   		ofono_gprs_add_context(gprs, gc);
> @@ -450,7 +481,8 @@ static void gemalto_post_online(struct ofono_modem *m=
odem)
>   =

>   	DBG("%p", modem);
>   =

> -	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app=
);
> +	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION,
> +							"atmodem", data->app);

Same comment about '> 80 characters / line' as above.  Separate these =

chunks into a separate commit and make it first in the series.

>   }
>   =

>   static struct ofono_modem_driver gemalto_driver =3D {
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index aa28bcb..68c8386 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1080,13 +1080,24 @@ static gboolean setup_gemalto(struct modem_info* =
modem)
>   				net =3D info->devnode;
>   			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
>   				qmi =3D info->devnode;
> +		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
> +			if (g_strcmp0(info->number, "00") =3D=3D 0)
> +				mdm =3D info->devnode;
> +			else if (g_strcmp0(info->number, "02") =3D=3D 0)
> +				app =3D info->devnode;
> +			else if (g_strcmp0(info->number, "04") =3D=3D 0)
> +				gps =3D info->devnode;
> +		} else if (g_strcmp0(info->interface, "2/6/0") =3D=3D 0 &&
> +			  g_strcmp0(info->number, "0a") =3D=3D 0) {

Please don't mix tabs & spaces.  If this doesn't fit into an 80 =

character line, you can get creative, e.g.:

} else if (g_strcmp0(info->interface, "2/6/0") =3D=3D 0) {
	if (g_strcmp0(info->number, "0a") =3D=3D 0)
		net =3D ...;
}

> +				net =3D info->devnode;
>   		}
> +

This whitespace change is spurious, please remove.

>   	}
>   =

>   	DBG("application=3D%s gps=3D%s modem=3D%s network=3D%s qmi=3D%s",
>   			app, gps, mdm, net, qmi);
>   =

> -	if (app =3D=3D NULL || mdm =3D=3D NULL)
> +	if (app =3D=3D NULL || (mdm =3D=3D NULL && net =3D=3D NULL))
>   		return FALSE;
>   =

>   	ofono_modem_set_string(modem->modem, "Application", app);
> @@ -1499,6 +1510,8 @@ static struct {
>   	{ "gemalto",	"option",	"1e2d",	"0053"	},
>   	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
>   	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
> +	{ "gemalto",	"cdc_acm",	"1e2d",	"0061"	},
> +	{ "gemalto",	"cdc_ether",	"1e2d",	"0061"	},
>   	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
>   	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
>   	{ }
> =


Regards,
-Denis

--===============5311612497491880839==--

