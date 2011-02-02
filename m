Content-Type: multipart/mixed; boundary="===============0749127784878626185=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 1/8] bluetooth: add server support
Date: Wed, 02 Feb 2011 16:21:38 -0200
Message-ID: <20110202182138.GK2273@joana>
In-Reply-To: <4D481614.5090305@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0749127784878626185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

* Frederic Danis <frederic.danis@linux.intel.com> [2011-02-01 15:17:56 +0=
100]:

> Hello Gustavo,
> =

> Le 31/01/2011 21:51, Gustavo F. Padovan a =C3=A9crit :
> > Initial code to have support to listen over a RFCOMM socket for incoming
> > connections.
> > ---
> >   Makefile.am         |    1 +
> >   plugins/bluetooth.c |  165 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   plugins/bluetooth.h |   11 ++++
> >   3 files changed, 177 insertions(+), 0 deletions(-)
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index a38fcb9..77b1453 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -321,6 +321,7 @@ builtin_sources +=3D plugins/bluetooth.c plugins/bl=
uetooth.h
> >   builtin_modules +=3D hfp
> >   builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
> >
> > +builtin_sources +=3D $(btio_sources)
> >   builtin_cflags +=3D @BLUEZ_CFLAGS@
> >   builtin_libadd +=3D @BLUEZ_LIBS@
> >   endif
> > diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> > index 93dd7a1..dcf75e6 100644
> > --- a/plugins/bluetooth.c
> > +++ b/plugins/bluetooth.c
> > @@ -35,13 +35,58 @@
> >
> >   #include<ofono/dbus.h>
> >
> > +#include<btio.h>
> >   #include "bluetooth.h"
> >
> >   static DBusConnection *connection;
> >   static GHashTable *uuid_hash =3D NULL;
> >   static GHashTable *adapter_address_hash =3D NULL;
> > +static GSList *server_list =3D NULL;
> >   static gint bluetooth_refcount;
> >
> > +struct server {
> > +	guint16		service;
> > +	gchar		*name;
> > +	guint8		channel;
> > +	GIOChannel	*io;
> > +	char		*adapter;
> > +	guint		handle;
> > +	ConnectFunc	connect_cb;
> > +	gpointer	user_data;
> > +};
> > +
> > +typedef struct {
> > +	guint8 b[6];
> > +} __attribute__((packed)) bdaddr_t;
> > +
> > +static void baswap(bdaddr_t *dst, const bdaddr_t *src)
> > +{
> > +	register unsigned char *d =3D (unsigned char *) dst;
> > +	register const unsigned char *s =3D (const unsigned char *) src;
> > +	register int i;
> > +
> > +	for (i =3D 0; i<  6; i++)
> > +		d[i] =3D s[5-i];
> > +}
> > +
> > +static int str2ba(const char *str, bdaddr_t *ba)
> > +{
> > +	guint8 b[6];
> > +	const char *ptr =3D str;
> > +	int i;
> > +
> > +	for (i =3D 0; i<  6; i++) {
> > +		b[i] =3D (guint8) strtol(ptr, NULL, 16);
> > +		if (i !=3D 5&&  !(ptr =3D strchr(ptr, ':')))
> > +			ptr =3D ":00:00:00:00:00";
> > +		ptr++;
> > +	}
> > +
> > +	baswap(ba, (bdaddr_t *) b);
> > +
> > +	return 0;
> > +}
> > +
> >   void bluetooth_create_path(const char *dev_addr, const char *adapter_=
addr,
> >   				char *buf, int size)
> >   {
> > @@ -371,6 +416,70 @@ static gboolean property_changed(DBusConnection *c=
onnection, DBusMessage *msg,
> >   	return TRUE;
> >   }
> >
> > +static void server_stop(gpointer data)
> > +{
> > +	struct server *server =3D data;
> > +
> > +	if (server->handle>  0) {
> > +		DBusMessage *msg;
> > +
> > +		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
> > +						server->adapter,
> > +						BLUEZ_SERVICE_INTERFACE,
> > +						"RemoveRecord");
> > +		dbus_message_append_args(msg, DBUS_TYPE_UINT32,&server->handle,
> > +						DBUS_TYPE_INVALID);
> > +		g_dbus_send_message(connection, msg);
> > +
> > +		server->handle =3D 0;
> > +	}
> > +
> > +	if (server->io !=3D NULL) {
> > +		g_io_channel_shutdown(server->io, TRUE, NULL);
> > +		g_io_channel_unref(server->io);
> > +		server->io =3D NULL;
> > +	}
> > +
> > +	g_free(server->adapter);
> > +	server->adapter =3D NULL;
> > +}
> > +
> > +static void new_connection(GIOChannel *io, gpointer user_data)
> > +{
> > +	struct server *server =3D user_data;
> > +
> > +	DBG("%p", server);
> > +}
> > +
> > +static void server_start(gpointer data, gpointer user_data)
> > +{
> > +	struct server *server =3D data;
> > +	char *addr, *path =3D user_data;
> > +	bdaddr_t baddr;
> > +	GError *err =3D NULL;
> > +
> > +	if (server->handle !=3D 0)
> > +		return;
> > +
> > +	addr =3D g_hash_table_lookup(adapter_address_hash, path);
> > +	str2ba(addr,&baddr);
> > +	server->io =3D bt_io_listen(BT_IO_RFCOMM, NULL, new_connection,
> > +					server, NULL,&err,
> > +					BT_IO_OPT_SOURCE_BDADDR,&baddr,
> > +					BT_IO_OPT_CHANNEL, server->channel,
> > +					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> > +					BT_IO_OPT_INVALID);
> > +	if (server->io =3D=3D NULL) {
> > +		ofono_error("Bluetooth %s register failed: %s",
> > +					server->name, err->message);
> > +		g_error_free(err);
> > +		server_stop(server);
> > +		return;
> > +	}
> > +
> > +	server->adapter =3D g_strdup(path);
> > +}
> > +
> This will not allows to start server on multiple adapters, as the test =

> of the SDP Record handle will prevent to bt_io_listen on other adapters.

Yes, it will. The SDP record is per adapter, so I call bt_io_listen on that
adapter and and add the SDP record to the adapter records. The code does th=
at
for all adapters.

> =

> I do not understand why you pass the adapter address, if it is omitted =

> the bt_io_listen will be done for all adapters.

See above.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============0749127784878626185==--

