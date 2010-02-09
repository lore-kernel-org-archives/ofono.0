Content-Type: multipart/mixed; boundary="===============8692271366373769843=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] hfp: set timeout to service level connection procedure
Date: Tue, 09 Feb 2010 15:57:24 -0200
Message-ID: <20100209175724.GB6797@vigoh>
In-Reply-To: <1265737944-27699-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8692271366373769843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Gustavo F. Padovan <padovan@profusion.mobi> [2010-02-09 15:52:24 -0200]:

> If it expires we call org.bluez.HandsfreeGateway.Disconnect()
> It also modifies send_method_call and break it down into two functions.
> Now we have send_method_call_with_reply, for DBus messages that needs a
> reply. It sets a reply and a timeout for the message reply.
> The other funcion is called send_method_call without timeout or reply
> parameters.
> ---
>  plugins/hfp.c |  103 +++++++++++++++++++++++++++++++++++++++++++--------=
------
>  1 files changed, 78 insertions(+), 25 deletions(-)
> =

> diff --git a/plugins/hfp.c b/plugins/hfp.c
> index d1d43f4..1693532 100644
> --- a/plugins/hfp.c
> +++ b/plugins/hfp.c
> @@ -186,8 +186,35 @@ static void cmer_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
>  =

>  static int send_method_call(const char *dest, const char *path,
>  				const char *interface, const char *method,
> +				int type, ...)
> +{
> +	DBusMessage *msg;
> +	va_list args;
> +
> +	msg =3D dbus_message_new_method_call(dest, path, interface, method);
> +	if (!msg) {
> +		ofono_error("Unable to allocate new D-Bus %s message", method);
> +		return -ENOMEM;
> +	}
> +
> +	va_start(args, type);
> +
> +	if (!dbus_message_append_args_valist(msg, type, args)) {
> +		dbus_message_unref(msg);
> +		va_end(args);
> +		return -EIO;
> +	}
> +
> +	va_end(args);
> +
> +	g_dbus_send_message(connection, msg);
> +	return 0;
> +}
> +
> +static int send_method_call_with_reply(const char *dest, const char *pat=
h,
> +				const char *interface, const char *method,
>  				DBusPendingCallNotifyFunction cb,
> -				void *user_data, int type, ...)
> +				void *user_data, int timeout, int type, ...)
>  {
>  	DBusMessage *msg;
>  	DBusPendingCall *call;
> @@ -209,12 +236,10 @@ static int send_method_call(const char *dest, const=
 char *path,
>  =

>  	va_end(args);
>  =

> -	if (!cb) {
> -		g_dbus_send_message(connection, msg);
> -		return 0;
> -	}
> +	if (timeout > 0)
> +		timeout *=3D1000;
>  =

> -	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
> +	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout)) {
>  		ofono_error("Sending %s failed", method);
>  		dbus_message_unref(msg);
>  		return -EIO;
> @@ -590,9 +615,9 @@ static void list_devices_cb(DBusPendingCall *call, gp=
ointer user_data)
>  		goto done;
>  =

>  	for (i =3D 0 ; i < num ; i++) {
> -		ret =3D send_method_call(BLUEZ_SERVICE, device_list[i],
> +		ret =3D send_method_call_with_reply(BLUEZ_SERVICE, device_list[i],
>  				BLUEZ_DEVICE_INTERFACE, "GetProperties",
> -				get_properties_cb, device_list[i],
> +				get_properties_cb, (void *)device_list[i], -1,
>  				DBUS_TYPE_INVALID);
>  		if (ret < 0) {
>  			g_free(device_list[i]);
> @@ -614,10 +639,9 @@ static gboolean adapter_added(DBusConnection *connec=
tion, DBusMessage *message,
>  	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
>  				DBUS_TYPE_INVALID);
>  =

> -	ret =3D send_method_call(BLUEZ_SERVICE, path,
> +	ret =3D send_method_call_with_reply(BLUEZ_SERVICE, path,
>  			BLUEZ_ADAPTER_INTERFACE, "ListDevices",
> -			list_devices_cb, NULL,
> -			DBUS_TYPE_INVALID);
> +			list_devices_cb, NULL, -1, DBUS_TYPE_INVALID);
>  =

>  	if (ret < 0)
>  		ofono_error("ListDevices failed(%d)", ret);
> @@ -671,10 +695,9 @@ static void list_adapters_cb(DBusPendingCall *call, =
gpointer user_data)
>  		goto done;
>  =

>  	for (i =3D 0 ; i < num ; i++) {
> -		ret =3D send_method_call(BLUEZ_SERVICE, adapter_list[i],
> +		ret =3D send_method_call_with_reply(BLUEZ_SERVICE, adapter_list[i],
>  				BLUEZ_ADAPTER_INTERFACE, "ListDevices",
> -				list_devices_cb, NULL,
> -				DBUS_TYPE_INVALID);
> +				list_devices_cb, NULL, -1, DBUS_TYPE_INVALID);
>  =

>  		if (ret < 0)
>  			ofono_error("ListDevices failed(%d)", ret);
> @@ -688,10 +711,9 @@ done:
>  =

>  static int hfp_load_modems()
>  {
> -	return send_method_call(BLUEZ_SERVICE, "/",
> +	return send_method_call_with_reply(BLUEZ_SERVICE, "/",
>  				BLUEZ_MANAGER_INTERFACE, "ListAdapters",
> -				list_adapters_cb, NULL,
> -				DBUS_TYPE_INVALID);
> +				list_adapters_cb, NULL, -1, DBUS_TYPE_INVALID);
>  }
>  =

>  static int hfp_register_ofono_handsfree(struct ofono_modem *modem)
> @@ -703,8 +725,8 @@ static int hfp_register_ofono_handsfree(struct ofono_=
modem *modem)
>  =

>  	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
>  				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent",
> -				NULL, NULL, DBUS_TYPE_OBJECT_PATH,
> -				&obj_path, DBUS_TYPE_INVALID);
> +				DBUS_TYPE_OBJECT_PATH, &obj_path,
> +				DBUS_TYPE_INVALID);
>  }
>  =

>  static int hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
> @@ -716,8 +738,8 @@ static int hfp_unregister_ofono_handsfree(struct ofon=
o_modem *modem)
>  =

>  	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
>  				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent",
> -				NULL, NULL, DBUS_TYPE_OBJECT_PATH,
> -				&obj_path, DBUS_TYPE_INVALID);
> +				DBUS_TYPE_OBJECT_PATH, &obj_path,
> +				DBUS_TYPE_INVALID);
>  }
>  =

