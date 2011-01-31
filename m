Content-Type: multipart/mixed; boundary="===============5135086813358256404=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 3/8] bluetooth: add Request auth code for new connections
Date: Mon, 31 Jan 2011 18:51:57 -0200
Message-ID: <1296507122-10936-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296507122-10936-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5135086813358256404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now a RFCOMM incoming connection can be made, all the pieces are here.
---
 plugins/bluetooth.c |  123 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 122 insertions(+), 1 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 0b5a021..f3b9140 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -90,6 +90,9 @@ struct server {
 	guint		handle;
 	ConnectFunc	connect_cb;
 	gpointer	user_data;
+	gboolean	pending_auth;
+	GIOChannel	*client_io;
+	guint		client_watch;
 };
 =

 typedef struct {
@@ -453,10 +456,25 @@ static gboolean property_changed(DBusConnection *conn=
ection, DBusMessage *msg,
 	return TRUE;
 }
 =

+static void disconnect(struct server *server)
+{
+	if (server->client_io =3D=3D NULL)
+		return;
+
+	server->client_io =3D NULL;
+
+	if (server->client_watch > 0) {
+		g_source_remove(server->client_watch);
+		server->client_watch =3D 0;
+	}
+}
+
 static void server_stop(gpointer data)
 {
 	struct server *server =3D data;
 =

+	disconnect(server);
+
 	if (server->handle > 0) {
 		DBusMessage *msg;
 =

@@ -481,11 +499,114 @@ static void server_stop(gpointer data)
 	server->adapter =3D NULL;
 }
 =

+static void cancel_authorization(struct server *server)
+{
+	DBusMessage *msg;
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, server->adapter,
+			BLUEZ_SERVICE_INTERFACE, "CancelAuthorization");
+	if (!msg)
+		return;
+
+	g_dbus_send_message(connection, msg);
+}
+
+static void auth_cb(DBusPendingCall *call, gpointer user_data)
+{
+	struct server *server =3D user_data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
+	GError *err =3D NULL;
+
+	dbus_error_init(&derr);
+
+	server->pending_auth =3D FALSE;
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("RequestAuthorization error: %s, %s",
+				derr.name, derr.message);
+
+		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
+			cancel_authorization(server);
+
+		dbus_error_free(&derr);
+		goto failed;
+	}
+
+	ofono_info("RequestAuthorization() succeeded");
+
+	if (!bt_io_accept(server->client_io, server->connect_cb,
+					server->user_data, NULL, &err)) {
+		ofono_error("%s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+	return;
+
+failed:
+	dbus_message_unref(reply);
+	disconnect(server);
+}
+
+static gboolean client_event(GIOChannel *io, GIOCondition cond,
+						gpointer user_data)
+{
+	struct server *server =3D user_data;
+
+	if (server->pending_auth =3D=3D TRUE)
+		cancel_authorization(server);
+
+	server->pending_auth =3D FALSE;
+
+	disconnect(server);
+
+	return FALSE;
+}
+
 static void new_connection(GIOChannel *io, gpointer user_data)
 {
 	struct server *server =3D user_data;
+	GError *err =3D NULL;
+	char address[18];
+	const char *addr;
+	guint8 channel;
+	int ret;
+
+	if (server->client_watch !=3D 0) {
+		ofono_info("Client already connected");
+		return;
+	}
+
+	bt_io_get(io, BT_IO_RFCOMM, &err, BT_IO_OPT_DEST, address,
+					BT_IO_OPT_CHANNEL, &channel,
+					BT_IO_OPT_INVALID);
+	if (err) {
+		ofono_error("%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	ofono_info("New connection from: %s, channel %u", address, channel);
+
+	addr =3D address;
+	ret =3D bluetooth_send_with_reply(server->adapter,
+					BLUEZ_SERVICE_INTERFACE,
+					"RequestAuthorization",
+					auth_cb, server, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &addr,
+					DBUS_TYPE_UINT32, &server->handle,
+					DBUS_TYPE_INVALID);
+	if (ret < 0) {
+		ofono_error("RequestAuthorization() failed");
+		return;
+	}
+
+	server->client_io =3D io;
+	server->client_watch =3D g_io_add_watch(server->client_io,
+					G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+					client_event, server);
 =

-	DBG("%p", server);
+	server->pending_auth =3D TRUE;
 }
 =

 static void add_record_cb(DBusPendingCall *call, gpointer user_data)
-- =

1.7.4.rc3


--===============5135086813358256404==--

