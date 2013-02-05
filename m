Content-Type: multipart/mixed; boundary="===============8213538952402667601=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/5] bluez5: Add SCO server register/unregister
Date: Tue, 05 Feb 2013 17:26:56 +0100
Message-ID: <1360081620-19458-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8213538952402667601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SCO server should be shared by both HFP HF and HFP AG plugins.
---
 plugins/bluez5.c        |  117 +++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluez5.h        |    5 ++
 plugins/hfp_hf_bluez5.c |   72 ++---------------------------
 3 files changed, 127 insertions(+), 67 deletions(-)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index d5c566e..5d10f44 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -26,6 +26,8 @@
 #include <errno.h>
 #include <stdint.h>
 #include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
 #include <sys/socket.h>
 #include <string.h>
 =

@@ -41,6 +43,9 @@
 =

 #define BLUEZ_PROFILE_MGMT_INTERFACE   BLUEZ_SERVICE ".ProfileManager1"
 =

+static guint sco_watch;
+static GSList *sco_cbs;
+
 void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src)
 {
 	memcpy(dst, src, sizeof(bdaddr_t));
@@ -57,6 +62,118 @@ int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2)
 	return memcmp(ba1, ba2, sizeof(bdaddr_t));
 }
 =

+static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct sockaddr_sco saddr;
+	socklen_t alen;
+	int sk, nsk;
+	GSList *l;
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
+		return FALSE;
+
+	sk =3D g_io_channel_unix_get_fd(io);
+
+	memset(&saddr, 0, sizeof(saddr));
+	alen =3D sizeof(saddr);
+
+	nsk =3D accept(sk, (struct sockaddr *) &saddr, &alen);
+	if (nsk < 0)
+		return TRUE;
+
+	for (l =3D sco_cbs; l; l =3D l->next) {
+		bt_sco_accept_cb cb =3D l->data;
+
+		if (cb(nsk, &saddr))
+			return TRUE;
+	}
+
+	ofono_warn("No SCO callback for incoming connection");
+	close(nsk);
+
+	return TRUE;
+}
+
+static int sco_init(void)
+{
+	GIOChannel *sco_io;
+	struct sockaddr_sco saddr;
+	int sk, defer_setup =3D 1;
+
+	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
+								BTPROTO_SCO);
+	if (sk < 0)
+		return -errno;
+
+	/* Bind to local address */
+	memset(&saddr, 0, sizeof(saddr));
+	saddr.sco_family =3D AF_BLUETOOTH;
+	bt_bacpy(&saddr.sco_bdaddr, BDADDR_ANY);
+
+	if (bind(sk, (struct sockaddr *) &saddr, sizeof(saddr)) < 0) {
+		close(sk);
+		return -errno;
+	}
+
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
+				&defer_setup, sizeof(defer_setup)) < 0)
+		ofono_warn("Can't enable deferred setup: %s (%d)",
+						strerror(errno), errno);
+
+	if (listen(sk, 5) < 0) {
+		close(sk);
+		return -errno;
+	}
+
+	sco_io =3D g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(sco_io, TRUE);
+
+	sco_watch =3D g_io_add_watch(sco_io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				sco_accept, NULL);
+
+	g_io_channel_unref(sco_io);
+
+	return 0;
+}
+
+int bt_register_sco_server(bt_sco_accept_cb cb)
+{
+	int err;
+
+	if (!cb) {
+		ofono_error("SCO: invalid callback");
+		return -1;
+	}
+
+	if (!sco_cbs) {
+		err =3D sco_init();
+		if (err < 0) {
+			ofono_error("SCO: %s(%d)", strerror(-err), -err);
+			return err;
+		}
+	}
+
+	sco_cbs =3D g_slist_append(sco_cbs, cb);
+
+	return 0;
+}
+
+void bt_unregister_sco_server(bt_sco_accept_cb cb)
+{
+	if (!cb) {
+		ofono_error("SCO: invalid callback");
+		return;
+	}
+
+	sco_cbs =3D g_slist_remove(sco_cbs, cb);
+	if (sco_cbs)
+		return;
+
+	g_source_remove(sco_watch);
+}
+
 static void profile_register_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index cdbfe72..29eba12 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -69,6 +69,11 @@ int bt_ba2str(const bdaddr_t *ba, char *str);
 =

 int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2);
 =

