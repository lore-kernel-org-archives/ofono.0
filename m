Content-Type: multipart/mixed; boundary="===============8703021382332924476=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] bluetooth: Add bluetooth server support
Date: Fri, 21 Jan 2011 19:15:16 -0200
Message-ID: <20110121211516.GH2400@joana>
In-Reply-To: <1295622461-11228-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8703021382332924476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

* Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com> [2011-01-21 1=
6:07:41 +0100]:

> Based on patches from: Zhenhua Zhang <zhenhua.zhang@intel.com>
> =

> It watches Bluetooth adapter property changes and adds SDP record to
> listen client connection request.
> It supports multiple servers and multiple client connections for each
> server.
> ---
> Authorization code will be added in next patch

You can send all patches together, review goes faster this way. ;)

> =

>  Makefile.am         |    1 +
>  plugins/bluetooth.c |  247 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/bluetooth.h |    9 ++
>  3 files changed, 257 insertions(+), 0 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 9933e32..abd5d11 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -317,6 +317,7 @@ builtin_sources +=3D plugins/bluetooth.c plugins/blue=
tooth.h
>  builtin_modules +=3D hfp
>  builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
>  =

> +builtin_sources +=3D $(btio_sources)
>  builtin_cflags +=3D @BLUEZ_CFLAGS@
>  builtin_libadd +=3D @BLUEZ_LIBS@
>  endif
> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 93dd7a1..56e22c6 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -35,12 +35,30 @@
>  =

>  #include <ofono/dbus.h>
>  =

> +#include <btio.h>
>  #include "bluetooth.h"
>  =

>  static DBusConnection *connection;
>  static GHashTable *uuid_hash =3D NULL;
>  static GHashTable *adapter_address_hash =3D NULL;
>  static gint bluetooth_refcount;
> +static GSList *server_list =3D NULL;
> +
> +struct server {
> +	guint8		channel;
> +	char		*sdp_record;
> +	GIOChannel	*io;
> +	char		*adapter;
> +	guint		handle;
> +	ConnectFunc	connect_cb;
> +	gpointer	user_data;
> +	GSList		*client_list;
> +};
> +
> +struct client_data {
> +	struct server *server;
> +	guint source;
> +};
>  =

>  void bluetooth_create_path(const char *dev_addr, const char *adapter_add=
r,
>  				char *buf, int size)
> @@ -371,6 +389,161 @@ static gboolean property_changed(DBusConnection *co=
nnection, DBusMessage *msg,
>  	return TRUE;
>  }
>  =

> +static void server_stop(gpointer data, gpointer user_data)
> +{
> +	struct server *server =3D data;
> +	DBusMessage *msg;
> +
> +	/* calling g_source_remove will also remove it from client list */
> +	while (server->client_list)
> +		g_source_remove((guint) server->client_list->data);
> +
> +	if (server->handle =3D=3D 0)
> +		goto out;
> +
> +	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, server->adapter,
> +					BLUEZ_SERVICE_INTERFACE,
> +					"RemoveRecord");
> +	if (msg =3D=3D NULL) {
> +		ofono_error("Unable to allocate D-Bus RemoveRecord message");
> +		goto out;
> +	}
> +
> +	dbus_message_append_args(msg, DBUS_TYPE_UINT32, &server->handle,
> +					DBUS_TYPE_INVALID);
> +	g_dbus_send_message(connection, msg);
> +
> +	server->handle =3D 0;
> +
> +out:
> +	if (server->io !=3D NULL) {
> +		g_io_channel_shutdown(server->io, TRUE, NULL);
> +		g_io_channel_unref(server->io);
> +		server->io =3D NULL;
> +	}
> +
> +	g_free(server->adapter);
> +	server->adapter =3D NULL;
> +}
> +
> +static void client_remove(struct client_data *cl)
> +{
> +	cl->server->client_list =3D g_slist_remove(cl->server->client_list,
> +						(void *) cl->source);
> +	g_free(cl);
> +}
> +
> +static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpoint=
er data)
> +{
> +	return FALSE;

What is that function for?

> +}
> +
> +static void confirm_event(GIOChannel *io, gpointer user_data)
> +{
> +	struct server *server =3D user_data;
> +	GError *err =3D NULL;
> +	char address[18];
> +	guint8 channel;
> +	struct client_data *cl;
> +
> +	bt_io_get(io, BT_IO_RFCOMM, &err, BT_IO_OPT_DEST, address,
> +					BT_IO_OPT_CHANNEL, &channel,
> +					BT_IO_OPT_INVALID);
> +	if (err) {
> +		ofono_error("%s", err->message);
> +		g_error_free(err);
> +		return;
> +	}
> +
> +	ofono_info("New connection from: %s, channel %u", address, channel);
> +
> +	if (!bt_io_accept(io, server->connect_cb, server->user_data,
> +						NULL, &err)) {
> +		ofono_error("%s", err->message);
> +		g_error_free(err);
> +		g_io_channel_unref(io);
> +		return;
> +	}
> +
> +	cl =3D g_try_new0(struct client_data, 1);
> +	if (cl =3D=3D NULL) {
> +		ofono_error("Unable to allocate new client event structure");
> +		return;
> +	}
> +
> +	cl->server =3D server;
> +	cl->source =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
> +					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +					client_event, cl,
> +					(GDestroyNotify) client_remove);
> +	server->client_list =3D g_slist_prepend(server->client_list,
> +						(void *)cl->source);
> +}
> +
> +static void add_record_cb(DBusPendingCall *call, gpointer user_data)
> +{
> +	struct server *server =3D user_data;
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
> +		server_stop(server, NULL);
> +		goto done;
> +	}
> +
> +	dbus_message_get_args(reply, NULL, DBUS_TYPE_UINT32, &handle,
> +					DBUS_TYPE_INVALID);
> +	server->handle =3D handle;
> +
> +	ofono_info("Registered handle: 0x%x for channel %d", handle,
> +			server->channel);

