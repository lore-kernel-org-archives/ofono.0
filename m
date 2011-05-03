Content-Type: multipart/mixed; boundary="===============0488943280807637894=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 3/3] connman: add plugin in oFono to request
 request/release private network
Date: Tue, 03 May 2011 17:06:16 +0200
Message-ID: <1304435176-4128-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1304433883-3806-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0488943280807637894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am       |    3 +
 plugins/connman.c |  255 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 plugins/connman.c

diff --git a/Makefile.am b/Makefile.am
index a413a47..37f9468 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -339,6 +339,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetooth=
.h
 builtin_modules +=3D dun_gw
 builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
 =

+builtin_modules +=3D connman
+builtin_sources +=3D plugins/connman.c
+
 builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
diff --git a/plugins/connman.c b/plugins/connman.c
new file mode 100644
index 0000000..47d4654
--- /dev/null
+++ b/plugins/connman.c
@@ -0,0 +1,255 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <gdbus.h>
+#include <string.h>
+
+#include <ofono.h>
+#include <emulator.h>
+
+#define CONNMAN_SERVICE			"net.connman"
+#define CONNMAN_PATH			"/net/connman"
+
+#define CONNMAN_DEBUG_INTERFACE		CONNMAN_SERVICE ".Debug"
+#define CONNMAN_ERROR_INTERFACE		CONNMAN_SERVICE ".Error"
+#define CONNMAN_AGENT_INTERFACE		CONNMAN_SERVICE ".Agent"
+#define CONNMAN_COUNTER_INTERFACE	CONNMAN_SERVICE ".Counter"
+
+#define CONNMAN_MANAGER_INTERFACE	CONNMAN_SERVICE ".Manager"
+#define CONNMAN_MANAGER_PATH		"/"
+
+#define CONNMAN_TASK_INTERFACE		CONNMAN_SERVICE ".Task"
+#define CONNMAN_PROFILE_INTERFACE	CONNMAN_SERVICE ".Profile"
+#define CONNMAN_SERVICE_INTERFACE	CONNMAN_SERVICE ".Service"
+#define CONNMAN_PROVIDER_INTERFACE	CONNMAN_SERVICE ".Provider"
+#define CONNMAN_TECHNOLOGY_INTERFACE	CONNMAN_SERVICE ".Technology"
+#define CONNMAN_SESSION_INTERFACE	CONNMAN_SERVICE ".Session"
+#define CONNMAN_NOTIFICATION_INTERFACE	CONNMAN_SERVICE ".Notification"
+
+static DBusConnection *connection;
+static GHashTable *pending_calls;
+static int id;
+
+static void settings_reply(DBusPendingCall *call, void *user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	DBusMessageIter array, dict, entry;
+	DBusMessage *reply;
+	int fd =3D -1;
+	const char *server_ip =3D NULL;
+	const char *peer_ip =3D NULL;
+	const char *primary_dns =3D NULL;
+	const char *secondary_dns =3D NULL;
+	int uid =3D ofono_emulator_get_uid(em);
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (!reply) {
+		g_hash_table_remove(pending_calls, &uid);
+		dbus_pending_call_unref(call);
+	}
+
+	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
+		goto done;
+
+	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_UNIX_FD)
+		goto done;
+
+	dbus_message_iter_get_basic(&array, &fd);
+	g_print("Fildescriptor =3D %d\n", fd);
+
+	dbus_message_iter_next(&array);
+
+	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
+		goto done;
+
+	dbus_message_iter_recurse(&array, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
+		DBusMessageIter iter;
+		const char *key;
+		int type;
+
+		dbus_message_iter_recurse(&dict, &entry);
+
+		dbus_message_iter_get_basic(&entry, &key);
+
+		g_print("key %s", key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &iter);
+
+		type =3D dbus_message_iter_get_arg_type(&iter);
+		if (type !=3D DBUS_TYPE_STRING)
+			break;
+
+		if (g_str_equal(key, "ServerIPv4")
+				&& type =3D=3D DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&iter, &server_ip);
+			g_print(" =3D %s\n", server_ip);
+
+		} else if (g_str_equal(key, "PeerIPv4")
+				&& type =3D=3D DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&iter, &peer_ip);
+			g_print(" =3D %s\n", peer_ip);
+
+		} else if (g_str_equal(key, "PrimaryDNS")
+				&& type =3D=3D DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&iter, &primary_dns);
+			g_print(" =3D %s\n", primary_dns);
+
+		} else if (g_str_equal(key, "SecondaryDNS")
+				&& type =3D=3D DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&iter, &secondary_dns);
+			g_print(" =3D %s\n", secondary_dns);
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+	if (server_ip =3D=3D NULL || peer_ip =3D=3D NULL ||
+		primary_dns =3D=3D NULL || secondary_dns =3D=3D NULL) {
+		ofono_error("Error while reading dictionnary...\n");
+		goto done;
+	}
+
+	ofono_emulator_setup_ppp(em, fd, server_ip, peer_ip, primary_dns,
+					secondary_dns);
+
+done:
+	g_hash_table_remove(pending_calls, &uid);
+	dbus_message_unref(reply);
+	dbus_pending_call_unref(call);
+}
+
+static int pn_get_settings(struct ofono_emulator *em)
+{
+	DBusMessage *message;
+	DBusPendingCall *call;
+
+	DBG("");
+
+	message =3D dbus_message_new_method_call(CONNMAN_SERVICE,
+				     CONNMAN_MANAGER_PATH,
+				     CONNMAN_MANAGER_INTERFACE,
+				     "RequestPrivateNetwork");
+
+	if (message =3D=3D NULL)
+		return -ENOMEM;
+
+	if (dbus_connection_send_with_reply(connection,
+				message, &call, 5000) =3D=3D FALSE) {
+		ofono_error("Error while sending message...");
+		dbus_message_unref(message);
+		return -EIO;
+	}
+
+	dbus_pending_call_set_notify(call, settings_reply,
+							em, NULL);
+
+	id++;
+	g_hash_table_insert(pending_calls, &id, call);
+
+	dbus_message_unref(message);
+
+	return id;
+}
+
+static void release_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply;
+
+	DBG("");
+
+	reply =3D dbus_pending_call_steal_reply(call);
+	dbus_pending_call_unref(call);
+}
+
+static void pn_release(int uid)
+{
+	DBusMessage *message;
+	DBusPendingCall *pending;
+	DBusPendingCall *call;
+
+	DBG("");
+
+	pending =3D g_hash_table_lookup(pending_calls, &uid);
+	if (pending) {
+		if (dbus_pending_call_get_completed(pending) =3D=3D FALSE) {
+			dbus_pending_call_cancel(pending);
+			g_hash_table_remove(pending_calls, &uid);
+			return;
+		}
+	}
+
+	message =3D dbus_message_new_method_call(CONNMAN_SERVICE,
+				     CONNMAN_MANAGER_PATH,
+				     CONNMAN_MANAGER_INTERFACE,
+				     "ReleasePrivateNetwork");
+
+	if (message =3D=3D NULL)
+		return;
+
+	if (dbus_connection_send_with_reply(connection,
+				message, &call, 5000) =3D=3D FALSE) {
+		dbus_message_unref(message);
+		return;
+	}
+
+	dbus_pending_call_set_notify(call, release_reply,
+							NULL, NULL);
+
+	dbus_message_unref(message);
+}
+
+static struct emulator_network_provision_driver pn_driver =3D {
+	.name		=3D "ConnMan Private Network",
+	.get_settings	=3D pn_get_settings,
+	.release	=3D pn_release,
+};
+
+static int connman_init(void)
+{
+	DBG("");
+
+	id =3D 0;
+	connection =3D ofono_dbus_get_connection();
+	pending_calls =3D g_hash_table_new(g_int_hash, g_int_equal);
+
+	return ofono_emulator_network_driver_register(&pn_driver);
+}
+
+static void connman_exit(void)
+{
+	g_hash_table_destroy(pending_calls);
+	ofono_emulator_network_driver_unregister(&pn_driver);
+}
+
+OFONO_PLUGIN_DEFINE(connman, "ConnMan plugin", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, connman_init, connman_exit)
-- =

1.7.1


--===============0488943280807637894==--

