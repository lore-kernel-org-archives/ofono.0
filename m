Content-Type: multipart/mixed; boundary="===============7576646097344435820=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 2/5] telit: add support the enable the SAP client modem
Date: Wed, 28 Sep 2011 17:48:57 -0300
Message-ID: <1317242940-4014-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317242940-4014-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7576646097344435820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <gustavo@padovan.org>

---
 plugins/bluetooth.h |    3 +-
 plugins/telit.c     |  185 +++++++++++++++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 181 insertions(+), 7 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 936659c..7e94f96 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -45,7 +45,8 @@ struct bluetooth_profile {
 =

 struct bluetooth_sap_driver {
 	const char *name;
-	int (*enable) (struct ofono_modem *modem);
+	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem,
+								int bt_fd);
 };
 =

 struct server;
diff --git a/plugins/telit.c b/plugins/telit.c
index 1f950aa..1c177c0 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -27,6 +27,10 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <fcntl.h>
+#include <termios.h>
+#include <string.h>
+#include <sys/socket.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -62,8 +66,14 @@ static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
 =

 struct telit_data {
 	GAtChat *chat;
+	GAtChat *aux;
 	struct ofono_sim *sim;
 	guint sim_inserted_source;
+	struct ofono_modem *sap_modem;
+	GIOChannel *bt_io;
+	GIOChannel *hw_io;
+	guint bt_watch;
+	guint hw_watch;
 };
 =

 static void telit_debug(const char *str, void *user_data)
@@ -73,6 +83,104 @@ static void telit_debug(const char *str, void *user_dat=
a)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static void sap_close_io(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	if (data->bt_io !=3D NULL) {
+		int sk =3D g_io_channel_unix_get_fd(data->bt_io);
+		shutdown(sk, SHUT_RDWR);
+
+		g_io_channel_unref(data->bt_io);
+		data->bt_io =3D NULL;
+	}
+
+	if (data->bt_watch > 0)
+		g_source_remove(data->bt_watch);
+
+	if (data->hw_io !=3D NULL) {
+		g_io_channel_unref(data->hw_io);
+		data->hw_io =3D NULL;
+	}
+
+	if (data->hw_watch > 0)
+		g_source_remove(data->hw_watch);
+}
+
+static void bt_watch_remove(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	data->bt_watch =3D 0;
+}
+
+static gboolean bt_event_cb(GIOChannel *bt_io, GIOCondition condition,
+							gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	if (condition & G_IO_IN) {
+		GIOStatus status;
+		gsize bytes_read, bytes_written;
+		gchar buf[300];
+
+		status =3D g_io_channel_read_chars(bt_io, buf, 300,
+							&bytes_read, NULL);
+
+		if (bytes_read > 0)
+			g_io_channel_write_chars(data->hw_io, buf,
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
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	data->hw_watch =3D 0;
+}
+
+static gboolean hw_event_cb(GIOChannel *hw_io, GIOCondition condition,
+							gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
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
+			g_io_channel_write_chars(data->bt_io, buf,
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
 static GAtChat *open_device(struct ofono_modem *modem,
 				const char *key, char *debug)
 {
@@ -137,23 +245,88 @@ static void rsen_enable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 }
 =

-static int telit_sap_enable(struct ofono_modem *modem)
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
+
+	/* Switch TTY to raw mode */
+	memset(&ti, 0, sizeof(ti));
+	cfmakeraw(&ti);
+
+	ti.c_cflag |=3D (B115200 | CLOCAL | CREAD);
+
+	tcflush(fd, TCIOFLUSH);
+	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
+		close(fd);
+		return -EBADF;
+	}
+
+	return fd;
+}
+
+static int telit_sap_enable(struct ofono_modem *modem,
+					struct ofono_modem *sap_modem,
+					int bt_fd)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
+	int fd;
 =

 	DBG("%p", modem);
 =

-	data->chat =3D open_device(modem, "Data", "Aux: ");
-	if (data->chat =3D=3D NULL)
+	data->aux =3D open_device(modem, "Data", "Aux: ");
+	if (data->aux =3D=3D NULL)
 		return -EINVAL;
 =

-	g_at_chat_register(data->chat, "#RSEN:", telit_rsen_notify,
+	fd =3D telit_sap_open();
+	if (fd < 0)
+		return fd;
+
+	data->hw_io =3D g_io_channel_unix_new(fd);
+	if (data->hw_io =3D=3D NULL) {
+		close(fd);
+		return -ENOMEM;
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
+	data->bt_io =3D g_io_channel_unix_new(bt_fd);
+	if (data->bt_io =3D=3D NULL) {
+		sap_close_io(modem);
+		return -ENOMEM;
+	}
+
+	g_io_channel_set_encoding(data->bt_io, NULL, NULL);
+	g_io_channel_set_buffered(data->bt_io, FALSE);
+	g_io_channel_set_close_on_unref(data->bt_io, TRUE);
+
+	data->bt_watch =3D g_io_add_watch_full(data->bt_io, G_PRIORITY_DEFAULT,
+				G_IO_HUP | G_IO_ERR | G_IO_NVAL | G_IO_IN,
+				bt_event_cb, modem, bt_watch_remove);
+
+
+	data->sap_modem =3D sap_modem;
+
+	g_at_chat_register(data->aux, "#RSEN:", telit_rsen_notify,
 				FALSE, modem, NULL);
 =

-	g_at_chat_send(data->chat, "AT#NOPT=3D3", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "AT#NOPT=3D0", NULL, NULL, NULL, NULL);
 =

 	/* Set SAP functionality */
-	g_at_chat_send(data->chat, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
+	g_at_chat_send(data->aux, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
 				rsen_enable_cb, modem, NULL);
 =

 	return -EINPROGRESS;
-- =

1.7.6.2


--===============7576646097344435820==--

