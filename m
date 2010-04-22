Content-Type: multipart/mixed; boundary="===============1962094923265882756=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: How to handle pins?
Date: Thu, 22 Apr 2010 08:54:38 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD1E3BC9EE@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <20100421061402.GA10199@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1962094923265882756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: connman-bounces(a)connman.net
> [mailto:connman-bounces(a)connman.net] On Behalf Of Daniel Wagner
> Sent: Wednesday, April 21, 2010 2:14 PM
> To: connman(a)connman.net
> Subject: How to handle pins?
> =

> Hi,
> =

> I was able to get connman with ofono working with my Option
> modem. Though one of the problem I had to workaround was the pin
> entering. When the device is attached to the computer, ofono
> identifies it as:
> =

> $ ./list-modems
> [ /hso0 ]
>     Powered =3D 1
>     Interfaces =3D org.ofono.SimManager
>     Model =3D GlobeTrotter HSUPA Modem
>     Manufacturer =3D Option N.V.
>     Serial =3D 351721030157214,PK29997020
>     Revision =3D 2.12.0.0Hd (Date: Oct 29 2009, Time: 09:56:48)
>     [ org.ofono.SimManager ]
>         SubscriberNumbers =3D
>         LockedPins =3D pin
>         PinRequired =3D pin
>         Present =3D 1
> =

> =

> connman ignores this device until the GPRS interface shows up. This
> wont happend until the pin is entered. In my ignorance I have tried
I think maybe pin can be handled at ofono side. =


> modify connmand that way, that it shows the modem as device (with a
> new property "PinRequired") even when the GPRS interface is not yet
> available. Though I had to hackaround with the IMSI (which is used as
> unique identifier for the dbus paths) is only available after the pin
> has been entered. Maybe the serial number could be used instead of the
> IMSI instead?
I am afraid that IMSI is the best identifier, and serial number is implemen=
ted by manufacturer, and sometime not unique.
Anyway it is the issue we need to resolve. So I also copy it to oFono maill=
ist for comments. ;-)

> =

> I'm not sure if I'm going the right road. What is the great master
> plan to handle this?
> =

> cheers,
> daniel
> =

> ps: btw here is the current hack:
> =

> diff --git a/plugins/ofono.c b/plugins/ofono.c
> index d0f358e..bd443f1 100644
> --- a/plugins/ofono.c
> +++ b/plugins/ofono.c
> @@ -843,7 +843,7 @@ done:
>  }
> =

