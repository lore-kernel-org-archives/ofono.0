Content-Type: multipart/mixed; boundary="===============9161559404137850743=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 3/3] hfp_hf_bluez5: Add SCO listen socket
Date: Wed, 23 Jan 2013 20:46:41 -0300
Message-ID: <1358984801-23640-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358984801-23640-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9161559404137850743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the initial SCO server socket handling.
---
 plugins/hfp_hf_bluez5.c | 95 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 95 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 0e496ee..84c4a55 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -64,6 +64,8 @@ struct hfp {
 static GHashTable *modem_hash =3D NULL;
 static GHashTable *devices_proxies =3D NULL;
 static GDBusClient *bluez =3D NULL;
+static GIOChannel *sco_io =3D NULL;
+static guint sco_watch =3D 0;
 =

 static void hfp_debug(const char *str, void *user_data)
 {
@@ -378,6 +380,87 @@ static const GDBusMethodTable profile_methods[] =3D {
 	{ }
 };
 =

+static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct sockaddr_sco saddr;
+	socklen_t optlen;
+	int sk, nsk;
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
+		return FALSE;
+
+	sk =3D g_io_channel_unix_get_fd(io);
+
+	memset(&saddr, 0, sizeof(saddr));
+	optlen =3D sizeof(saddr);
+
+	nsk =3D accept(sk, (struct sockaddr *) &saddr, &optlen);
+	if (nsk < 0)
+		return TRUE;
+
+	/* TODO: Verify if the device has a modem */
+
+	return TRUE;
+}
+
+static GIOChannel *sco_listen(int *err)
+{
+	struct sockaddr_sco addr;
+	GIOChannel *io;
+	int sk, defer_setup =3D 1;
+
+	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
+	if (sk < 0) {
+		*err =3D -errno;
+		return NULL;
+	}
+
+	/* Bind to local address */
+	memset(&addr, 0, sizeof(addr));
+	addr.sco_family =3D AF_BLUETOOTH;
+	bt_bacpy(&addr.sco_bdaddr, BDADDR_ANY);
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		close(sk);
+		*err =3D -errno;
+		return NULL;
+	}
+
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
+				&defer_setup, sizeof(defer_setup)) < 0) {
+		ofono_warn("Can't enable deferred setup: %s (%d)",
+						strerror(errno), errno);
+		*err =3D -errno;
+	}
+
+	io =3D g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+
+	if (listen(sk, 5) < 0) {
+		g_io_channel_unref(io);
+		*err =3D -errno;
+		return NULL;
+	}
+
+	return io;
+}
+
+static int sco_init(void)
+{
+	GIOCondition cond =3D G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	int err =3D 0;
+
+	sco_io =3D sco_listen(&err);
+	if (sco_io =3D=3D NULL)
+		return err;
+
+	sco_watch =3D g_io_add_watch(sco_io, cond, sco_accept, NULL);
+
+	return 0;
+}
+
 static void connect_handler(DBusConnection *conn, void *user_data)
 {
 	DBG("Registering External Profile handler ...");
@@ -500,6 +583,12 @@ static int hfp_init(void)
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
@@ -550,6 +639,12 @@ static void hfp_exit(void)
 =

 	g_hash_table_destroy(modem_hash);
 	g_hash_table_destroy(devices_proxies);
+
+	if (sco_watch)
+		g_source_remove(sco_watch);
+
+	if (sco_io)
+		g_io_channel_unref(sco_io);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VERS=
ION,
-- =

1.7.11.7


--===============9161559404137850743==--

