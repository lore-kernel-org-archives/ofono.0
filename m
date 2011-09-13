Content-Type: multipart/mixed; boundary="===============8553920875078959466=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 20/24] sap: do a proper shutdown of the channels
Date: Tue, 13 Sep 2011 15:58:28 -0300
Message-ID: <1315940312-1238-20-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-19-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8553920875078959466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index c2a2281..10b2386 100644
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
@@ -182,9 +183,39 @@ static void sap_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
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
+	if (data->bt_watch > 0) {
+		g_source_remove(data->bt_watch);
+		data->bt_watch =3D 0;
+	}
+
+	if (data->hw_io !=3D NULL) {
+		g_io_channel_unref(data->hw_io);
+		data->hw_io =3D NULL;
+	}
+
+	if (data->hw_watch > 0) {
+		g_source_remove(data->hw_watch);
+		data->hw_watch =3D 0;
+	}
+}
+
 static void sap_failed_cb(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
+
+	sap_close_io(modem);
 }
 =

 static void sap_connect_reply(DBusPendingCall *call, gpointer user_data)
@@ -244,13 +275,13 @@ static void sap_connect_reply(DBusPendingCall *call, =
gpointer user_data)
 =

 	fd =3D data->sap_driver->open(data->hw_modem);
 	if (!fd)  {
-		g_io_channel_unref(data->bt_io);
+		sap_close_io(modem);
 		return;
 	}
 =

 	data->hw_io =3D g_io_channel_unix_new(fd);
 	if (data->hw_io =3D=3D NULL) {
-		g_io_channel_unref(data->bt_io);
+		sap_close_io(modem);
 		close(fd);
 		return;
 	}
@@ -295,6 +326,8 @@ static int sap_disable(struct ofono_modem *modem)
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


--===============8553920875078959466==--

