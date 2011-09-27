Content-Type: multipart/mixed; boundary="===============1248843180904834466=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 02/21] sap: add watch for the Bluetooth Link
Date: Tue, 27 Sep 2011 18:04:01 -0300
Message-ID: <1317157460-17012-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1248843180904834466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
---
 1 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 169bb7f..004d225 100644
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
@@ -100,6 +102,36 @@ void bluetooth_sap_client_unregister(struct ofono_mode=
m *modem)
 	sap_hw_driver =3D NULL;
 }
 =

+static void bt_watch_remove(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	data->bt_watch =3D 0;
+}
+
+static gboolean bt_event_cb(GIOChannel *bt_io, GIOCondition condition,
+							gpointer data)
+{
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
+	return FALSE;
+}
+
 static int sap_probe(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
@@ -115,8 +147,10 @@ static void sap_remove(struct ofono_modem *modem)
 static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct sap_data *data =3D ofono_modem_get_data(modem);
 	DBusError derr;
 	DBusMessage *reply;
+	int fd;
 =

 	DBG("");
 =

@@ -126,14 +160,31 @@ static void sap_connect_reply(DBusPendingCall *call, =
gpointer user_data)
 		goto done;
 =

 	dbus_error_init(&derr);
-	if (!dbus_set_error_from_message(&derr, reply))
+	if (dbus_set_error_from_message(&derr, reply)) {
+
+		DBG("Connect reply: %s", derr.message);
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
+	data->bt_watch =3D g_io_add_watch_full(data->bt_io, G_PRIORITY_DEFAULT,
+				G_IO_HUP | G_IO_ERR | G_IO_NVAL | G_IO_IN,
+				bt_event_cb, modem, bt_watch_remove);
 =

 done:
 	dbus_message_unref(reply);
-- =

1.7.6.2


--===============1248843180904834466==--

