Content-Type: multipart/mixed; boundary="===============6963244476828822147=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 2/3] ofono: Add support for message_manager tracking
Date: Fri, 06 Jul 2012 11:32:26 +0200
Message-ID: <1341567147-18467-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1341567147-18467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6963244476828822147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.c |  135 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 135 insertions(+)

diff --git a/plugins/ofono.c b/plugins/ofono.c
index 45fac91..8f2e71f 100644
--- a/plugins/ofono.c
+++ b/plugins/ofono.c
@@ -40,6 +40,7 @@
 #define OFONO_SIM_INTERFACE	OFONO_SERVICE ".SimManager"
 #define OFONO_GPRS_INTERFACE	OFONO_SERVICE ".ConnectionManager"
 #define OFONO_CONTEXT_INTERFACE	OFONO_SERVICE ".ConnectionContext"
+#define OFONO_MESSAGE_MANAGER_INTERFACE	OFONO_SERVICE ".MessageManager"
 #define OFONO_PUSH_INTERFACE	OFONO_SERVICE ".PushNotification"
 #define OFONO_AGENT_INTERFACE	OFONO_SERVICE ".PushNotificationAgent"
 =

@@ -59,6 +60,7 @@ struct modem_data {
 	dbus_bool_t context_active;
 	char *context_interface;
 	char *context_proxy;
+	dbus_bool_t use_dr;
 };
 =

 static GHashTable *modem_list;
@@ -885,6 +887,126 @@ static int get_gprs_properties(struct modem_data *mod=
em)
 	return 0;
 }
 =

+static void check_message_mgr_delivery_report(struct modem_data *modem,
+							DBusMessageIter *iter)
+{
+	dbus_bool_t use_dr;
+
+	dbus_message_iter_get_basic(iter, &use_dr);
+
+	if (modem->use_dr =3D=3D use_dr)
+		return;
+
+	modem->use_dr =3D use_dr;
+
+	DBG("Use DeliveryReport %d", modem->use_dr);
+
+	mms_service_set_delivery_report(modem->service, modem->use_dr);
+}
+
+static gboolean message_mgr_changed(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	struct modem_data *modem;
+	DBusMessageIter iter, value;
+	const char *path, *key;
+
+	if (dbus_message_iter_init(message, &iter) =3D=3D FALSE)
+		return TRUE;
+
+	path =3D dbus_message_get_path(message);
+
+	modem =3D g_hash_table_lookup(modem_list, path);
+	if (modem =3D=3D NULL)
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &key);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &value);
+
+	if (g_str_equal(key, "UseDeliveryReports") =3D=3D TRUE)
+		check_message_mgr_delivery_report(modem, &value);
+
+	return TRUE;
+}
+
+static void get_message_mgr_properties_reply(DBusPendingCall *call,
+								void *user_data)
+{
+	struct modem_data *modem =3D user_data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusMessageIter iter, dict;
+	DBusError err;
+
+	dbus_error_init(&err);
+
+	if (dbus_set_error_from_message(&err, reply) =3D=3D TRUE) {
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	if (dbus_message_has_signature(reply, "a{sv}") =3D=3D FALSE)
+		goto done;
+
+	if (dbus_message_iter_init(reply, &iter) =3D=3D FALSE)
+		goto done;
+
+	dbus_message_iter_recurse(&iter, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
+		DBusMessageIter entry, value;
+		const char *key;
+
+		dbus_message_iter_recurse(&dict, &entry);
+
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (g_str_equal(key, "UseDeliveryReports") =3D=3D TRUE)
+			check_message_mgr_delivery_report(modem, &value);
+
+		dbus_message_iter_next(&dict);
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
+static int get_message_mgr_properties(struct modem_data *modem)
+{
+	DBusConnection *conn =3D modem->conn;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+
+	msg =3D dbus_message_new_method_call(OFONO_SERVICE, modem->path,
+					OFONO_MESSAGE_MANAGER_INTERFACE,
+					"GetProperties");
+	if (msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_set_auto_start(msg, FALSE);
+
+	if (dbus_connection_send_with_reply(conn, msg, &call, -1) =3D=3D FALSE) {
+		dbus_message_unref(msg);
+		return -EIO;
+	}
+
+	dbus_message_unref(msg);
+
+	if (call =3D=3D NULL)
+		return -EINVAL;
+
+	dbus_pending_call_set_notify(call, get_message_mgr_properties_reply,
+							modem, NULL);
+
+	dbus_pending_call_unref(call);
+
+	return 0;
+}
+
 static void check_interfaces(struct modem_data *modem, DBusMessageIter *it=
er)
 {
 	DBusMessageIter entry;
@@ -963,6 +1085,8 @@ static void check_interfaces(struct modem_data *modem,=
 DBusMessageIter *iter)
 		if (modem->has_push =3D=3D FALSE && modem->has_agent =3D=3D TRUE)
 			remove_agent(modem);
 	}
+
+	get_message_mgr_properties(modem);
 }
 =

 static void create_modem(DBusConnection *conn,
@@ -982,6 +1106,7 @@ static void create_modem(DBusConnection *conn,
 	modem->has_gprs =3D FALSE;
 	modem->has_push =3D FALSE;
 	modem->has_agent =3D FALSE;
+	modem->use_dr =3D FALSE;
 =

 	modem->service =3D mms_service_create();
 =

@@ -1146,6 +1271,7 @@ static guint gprs_changed_watch;
 static guint context_added_watch;
 static guint context_removed_watch;
 static guint context_changed_watch;
+static guint message_mgr_changed_watch;
 =

 static void ofono_connect(DBusConnection *conn, void *user_data)
 {
@@ -1188,6 +1314,10 @@ static void ofono_connect(DBusConnection *conn, void=
 *user_data)
 				OFONO_CONTEXT_INTERFACE, "PropertyChanged",
 						context_changed, NULL, NULL);
 =

+	message_mgr_changed_watch =3D g_dbus_add_signal_watch(conn, NULL, NULL,
+			OFONO_MESSAGE_MANAGER_INTERFACE, "PropertyChanged",
+					message_mgr_changed, NULL, NULL);
+
 	get_modems(conn);
 }
 =

@@ -1237,6 +1367,11 @@ static void ofono_disconnect(DBusConnection *conn, v=
oid *user_data)
 		context_changed_watch =3D 0;
 	}
 =

+	if (message_mgr_changed_watch > 0) {
+		g_dbus_remove_watch(conn, message_mgr_changed_watch);
+		message_mgr_changed_watch =3D 0;
+	}
+
 	g_hash_table_destroy(modem_list);
 	modem_list =3D NULL;
 }
-- =

1.7.9.5


--===============6963244476828822147==--

