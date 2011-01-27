Content-Type: multipart/mixed; boundary="===============6793851196658679884=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 3/4] bluetooth: Add bluetooth server support
Date: Thu, 27 Jan 2011 14:26:23 -0200
Message-ID: <20110127162623.GD2163@joana>
In-Reply-To: <1296140740-11486-4-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6793851196658679884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

* Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com> [2011-01-27 1=
6:05:39 +0100]:

> ---
>  Makefile.am         |    1 +
>  plugins/bluetooth.c |  340 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/bluetooth.h |    9 ++
>  3 files changed, 350 insertions(+), 0 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 9b77e63..c0efe28 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -318,6 +318,7 @@ builtin_sources +=3D plugins/bluetooth.c plugins/blue=
tooth.h
>  builtin_modules +=3D hfp
>  builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
>  =

> +builtin_sources +=3D $(btio_sources)
>  builtin_cflags +=3D @BLUEZ_CFLAGS@
>  builtin_libadd +=3D @BLUEZ_LIBS@
>  endif
> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 4da662a..86d4c25 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -35,18 +35,36 @@
>  =

>  #include <ofono/dbus.h>
>  =

> +#include <btio.h>
>  #include "bluetooth.h"
>  =

>  static DBusConnection *connection;
>  static GHashTable *uuid_hash =3D NULL;
>  static GSList *adapter_list =3D NULL;
>  static gint bluetooth_refcount;
> +static GSList *server_list =3D NULL;
>  =

>  struct adapter_address {
>  	char *adapter;
>  	char *address;
>  };
>  =

