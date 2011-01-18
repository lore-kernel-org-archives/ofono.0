Content-Type: multipart/mixed; boundary="===============5291236018192945974=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] bluetooth: Add bluetooth server support (based on Zhenhua
 code)
Date: Tue, 18 Jan 2011 14:35:40 -0200
Message-ID: <20110118163540.GA20925@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5291236018192945974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<1295363736-7374-1-git-send-email-frederic.danis@linux.intel.com>

Hi Fr=C3=A9d=C3=A9ric,

* Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com> [2011-01-18 1=
6:15:36 +0100]:

> It watches Bluetooth adapter property changes and adds SDP record to
> listen client connection request (refactored to support both DUN and
> HFP GW servers).
> Add bluetooth_ref()/bluetooth_unref() to support reference count in
> bluetooth utils.

Move the "based on Zhenhua code" to the commit message please, like this.

Based on patches from: Zhenhua Zhang <zhenhua.zhang@intel.com>

> ---
>  Makefile.am         |    2 +-
>  plugins/bluetooth.c |  396 +++++++++++++++++++++++++++++++++++++++++++++=
+++--
>  plugins/bluetooth.h |   11 ++
>  3 files changed, 392 insertions(+), 17 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index da59be7..fb3f750 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -312,7 +312,7 @@ builtin_sources +=3D plugins/nokiacdma.c
>  =

>  if BLUETOOTH
>  builtin_modules +=3D bluetooth
> -builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
> +builtin_sources +=3D $(btio_sources) plugins/bluetooth.c plugins/bluetoo=
th.h
>  =

>  builtin_modules +=3D hfp
>  builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 602c6da..fd6f541 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -35,11 +35,34 @@
>  =

>  #include <ofono/dbus.h>
>  =

> +#include <btio.h>
>  #include "bluetooth.h"
>  =

>  static DBusConnection *connection;
>  static GHashTable *uuid_hash =3D NULL;
>  static GHashTable *adapter_address_hash =3D NULL;
> +static GSList *server_list =3D NULL;
> +static gint ref_count;
> +
> +#define TIMEOUT (60*1000) /* Timeout for user response (miliseconds) */
> +
> +struct client {
> +	GIOChannel	*io;
> +	guint		watch;
> +};
> +
> +struct server {
> +	gchar		*name;
> +	guint8		channel;
> +	gchar		*sdp_record;
> +	GIOChannel	*io;
> +	gchar		*adapter;
> +	guint		handle;
> +	ConnectFunc	connect_cb;
> +	gpointer	user_data;
> +
> +	struct client	client;
> +};
>  =

>  void bluetooth_create_path(const char *dev_addr, const char *adapter_add=
r,
>  				char *buf, int size)
> @@ -370,6 +393,246 @@ static gboolean property_changed(DBusConnection *co=
nnection, DBusMessage *msg,
>  	return TRUE;
>  }
>  =

