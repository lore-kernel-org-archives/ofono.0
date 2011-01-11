Content-Type: multipart/mixed; boundary="===============3350761623528015437=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv5] plugin: Add ste modem initd integration
Date: Mon, 10 Jan 2011 16:58:02 -0800
Message-ID: <1294707482.3873.17.camel@aeonflux>
In-Reply-To: <1294306682-7309-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3350761623528015437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> +static void get_modems()
> +{

so these are declared as get_modems(void) btw. The compiler should have
warned you about this.

> +	DBusMessage *message;
> +	DBusPendingCall *call;
> +
> +	message =3D dbus_message_new_method_call(MGR_SERVICE, "/",
> +					MGR_INTERFACE, MGR_GET_MODEMS);
> +	if (message =3D=3D NULL) {
> +		ofono_error("Unable to allocate new D-Bus message");
> +		goto error;
> +	}
> +
> +	dbus_message_set_auto_start(message, FALSE);
> +
> +	if (!dbus_connection_send_with_reply(connection, message, &call,
> +						GET_MODEMS_TIMEOUT)) {
> +		ofono_error("Sending D-Bus message failed");
> +		goto error;
> +	}
> +
> +	if (call =3D=3D NULL) {
> +		DBG("D-Bus connection not available");
> +		goto error;
> +	}
> +
> +	dbus_pending_call_set_notify(call, get_modems_reply, NULL, NULL);
> +	dbus_pending_call_unref(call);
> +
> +error:
> +	dbus_message_unref(message);
> +}
> +
> +static gboolean property_changed(DBusConnection *connection,
> +					DBusMessage *message, void *user_data)
> +{
> +	DBusMessageIter iter;
> +	struct ste_modem *stemodem;
> +	const char *key;
> +	enum ste_operation operation;
> +	gboolean operation_valid;
> +
> +	stemodem =3D g_hash_table_lookup(modem_list,
> +					dbus_message_get_path(message));
> +
> +	if (stemodem =3D=3D NULL)
> +		return TRUE;
> +
> +
> +	if (!dbus_message_iter_init(message, &iter))
> +		return TRUE;
> +
> +	dbus_message_iter_get_basic(&iter, &key);
> +	dbus_message_iter_next(&iter);
> +
> +	update_property(stemodem, key, &iter, &operation, &operation_valid);
> +
> +	if (operation_valid)
> +		state_change(stemodem, operation);
> +
> +	return TRUE;
> +}
> +
> +static void mgr_connect(DBusConnection *connection, void *user_data)
> +{
> +	property_changed_watch =3D g_dbus_add_signal_watch(connection, NULL,
> +						NULL,
> +						MGR_MODEM_INTERFACE,
> +						PROPERTY_CHANGED,
> +						property_changed,
> +						NULL, NULL);
> +	get_modems();
> +}
> +
> +static void mgr_disconnect(DBusConnection *connection, void *user_data)
> +{
> +	g_hash_table_remove_all(modem_list);
> +	g_dbus_remove_watch(connection, property_changed_watch);
> +}
> +
> +static void destroy_stemodem(gpointer data)
> +{
> +	struct ste_modem *stemodem =3D data;
> +
> +	ofono_modem_remove(stemodem->modem);

I would add an extra empty line for pure visual sake here.

> +	g_free(stemodem->interface);
> +	g_free(stemodem->path);
> +	g_free(stemodem->serial);
> +	g_free(stemodem);
> +}
> +
> +static int stemgr_init()
> +{
> +	connection =3D ofono_dbus_get_connection();
> +
> +	modem_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +						NULL, destroy_stemodem);
> +	modem_daemon_watch =3D g_dbus_add_service_watch(connection, MGR_SERVICE,
> +				mgr_connect, mgr_disconnect, NULL, NULL);
> +	return 0;
> +}
> +
> +static void stemgr_exit()
> +{
> +	g_hash_table_destroy(modem_list);
> +	g_dbus_remove_watch(connection, modem_daemon_watch);
> +	g_dbus_remove_watch(connection, property_changed_watch);

This is not right. You need to remove the property_changed_watch in the
disconnect callback. Otherwise if your daemon restarts twice you
actually have two watches.

Regards

Marcel



--===============3350761623528015437==--

