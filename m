Content-Type: multipart/mixed; boundary="===============3036702426618170904=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 3/6] radio settings: add FastDormancy property
Date: Tue, 26 Oct 2010 18:31:50 +0300
Message-ID: <1288107113-2740-4-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288107113-2740-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3036702426618170904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/radio-settings.h |   13 +++++
 src/radio-settings.c     |  114 ++++++++++++++++++++++++++++++++++++++++++=
+--
 2 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/include/radio-settings.h b/include/radio-settings.h
index 1b133e9..9a00772 100644
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -44,6 +44,12 @@ typedef void (*ofono_radio_settings_rat_mode_query_cb_t)=
(const struct ofono_erro
 						enum ofono_radio_access_mode mode,
 						void *data);
 =

+typedef void (*ofono_radio_settings_fast_dormancy_set_cb_t)(const struct o=
fono_error *error,
+							void *data);
+typedef void (*ofono_radio_settings_fast_dormancy_query_cb_t)(const struct=
 ofono_error *error,
+							ofono_bool_t enable,
+							void *data);
+
 struct ofono_radio_settings_driver {
 	const char *name;
 	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor,
@@ -56,6 +62,13 @@ struct ofono_radio_settings_driver {
 				enum ofono_radio_access_mode mode,
 				ofono_radio_settings_rat_mode_set_cb_t cb,
 				void *data);
+	void (*query_fast_dormancy)(struct ofono_radio_settings *rs,
+			ofono_radio_settings_fast_dormancy_query_cb_t cb,
+			void *data);
+	void (*set_fast_dormancy)(struct ofono_radio_settings *rs,
+				int enable,
+				ofono_radio_settings_fast_dormancy_set_cb_t,
+				void *data);
 };
 =

 int ofono_radio_settings_driver_register(const struct ofono_radio_settings=
_driver *d);
diff --git a/src/radio-settings.c b/src/radio-settings.c
index 173e5bf..223ee51 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -33,7 +33,7 @@
 #include "ofono.h"
 #include "common.h"
 =

-#define RADIO_SETTINGS_MODE_CACHED 0x1
+#define RADIO_SETTINGS_FLAG_CACHED 0x1
 =

 static GSList *g_drivers =3D NULL;
 =

