Content-Type: multipart/mixed; boundary="===============3977267809995579812=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 3/8] hfp_hf_bluez5: Add SCO listen socket
Date: Mon, 28 Jan 2013 18:11:03 -0300
Message-ID: <1359407468-5110-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359407468-5110-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3977267809995579812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the initial SCO server socket handling. BtIO and BlueZ
functions should not be used, with the new Profile API the objetive is
to get rid of these dependencies.
---
 plugins/hfp_hf_bluez5.c | 77 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 77 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 0e496ee..e7d8717 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -28,6 +28,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
+#include <fcntl.h>
 #include <sys/socket.h>
 =

 #include <glib.h>
@@ -64,6 +65,7 @@ struct hfp {
 static GHashTable *modem_hash =3D NULL;
 static GHashTable *devices_proxies =3D NULL;
 static GDBusClient *bluez =3D NULL;
+static guint sco_watch =3D 0;
 =

 static void hfp_debug(const char *str, void *user_data)
 {
@@ -378,6 +380,72 @@ static const GDBusMethodTable profile_methods[] =3D {
 	{ }
 };
 =

+static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct sockaddr_sco saddr;
+	socklen_t alen;
+	int sk, nsk;
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
+	/* TODO: Verify if the device has a modem */
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
+				&defer_setup, sizeof(defer_setup)) < 0) {
+		ofono_warn("Can't enable deferred setup: %s (%d)",
+						strerror(errno), errno);
+	}
+
+	if (listen(sk, 5) < 0) {
+		close(sk);
+		return -errno;
+	}
+
+	sco_io =3D g_io_channel_unix_new(sk);
+	sco_watch =3D g_io_add_watch(sco_io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				sco_accept, NULL);
+
+	g_io_channel_unref(sco_io);
+
+	return 0;
+}
+
 static void connect_handler(DBusConnection *conn, void *user_data)
 {
 	DBG("Registering External Profile handler ...");
@@ -500,6 +568,12 @@ static int hfp_init(void)
 	if (DBUS_TYPE_UNIX_FD < 0)
 		return -EBADF;
 =

+	err =3D sco_init();
+	if (err < 0) {
+		ofono_error("SCO: %s(%d)", strerror(-err), -err);
+		return err;
+	}
+
 	/* Registers External Profile handler */
 	if (!g_dbus_register_interface(conn, HFP_EXT_PROFILE_PATH,
 					BLUEZ_PROFILE_INTERFACE,
@@ -550,6 +624,9 @@ static void hfp_exit(void)
 =

 	g_hash_table_destroy(modem_hash);
 	g_hash_table_destroy(devices_proxies);
+
+	if (sco_watch > 0)
+		g_source_remove(sco_watch);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VERS=
ION,
-- =

1.7.11.7


--===============3977267809995579812==--