>  static void add_device(const char *path, const char *imsi,
> -					unsigned char mnc_length)
> +			       unsigned char mnc_length, const char *pin_required)
>  {
>  	struct modem_data *modem;
>  	struct connman_device *device;
> @@ -877,6 +877,8 @@ static void add_device(const char *path, const char
> *imsi,
>  		g_free(mcc_mnc);
>  	}
> =

> +	connman_device_set_string(device, "PinRequired", pin_required);
> +
>  	if (connman_device_register(device) < 0) {
>  		connman_device_unref(device);
>  		return;
> @@ -890,7 +892,8 @@ static void add_device(const char *path, const char
> *imsi,
>  static void sim_properties_reply(DBusPendingCall *call, void *user_data)
>  {
>  	const char *path =3D user_data;
> -	const char *imsi;
> +	char *imsi =3D "foo";
> +	char *pin_required =3D "";
>  	/* If MobileNetworkCodeLength is not provided, mnc_length is 0 */
>  	unsigned char mnc_length =3D 0;
>  	DBusMessage *reply;
> @@ -923,11 +926,13 @@ static void sim_properties_reply(DBusPendingCall
> *call, void *user_data)
>  		else if (g_str_equal(key, "MobileNetworkCodeLength") =3D=3D TRUE)
>  			dbus_message_iter_get_basic(&value,
>  						(void *) &mnc_length);
> +		else if (g_str_equal(key, "PinRequired") =3D=3D TRUE)
> +			dbus_message_iter_get_basic(&value, &pin_required);
> =

>  		dbus_message_iter_next(&dict);
>  	}
> =

> -	add_device(path, imsi, mnc_length);
> +	add_device(path, imsi, mnc_length, pin_required);
> =

>  done:
>  	dbus_message_unref(reply);
> @@ -935,7 +940,7 @@ done:
>  	dbus_pending_call_unref(call);
>  }
> =

> -static void get_imsi(const char *path)
> +static void get_sim_properties(const char *path)
>  {
>  	DBusMessage *message;
>  	DBusPendingCall *call;
> @@ -1036,6 +1041,7 @@ static struct modem_data *add_modem(const char
> *path)
>  	return modem;
>  }
> =

> +/*
>  static gboolean modem_has_gprs(DBusMessageIter *array)
>  {
>  	DBusMessageIter entry;
> @@ -1055,6 +1061,7 @@ static gboolean modem_has_gprs(DBusMessageIter
> *array)
> =

>  	return FALSE;
>  }
> +*/
> =

>  static void modem_properties_reply(DBusPendingCall *call, void *user_dat=
a)
>  {
> @@ -1093,8 +1100,7 @@ static void
> modem_properties_reply(DBusPendingCall *call, void *user_data)
>  				break;
>  			}
>  		} else if (g_str_equal(key, "Interfaces") =3D=3D TRUE) {
> -			if (modem_has_gprs(&value) =3D=3D TRUE)
> -				get_imsi(path);
> +			get_sim_properties(path);
>  		}
> =

>  		dbus_message_iter_next(&dict);
> @@ -1333,10 +1339,9 @@ static gboolean modem_changed(DBusConnection
> *connection, DBusMessage *message,
> =

>  		modem_remove_device(modem);
>  	} else if (g_str_equal(key, "Interfaces") =3D=3D TRUE) {
> -		if (modem_has_gprs(&value) =3D=3D TRUE) {
> -			if (modem->device =3D=3D NULL)
> -				get_imsi(modem->path);
> -		} else if (modem->device !=3D NULL)
> +		if (modem->device =3D=3D NULL)
> +			get_sim_properties(modem->path);
> +		else if (modem->device !=3D NULL)
>  			modem_remove_device(modem);
>  	}
> =

> diff --git a/src/device.c b/src/device.c
> index 619fe5e..146ed40 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -66,6 +66,8 @@ struct connman_device {
> =

>  	DBusMessage *pending;
>  	guint timeout;
> +
> +	char *pin_required;
>  };
> =

>  static gboolean device_scan_trigger(gpointer user_data)
> @@ -324,6 +326,20 @@ static DBusMessage *get_properties(DBusConnection
> *conn,
>  		break;
>  	}
> =

> +	switch (device->type) {
> +	case CONNMAN_DEVICE_TYPE_UNKNOWN:
> +	case CONNMAN_DEVICE_TYPE_VENDOR:
> +	case CONNMAN_DEVICE_TYPE_ETHERNET:
> +	case CONNMAN_DEVICE_TYPE_WIFI:
> +	case CONNMAN_DEVICE_TYPE_WIMAX:
> +	case CONNMAN_DEVICE_TYPE_BLUETOOTH:
> +	case CONNMAN_DEVICE_TYPE_GPS:
> +		break;
> +	case CONNMAN_DEVICE_TYPE_CELLULAR:
> +		connman_dbus_dict_append_basic(&dict, "PinRequired",
> +					       DBUS_TYPE_STRING,
> &device->pin_required);
> +	}
> +
>  	connman_dbus_dict_close(&array, &dict);
> =

>  	return reply;
> @@ -682,6 +698,7 @@ static void device_destruct(struct connman_element
> *element)
>  	g_free(device->address);
>  	g_free(device->control);
>  	g_free(device->interface);
> +	g_free(device->pin_required);
> =

>  	g_free(device->last_network);
> =

> @@ -1292,6 +1309,9 @@ int connman_device_set_string(struct
> connman_device *device,
>  	} else if (g_str_equal(key, "Node") =3D=3D TRUE) {
>  		g_free(device->node);
>  		device->node =3D g_strdup(value);
> +	} else if (g_str_equal(key, "PinRequired") =3D=3D TRUE) {
> +		g_free(device->pin_required);
> +		device->pin_required =3D g_strdup(value);
>  	}
> =

>  	return connman_element_set_string(&device->element, key, value);
> @@ -1315,6 +1335,8 @@ const char *connman_device_get_string(struct
> connman_device *device,
>  		return device->name;
>  	else if (g_str_equal(key, "Node") =3D=3D TRUE)
>  		return device->node;
> +	else if (g_str_equal(key, "PinRequired") =3D=3D TRUE)
> +		return device->pin_required;
> =

>  	return connman_element_get_string(&device->element, key);
>  }
> _______________________________________________
> connman mailing list
> connman(a)connman.net
> http://lists.connman.net/listinfo/connman

--===============1962094923265882756==--