> +struct server {
> +	guint8 channel;
> +	char *sdp_record;
> +	GIOChannel *io;
> +	GHashTable *adapter_hash;
> +	ConnectFunc connect_cb;
> +	gpointer user_data;
> +	GSList *client_list;
> +};
> +
> +struct cb_data {
> +	struct server *server;
> +	char *path;
> +	guint source;
> +};
> +
>  void bluetooth_create_path(const char *dev_addr, const char *adapter_add=
r,
>  				char *buf, int size)
>  {
> @@ -429,6 +447,277 @@ static gboolean property_changed(DBusConnection *co=
nnection, DBusMessage *msg,
>  	return TRUE;
>  }
>  =

> +static void remove_record(char *path, guint handle, struct server *serve=
r)
> +{
> +	DBusMessage *msg;
> +
> +	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, path,
> +					BLUEZ_SERVICE_INTERFACE,
> +					"RemoveRecord");
> +	if (msg =3D=3D NULL) {
> +		ofono_error("Unable to allocate D-Bus RemoveRecord message");
> +		return;
> +	}
> +
> +	dbus_message_append_args(msg, DBUS_TYPE_UINT32, &handle,
> +					DBUS_TYPE_INVALID);
> +	g_dbus_send_message(connection, msg);
> +
> +	ofono_info("Unregistered handle for %s, channel %d: 0x%x", path,
> +			server->channel, handle);
> +}
> +
> +static void server_stop(struct server *server)
> +{
> +	while (server->client_list) {
> +		g_source_remove((guint) server->client_list->data);
> +		server->client_list =3D g_slist_remove(server->client_list,
> +						server->client_list->data);
> +	}
> +
> +	g_hash_table_foreach_remove(server->adapter_hash,
> +					(GHRFunc) remove_record, server);
> +
> +	if (server->io !=3D NULL) {
> +		g_io_channel_shutdown(server->io, TRUE, NULL);
> +		g_io_channel_unref(server->io);
> +		server->io =3D NULL;
> +	}
> +}
> +
> +static void cb_data_destroy(gpointer data)
> +{
> +	struct cb_data *cb_data =3D data;
> +
> +	if (cb_data->path !=3D NULL)
> +		g_free(cb_data->path);
> +	g_free(cb_data);
> +}
> +
> +static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpoint=
er data)
> +{
> +	struct cb_data *cb_data =3D data;
> +	struct server *server =3D cb_data->server;
> +
> +	server->client_list =3D g_slist_remove(server->client_list,
> +						(void *) cb_data->source);
> +
> +	cb_data_destroy(cb_data);
> +
> +	return FALSE;
> +}
> +
> +static void confirm_event(GIOChannel *io, gpointer user_data)
> +{
> +	struct server *server =3D user_data;
> +	struct cb_data *client_data;
> +	GError *err =3D NULL;
> +	char laddress[18], raddress[18];
> +	guint8 channel;
> +
> +	bt_io_get(io, BT_IO_RFCOMM, &err, BT_IO_OPT_SOURCE, laddress,
> +					BT_IO_OPT_DEST, raddress,
> +					BT_IO_OPT_CHANNEL, &channel,
> +					BT_IO_OPT_INVALID);
> +	if (err) {
> +		ofono_error("%s", err->message);
> +		g_error_free(err);
> +		return;
> +	}
> +
> +	ofono_info("New connection for %s on  channel %u from: %s,", laddress,
> +							channel, raddress);
> +
> +	if (!bt_io_accept(io, server->connect_cb, server->user_data,
> +						NULL, &err)) {
> +		ofono_error("%s", err->message);
> +		g_error_free(err);
> +		g_io_channel_unref(io);
> +		return;
> +	}
> +
> +	client_data =3D g_try_new0(struct cb_data, 1);
> +	if (client_data =3D=3D NULL) {
> +		ofono_error("Unable to allocate client cb_data structure");
> +		return;
> +	}
> +
> +	client_data->server =3D server;
> +	client_data->source =3D g_io_add_watch(io,
> +					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +					client_event, client_data);
> +	server->client_list =3D g_slist_prepend(server->client_list,
> +						(void *)client_data->source);
> +}
> +
> +static void add_record_cb(DBusPendingCall *call, gpointer user_data)
> +{
> +	struct cb_data *cb_data =3D user_data;
> +	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
> +	DBusError derr;
> +	guint32 handle;
> +
> +	dbus_error_init(&derr);
> +
> +	if (dbus_set_error_from_message(&derr, reply)) {
> +		ofono_error("Replied with an error: %s, %s",
> +					derr.name, derr.message);
> +		dbus_error_free(&derr);
> +		g_free(cb_data->path);
> +		goto done;
> +	}
> +
> +	dbus_message_get_args(reply, NULL, DBUS_TYPE_UINT32, &handle,
> +					DBUS_TYPE_INVALID);
> +
> +	g_hash_table_insert(cb_data->server->adapter_hash, cb_data->path,
> +				(void *) handle);
> +
> +	ofono_info("Registered handle for %s, channel %d: 0x%x", cb_data->path,
> +			cb_data->server->channel, handle);
> +
> +done:
> +	/* Do not free cb_data->path, it is used in adapter_hash */
> +	g_free(cb_data);
> +	dbus_message_unref(reply);
> +}
> +
> +static void server_adapter_properties_cb(DBusPendingCall *call,
> +						gpointer user_data)
> +{
> +	struct cb_data *cb_data =3D user_data;
> +	const char *path =3D cb_data->path;
> +	DBusMessage *reply;
> +	const char *addr;
> +	struct server *server =3D cb_data->server;
> +
> +	reply =3D dbus_pending_call_steal_reply(call);
> +
> +	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
> +		DBG("Bluetooth daemon is apparently not available.");
> +		goto done;
> +	}
> +
> +	bluetooth_parse_properties(reply, "Address", parse_string, &addr, NULL);
> +
> +	DBG("Adapter Address: %s, Path: %s", addr, path);
> +	adapter_list =3D adapter_address_add(adapter_list, path, addr);
> +
> +	DBG("Add record on %s", path);
> +
> +	bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE,
> +				"AddRecord", add_record_cb,
> +				cb_data, NULL, -1,
> +				DBUS_TYPE_STRING, &server->sdp_record,
> +				DBUS_TYPE_INVALID);
> +
> +done:
> +	dbus_message_unref(reply);
> +}
> +
> +static void server_parse_adapters(DBusMessageIter *array, gpointer user_=
data)
> +{
> +	struct server *server =3D user_data;
> +	DBusMessageIter value;
> +	struct cb_data *cb_data;
> +
> +	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
> +		return;
> +
> +	dbus_message_iter_recurse(array, &value);
> +
> +	while (dbus_message_iter_get_arg_type(&value)
> +			=3D=3D DBUS_TYPE_OBJECT_PATH) {
> +		const char *path;
> +
> +		dbus_message_iter_get_basic(&value, &path);
> +
> +		DBG("Calling GetProperties on %s", path);
> +
> +		cb_data =3D g_try_new0(struct cb_data, 1);
> +		if (cb_data =3D=3D NULL) {
> +			ofono_error("Unable to allocate cb_data structure");
> +			return;
> +		}
> +
> +		cb_data->server =3D server;
> +		cb_data->path =3D g_strdup(path);
> +
> +		bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
> +				"GetProperties", server_adapter_properties_cb,
> +				cb_data, NULL, -1, DBUS_TYPE_INVALID);
> +
> +		dbus_message_iter_next(&value);
> +	}
> +}
> +
> +static void server_manager_properties_cb(DBusPendingCall *call,
> +						gpointer user_data)
> +{
> +	DBusMessage *reply;
> +
> +	reply =3D dbus_pending_call_steal_reply(call);
> +
> +	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
> +		DBG("Bluetooth daemon is apparently not available.");
> +		goto done;
> +	}
> +
> +	bluetooth_parse_properties(reply, "Adapters", server_parse_adapters,
> +						user_data, NULL);
> +
> +done:
> +	dbus_message_unref(reply);
> +}

What's going on here? You are duplicating many line of codes that we already
have in bluetooth.c. Can't you just adapt the code we have there?

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============6793851196658679884==--

