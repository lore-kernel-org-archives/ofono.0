Content-Type: multipart/mixed; boundary="===============1247065182448509723=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 5/5] hfp_ag_bluez5: Add SCO listen socket
Date: Tue, 05 Feb 2013 17:27:00 +0100
Message-ID: <1360081620-19458-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1360081620-19458-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1247065182448509723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the initial SCO server socket handling.
---
 plugins/hfp_ag_bluez5.c |   83 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 83 insertions(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index c6b858e..ee8c8bf 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -48,6 +48,7 @@ struct hfp_ag {
 	struct ofono_emulator *em;
 	bdaddr_t local;
 	bdaddr_t peer;
+	guint sco_watch;
 };
 =

 static guint modemwatch_id;
@@ -64,6 +65,9 @@ static void free_hfp_ag(void *data)
 	if (hfp_ag =3D=3D NULL)
 		return;
 =

+	if (hfp_ag->sco_watch)
+		g_source_remove(hfp_ag->sco_watch);
+
 	hfp_ags =3D g_slist_remove(hfp_ags, hfp_ag);
 	g_free(hfp_ag);
 }
@@ -206,6 +210,82 @@ static const GDBusMethodTable profile_methods[] =3D {
 	{ }
 };
 =

+static gboolean sco_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+
+{
+	struct hfp_ag *hfp_ag =3D user_data;
+	char adapter_address[18];
+	char device_address[18];
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		hfp_ag->sco_watch =3D 0;
+
+		bt_ba2str(&hfp_ag->local, adapter_address);
+		bt_ba2str(&hfp_ag->peer, device_address);
+		DBG("SCO: %s - %s (closed)", adapter_address, device_address);
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static gboolean hfp_ag_sco_accept(int fd, struct sockaddr_sco *raddr)
+{
+	struct sockaddr_sco laddr;
+	socklen_t optlen;
+	GSList *l;
+	char adapter_address[18];
+	char device_address[18];
+	struct hfp_ag *hfp_ag =3D NULL;
+	GIOChannel *sco_io;
+	int err;
+
+	memset(&laddr, 0, sizeof(laddr));
+	optlen =3D sizeof(laddr);
+	if (getsockname(fd, (struct sockaddr *) &laddr, &optlen) < 0) {
+		err =3D errno;
+		ofono_error("SCO getsockname(): %s (%d)", strerror(err), err);
+		return FALSE;
+	}
+
+	for (l =3D hfp_ags; l; l =3D l->next) {
+		struct hfp_ag *tmp =3D l->data;
+
+		if (bt_bacmp(&laddr.sco_bdaddr, &tmp->local) !=3D 0)
+			continue;
+
+		if (bt_bacmp(&raddr->sco_bdaddr, &tmp->peer) !=3D 0)
+			continue;
+
+		hfp_ag =3D tmp;
+		break;
+	}
+
+	if (!hfp_ag) {
+		ofono_error("Rejecting SCO: SLC connection missing!");
+		return FALSE;
+	}
+
+	bt_ba2str(&laddr.sco_bdaddr, adapter_address);
+	bt_ba2str(&raddr->sco_bdaddr, device_address);
+	DBG("SCO: %s < %s (incoming)", adapter_address, device_address);
+
+	sco_io =3D g_io_channel_unix_new(fd);
+
+	g_io_channel_set_close_on_unref(sco_io, TRUE);
+	g_io_channel_set_flags(sco_io, G_IO_FLAG_NONBLOCK, NULL);
+
+	hfp_ag->sco_watch =3D g_io_add_watch(sco_io,
+						G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						sco_cb, hfp_ag);
+
+	g_io_channel_unref(sco_io);
+
+	return TRUE;
+}
+
 static void sim_state_watch(enum ofono_sim_state new_state, void *data)
 {
 	struct ofono_modem *modem =3D data;
@@ -219,6 +299,7 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *data)
 		if (modems !=3D NULL)
 			return;
 =

+		bt_unregister_sco_server(hfp_ag_sco_accept);
 		bluetooth_unregister_profile(conn, HFP_AG_EXT_PROFILE_PATH);
 =

 		return;
@@ -234,6 +315,8 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *data)
 =

 	bluetooth_register_profile(conn, HFP_AG_UUID, "hfp_ag",
 						HFP_AG_EXT_PROFILE_PATH);
+
+	bt_register_sco_server(hfp_ag_sco_accept);
 }
 =

 static gboolean sim_watch_remove(gpointer key, gpointer value,
-- =

1.7.9.5


--===============1247065182448509723==--

