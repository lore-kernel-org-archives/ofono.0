Content-Type: multipart/mixed; boundary="===============8750755505176833287=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 3/6] cdma-connman: Add DormantInterval porperty and dormant
 notification
Date: Wed, 07 Dec 2011 17:05:48 +0100
Message-ID: <1323273951-24162-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323273951-24162-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8750755505176833287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 87cefd6..38ee165 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -38,6 +38,8 @@
 #include "ofono.h"
 #include "common.h"
 =

+#define MAX_DORMANT_INTERVAL 300
+
 static GSList *g_drivers;
 =

 struct cdma_connman_settings {
@@ -52,6 +54,7 @@ struct cdma_connman_settings {
 struct ofono_cdma_connman {
 	ofono_bool_t powered;
 	ofono_bool_t dormant;
+	int dormant_interval;
 	struct cdma_connman_settings *settings;
 	DBusMessage *pending;
 	const struct ofono_cdma_connman_driver *driver;
@@ -319,6 +322,33 @@ static void deactivate_callback(const struct ofono_err=
or *error, void *data)
 				"Powered", DBUS_TYPE_BOOLEAN, &value);
 }
 =

+static void set_dormant_interval_callback(const struct ofono_error *error,=
 void *data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_cdma_connman *cm =3D data;
+	int value;
+	const char *path;
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Setting dormant interval failed with error: %s",
+				telephony_error_to_str(error));
+		__ofono_dbus_pending_reply(&cm->pending,
+					__ofono_error_failed(cm->pending));
+		cm->dormant_interval =3D -1;
+	}
+
+	__ofono_dbus_pending_reply(&cm->pending,
+				dbus_message_new_method_return(cm->pending));
+
+	path =3D __ofono_atom_get_path(cm->atom);
+	value =3D cm->dormant_interval;
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE,
+				"DormantInterval", DBUS_TYPE_INT32, &value);
+}
+
 static void cdma_connman_settings_append_properties(
 						struct ofono_cdma_connman *cm,
 						DBusMessageIter *dict)
@@ -371,6 +401,7 @@ static DBusMessage *cdma_connman_get_properties(DBusCon=
nection *conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	dbus_bool_t value;
+	int dorm_int;
 =

 	DBG("");
 =

@@ -390,6 +421,12 @@ static DBusMessage *cdma_connman_get_properties(DBusCo=
nnection *conn,
 	value =3D cm->dormant;
 	ofono_dbus_dict_append(&dict, "Dormant", DBUS_TYPE_BOOLEAN, &value);
 =

+	if (cm->dormant_interval >=3D 0) {
+		dorm_int =3D cm->dormant_interval;
+		ofono_dbus_dict_append(&dict, "Dormant", DBUS_TYPE_BOOLEAN,
+					&dorm_int);
+	}
+
 	if (cm->settings)
 		cdma_connman_settings_append_properties(cm, &dict);
 =

@@ -455,6 +492,7 @@ static DBusMessage *cdma_connman_set_property(DBusConne=
ction *conn,
 	const char *property;
 	dbus_bool_t value;
 	const char *str;
+	int dormant;
 =

 	DBG("");
 =

@@ -512,9 +550,27 @@ static DBusMessage *cdma_connman_set_property(DBusConn=
ection *conn,
 =

 		dbus_message_iter_get_basic(&var, &str);
 		return cdma_connman_set_password(cm, conn, msg, str);
-	}
+	} else if (!strcmp(property, "DormantInterval")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_INT32)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &dormant);
+
+		if (dormant < 0 || dormant > MAX_DORMANT_INTERVAL)
+			return __ofono_error_invalid_args(msg);
 =

-	/* TODO: Dormant property. Not yet supported. */
+		if (cm->driver =3D=3D NULL || cm->driver->set_dormant_interval
+				=3D=3D NULL)
+			return __ofono_error_not_implemented(msg);
+
+		cm->dormant_interval =3D dormant;
+		cm->pending =3D dbus_message_ref(msg);
+
+		cm->driver->set_dormant_interval(cm, dormant,
+					 set_dormant_interval_callback, cm);
+
+		return NULL;
+	}
 =

 	return __ofono_error_invalid_args(msg);
 }
@@ -572,6 +628,23 @@ void ofono_cdma_connman_deactivated(struct ofono_cdma_=
connman *cm)
 				"Powered", DBUS_TYPE_BOOLEAN, &value);
 }
 =

+void ofono_cdma_connman_dormant_state_notify(struct ofono_cdma_connman *cm,
+						ofono_bool_t dormant)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	if (cm =3D=3D NULL)
+		return;
+
+	cm->dormant =3D dormant;
+	path =3D __ofono_atom_get_path(cm->atom);
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE,
+				"Dormant", DBUS_TYPE_BOOLEAN, &dormant);
+}
+
 static void cdma_connman_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -619,6 +692,8 @@ struct ofono_cdma_connman *ofono_cdma_connman_create(
 	if (cm =3D=3D NULL)
 		return NULL;
 =

+	cm->dormant_interval =3D -1;
+
 	cm->atom =3D __ofono_modem_add_atom(modem,
 					OFONO_ATOM_TYPE_CDMA_CONNMAN,
 					cdma_connman_remove, cm);
-- =

1.7.1


--===============8750755505176833287==--

