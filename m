Content-Type: multipart/mixed; boundary="===============3200824348251997184=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 08/20] sap: connect the hw and the bluetooth link
Date: Mon, 05 Sep 2011 15:03:37 -0300
Message-ID: <1315245829-6887-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315245829-6887-8-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3200824348251997184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

data is now passed from one side to another
---
 plugins/sap.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 90e2a03..678addc 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -54,7 +54,9 @@ struct sap_data {
 	char *server_path;
 	struct ofono_modem *hw_modem;
 	GIOChannel *bt_io;
+	GIOChannel *hw_io;
 	guint bt_watch;
+	guint hw_watch;
 };
 =

 int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
@@ -106,7 +108,7 @@ static gboolean bt_event_cb(GIOChannel *bt_io, GIOCondi=
tion condition,
 =

 	if (condition & G_IO_IN) {
 		GIOStatus status;
-		gsize bytes_read;
+		gsize bytes_read, bytes_written;
 		gchar buf[300];
 =

 		status =3D g_io_channel_read_chars(bt_io, buf, 300,
@@ -129,6 +131,37 @@ static gboolean bt_event_cb(GIOChannel *bt_io, GIOCond=
ition condition,
 	return FALSE;
 }
 =

+static gboolean hw_event_cb(GIOChannel *hw_io, GIOCondition condition,
+							gpointer data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sap_data *sap_data =3D ofono_modem_get_data(modem);
+
+	if (condition & G_IO_IN) {
+		GIOStatus status;
+		gsize bytes_read, bytes_written;
+		gchar buf[300];
+
+		status =3D g_io_channel_read_chars(hw_io, buf, 300,
+							&bytes_read, NULL);
+
+		if (bytes_read > 0)
+			g_io_channel_write_chars(sap_data->bt_io, buf,
+					bytes_read, &bytes_written, NULL);
+
+		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
+			return FALSE;
+
+		return TRUE;
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	sap_data->hw_watch =3D 0;
+
+	return FALSE;
+}
+
 static int sap_probe(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
@@ -154,6 +187,7 @@ static void sap_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	struct sap_data *data =3D ofono_modem_get_data(modem);
 	DBusError derr;
 	DBusMessage *reply, *msg;
+	struct bluetooth_sap_driver *sap_driver;
 	int fd;
 =

 	DBG("");
@@ -204,6 +238,34 @@ static void sap_connect_reply(DBusPendingCall *call, g=
pointer user_data)
 	data->bt_watch =3D g_io_add_watch(data->bt_io, G_IO_HUP | G_IO_ERR
 				| G_IO_NVAL | G_IO_IN, bt_event_cb, modem);
 =

+	sap_driver =3D g_hash_table_lookup(sap_hw_hash, data->hw_modem);
+	if (!sap_driver)
+		return;
+
+	fd =3D sap_driver->open(data->hw_modem);
+	if (!fd)  {
+		g_io_channel_unref(data->bt_io);
+		return;
+	}
+
+	data->hw_io =3D g_io_channel_unix_new(fd);
+	if (data->hw_io =3D=3D NULL) {
+		g_io_channel_unref(data->bt_io);
+		close(fd);
+		return;
+	}
+
+	g_io_channel_set_encoding(data->hw_io, NULL, NULL);
+	g_io_channel_set_buffered(data->hw_io, FALSE);
+	g_io_channel_set_close_on_unref(data->hw_io, TRUE);
+
+	data->hw_watch =3D g_io_add_watch(data->hw_io, G_IO_HUP | G_IO_ERR
+				| G_IO_NVAL | G_IO_IN, hw_event_cb, modem);
+
+	sap_driver->enable(data->hw_modem);
+
+	ofono_modem_set_powered(modem, TRUE);
+
 done:
 	dbus_message_unref(reply);
 }
-- =

1.7.6.1


--===============3200824348251997184==--

