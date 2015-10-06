Content-Type: multipart/mixed; boundary="===============4063681579736723020=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 3/3] hfp_ag_bluez5: register audio card
Date: Tue, 06 Oct 2015 12:48:14 +0200
Message-ID: <1444128494-31742-4-git-send-email-simon.fels@canonical.com>
In-Reply-To: <1444128494-31742-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4063681579736723020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To let others (PulseAudio) be notified when a handsfree device is
connected with us and can be used for audio routing we need to
expose this by registering a audio card with the correct type.
---
 plugins/hfp_ag_bluez5.c | 49 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/emulator.c          |  1 +
 2 files changed, 50 insertions(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 93de302..ef8a048 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -22,6 +22,7 @@
 #include <config.h>
 #endif
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
@@ -35,15 +36,18 @@
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
+#include <ofono/handsfree-audio.h>
 =

 #include "hfp.h"
 #include "bluez5.h"
+#include "bluetooth.h"
 =

 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
 #endif
 =

 #define HFP_AG_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_ag"
+#define BT_ADDR_SIZE 18
 =

 static guint modemwatch_id;
 static GList *modems;
@@ -77,8 +81,13 @@ static DBusMessage *profile_new_connection(DBusConnectio=
n *conn,
 	const char *device;
 	GIOChannel *io;
 	int fd, fd_dup;
+	struct sockaddr_rc saddr;
+	socklen_t optlen;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
+	char local[BT_ADDR_SIZE], remote[BT_ADDR_SIZE];
+	struct ofono_handsfree_card *card;
+	int err;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -111,8 +120,35 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	}
 =

 	modem =3D modems->data;
+
 	DBG("Picked modem %p for emulator", modem);
 =

+	memset(&saddr, 0, sizeof(saddr));
+	optlen =3D sizeof(saddr);
+
+	if (getsockname(fd, (struct sockaddr *) &saddr, &optlen) < 0) {
+		err =3D errno;
+		ofono_error("RFCOMM getsockname(): %s (%d)", strerror(err),
+									err);
+		close(fd);
+		goto invalid;
+	}
+
+	bt_ba2str(&saddr.rc_bdaddr, local);
+
+	memset(&saddr, 0, sizeof(saddr));
+	optlen =3D sizeof(saddr);
+
+	if (getpeername(fd, (struct sockaddr *) &saddr, &optlen) < 0) {
+		err =3D errno;
+		ofono_error("RFCOMM getpeername(): %s (%d)", strerror(err),
+									err);
+		close(fd);
+		goto invalid;
+	}
+
+	bt_ba2str(&saddr.rc_bdaddr, remote);
+
 	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_HFP);
 	if (em =3D=3D NULL) {
 		close(fd);
@@ -129,6 +165,15 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 						g_strdup(device), g_free);
 	g_io_channel_unref(io);
 =

+	card =3D ofono_handsfree_card_create(0,
+					OFONO_HANDSFREE_CARD_TYPE_GATEWAY,
+					NULL, NULL);
+
+	ofono_handsfree_card_set_local(card, local);
+	ofono_handsfree_card_set_remote(card, remote);
+
+	ofono_emulator_set_handsfree_card(em, card);
+
 	g_hash_table_insert(connection_hash, g_strdup(device),
 						GINT_TO_POINTER(fd_dup));
 =

@@ -346,6 +391,8 @@ static int hfp_ag_init(void)
 	connection_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 					g_free, connection_destroy);
 =

+	ofono_handsfree_audio_ref();
+
 	return 0;
 }
 =

@@ -362,6 +409,8 @@ static void hfp_ag_exit(void)
 	g_list_free(modems);
 	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
 	g_hash_table_destroy(sim_hash);
+
+	ofono_handsfree_audio_unref();
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_ag_bluez5, "Hands-Free Audio Gateway Profile Plugi=
ns",
diff --git a/src/emulator.c b/src/emulator.c
index 5be7b63..626dec3 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -35,6 +35,7 @@
 #include "hfp.h"
 #include "gatserver.h"
 #include "gatppp.h"
+#include "handsfree-audio.h"
 =

 #define RING_TIMEOUT 3
 =

-- =

2.5.0


--===============4063681579736723020==--

