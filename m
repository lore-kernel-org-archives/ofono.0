Content-Type: multipart/mixed; boundary="===============6205915701685949285=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC 3/3] hfp_ag: update to org.bluez.Telephony interface
Date: Tue, 31 Jan 2012 16:50:05 +0100
Message-ID: <1328025005-12012-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1328025005-12012-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6205915701685949285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bluez moves agent registration from a per device interface to
a per adapter interface.
Update hfp_ag modem emulator to reflect this change.
---
 plugins/hfp_ag.c |  119 ++++++++++++++++++++++----------------------------=
---
 1 files changed, 49 insertions(+), 70 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index c2d1d30..b1e8188 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -35,97 +35,79 @@
 =

 #include "bluetooth.h"
 =

-#define HFP_AG_CHANNEL	13
+#define AGENT_PATH "/hfp_ag"
+#define VERSION_1_5 0x0105
+#define FEATURES	(HFP_AG_FEATURE_3WAY | HFP_AG_FEATURE_REJECT_CALL | \
+			HFP_AG_FEATURE_ENHANCED_CALL_STATUS | \
+			HFP_AG_FEATURE_ENHANCED_CALL_CONTROL | \
+			HFP_AG_FEATURE_EXTENDED_RES_CODE)
 =

-static struct server *server;
 static guint modemwatch_id;
 static GList *modems;
 static GHashTable *sim_hash =3D NULL;
 =

-static const gchar *hfp_ag_record =3D
-"<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
-"<record>\n"
-"  <attribute id=3D\"0x0001\">\n"
-"    <sequence>\n"
-"      <uuid value=3D\"0x111F\"/>\n"
-"      <uuid value=3D\"0x1203\"/>\n"
-"    </sequence>\n"
-"  </attribute>\n"
-"\n"
-"  <attribute id=3D\"0x0004\">\n"
-"    <sequence>\n"
-"      <sequence>\n"
-"        <uuid value=3D\"0x0100\"/>\n"
-"      </sequence>\n"
-"      <sequence>\n"
-"        <uuid value=3D\"0x0003\"/>\n"
-"        <uint8 value=3D\"13\" name=3D\"channel\"/>\n"
-"      </sequence>\n"
-"    </sequence>\n"
-"  </attribute>\n"
-"\n"
-"  <attribute id=3D\"0x0009\">\n"
-"    <sequence>\n"
-"      <sequence>\n"
-"        <uuid value=3D\"0x111E\"/>\n"
-"        <uint16 value=3D\"0x0105\" name=3D\"version\"/>\n"
-"      </sequence>\n"
-"    </sequence>\n"
-"  </attribute>\n"
-"\n"
-"  <attribute id=3D\"0x0100\">\n"
-"    <text value=3D\"Hands-Free Audio Gateway\" name=3D\"name\"/>\n"
-"  </attribute>\n"
-"\n"
-"  <attribute id=3D\"0x0301\">\n"
-"    <uint8 value=3D\"0x01\" />\n"
-"  </attribute>\n"
-"\n"
-"  <attribute id=3D\"0x0311\">\n"
-"    <uint16 value=3D\"0x0001\" />\n"
-"  </attribute>\n"
-"</record>\n";
-
-static void hfp_ag_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
+static DBusMessage *hfp_ag_agent_new_connection(DBusConnection *conn,
+						DBusMessage *msg, void *data)
 {
-	struct ofono_modem *modem;
-	struct ofono_emulator *em;
 	int fd;
+	const char *device, *uuid;
+	const char *path =3D NULL;
+	guint16 version =3D 0;
+	guint16 features =3D 0;
+	struct ofono_emulator *em;
+	struct ofono_modem *modem;
 =

-	DBG("");
+	fd =3D bluetooth_parse_newconnection_message(msg, &device, &uuid,
+						&version, &features, &path);
+	if (fd < 0)
+		return __ofono_error_invalid_args(msg);
 =

-	if (err) {
-		DBG("%s", err->message);
-		return;
-	}
+	DBG("New connection for %s on %s (version 0x%04X, features 0x%02X, " \
+					"media transport path: %s)",
+					device, uuid, version, features, path);
 =

 	/* Pick the first voicecall capable modem */
 	modem =3D modems->data;
 	if (modem =3D=3D NULL)
-		return;
+		return __ofono_error_failed(msg);
 =

 	DBG("Picked modem %p for emulator", modem);
 =

 	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_HFP);
 	if (em =3D=3D NULL)
-		return;
-
-	fd =3D g_io_channel_unix_get_fd(io);
-	g_io_channel_set_close_on_unref(io, FALSE);
+		return __ofono_error_failed(msg);
 =

 	ofono_emulator_register(em, fd);
+
+	return dbus_message_new_method_return(msg);
 }
 =

+static DBusMessage *hfp_ag_agent_release(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBG("");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable agent_methods[] =3D {
+	{ "NewConnection", "ha{sv}", "", hfp_ag_agent_new_connection,
+		G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Release", "", "", hfp_ag_agent_release },
+	{ NULL, NULL, NULL, NULL }
+};
+
 static void sim_state_watch(enum ofono_sim_state new_state, void *data)
 {
 	struct ofono_modem *modem =3D data;
 =

 	if (new_state !=3D OFONO_SIM_STATE_READY) {
+		if (modems =3D=3D NULL)
+			return;
+
 		modems =3D g_list_remove(modems, modem);
-		if (modems =3D=3D NULL && server !=3D NULL) {
-			bluetooth_unregister_server(server);
-			server =3D NULL;
-		}
+		if (modems =3D=3D NULL)
+			bluetooth_unregister_telephony_agent(AGENT_PATH);
 =

 		return;
 	}
@@ -138,8 +120,9 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *data)
 	if (modems->next !=3D NULL)
 		return;
 =

-	server =3D bluetooth_register_server(HFP_AG_CHANNEL, hfp_ag_record,
-						hfp_ag_connect_cb, NULL);
+	bluetooth_register_telephony_agent(AGENT_PATH, HFP_AG_UUID,
+						VERSION_1_5, FEATURES,
+						agent_methods, NULL, NULL);
 }
 =

 static gboolean sim_watch_remove(gpointer key, gpointer value,
@@ -203,14 +186,10 @@ static int hfp_ag_init(void)
 static void hfp_ag_exit(void)
 {
 	__ofono_modemwatch_remove(modemwatch_id);
+
 	g_list_free(modems);
 	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
 	g_hash_table_destroy(sim_hash);
-
-	if (server) {
-		bluetooth_unregister_server(server);
-		server =3D NULL;
-	}
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_ag, "Hands-Free Audio Gateway Profile Plugins", VE=
RSION,
-- =

1.7.1


--===============6205915701685949285==--

