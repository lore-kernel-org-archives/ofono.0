Content-Type: multipart/mixed; boundary="===============0508090404846965768=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 15/21] sap: do a proper shutdown of the channels
Date: Tue, 27 Sep 2011 18:04:14 -0300
Message-ID: <1317157460-17012-15-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-14-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0508090404846965768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 4f29477..c8b0ef5 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -28,6 +28,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
+#include <sys/socket.h>
 #include <glib.h>
 #include <gdbus.h>
 #include <ofono.h>
@@ -73,10 +74,36 @@ int bluetooth_sap_client_register(struct bluetooth_sap_=
driver *sap,
 	return 0;
 }
 =

+static void sap_close_io(struct ofono_modem *modem)
+{
+	struct sap_data *data =3D ofono_modem_get_data(modem);
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
 static void sap_remove_modem(struct ofono_modem *modem)
 {
 	struct sap_data *data =3D ofono_modem_get_data(modem);
 =

+	sap_close_io(modem);
+
 	g_free(data->server_path);
 	g_free(data);
 =

@@ -193,6 +220,8 @@ static void sap_remove(struct ofono_modem *modem)
 static void sap_failed_cb(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
+
+	sap_close_io(modem);
 }
 =

 static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
@@ -241,12 +270,14 @@ static void sap_connect_reply(DBusPendingCall *call, =
gpointer user_data)
 	data->sap_driver =3D sap_hw_driver;
 =

 	fd =3D data->sap_driver->enable(data->hw_modem, modem, sap_failed_cb);
-	if (fd < 0)
+	if (!fd)  {
+		sap_close_io(modem);
 		return;
+	}
 =

 	data->hw_io =3D g_io_channel_unix_new(fd);
 	if (data->hw_io =3D=3D NULL) {
-		g_io_channel_unref(data->bt_io);
+		sap_close_io(modem);
 		close(fd);
 		return;
 	}
@@ -290,6 +321,8 @@ static int sap_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	sap_close_io(modem);
+
 	data->sap_driver->disable(data->hw_modem);
 =

 	return 0;
-- =

1.7.6.2


--===============0508090404846965768==--

