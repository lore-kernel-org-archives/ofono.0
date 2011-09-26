Content-Type: multipart/mixed; boundary="===============0069454595350669301=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 06/23] sap: add watch for the Bluetooth Link
Date: Mon, 26 Sep 2011 14:26:59 -0300
Message-ID: <1317058036-32641-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317058036-32641-5-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0069454595350669301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++-=
---
 1 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 3151c4c..b620309 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -55,6 +55,8 @@ struct sap_data {
 	char *server_path;
 	struct ofono_modem *hw_modem;
 	struct bluetooth_sap_driver *sap_driver;
+	GIOChannel *bt_io;
+	guint bt_watch;
 };
 =

 int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
@@ -102,6 +104,33 @@ void bluetooth_sap_client_unregister(struct ofono_mode=
m *modem)
 	sap_hw_driver =3D NULL;
 }
 =

+static gboolean bt_event_cb(GIOChannel *bt_io, GIOCondition condition,
+							gpointer data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sap_data *sap_data =3D ofono_modem_get_data(modem);
+
+	if (condition & G_IO_IN) {
+		GIOStatus status;
+		gsize bytes_read;
+		gchar buf[300];
+
+		status =3D g_io_channel_read_chars(bt_io, buf, 300,
+							&bytes_read, NULL);
+
+		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
+			return FALSE;
+
+		return TRUE;
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	sap_data->bt_watch =3D 0;
+
+	return FALSE;
+}
+
 static int sap_probe(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
@@ -117,8 +146,10 @@ static void sap_remove(struct ofono_modem *modem)
 static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct sap_data *data =3D ofono_modem_get_data(modem);
 	DBusError derr;
-	DBusMessage *reply;
+	DBusMessage *reply, *msg;
+	int fd;
 =

 	DBG("");
 =

@@ -128,14 +159,44 @@ static void sap_connect_reply(DBusPendingCall *call, =
gpointer user_data)
 		goto done;
 =

 	dbus_error_init(&derr);
-	if (!dbus_set_error_from_message(&derr, reply))
+	if (dbus_set_error_from_message(&derr, reply)) {
+
+		DBG("Connect reply: %s", derr.message);
+
+		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
+			const char *str =3D "sap";
+
+			msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
+					data->server_path,
+					BLUEZ_SERIAL_INTERFACE, "Disconnect");
+			dbus_message_append_args(msg, DBUS_TYPE_STRING,
+					&str, DBUS_TYPE_INVALID);
+			if (msg =3D=3D NULL)
+				ofono_error("Disconnect failed");
+			else
+				g_dbus_send_message(connection, msg);
+		}
+
+		ofono_modem_set_powered(modem, FALSE);
+
+		dbus_error_free(&derr);
 		goto done;
+	}
+
+	if (!dbus_message_get_args(reply, NULL, DBUS_TYPE_UNIX_FD, &fd,
+				DBUS_TYPE_INVALID))
+		return;
 =

-	DBG("Connect reply: %s", derr.message);
+	data->bt_io =3D g_io_channel_unix_new(fd);
+	if (data->bt_io =3D=3D NULL)
+		return;
 =

-	ofono_modem_set_powered(modem, FALSE);
+	g_io_channel_set_encoding(data->bt_io, NULL, NULL);
+	g_io_channel_set_buffered(data->bt_io, FALSE);
+	g_io_channel_set_close_on_unref(data->bt_io, TRUE);
 =

-	dbus_error_free(&derr);
+	data->bt_watch =3D g_io_add_watch(data->bt_io, G_IO_HUP | G_IO_ERR
+				| G_IO_NVAL | G_IO_IN, bt_event_cb, modem);
 =

 done:
 	dbus_message_unref(reply);
@@ -152,7 +213,7 @@ static int sap_enable(struct ofono_modem *modem)
 =

 	status =3D bluetooth_send_with_reply(data->server_path,
 					BLUEZ_SERIAL_INTERFACE, "ConnectFD",
-					sap_connect_reply, modem, NULL,
+					NULL, sap_connect_reply, modem, NULL,
 					DBUS_TIMEOUT, DBUS_TYPE_STRING,
 					&str, DBUS_TYPE_INVALID);
 =

-- =

1.7.6.2


--===============0069454595350669301==--

