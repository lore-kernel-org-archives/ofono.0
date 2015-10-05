Content-Type: multipart/mixed; boundary="===============8683951785795166710=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 2/2] hfp_ag_bluez5: register audio card
Date: Mon, 05 Oct 2015 10:35:23 +0200
Message-ID: <1444034123-2653-2-git-send-email-simon.fels@canonical.com>
In-Reply-To: <1444034123-2653-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8683951785795166710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To let others (PulseAudio) be notified when a handsfree device is
connected with us and can be used for audio routing we need to
expose this by registering a audio card with the correct type.

For now there is no need to provide a card driver and we just stick
to what the core provides.
---
 plugins/hfp_ag_bluez5.c | 81 ++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 93de302..85ff442 100644
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
@@ -35,9 +36,12 @@
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
+#include <ofono/handsfree.h>
+#include <ofono/handsfree-audio.h>
 =

 #include "hfp.h"
 #include "bluez5.h"
+#include "bluetooth.h"
 =

 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
@@ -50,6 +54,11 @@ static GList *modems;
 static GHashTable *sim_hash =3D NULL;
 static GHashTable *connection_hash;
 =

+struct device_info {
+	int fd;
+	struct ofono_handsfree_card *card;
+};
+
 static void connection_destroy(gpointer data)
 {
 	int fd =3D GPOINTER_TO_INT(data);
@@ -77,8 +86,13 @@ static DBusMessage *profile_new_connection(DBusConnectio=
n *conn,
 	const char *device;
 	GIOChannel *io;
 	int fd, fd_dup;
+	struct sockaddr_rc saddr;
+	socklen_t optlen;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
+	struct device_info *dev;
+	char local[18], remote[18];
+	int err;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -95,7 +109,10 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 		goto invalid;
 =

 	dbus_message_iter_get_basic(&entry, &fd);
+
 	dbus_message_iter_next(&entry);
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_ARRAY)
+		goto invalid;
 =

 	if (fd < 0)
 		goto invalid;
@@ -111,8 +128,35 @@ static DBusMessage *profile_new_connection(DBusConnect=
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
@@ -129,8 +173,18 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 						g_strdup(device), g_free);
 	g_io_channel_unref(io);
 =

-	g_hash_table_insert(connection_hash, g_strdup(device),
-						GINT_TO_POINTER(fd_dup));
+	dev =3D g_new0(struct device_info, 1);
+	dev->fd =3D fd_dup;
+
+	dev->card =3D ofono_handsfree_card_create(0, OFONO_HANDSFREE_CARD_TYPE_GA=
TEWAY,
+											NULL, NULL);
+
+	ofono_handsfree_card_set_local(dev->card, local);
+	ofono_handsfree_card_set_remote(dev->card, remote);
+
+	g_hash_table_insert(connection_hash, g_strdup(device), dev);
+
+	ofono_handsfree_card_register(dev->card);
 =

 	return dbus_message_new_method_return(msg);
 =

@@ -164,7 +218,7 @@ static DBusMessage *profile_disconnection(DBusConnectio=
n *conn,
 {
 	DBusMessageIter iter;
 	const char *device;
-	gpointer fd;
+	struct device_info *dev;
 =

 	DBG("Profile handler RequestDisconnection");
 =

@@ -178,11 +232,11 @@ static DBusMessage *profile_disconnection(DBusConnect=
ion *conn,
 =

 	DBG("%s", device);
 =

-	fd =3D g_hash_table_lookup(connection_hash, device);
-	if (fd =3D=3D NULL)
+	dev =3D g_hash_table_lookup(connection_hash, device);
+	if (!dev)
 		goto invalid;
 =

-	shutdown(GPOINTER_TO_INT(fd), SHUT_RDWR);
+	shutdown(GPOINTER_TO_INT(dev->fd), SHUT_RDWR);
 =

 	g_hash_table_remove(connection_hash, device);
 =

@@ -321,6 +375,15 @@ static void call_modemwatch(struct ofono_modem *modem,=
 void *user)
 	modem_watch(modem, TRUE, user);
 }
 =

+static void free_device_info(void *user_data)
+{
+	struct device_info *dev =3D user_data;
+
+	ofono_handsfree_card_remove(dev->card);
+
+	g_free(dev);
+}
+
 static int hfp_ag_init(void)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -344,7 +407,9 @@ static int hfp_ag_init(void)
 	__ofono_modem_foreach(call_modemwatch, NULL);
 =

 	connection_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-					g_free, connection_destroy);
+					free_device_info, connection_destroy);
+
+	ofono_handsfree_audio_ref();
 =

 	return 0;
 }
@@ -362,6 +427,8 @@ static void hfp_ag_exit(void)
 	g_list_free(modems);
 	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
 	g_hash_table_destroy(sim_hash);
+
+	ofono_handsfree_audio_unref();
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_ag_bluez5, "Hands-Free Audio Gateway Profile Plugi=
ns",
-- =

2.5.0


--===============8683951785795166710==--