> +static void disconnect(struct server *server)
> +{
> +	struct client *client =3D &server->client;
> +
> +	if (!client->io)
> +		return;
> +
> +	g_io_channel_unref(client->io);
> +	client->io =3D NULL;
> +
> +	if (client->watch > 0) {
> +		g_source_remove(client->watch);
> +		client->watch =3D 0;
> +	}
> +
> +	return;
> +}
> +
> +static void server_stop(gpointer data, gpointer user_data)
> +{
> +	struct server *server =3D data;
> +
> +	disconnect(server);
> +
> +	if (server->handle) {
> +		DBusMessage *msg;
> +
> +		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
> +						server->adapter,
> +						BLUEZ_SERVICE_INTERFACE,
> +						"RemoveRecord");
> +		dbus_message_append_args(msg, DBUS_TYPE_UINT32, &server->handle,
> +						DBUS_TYPE_INVALID);
> +		g_dbus_send_message(connection, msg);
> +
> +		server->handle =3D 0;
> +	}
> +
> +	if (server->io) {
> +		g_io_channel_shutdown(server->io, TRUE, NULL);
> +		g_io_channel_unref(server->io);
> +		server->io =3D NULL;
> +	}
> +
> +	g_free(server->adapter);
> +	server->adapter =3D NULL;
> +}
> +
> +static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpoint=
er data)
> +{
> +	struct server *server =3D data;
> +
> +	disconnect(server);
> +
> +	return FALSE;
> +}
> +
> +static void cancel_authorization(struct server *server)
> +{
> +	DBusMessage *msg;
> +
> +	if (!server->adapter)
> +		return;
> +
> +	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, server->adapter,
> +						BLUEZ_SERVICE_INTERFACE,
> +						"CancelAuthorization");
> +
> +	g_dbus_send_message(connection, msg);
> +}
> +
> +static void auth_cb(DBusPendingCall *call, gpointer user_data)
> +{
> +	struct server *server =3D user_data;
> +	struct client *client =3D &server->client;
> +	GIOChannel *io =3D client->io;
> +	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
> +	DBusError derr;
> +	GError *err =3D NULL;
> +
> +	dbus_error_init(&derr);
> +
> +	if (dbus_set_error_from_message(&derr, reply)) {
> +		ofono_error("RequestAuthorization error: %s, %s",
> +				derr.name, derr.message);
> +
> +		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
> +			cancel_authorization(server);
> +
> +		dbus_error_free(&derr);
> +		goto failed;
> +	}
> +
> +	ofono_info("RequestAuthorization succeeded");
> +
> +	if (!bt_io_accept(io, server->connect_cb, server->user_data,
> +						NULL, &err)) {
> +		ofono_error("%s", err->message);
> +		g_error_free(err);
> +		goto failed;
> +	}
> +
> +	g_source_remove(client->watch);
> +
> +	client->watch =3D g_io_add_watch(client->io,
> +					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +					client_event, server);
> +
> +	dbus_message_unref(reply);
> +
> +	return;
> +
> +failed:
> +	dbus_message_unref(reply);
> +	disconnect(server);
> +}
> +
> +static gboolean auth_watch(GIOChannel *io, GIOCondition cond,
> +						gpointer user_data)
> +{
> +	struct server *server =3D user_data;
> +
> +	cancel_authorization(server);
> +	disconnect(server);
> +
> +	return FALSE;
> +}
> +
> +static void confirm_event(GIOChannel *io, gpointer user_data)
> +{
> +	struct server *server =3D user_data;
> +	struct client *client =3D &server->client;
> +	GError *err =3D NULL;
> +	char address[18];
> +	const char *addr;
> +	guint8 channel;
> +	int ret;
> +
> +	if (client->io) {
> +		ofono_error("Rejecting connection since one client already \
> +				connected");
> +		return;
> +	}
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
> +	addr =3D address;
> +	ret =3D bluetooth_send_with_reply(server->adapter,
> +					BLUEZ_SERVICE_INTERFACE,
> +					"RequestAuthorization",
> +					auth_cb, server, NULL, TIMEOUT,
> +					DBUS_TYPE_STRING, &addr,
> +					DBUS_TYPE_UINT32, &server->handle,
> +					DBUS_TYPE_INVALID);
> +	if (ret < 0) {
> +		ofono_error("Request Bluetooth authorization failed");
> +		return;
> +	}
> +
> +	ofono_info("RequestAuthorization(%s, 0x%x)", address, server->handle);
> +
> +	client->io =3D g_io_channel_ref(io);
> +	client->watch =3D g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +					auth_watch, server);
> +
> +	return;
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
> +	ofono_info("Registered: %s, handle: 0x%x", server->name, handle);
> +
> +done:
> +	dbus_message_unref(reply);
> +}
> +
> +static void server_start(gpointer data, gpointer user_data)
> +{
> +	struct server *server =3D data;
> +	gchar *path =3D user_data;
> +	GError *err =3D NULL;
> +
> +	if (server->io !=3D NULL)
> +		return;
> +
> +	server->io =3D bt_io_listen(BT_IO_RFCOMM, NULL, confirm_event,
> +					server, NULL, &err,
> +					BT_IO_OPT_CHANNEL, server->channel,
> +					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> +					BT_IO_OPT_INVALID);

This does not work for a system with more than one bluetooth adapter, you h=
ave
to pass the bluetooth address of the device you want to listen for incoming
connections.

> +	if (server->io =3D=3D NULL) {
> +		ofono_error("Bluetooth %s register failed: %s",
> +					server->name, err->message);
> +		g_error_free(err);
> +		goto failed;
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
> +
> +	return;
> +
> +failed:
> +	server_stop(server, NULL);
> +}
> +
>  static void adapter_properties_cb(DBusPendingCall *call, gpointer user_d=
ata)
>  {
>  	const char *path =3D user_data;
> @@ -394,6 +657,9 @@ static void adapter_properties_cb(DBusPendingCall *ca=
ll, gpointer user_data)
>  	g_hash_table_insert(adapter_address_hash,
>  				g_strdup(path), g_strdup(addr));
>  =

> +	if (server_list)
> +		g_slist_foreach(server_list, server_start, (gpointer)path);
> +
>  	for (l =3D device_list; l; l =3D l->next) {
>  		const char *device =3D l->data;
>  =

> @@ -428,11 +694,26 @@ static gboolean adapter_removed(DBusConnection *con=
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
> +		if (!server->adapter)
> +			continue;
> +
> +		if (!g_str_equal(path, server->adapter))
> +			continue;
> +
> +		/* Don't remove handle if the adapter has been removed */
> +		server->handle =3D 0;
> +		server_stop(server, NULL);
> +	}
> +
>  	return TRUE;
>  }
>  =

> @@ -504,12 +785,14 @@ static guint adapter_added_watch;
>  static guint adapter_removed_watch;
>  static guint property_watch;
>  =

> -int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *=
profile)
> +static int bluetooth_ref()
>  {
>  	int err;
>  =

> -	if (uuid_hash)
> -		goto done;
> +	g_atomic_int_inc(&ref_count);
> +
> +	if (ref_count > 1)
> +		return 0;

Only increment the ref_count in the end of the function, if some error occu=
rs
and the function returns before complete all operations, the ref_count will=
 be
wrong.

>  =

>  	connection =3D ofono_dbus_get_connection();
>  =

> @@ -543,13 +826,6 @@ int bluetooth_register_uuid(const char *uuid, struct=
 bluetooth_profile *profile)
>  	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
>  						g_free, g_free);
>  =

> -done:
> -	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
> -
> -	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
> -				manager_properties_cb, NULL, NULL, -1,
> -				DBUS_TYPE_INVALID);
> -
>  	return 0;
>  =

