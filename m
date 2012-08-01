Content-Type: multipart/mixed; boundary="===============0714511830110374174=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v6 12/12] dun_gw: Update to org.bluez.Telephony interface
Date: Wed, 01 Aug 2012 12:09:47 +0200
Message-ID: <1343815787-22670-13-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343815787-22670-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0714511830110374174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bluez moves agent registration from a per device interface to
a per adapter interface.
Update dun_gw modem emulator to reflect this change.
---
 plugins/dun_gw.c |  119 ++++++++++++++++++++++++--------------------------=
----
 1 file changed, 52 insertions(+), 67 deletions(-)

diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
index 75b62eb..5cc839e 100644
--- a/plugins/dun_gw.c
+++ b/plugins/dun_gw.c
@@ -35,77 +35,65 @@
 =

 #include "bluetooth.h"
 =

-#define DUN_GW_CHANNEL	1
+#define AGENT_PATH	"/dun_gw"
+#define VERSION_1_0	0x0100
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
 =

-static struct server *server;
 static guint modemwatch_id;
 static GList *modems;
 =

-static const gchar *dun_record =3D
-"<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
-"<record>\n"
-"  <attribute id=3D\"0x0001\">\n"
-"    <sequence>\n"
-"      <uuid value=3D\"0x1103\"/>\n"
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
-"        <uint8 value=3D\"1\" name=3D\"channel\"/>\n"
-"      </sequence>\n"
-"    </sequence>\n"
-"  </attribute>\n"
-"\n"
-"  <attribute id=3D\"0x0009\">\n"
-"    <sequence>\n"
-"      <sequence>\n"
-"        <uuid value=3D\"0x1103\"/>\n"
-"        <uint16 value=3D\"0x0100\" name=3D\"version\"/>\n"
-"      </sequence>\n"
-"    </sequence>\n"
-"  </attribute>\n"
-"\n"
-"  <attribute id=3D\"0x0100\">\n"
-"    <text value=3D\"Dial-up Networking\" name=3D\"name\"/>\n"
-"  </attribute>\n"
-"</record>\n";
-
-static void dun_gw_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
+static DBusMessage *dun_gw_agent_new_connection(DBusConnection *conn,
+						DBusMessage *msg, void *data)
 {
-	struct ofono_emulator *em =3D user_data;
-	struct ofono_modem *modem;
 	int fd;
+	const char *device;
+	guint16 version =3D 0;
+	struct ofono_emulator *em;
+	struct ofono_modem *modem;
 =

-	DBG("");
+	fd =3D bluetooth_parse_newconnection_message(msg, &device, &version, NULL,
+							NULL);
+	if (fd < 0)
+		return __ofono_error_invalid_args(msg);
 =

-	if (err) {
-		DBG("%s", err->message);
-		g_io_channel_shutdown(io, TRUE, NULL);
-		return;
-	}
+	DBG("New connection for %s (version 0x%04X)", device, version);
 =

 	/* Pick the first powered modem */
 	modem =3D modems->data;
+	if (modem =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
 	DBG("Picked modem %p for emulator", modem);
 =

 	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_DUN);
-	if (em =3D=3D NULL) {
-		g_io_channel_shutdown(io, TRUE, NULL);
-		return;
-	}
-
-	fd =3D g_io_channel_unix_get_fd(io);
-	g_io_channel_set_close_on_unref(io, FALSE);
+	if (em =3D=3D NULL)
+		return __ofono_error_failed(msg);
 =

 	ofono_emulator_register(em, fd);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *dun_gw_agent_release(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBG("");
+
+	return dbus_message_new_method_return(msg);
 }
 =

+static const GDBusMethodTable agent_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("NewConnection",
+				GDBUS_ARGS({ "fd", "h" },
+						{ "property", "a{sv}" }),
+				NULL, dun_gw_agent_new_connection) },
+	{ GDBUS_METHOD("Release", NULL, NULL, dun_gw_agent_release) },
+	{ }
+};
+
 static void gprs_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
@@ -115,17 +103,16 @@ static void gprs_watch(struct ofono_atom *atom,
 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
 		modems =3D g_list_append(modems, modem);
 =

-		if (modems->next =3D=3D NULL)
-			server =3D bluetooth_register_server(DUN_GW_CHANNEL,
-					dun_record,
-					dun_gw_connect_cb,
-					NULL);
+		if (modems->next !=3D NULL)
+			return;
+
+		bluetooth_register_telephony_agent(AGENT_PATH, DUN_GW_UUID,
+						   VERSION_1_0, 0,
+						   agent_methods, NULL, NULL);
 	} else {
 		modems =3D g_list_remove(modems, modem);
-		if (modems =3D=3D NULL && server !=3D NULL) {
-			bluetooth_unregister_server(server);
-			server =3D NULL;
-		}
+		if (modems =3D=3D NULL)
+			bluetooth_unregister_telephony_agent(AGENT_PATH);
 	}
 }
 =

@@ -149,6 +136,9 @@ static int dun_gw_init(void)
 {
 	DBG("");
 =

+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 =

 	__ofono_modem_foreach(call_modemwatch, NULL);
@@ -160,11 +150,6 @@ static void dun_gw_exit(void)
 {
 	__ofono_modemwatch_remove(modemwatch_id);
 	g_list_free(modems);
-
-	if (server) {
-		bluetooth_unregister_server(server);
-		server =3D NULL;
-	}
 }
 =

 OFONO_PLUGIN_DEFINE(dun_gw, "Dial-up Networking Profile Plugins", VERSION,
-- =

1.7.9.5


--===============0714511830110374174==--

