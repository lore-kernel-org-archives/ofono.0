Content-Type: multipart/mixed; boundary="===============1450423331609264105=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 2/6] handsfree-audio: Move SCO to handsfree-audio.c
Date: Mon, 04 Mar 2013 17:48:49 -0300
Message-ID: <1362430133-6870-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362430133-6870-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1450423331609264105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch moves the SCO socket handling from hfp_hf_bluez5 plugin to
handsfree-audio.c file. This is the initial step to be able to support
sending the file descriptor through the Agent NewConnection method.

This patch replaces the handsfree modem verification by the Audio Card.
Audio Cards are created when the RFCOMM fd descriptor is received, and
registered when the service level connetion is established.
---
 plugins/hfp_hf_bluez5.c | 102 +-------------------------------------------=
----
 src/handsfree-audio.c   |  91 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 102 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 3a48a51..381a541 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -68,8 +68,6 @@ struct hfp {
 };
 =

 static GDBusClient *bluez =3D NULL;
-static guint sco_watch =3D 0;
-static uint16_t local_hfp_version =3D HFP_VERSION_1_6;
 =

 static void hfp_debug(const char *str, void *user_data)
 {
@@ -483,100 +481,11 @@ static const GDBusMethodTable profile_methods[] =3D {
 	{ }
 };
 =

-static ofono_bool_t slc_match(struct ofono_modem *modem, void *userdata)
-{
-	const char *remote =3D userdata;
-	const char *value =3D ofono_modem_get_string(modem, "Remote");
-
-	if (value =3D=3D NULL)
-		return FALSE;
-
-	/* Make sure SLC has been established */
-	if (ofono_modem_get_powered(modem) !=3D TRUE)
-		return FALSE;
-
-	return g_str_equal(remote, value);
-}
-
-static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	struct sockaddr_sco saddr;
-	socklen_t alen;
-	int sk, nsk;
-	char remote[18];
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
-	bt_ba2str(&saddr.sco_bdaddr, remote);
-
-	if (ofono_modem_find(slc_match, remote) =3D=3D NULL) {
-		ofono_error("Rejecting SCO: No SLC connection found!");
-		close(nsk);
-		return TRUE;
-	}
-
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
-				&defer_setup, sizeof(defer_setup)) < 0) {
-		ofono_warn("Can't enable deferred setup: %s (%d)",
-						strerror(errno), errno);
-		local_hfp_version =3D HFP_VERSION_1_5;
-	}
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
-}
-
 static void connect_handler(DBusConnection *conn, void *user_data)
 {
 	DBG("Registering External Profile handler ...");
 =

-	bt_register_profile(conn, HFP_HS_UUID, local_hfp_version, "hfp_hf",
+	bt_register_profile(conn, HFP_HS_UUID, HFP_VERSION_1_6, "hfp_hf",
 						HFP_EXT_PROFILE_PATH);
 }
 =

@@ -696,12 +605,6 @@ static int hfp_init(void)
 	if (DBUS_TYPE_UNIX_FD < 0)
 		return -EBADF;
 =

-	err =3D sco_init();
-	if (err < 0) {
-		ofono_error("SCO: %s(%d)", strerror(-err), -err);
-		return err;
-	}
-
 	/* Registers External Profile handler */
 	if (!g_dbus_register_interface(conn, HFP_EXT_PROFILE_PATH,
 					BLUEZ_PROFILE_INTERFACE,
@@ -746,9 +649,6 @@ static void hfp_exit(void)
 	ofono_modem_driver_unregister(&hfp_driver);
 	g_dbus_client_unref(bluez);
 =

-	if (sco_watch > 0)
-		g_source_remove(sco_watch);
-
 	ofono_handsfree_audio_unref();
 }
 =

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index bfce42a..24bb2ad 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -25,12 +25,17 @@
 =

 #include <errno.h>
 #include <stdio.h>
+#include <stdint.h>
 #include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/socket.h>
 =

 #include <gdbus.h>
 =

 #include <ofono/handsfree-audio.h>
 =

+#include "bluetooth.h"
 #include "ofono.h"
 =

 #define HFP_AUDIO_MANAGER_INTERFACE	OFONO_SERVICE ".HandsfreeAudioManager"
@@ -60,6 +65,87 @@ struct agent {
 static struct agent *agent =3D NULL;
 static int ref_count =3D 0;
 static GSList *card_list =3D 0;
+static guint sco_watch =3D 0;
+
+static int card_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_handsfree_card *card =3D a;
+	const char *remote =3D b;
+
+	return g_strcmp0(card->remote, remote);
+}
+
+static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct sockaddr_sco saddr;
+	socklen_t alen;
+	int sk, nsk;
+	char remote[18];
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
+	bt_ba2str(&saddr.sco_bdaddr, remote);
+
+	if (g_slist_find_custom(card_list, remote, card_cmp) =3D=3D NULL) {
+		ofono_error("Rejecting SCO: Audio Card not found!");
+		close(nsk);
+		return TRUE;
+	}
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
+	sco_watch =3D g_io_add_watch(sco_io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				sco_accept, NULL);
+
+	g_io_channel_unref(sco_io);
+
+	return 0;
+}
 =

 static void card_append_properties(struct ofono_handsfree_card *card,
 					DBusMessageIter *dict)
@@ -437,7 +523,7 @@ void ofono_handsfree_audio_unref(void)
 =

 int __ofono_handsfree_audio_manager_init(void)
 {
-	return 0;
+	return sco_init();
 }
 =

 void __ofono_handsfree_audio_manager_cleanup(void)
@@ -450,4 +536,7 @@ void __ofono_handsfree_audio_manager_cleanup(void)
 =

 	ref_count =3D 1;
 	ofono_handsfree_audio_unref();
+
+	if (sco_watch > 0)
+		g_source_remove(sco_watch);
 }
-- =

1.7.11.7


--===============1450423331609264105==--