Can we also have the adapter path or address in the ofono_info?

> +
> +done:
> +	dbus_message_unref(reply);
> +}
> +
> +static void server_start(gpointer data, gpointer user_data)
> +{
> +	struct server *server =3D data;
> +	char *path =3D user_data;
> +	char *adapter_addr;
> +	GError *err =3D NULL;
> +
> +	if (server->io !=3D NULL)
> +		return;
> +
> +	adapter_addr =3D g_hash_table_lookup(adapter_address_hash, path);
> +
> +	server->io =3D bt_io_listen(BT_IO_RFCOMM, NULL, confirm_event,
> +					server, NULL, &err,
> +					BT_IO_OPT_SOURCE, adapter_addr,
> +					BT_IO_OPT_CHANNEL, server->channel,
> +					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> +					BT_IO_OPT_INVALID);
> +	if (server->io =3D=3D NULL) {
> +		ofono_error("Bluetooth channel %d register failed: %s",
> +					server->channel, err->message);
> +		g_error_free(err);
> +		server_stop(server, NULL);
> +		return;
> +	}
> +
> +	server->adapter =3D g_strdup(path);
> +
> +	if (server->sdp_record !=3D NULL)
> +		bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE,
> +					"AddRecord", add_record_cb,
> +					server, NULL, -1,
> +					DBUS_TYPE_STRING, &server->sdp_record,
> +					DBUS_TYPE_INVALID);
> +}
> +
>  static void adapter_properties_cb(DBusPendingCall *call, gpointer user_d=
ata)
>  {
>  	const char *path =3D user_data;
> @@ -395,6 +568,9 @@ static void adapter_properties_cb(DBusPendingCall *ca=
ll, gpointer user_data)
>  	g_hash_table_insert(adapter_address_hash,
>  				g_strdup(path), g_strdup(addr));
>  =

> +	if (server_list)
> +		g_slist_foreach(server_list, server_start, (gpointer)path);
> +

I don't if you fixed that, but in the original Zhenhua patches have the ser=
ver
started when I plug a new dongle with oFono running is not working for me.

>  	for (l =3D device_list; l; l =3D l->next) {
>  		const char *device =3D l->data;
>  =

> @@ -429,11 +605,26 @@ static gboolean adapter_removed(DBusConnection *con=
nection,
>  				DBusMessage *message, void *user_data)
>  {
>  	const char *path;
> +	GSList *l;
>  =

>  	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
>  				DBUS_TYPE_INVALID) =3D=3D TRUE)
>  		g_hash_table_remove(adapter_address_hash, path);
>  =

> +	for (l =3D server_list; l; l =3D l->next) {
> +		struct server *server =3D l->data;
> +
> +		if (server->adapter =3D=3D NULL)
> +			continue;

I really don't know why the adapter could be NULL here.

> +
> +		if (g_str_equal(path, server->adapter) =3D=3D FALSE)
> +			continue;
> +
> +		/* Don't remove handle if the adapter has been removed */

/* Handle have already been removed, so setting to 0 */   is better.

> +		server->handle =3D 0;
> +		server_stop(server, NULL);
> +	}
> +
>  	return TRUE;
>  }
>  =

> @@ -555,6 +746,8 @@ remove:
>  =

>  static void bluetooth_unref(void)
>  {
> +	GSList *l;
> +
>  	if (g_atomic_int_dec_and_test(&bluetooth_refcount) =3D=3D FALSE)
>  		return;
>  =

> @@ -565,6 +758,19 @@ static void bluetooth_unref(void)
>  =

>  	g_hash_table_destroy(uuid_hash);
>  	g_hash_table_destroy(adapter_address_hash);
> +
> +	if (server_list =3D=3D NULL)
> +		return;

Do we really need this check?

> +
> +	for (l =3D server_list; l; l =3D l->next) {
> +		struct server *server =3D l->data;
> +
> +		server_stop(server, NULL);
> +		g_free(server);

This server_stop and g_free alreadand server_list will be NULL already.serv=
er()
is called, so why do you need to run this 'for' here. You can trust
that the server is already freed and server_list will be NULL already.

You were leaking sdp_record here, btw.

> +	}
> +
> +	g_slist_free(server_list);
> +	server_list =3D NULL;
>  }
>  =

>  int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *=
profile)
> @@ -590,5 +796,46 @@ void bluetooth_unregister_uuid(const char *uuid)
>  	bluetooth_unref();
>  }
>  =

> +struct server *bluetooth_register_server(guint8 channel, const char *sdp=
_record,
> +					ConnectFunc cb, gpointer user_data)
> +{
> +	struct server *server;
> +
> +	server =3D g_try_new0(struct server, 1);
> +	if (!server)
> +		return NULL;
> +
> +	bluetooth_ref();
> +
> +	if (bluetooth_refcount =3D=3D 0) {
> +		g_free(server);
> +		return NULL;
> +	}

You can't have this check here. bluetooth_refcount can only be read/write by
bluetooth_ref/unref.


-- =

Gustavo F. Padovan
http://profusion.mobi

--===============8703021382332924476==--