>  remove:
> @@ -557,14 +833,18 @@ remove:
>  	g_dbus_remove_watch(connection, adapter_added_watch);
>  	g_dbus_remove_watch(connection, adapter_removed_watch);
>  	g_dbus_remove_watch(connection, property_watch);
> +
>  	return err;
>  }
>  =

> -void bluetooth_unregister_uuid(const char *uuid)
> +static void bluetooth_unref()
>  {
> -	g_hash_table_remove(uuid_hash, uuid);
> +	gboolean is_zero;
> +	GSList *l;
> +
> +	is_zero =3D g_atomic_int_dec_and_test(&ref_count);
>  =

> -	if (g_hash_table_size(uuid_hash))
> +	if (is_zero =3D=3D FALSE)
>  		return;
>  =

>  	g_dbus_remove_watch(connection, bluetooth_watch);
> @@ -572,9 +852,93 @@ void bluetooth_unregister_uuid(const char *uuid)
>  	g_dbus_remove_watch(connection, adapter_removed_watch);
>  	g_dbus_remove_watch(connection, property_watch);
>  =

> -	g_hash_table_destroy(uuid_hash);
> -	g_hash_table_destroy(adapter_address_hash);
> -	uuid_hash =3D NULL;
> +	if (uuid_hash) {
> +		g_hash_table_destroy(uuid_hash);
> +		uuid_hash =3D NULL;
> +	}
> +
> +	if (adapter_address_hash) {
> +		g_hash_table_destroy(adapter_address_hash);
> +		adapter_address_hash =3D NULL;
> +	}
> +
> +	if (server_list =3D=3D NULL)
> +		return;
> +
> +	for (l =3D server_list; l; l =3D l->next) {
> +		struct server *server =3D l->data;
> +
> +		server_stop(server, NULL);
> +		g_free(server->name);
> +		g_free(server);
> +	}
> +
> +	g_slist_free(server_list);
> +	server_list =3D NULL;
> +}
> +
> +int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *=
profile)
> +{
> +	int err =3D bluetooth_ref();;
> +
> +	if (err !=3D 0)
> +		return err;
> +
> +	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
> +
> +	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
> +				manager_properties_cb, NULL, NULL, -1,
> +				DBUS_TYPE_INVALID);
> +
> +	return 0;
> +}
> +
> +void bluetooth_unregister_uuid(const char *uuid)
> +{
> +	g_hash_table_remove(uuid_hash, uuid);
> +
> +	bluetooth_unref();
> +}
> +
> +struct server *bluetooth_register_rfcomm_server(char *name, guint8 chann=
el,
> +					const char *sdp_record, ConnectFunc cb,
> +					gpointer user_data)