>  static int hfp_probe(struct ofono_modem *modem)
> @@ -750,15 +772,46 @@ static void hfp_remove(struct ofono_modem *modem)
>  	ofono_modem_set_data(modem, NULL);
>  }
>  =

> +static void hfp_connect_reply(DBusPendingCall *call, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct hfp_data *data =3D ofono_modem_get_data(modem);
> +	DBusError derr;
> +	DBusMessage *reply;
> +	int ret;
> +
> +	reply =3D dbus_pending_call_steal_reply(call);
> +
> +	if (ofono_modem_get_powered(modem))
> +		goto done;
> +
> +	dbus_error_init(&derr);
> +	if (!dbus_set_error_from_message(&derr, reply) || data->slc_msg)
> +		goto done;
> +
> +	ofono_debug("Connect reply: %s", derr.message);
> +	dbus_error_free(&derr);
> +
> +	ret =3D send_method_call(BLUEZ_SERVICE, data->handsfree_path,
> +				BLUEZ_GATEWAY_INTERFACE, "Disconnect",
> +				DBUS_TYPE_INVALID);
> +	if (ret < 0)
> +		ofono_error("Disconnect failed(%d)", ret);
> +
> +done:
> +	dbus_message_unref(reply);
> +}
> +
>  static int hfp_connect_ofono_handsfree(struct ofono_modem *modem)
>  {
>  	struct hfp_data *data =3D ofono_modem_get_data(modem);
>  =

>  	ofono_debug("Connect to bluetooth daemon");
>  =

> -	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
> +	return send_method_call_with_reply(BLUEZ_SERVICE, data->handsfree_path,
>  				BLUEZ_GATEWAY_INTERFACE, "Connect",
> -				NULL, NULL, DBUS_TYPE_INVALID);
> +				hfp_connect_reply, modem, 15,
> +				DBUS_TYPE_INVALID);
>  }
>  =

>  /* power up hardware */
> @@ -797,9 +850,9 @@ static int hfp_disconnect_ofono_handsfree(struct ofon=
o_modem *modem)
>  {
>  	struct hfp_data *data =3D ofono_modem_get_data(modem);
>  =

> -	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
> +	return send_method_call_with_reply(BLUEZ_SERVICE, data->handsfree_path,
>  				BLUEZ_GATEWAY_INTERFACE, "Disconnect",
> -				hfp_power_down, modem, DBUS_TYPE_INVALID);
> +				hfp_power_down, modem, -1, DBUS_TYPE_INVALID);
>  }
>  =

>  static int hfp_disable(struct ofono_modem *modem)
> -- =

> 1.6.4.4
> =


I forgot to rebase. Again. :(

-- =

Gustavo F. Padovan
http://padovan.org

ProFUSION embedded systems - http://profusion.mobi

--===============8692271366373769843==--