+typedef gboolean (*bt_sco_accept_cb)(int fd, struct sockaddr_sco *saddr);
+
+int bt_register_sco_server(bt_sco_accept_cb cb);
+void bt_unregister_sco_server(bt_sco_accept_cb cb);
+
 int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
 =

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2f4a89e..a8738bd 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -65,7 +65,6 @@ struct hfp {
 =

 static GHashTable *modem_hash =3D NULL;
 static GDBusClient *bluez =3D NULL;
-static guint sco_watch =3D 0;
 =

 static void hfp_debug(const char *str, void *user_data)
 {
@@ -360,69 +359,11 @@ static const GDBusMethodTable profile_methods[] =3D {
 	{ }
 };
 =

-static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
+static gboolean hfp_hf_sco_accept(int fd, struct sockaddr_sco *saddr)
 {
-	struct sockaddr_sco saddr;
-	socklen_t alen;
-	int sk, nsk;
-
-	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
-		return FALSE;
-
-	sk =3D g_io_channel_unix_get_fd(io);
-
-	memset(&saddr, 0, sizeof(saddr));
-	alen =3D sizeof(saddr);
-
-	nsk =3D accept(sk, (struct sockaddr *) &saddr, &alen);
-	if (nsk < 0)
-		return TRUE;
-
 	/* TODO: Verify if the device has a modem */
 =

-	return TRUE;
-}
-
-static int sco_init(void)
-{
-	GIOChannel *sco_io;
-	struct sockaddr_sco saddr;
-	int sk, defer_setup =3D 1;
-
-	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
-								BTPROTO_SCO);
-	if (sk < 0)
-		return -errno;
-
-	/* Bind to local address */
-	memset(&saddr, 0, sizeof(saddr));
-	saddr.sco_family =3D AF_BLUETOOTH;
-	bt_bacpy(&saddr.sco_bdaddr, BDADDR_ANY);
-
-	if (bind(sk, (struct sockaddr *) &saddr, sizeof(saddr)) < 0) {
-		close(sk);
-		return -errno;
-	}
-
-	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
-				&defer_setup, sizeof(defer_setup)) < 0)
-		ofono_warn("Can't enable deferred setup: %s (%d)",
-						strerror(errno), errno);
-
-	if (listen(sk, 5) < 0) {
-		close(sk);
-		return -errno;
-	}
-
-	sco_io =3D g_io_channel_unix_new(sk);
-	sco_watch =3D g_io_add_watch(sco_io,
-				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				sco_accept, NULL);
-
-	g_io_channel_unref(sco_io);
-
-	return 0;
+	return FALSE;
 }
 =

 static void connect_handler(DBusConnection *conn, void *user_data)
@@ -561,11 +502,9 @@ static int hfp_init(void)
 	if (DBUS_TYPE_UNIX_FD < 0)
 		return -EBADF;
 =

-	err =3D sco_init();
-	if (err < 0) {
-		ofono_error("SCO: %s(%d)", strerror(-err), -err);
+	err =3D bt_register_sco_server(hfp_hf_sco_accept);
+	if (err < 0)
 		return err;
-	}
 =

 	/* Registers External Profile handler */
 	if (!g_dbus_register_interface(conn, HFP_EXT_PROFILE_PATH,
@@ -614,8 +553,7 @@ static void hfp_exit(void)
 =

 	g_hash_table_destroy(modem_hash);
 =

-	if (sco_watch > 0)
-		g_source_remove(sco_watch);
+	bt_unregister_sco_server(hfp_hf_sco_accept);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VERS=
ION,
-- =

1.7.9.5


--===============8213538952402667601==--

