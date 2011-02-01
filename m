Content-Type: multipart/mixed; boundary="===============0522138024836145944=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH 1/8] bluetooth: add server support
Date: Tue, 01 Feb 2011 15:17:56 +0100
Message-ID: <4D481614.5090305@linux.intel.com>
In-Reply-To: <1296507122-10936-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0522138024836145944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Gustavo,

Le 31/01/2011 21:51, Gustavo F. Padovan a =C3=A9crit :
> Initial code to have support to listen over a RFCOMM socket for incoming
> connections.
> ---
>   Makefile.am         |    1 +
>   plugins/bluetooth.c |  165 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   plugins/bluetooth.h |   11 ++++
>   3 files changed, 177 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index a38fcb9..77b1453 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -321,6 +321,7 @@ builtin_sources +=3D plugins/bluetooth.c plugins/blue=
tooth.h
>   builtin_modules +=3D hfp
>   builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
>
> +builtin_sources +=3D $(btio_sources)
>   builtin_cflags +=3D @BLUEZ_CFLAGS@
>   builtin_libadd +=3D @BLUEZ_LIBS@
>   endif
> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 93dd7a1..dcf75e6 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -35,13 +35,58 @@
>
>   #include<ofono/dbus.h>
>
> +#include<btio.h>
>   #include "bluetooth.h"
>
>   static DBusConnection *connection;
>   static GHashTable *uuid_hash =3D NULL;
>   static GHashTable *adapter_address_hash =3D NULL;
> +static GSList *server_list =3D NULL;
>   static gint bluetooth_refcount;
>
> +struct server {
> +	guint16		service;
> +	gchar		*name;
> +	guint8		channel;
> +	GIOChannel	*io;
> +	char		*adapter;
> +	guint		handle;
> +	ConnectFunc	connect_cb;
> +	gpointer	user_data;
> +};
> +
> +typedef struct {
> +	guint8 b[6];
> +} __attribute__((packed)) bdaddr_t;
> +
> +static void baswap(bdaddr_t *dst, const bdaddr_t *src)
> +{
> +	register unsigned char *d =3D (unsigned char *) dst;
> +	register const unsigned char *s =3D (const unsigned char *) src;
> +	register int i;
> +
> +	for (i =3D 0; i<  6; i++)
> +		d[i] =3D s[5-i];
> +}
> +
> +static int str2ba(const char *str, bdaddr_t *ba)
> +{
> +	guint8 b[6];
> +	const char *ptr =3D str;
> +	int i;
> +
> +	for (i =3D 0; i<  6; i++) {
> +		b[i] =3D (guint8) strtol(ptr, NULL, 16);
> +		if (i !=3D 5&&  !(ptr =3D strchr(ptr, ':')))
> +			ptr =3D ":00:00:00:00:00";
> +		ptr++;
> +	}
> +
> +	baswap(ba, (bdaddr_t *) b);
> +
> +	return 0;
> +}
> +
>   void bluetooth_create_path(const char *dev_addr, const char *adapter_ad=
dr,
>   				char *buf, int size)
>   {
> @@ -371,6 +416,70 @@ static gboolean property_changed(DBusConnection *con=
nection, DBusMessage *msg,
>   	return TRUE;
>   }
>
> +static void server_stop(gpointer data)
> +{
> +	struct server *server =3D data;
> +
> +	if (server->handle>  0) {
> +		DBusMessage *msg;
> +
> +		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
> +						server->adapter,
> +						BLUEZ_SERVICE_INTERFACE,
> +						"RemoveRecord");
> +		dbus_message_append_args(msg, DBUS_TYPE_UINT32,&server->handle,
> +						DBUS_TYPE_INVALID);
> +		g_dbus_send_message(connection, msg);
> +
> +		server->handle =3D 0;
> +	}
> +
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
> +static void new_connection(GIOChannel *io, gpointer user_data)
> +{
> +	struct server *server =3D user_data;
> +
> +	DBG("%p", server);
> +}
> +
> +static void server_start(gpointer data, gpointer user_data)
> +{
> +	struct server *server =3D data;
> +	char *addr, *path =3D user_data;
> +	bdaddr_t baddr;
> +	GError *err =3D NULL;
> +
> +	if (server->handle !=3D 0)
> +		return;
> +
> +	addr =3D g_hash_table_lookup(adapter_address_hash, path);
> +	str2ba(addr,&baddr);
> +	server->io =3D bt_io_listen(BT_IO_RFCOMM, NULL, new_connection,
> +					server, NULL,&err,
> +					BT_IO_OPT_SOURCE_BDADDR,&baddr,
> +					BT_IO_OPT_CHANNEL, server->channel,
> +					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> +					BT_IO_OPT_INVALID);
> +	if (server->io =3D=3D NULL) {
> +		ofono_error("Bluetooth %s register failed: %s",
> +					server->name, err->message);
> +		g_error_free(err);
> +		server_stop(server);
> +		return;
> +	}
> +
> +	server->adapter =3D g_strdup(path);
> +}
> +
This will not allows to start server on multiple adapters, as the test =

of the SDP Record handle will prevent to bt_io_listen on other adapters.

I do not understand why you pass the adapter address, if it is omitted =

the bt_io_listen will be done for all adapters.

>   static void adapter_properties_cb(DBusPendingCall *call, gpointer user_=
data)
>   {
>   	const char *path =3D user_data;
> @@ -395,6 +504,9 @@ static void adapter_properties_cb(DBusPendingCall *ca=
ll, gpointer user_data)
>   	g_hash_table_insert(adapter_address_hash,
>   				g_strdup(path), g_strdup(addr));
>
> +	if (server_list)
> +		g_slist_foreach(server_list, server_start, (gpointer)path);
> +
>   	for (l =3D device_list; l; l =3D l->next) {
>   		const char *device =3D l->data;
>
> @@ -429,11 +541,26 @@ static gboolean adapter_removed(DBusConnection *con=
nection,
>   				DBusMessage *message, void *user_data)
>   {
>   	const char *path;
> +	GSList *l;
>
>   	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH,&path,
>   				DBUS_TYPE_INVALID) =3D=3D TRUE)
>   		g_hash_table_remove(adapter_address_hash, path);
>
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
> +		server_stop(server);
> +	}
> +
>   	return TRUE;
>   }
>
> @@ -590,5 +717,43 @@ void bluetooth_unregister_uuid(const char *uuid)
>   	bluetooth_unref();
>   }
>
> +struct server *bluetooth_register_server(guint16 service, char *name,
> +						guint8 channel, ConnectFunc cb,
> +						gpointer user_data)
> +{
> +	struct server *server;
> +
> +	server =3D g_try_new0(struct server, 1);
> +	if (!server)
> +		return NULL;
> +
> +	bluetooth_ref();
> +
> +	server->service =3D service;
> +	server->name =3D g_strdup(name);
> +	server->channel =3D channel;
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
> +void bluetooth_unregister_server(struct server *server)
> +{
> +	server_list =3D g_slist_remove(server_list, server);
> +
> +	server_stop(server);
> +	g_free(server->name);
> +	g_free(server);
> +
> +	bluetooth_unref();
> +}
> +
>   OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
>   			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
> diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
> index 42b0d13..f6fc6a6 100644
> --- a/plugins/bluetooth.h
> +++ b/plugins/bluetooth.h
> @@ -23,6 +23,7 @@
>   #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
>   #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
>   #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
> +#define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
>
>   #define DBUS_TIMEOUT 15
>
> @@ -39,10 +40,20 @@ struct bluetooth_profile {
>   	void (*set_alias)(const char *device, const char *);
>   };
>
> +
> +typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_d=
ata);
> +
> +struct server;
> +
>   int bluetooth_register_uuid(const char *uuid,
>   				struct bluetooth_profile *profile);
>   void bluetooth_unregister_uuid(const char *uuid);
>
> +struct server *bluetooth_register_server(guint16 service, char *name,
> +						guint8 channel, ConnectFunc cb,
> +						gpointer user_data);
> +void bluetooth_unregister_server(struct server *server);
> +
>   void bluetooth_create_path(const char *dev_addr, const char *adapter_ad=
dr,
>   							char *buf, int size);
>


-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============0522138024836145944==--

