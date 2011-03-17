Content-Type: multipart/mixed; boundary="===============1855381667548547296=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 1/9] bluetooth: add functions for sco connection
Date: Thu, 17 Mar 2011 19:55:40 +0100
Message-ID: <1300388148-925-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1855381667548547296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |  122 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluetooth.h |    7 +++
 2 files changed, 129 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 7c2d5b0..89cc72d 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -64,6 +64,14 @@ struct cb_data {
 	GIOChannel *io;
 };
 =

+struct sco {
+	char laddress[18];
+	char raddress[18];
+	guint active_watch;
+	GIOChannel *active;
+	GIOChannel *listening;
+};
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
 {
@@ -932,5 +940,119 @@ void bluetooth_unregister_server(struct server *serve=
r)
 	bluetooth_unref();
 }
 =

+static gboolean sco_disconnect_cb(GIOChannel *io, GIOCondition cond,
+								gpointer data)
+{
+	struct sco *sco =3D data;
+
+	if(cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		DBG("");
+		sco->active =3D NULL;
+		sco->active_watch =3D 0;
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void sco_connect_cb(GIOChannel *channel, GError *err, gpointer data)
+{
+	struct sco *sco =3D data;
+
+	if(err !=3D NULL) {
+		DBG("Failed to connect SCO channel: %s", err->message);
+		return;
+	}
+
+	DBG("sco->active_watch %d sco->active %p sco->listening %p",
+			sco->active_watch, sco->active, sco->listening);
+
+	if(sco->active_watch)
+		return;
+
+	sco->active_watch =3D g_io_add_watch(channel,
+				G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				sco_disconnect_cb, data);
+
+	if(sco->active)
+		g_io_channel_unref(sco->active);
+
+	sco->active =3D channel;
+	g_io_channel_set_close_on_unref(sco->active, TRUE);
+}
+
+void sco_connect(struct sco *sco)
+{
+	GError *err =3D NULL;
+
+	if(sco->active !=3D NULL)
+		return;
+
+	sco->active =3D bt_io_connect(BT_IO_SCO, sco_connect_cb, sco,
+			NULL, &err, BT_IO_OPT_SOURCE, sco->laddress,
+			BT_IO_OPT_DEST, sco->raddress, BT_IO_OPT_INVALID);
+
+	if(sco->active)
+		g_io_channel_set_close_on_unref(sco->active, TRUE);
+
+	if(err !=3D NULL) {
+		DBG("Failed to get device address: %s", err->message);
+		g_error_free(err);
+	}
+}
+
+void sco_disconnect(struct sco *sco)
+{
+	if(sco->active =3D=3D NULL)
+		return;
+
+	g_source_remove(sco->active_watch);
+	sco->active_watch =3D 0;
+	sco->active =3D NULL;
+}
+
+struct sco *sco_register_server(GIOChannel *channel)
+{
+	struct sco *sco;
+	GError *err =3D NULL;
+
+	sco =3D g_try_malloc0(sizeof(struct sco));
+	if(sco =3D=3D NULL)
+		return NULL;
+
+	sco->listening =3D bt_io_listen(BT_IO_SCO, sco_connect_cb, NULL, sco,
+			NULL, &err, BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+			BT_IO_OPT_INVALID);
+
+	if(err !=3D NULL) {
+		DBG("Failed to listen incoming SCO: %s", err->message);
+		g_error_free(err);
+		err =3D NULL;
+	}
+
+	if(sco->listening)
+		g_io_channel_set_close_on_unref(sco->listening, TRUE);
+
+	bt_io_get(channel, BT_IO_RFCOMM, &err, BT_IO_OPT_SOURCE, sco->laddress,
+			BT_IO_OPT_DEST, sco->raddress, BT_IO_OPT_INVALID);
+
+	if(err !=3D NULL) {
+		DBG("Failed to get device address: %s", err->message);
+		g_error_free(err);
+	}
+
+	return sco;
+}
+
+void sco_unregister_server(struct sco *sco)
+{
+	sco_disconnect(sco);
+
+	if(sco->listening !=3D NULL)
+		g_io_channel_unref(sco->listening);
+
+	g_free(sco);
+}
+
 OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
 			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 505d908..ba88e96 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -42,6 +42,8 @@ struct bluetooth_profile {
 =

 struct server;
 =

+struct sco;
+
 typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_dat=
a);
 =

 int bluetooth_register_uuid(const char *uuid,
@@ -52,6 +54,11 @@ struct server *bluetooth_register_server(guint8 channel,=
 const char *sdp_record,
 					ConnectFunc cb, gpointer user_data);
 void bluetooth_unregister_server(struct server *server);
 =

+void sco_connect(struct sco *sco);
+void sco_disconnect(struct sco *sco);
+struct sco *sco_register_server(GIOChannel *channel);
+void sco_unregister_server(struct sco *sco);
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 							char *buf, int size);
 =

-- =

1.7.1


--===============1855381667548547296==--