@@ -42,6 +42,8 @@ struct ofono_radio_settings {
 	int flags;
 	enum ofono_radio_access_mode mode;
 	enum ofono_radio_access_mode pending_mode;
+	ofono_bool_t fast_dormancy;
+	ofono_bool_t fast_dormancy_pending;
 	const struct ofono_radio_settings_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -106,11 +108,55 @@ static DBusMessage *radio_get_properties_reply(DBusMe=
ssage *msg,
 	ofono_dbus_dict_append(&dict, "TechnologyPreference",
 					DBUS_TYPE_STRING, &mode);
 =

+	if (rs->driver->query_fast_dormancy) {
+		dbus_bool_t value =3D rs->fast_dormancy;
+		ofono_dbus_dict_append(&dict, "FastDormancy",
+					DBUS_TYPE_BOOLEAN, &value);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
 }
 =

+static void radio_set_fast_dormancy(struct ofono_radio_settings *rs,
+					ofono_bool_t enable)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(rs->atom);
+	dbus_bool_t value =3D enable;
+
+	if ((rs->flags & RADIO_SETTINGS_FLAG_CACHED) &&
+		rs->fast_dormancy =3D=3D enable)
+		return;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_RADIO_SETTINGS_INTERFACE,
+						"FastDormancy",
+						DBUS_TYPE_BOOLEAN, &value);
+	rs->fast_dormancy =3D enable;
+}
+
+static void radio_fast_dormancy_set_callback(const struct ofono_error *err=
or,
+						void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error setting fast dormancy");
+		rs->fast_dormancy_pending =3D rs->fast_dormancy;
+		reply =3D __ofono_error_failed(rs->pending);
+		__ofono_dbus_pending_reply(&rs->pending, reply);
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(rs->pending);
+	__ofono_dbus_pending_reply(&rs->pending, reply);
+
+	radio_set_fast_dormancy(rs, rs->fast_dormancy_pending);
+}
+
 static void radio_set_rat_mode(struct ofono_radio_settings *rs,
 				enum ofono_radio_access_mode mode)
 {
@@ -122,7 +168,6 @@ static void radio_set_rat_mode(struct ofono_radio_setti=
ngs *rs,
 		return;
 =

 	rs->mode =3D mode;
-	rs->flags |=3D RADIO_SETTINGS_MODE_CACHED;
 =

 	path =3D __ofono_atom_get_path(rs->atom);
 	str_mode =3D radio_access_mode_to_string(rs->mode);
@@ -152,6 +197,43 @@ static void radio_mode_set_callback(const struct ofono=
_error *error, void *data)
 	radio_set_rat_mode(rs, rs->pending_mode);
 }
 =

+static void radio_send_properties_reply(struct ofono_radio_settings *rs)
+{
+	DBusMessage *reply;
+
+	rs->flags |=3D RADIO_SETTINGS_FLAG_CACHED;
+	reply =3D radio_get_properties_reply(rs->pending, rs);
+	__ofono_dbus_pending_reply(&rs->pending, reply);
+}
+
+static void radio_fast_dormancy_query_callback(const struct ofono_error *e=
rror,
+						ofono_bool_t enable, void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error during fast dormancy query");
+		reply =3D __ofono_error_failed(rs->pending);
+		__ofono_dbus_pending_reply(&rs->pending, reply);
+		return;
+	}
+
+	radio_set_fast_dormancy(rs, enable);
+	radio_send_properties_reply(rs);
+}
+
+static void radio_query_fast_dormancy(struct ofono_radio_settings *rs)
+{
+	if (!rs->driver->query_fast_dormancy) {
+		radio_send_properties_reply(rs);
+		return;
+	}
+
+	rs->driver->query_fast_dormancy(rs, radio_fast_dormancy_query_callback,
+					rs);
+}
+
 static void radio_rat_mode_query_callback(const struct ofono_error *error,
 					enum ofono_radio_access_mode mode,
 					void *data)
@@ -167,9 +249,7 @@ static void radio_rat_mode_query_callback(const struct =
ofono_error *error,
 	}
 =

 	radio_set_rat_mode(rs, mode);
-
-	reply =3D radio_get_properties_reply(rs->pending, rs);
-	__ofono_dbus_pending_reply(&rs->pending, reply);
+	radio_query_fast_dormancy(rs);
 }
 =

 static DBusMessage *radio_get_properties(DBusConnection *conn,
@@ -177,7 +257,7 @@ static DBusMessage *radio_get_properties(DBusConnection=
 *conn,
 {
 	struct ofono_radio_settings *rs =3D data;
 =

-	if (rs->flags & RADIO_SETTINGS_MODE_CACHED)
+	if (rs->flags & RADIO_SETTINGS_FLAG_CACHED)
 		return radio_get_properties_reply(msg, rs);
 =

 	if (!rs->driver->query_rat_mode)
@@ -240,6 +320,28 @@ static DBusMessage *radio_set_property(DBusConnection =
*conn, DBusMessage *msg,
 		rs->driver->set_rat_mode(rs, mode, radio_mode_set_callback, rs);
 =

 		return NULL;
+	} else if (g_strcmp0(property, "FastDormancy") =3D=3D 0) {
+		dbus_bool_t value;
+		int target;
+
+		if (!rs->driver->set_fast_dormancy)
+			return __ofono_error_not_implemented(msg);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		target =3D value;
+
+		if (rs->fast_dormancy_pending =3D=3D target)
+			return dbus_message_new_method_return(msg);
+
+		rs->pending =3D dbus_message_ref(msg);
+		rs->fast_dormancy_pending =3D target;
+
+		rs->driver->set_fast_dormancy(rs, target,
+					radio_fast_dormancy_set_callback, rs);
+		return NULL;
 	}
 =

 	return __ofono_error_invalid_args(msg);
-- =

1.7.0.4


--===============3036702426618170904==--