And I think we can call this just bluetooth_register_server()

> +{
> +	struct server *server;
> +	int err =3D bluetooth_ref();

Same here, call bluetooth_ref() in the end of the function.

> +
> +	if (err !=3D 0)
> +		return NULL;
> +
> +	server =3D g_try_new0(struct server, 1);
> +	if (!server)
> +		return NULL;
> +
> +	server->name =3D g_strdup(name);
> +	server->channel =3D channel;
> +	if (sdp_record !=3D NULL)
> +		server->sdp_record =3D g_strdup(sdp_record);
> +	server->connect_cb =3D cb;
> +	server->user_data =3D user_data;
> +
> +	server_list =3D g_slist_prepend(server_list, server);
> +
> +	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
> +					manager_properties_cb, NULL, NULL, -1,
> +					DBUS_TYPE_INVALID);
> +
> +	return server;
> +}
> +
> +void bluetooth_unregister_rfcomm_server(struct server *server)
> +{
> +	server_list =3D g_slist_remove(server_list, server);
> +	server_stop(server, NULL);
> +	g_free(server->name);
> +	g_free(server->sdp_record);
> +	g_free(server);
> +
> +	bluetooth_unref();
>  }
>  =

>  OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
> diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
> index 42b0d13..c0df13f 100644
> --- a/plugins/bluetooth.h
> +++ b/plugins/bluetooth.h
> @@ -3,6 +3,7 @@
>   *  oFono - Open Source Telephony
>   *
>   *  Copyright (C) 2010 Gustavo F. Padovan <gustavo@padovan.org>
> + *  Copyright (C) 2010 Intel Corporation. All rights reserved.
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2 as
> @@ -23,6 +24,7 @@
>  #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
>  #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
>  #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
> +#define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
>  =

>  #define DBUS_TIMEOUT 15
>  =

> @@ -39,10 +41,19 @@ struct bluetooth_profile {
>  	void (*set_alias)(const char *device, const char *);
>  };
>  =

> +struct server;
> +
> +typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_d=
ata);
> +
>  int bluetooth_register_uuid(const char *uuid,
>  				struct bluetooth_profile *profile);
>  void bluetooth_unregister_uuid(const char *uuid);
>  =

> +struct server *bluetooth_register_rfcomm_server(char *name, guint8 chann=
el,
> +					const char *sdp_record, ConnectFunc cb,
> +					gpointer user_data);
> +void bluetooth_unregister_rfcomm_server(struct server *server);
> +
>  void bluetooth_create_path(const char *dev_addr, const char *adapter_add=
r,
>  							char *buf, int size);


I understand this as a temporary solution to how oFono access Bluetooth. A =
new
DBUS api to listen for incoming connection in a specific channel and that a=
lso
adds the SDP record automatically when listening would be better. oFono will
just receive the fd in the end and won't have to bother with Bluetooth
specific stuff, like Authorization or even having btio in it sources.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============5291236018192945974==--

