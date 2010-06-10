Content-Type: multipart/mixed; boundary="===============8876752970232877472=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] Move bluetooth utils from hfp.c to bluetooth.c
Date: Thu, 10 Jun 2010 16:17:12 -0500
Message-ID: <201006101617.12795.denkenz@gmail.com>
In-Reply-To: <1275983040-26944-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8876752970232877472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

Please break this patch up more.  You're moving functions but also modifyin=
g =

them in between.  I'm getting lost.

> +static int send_method_call_with_reply(const char *dest, const char *pat=
h,
> +				const char *interface, const char *method,
> +				DBusPendingCallNotifyFunction cb,
> +				void *user_data, DBusFreeFunction free_func,
> +				int timeout, int type, ...)
> +{
> +	DBusMessage *msg;
> +	DBusPendingCall *call;
> +	va_list args;
> +	int err;
> +
> +	msg =3D dbus_message_new_method_call(dest, path, interface, method);
> +	if (!msg) {
> +		ofono_error("Unable to allocate new D-Bus %s message", method);
> +		err =3D -ENOMEM;
> +		goto fail;
> +	}
> +
> +	va_start(args, type);
> +
> +	if (!dbus_message_append_args_valist(msg, type, args)) {
> +		va_end(args);
> +		err =3D -EIO;
> +		goto fail;
> +	}
> +
> +	va_end(args);
> +
> +	if (timeout > 0)
> +		timeout *=3D 1000;
> +
> +	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout)) {
> +		ofono_error("Sending %s failed", method);
> +		err =3D -EIO;
> +		goto fail;
> +	}
> +
> +	dbus_pending_call_set_notify(call, cb, user_data, free_func);
> +	dbus_pending_call_unref(call);
> +	dbus_message_unref(msg);
> +
> +	return 0;
> +
> +fail:
> +	if (free_func && user_data)
> +		free_func(user_data);
> +
> +	if (msg)
> +		dbus_message_unref(msg);
> +
> +	return err;
> +}

So this should be in a separate patch...

> +
> +typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer
>  user_data); +
> +struct property_handler {
> +	const char *property;
> +	PropertyHandler callback;
> +	gpointer user_data;
> +};
> +
> +static gint property_handler_compare(gconstpointer a, gconstpointer b)
> +{
> +	const struct property_handler *handler =3D a;
> +	const char *property =3D b;
> +
> +	return strcmp(handler->property, property);
> +}
> +
> +static void parse_properties_reply(DBusMessage *reply,
> +					const char *property, ...)
> +{
> +	va_list args;
> +	GSList *prop_handlers =3D NULL;
> +	DBusMessageIter array, dict;
> +
> +	va_start(args, property);
> +
> +	while (property !=3D NULL) {
> +		struct property_handler *handler =3D
> +					g_new0(struct property_handler, 1);
> +
> +		handler->property =3D property;
> +		handler->callback =3D va_arg(args, PropertyHandler);
> +		handler->user_data =3D va_arg(args, gpointer);
> +
> +		property =3D va_arg(args, const char *);
> +
> +		prop_handlers =3D g_slist_prepend(prop_handlers, handler);
> +	}
> +
> +	va_end(args);
> +
> +	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
> +		goto done;
> +
> +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
> +		goto done;
> +
> +	dbus_message_iter_recurse(&array, &dict);
> +
> +	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTR=
Y) {
> +		DBusMessageIter entry, value;
> +		const char *key;
> +		GSList *l;
> +
> +		dbus_message_iter_recurse(&dict, &entry);
> +
> +		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
> +			goto done;
> +
> +		dbus_message_iter_get_basic(&entry, &key);
> +
> +		dbus_message_iter_next(&entry);
> +
> +		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
> +			goto done;
> +
> +		dbus_message_iter_recurse(&entry, &value);
> +
> +		l =3D g_slist_find_custom(prop_handlers, key,
> +					property_handler_compare);
> +
> +		if (l) {
> +			struct property_handler *handler =3D l->data;
> +
> +			handler->callback(&value, handler->user_data);
> +		}
> +
> +		dbus_message_iter_next(&dict);
> +	}
> +
> +done:
> +	g_slist_foreach(prop_handlers, (GFunc)g_free, NULL);
> +	g_slist_free(prop_handlers);
> +}

And this one too...

> +
> +static void has_uuid(DBusMessageIter *array, gpointer user_data)
> +{
> +	gboolean *profiles =3D user_data;
> +	DBusMessageIter value;
> +
> +	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
> +		return;
> +
> +	dbus_message_iter_recurse(array, &value);
> +
> +	while (dbus_message_iter_get_arg_type(&value) =3D=3D DBUS_TYPE_STRING) {
> +		const char *uuid;
> +
> +		dbus_message_iter_get_basic(&value, &uuid);
> +
> +		if (!strcasecmp(uuid, HFP_AG_UUID))
> +			*profiles |=3D HFP_AG;
> +
> +		dbus_message_iter_next(&value);
> +	}
> +}
> +
> +static void parse_string(DBusMessageIter *iter, gpointer user_data)
> +{
> +	char **str =3D user_data;
> +	int arg_type =3D dbus_message_iter_get_arg_type(iter);
> +
> +	if (arg_type !=3D DBUS_TYPE_OBJECT_PATH && arg_type !=3D DBUS_TYPE_STRI=
NG)
> +		return;
> +
> +	dbus_message_iter_get_basic(iter, str);
> +}
> +
> +static void device_properties_cb(DBusPendingCall *call, gpointer
>  user_data) +{
> +	DBusMessage *reply;
> +	int have_uuid =3D 0;
> +	const char *path =3D user_data;
> +	const char *adapter =3D NULL;
> +	const char *adapter_addr =3D NULL;
> +	const char *device_addr =3D NULL;
> +	const char *alias =3D NULL;
> +	struct bluetooth_profile *profile;
> +
> +	reply =3D dbus_pending_call_steal_reply(call);
> +
> +	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
> +		DBG("Bluetooth daemon is apparently not available.");
> +		goto done;
> +	}
> +
> +	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {
> +		if (!dbus_message_is_error(reply, DBUS_ERROR_UNKNOWN_METHOD))
> +			ofono_info("Error from GetProperties reply: %s",
> +					dbus_message_get_error_name(reply));
> +
> +		goto done;
> +	}
> +
> +	parse_properties_reply(reply, "UUIDs", has_uuid, &have_uuid,
> +				"Adapter", parse_string, &adapter,
> +				"Address", parse_string, &device_addr,
> +				"Alias", parse_string, &alias, NULL);
> +
> +	if (adapter)
> +		adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
> +							adapter);
> +
> +	if ((have_uuid & HFP_AG) && device_addr && adapter_addr) {
> +		profile =3D g_hash_table_lookup(uuid_hash, HFP_AG_UUID);
> +		profile->create(path, device_addr, adapter_addr, alias);

No checking of profile NULL-ness or profile->create NULL-ness?  I noticed a=
 few =

instances of this.

Regards,
-Denis

--===============8876752970232877472==--

