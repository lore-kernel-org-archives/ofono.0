Content-Type: multipart/mixed; boundary="===============6794551463331477580=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: [PATCH 2/5] Move bluetooth utils from hfp.c to bluetooth.c
Date: Sat, 12 Jun 2010 00:53:05 -0300
Message-ID: <20100612035202.GA32159@vigoh>
In-Reply-To: <201006101617.12795.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6794551463331477580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

* Denis Kenzior <denkenz@gmail.com> [2010-06-10 16:17:12 -0500]:

> Hi Gustavo,
> =

> Please break this patch up more.  You're moving functions but also modify=
ing =

> them in between.  I'm getting lost.
> =

> > +static int send_method_call_with_reply(const char *dest, const char *p=
ath,
> > +				const char *interface, const char *method,
> > +				DBusPendingCallNotifyFunction cb,
> > +				void *user_data, DBusFreeFunction free_func,
> > +				int timeout, int type, ...)
> > +{
> > +	DBusMessage *msg;
> > +	DBusPendingCall *call;
> > +	va_list args;
> > +	int err;
> > +
> > +	msg =3D dbus_message_new_method_call(dest, path, interface, method);
> > +	if (!msg) {
> > +		ofono_error("Unable to allocate new D-Bus %s message", method);
> > +		err =3D -ENOMEM;
> > +		goto fail;
> > +	}
> > +
> > +	va_start(args, type);
> > +
> > +	if (!dbus_message_append_args_valist(msg, type, args)) {
> > +		va_end(args);
> > +		err =3D -EIO;
> > +		goto fail;
> > +	}
> > +
> > +	va_end(args);
> > +
> > +	if (timeout > 0)
> > +		timeout *=3D 1000;
> > +
> > +	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout)=
) {
> > +		ofono_error("Sending %s failed", method);
> > +		err =3D -EIO;
> > +		goto fail;
> > +	}
> > +
> > +	dbus_pending_call_set_notify(call, cb, user_data, free_func);
> > +	dbus_pending_call_unref(call);
> > +	dbus_message_unref(msg);
> > +
> > +	return 0;
> > +
> > +fail:
> > +	if (free_func && user_data)
> > +		free_func(user_data);
> > +
> > +	if (msg)
> > +		dbus_message_unref(msg);
> > +
> > +	return err;
> > +}
> =

> So this should be in a separate patch...

If I put this in a separate patch, it won't compile because no one is
using send_method_call_with_reply.

> =

> > +
> > +typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer
> >  user_data); +
> > +struct property_handler {
> > +	const char *property;
> > +	PropertyHandler callback;
> > +	gpointer user_data;
> > +};
> > +
> > +static gint property_handler_compare(gconstpointer a, gconstpointer b)
> > +{
> > +	const struct property_handler *handler =3D a;
> > +	const char *property =3D b;
> > +
> > +	return strcmp(handler->property, property);
> > +}
> > +
> > +static void parse_properties_reply(DBusMessage *reply,
> > +					const char *property, ...)
> > +{
> > +	va_list args;
> > +	GSList *prop_handlers =3D NULL;
> > +	DBusMessageIter array, dict;
> > +
> > +	va_start(args, property);
> > +
> > +	while (property !=3D NULL) {
> > +		struct property_handler *handler =3D
> > +					g_new0(struct property_handler, 1);
> > +
> > +		handler->property =3D property;
> > +		handler->callback =3D va_arg(args, PropertyHandler);
> > +		handler->user_data =3D va_arg(args, gpointer);
> > +
> > +		property =3D va_arg(args, const char *);
> > +
> > +		prop_handlers =3D g_slist_prepend(prop_handlers, handler);
> > +	}
> > +
> > +	va_end(args);
> > +
> > +	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
> > +		goto done;
> > +
> > +	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
> > +		goto done;
> > +
> > +	dbus_message_iter_recurse(&array, &dict);
> > +
> > +	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_EN=
TRY) {
> > +		DBusMessageIter entry, value;
> > +		const char *key;
> > +		GSList *l;
> > +
> > +		dbus_message_iter_recurse(&dict, &entry);
> > +
> > +		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
> > +			goto done;
> > +
> > +		dbus_message_iter_get_basic(&entry, &key);
> > +
> > +		dbus_message_iter_next(&entry);
> > +
> > +		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
> > +			goto done;
> > +
> > +		dbus_message_iter_recurse(&entry, &value);
> > +
> > +		l =3D g_slist_find_custom(prop_handlers, key,
> > +					property_handler_compare);
> > +
> > +		if (l) {
> > +			struct property_handler *handler =3D l->data;
> > +
> > +			handler->callback(&value, handler->user_data);
> > +		}
> > +
> > +		dbus_message_iter_next(&dict);
> > +	}
> > +
> > +done:
> > +	g_slist_foreach(prop_handlers, (GFunc)g_free, NULL);
> > +	g_slist_free(prop_handlers);
> > +}
> =

> And this one too...

Same here.

-- =

Gustavo F. Padovan
http://padovan.org

--===============6794551463331477580==--

