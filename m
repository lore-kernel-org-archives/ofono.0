Content-Type: multipart/mixed; boundary="===============6255856212889187266=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 03/21] sap: add support to enable SAP
Date: Tue, 27 Sep 2011 18:04:02 -0300
Message-ID: <1317157460-17012-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6255856212889187266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

connects the bluetooth link with the the hw and initiate the SAP
connection procedure.
---
 plugins/sap.c   |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 plugins/telit.c |   34 +++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 004d225..f0965f1 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -56,7 +56,9 @@ struct sap_data {
 	struct ofono_modem *hw_modem;
 	struct bluetooth_sap_driver *sap_driver;
 	GIOChannel *bt_io;
+	GIOChannel *hw_io;
 	guint bt_watch;
+	guint hw_watch;
 };
 =

 int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
@@ -115,14 +117,58 @@ static void bt_watch_remove(gpointer userdata)
 static gboolean bt_event_cb(GIOChannel *bt_io, GIOCondition condition,
 							gpointer data)
 {
+	struct ofono_modem *modem =3D data;
+	struct sap_data *sap_data =3D ofono_modem_get_data(modem);
+
 	if (condition & G_IO_IN) {
 		GIOStatus status;
-		gsize bytes_read;
+		gsize bytes_read, bytes_written;
 		gchar buf[300];
 =

 		status =3D g_io_channel_read_chars(bt_io, buf, 300,
 							&bytes_read, NULL);
 =

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
+	return FALSE;
+}
+
+static void hw_watch_remove(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	data->hw_watch =3D 0;
+}
+
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
 		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
 			return FALSE;
 =

@@ -186,6 +232,30 @@ static void sap_connect_reply(DBusPendingCall *call, g=
pointer user_data)
 				G_IO_HUP | G_IO_ERR | G_IO_NVAL | G_IO_IN,
 				bt_event_cb, modem, bt_watch_remove);
 =

+	data->hw_modem =3D sap_hw_modem;
+	data->sap_driver =3D sap_hw_driver;
+
+	fd =3D data->sap_driver->enable(data->hw_modem);
+	if (fd < 0)
+		return;
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
+	data->hw_watch =3D g_io_add_watch_full(data->hw_io, G_PRIORITY_DEFAULT,
+				G_IO_HUP | G_IO_ERR | G_IO_NVAL | G_IO_IN,
+				hw_event_cb, modem, hw_watch_remove);
+
+	ofono_modem_set_powered(modem, TRUE);
+
 done:
 	dbus_message_unref(reply);
 }
diff --git a/plugins/telit.c b/plugins/telit.c
index 1f950aa..a5f9941 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -27,6 +27,9 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <fcntl.h>
+#include <termios.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -134,12 +137,37 @@ static void rsen_enable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		ofono_modem_set_powered(modem, FALSE);
 		return;
 	}
+}
+
+static int telit_sap_open()
+{
+	const char *device =3D "/dev/ttyUSB4";
+	struct termios ti;
+	int fd;
+
+	DBG("%s", device);
+
+	fd =3D open(device, O_RDWR | O_NOCTTY | O_NONBLOCK);
+	if (fd < 0)
+		return -EINVAL;
 =

+	/* Switch TTY to raw mode */
+	memset(&ti, 0, sizeof(ti));
+	cfmakeraw(&ti);
+
+	tcflush(fd, TCIOFLUSH);
+	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
+		close(fd);
+		return -EBADF;
+	}
+
+	return fd;
 }
 =

 static int telit_sap_enable(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
+	int fd;
 =

 	DBG("%p", modem);
 =

@@ -147,6 +175,10 @@ static int telit_sap_enable(struct ofono_modem *modem)
 	if (data->chat =3D=3D NULL)
 		return -EINVAL;
 =

+	fd =3D telit_sap_open();
+	if (fd < 0)
+		return fd;
+
 	g_at_chat_register(data->chat, "#RSEN:", telit_rsen_notify,
 				FALSE, modem, NULL);
 =

@@ -156,7 +188,7 @@ static int telit_sap_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->chat, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
 				rsen_enable_cb, modem, NULL);
 =

-	return -EINPROGRESS;
+	return fd;
 }
 =

 static struct bluetooth_sap_driver sap_driver =3D {
-- =

1.7.6.2


--===============6255856212889187266==--

