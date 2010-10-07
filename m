Content-Type: multipart/mixed; boundary="===============6729732618093824106=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 2/4] radio settings: add FastDormancy property
Date: Thu, 07 Oct 2010 16:37:31 +0300
Message-ID: <1286458653-12096-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1286458653-12096-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6729732618093824106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/radio-settings.h |   14 ++++++
 src/radio-settings.c     |  104 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 117 insertions(+), 1 deletions(-)

diff --git a/include/radio-settings.h b/include/radio-settings.h
index d41ec0b..20c2a51 100644
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -42,6 +42,13 @@ typedef void (*ofono_radio_settings_rat_mode_set_cb_t)(c=
onst struct ofono_error
 typedef void (*ofono_radio_settings_rat_mode_query_cb_t)(const struct ofon=
o_error *error,
 						enum ofono_radio_access_mode mode,
 						void *data);
+typedef void (*ofono_radio_settings_fast_dormancy_set_cb_t)(
+	const struct ofono_error *error,
+	void *data);
+typedef void (*ofono_radio_settings_fast_dormancy_query_cb_t)(
+	const struct ofono_error *error,
+	ofono_bool_t enable,
+	void *data);
 =

 struct ofono_radio_settings_driver {
 	const char *name;
@@ -55,6 +62,13 @@ struct ofono_radio_settings_driver {
 				enum ofono_radio_access_mode mode,
 				ofono_radio_settings_rat_mode_set_cb_t cb,
 				void *data);
+	void (*query_fast_dormancy)(struct ofono_radio_settings *rs,
+			ofono_radio_settings_fast_dormancy_query_cb_t cb,
+			void *data);
+	void (*set_fast_dormancy)(struct ofono_radio_settings *rs,
+				ofono_bool_t enable,
+				ofono_radio_settings_fast_dormancy_set_cb_t,
+				void *data);
 };
 =

 int ofono_radio_settings_driver_register(const struct ofono_radio_settings=
_driver *d);
diff --git a/src/radio-settings.c b/src/radio-settings.c
index 5b6ef9e..e6f0980 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -33,7 +33,9 @@
 #include "ofono.h"
 #include "common.h"
 =

-#define RADIO_SETTINGS_MODE_CACHED 0x1
+#define RADIO_SETTINGS_MODE_CACHED	0x01
+#define FAST_DORMANCY_SETTING_CACHED	0x02
+
 =

 static GSList *g_drivers =3D NULL;
 =

@@ -42,6 +44,8 @@ struct ofono_radio_settings {
 	int flags;
 	int mode;
 	int pending_mode;
+	ofono_bool_t fast_dormancy_current;
+	ofono_bool_t fast_dormancy_target;
 	const struct ofono_radio_settings_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -80,6 +84,9 @@ static int string_to_radio_access_mode(const char *mode)
 static void radio_rat_mode_query_callback(const struct ofono_error *error,
 					enum ofono_radio_access_mode mode,
 					void *data);
+static void fast_dormancy_query_callback(const struct ofono_error *error,
+					ofono_bool_t enable,
+					void *data);
 =

 static DBusMessage *radio_get_properties_reply(DBusMessage *msg,
 					       struct ofono_radio_settings *rs)
@@ -110,6 +117,17 @@ static DBusMessage *radio_get_properties_reply(DBusMes=
sage *msg,
 		return NULL;
 	}
 =

+	if (rs->flags & FAST_DORMANCY_SETTING_CACHED) {
+		dbus_bool_t value =3D rs->fast_dormancy_current;
+		ofono_dbus_dict_append(&dict, "FastDormancy",
+				DBUS_TYPE_BOOLEAN, &value);
+	} else if (rs->driver->query_fast_dormancy) {
+		rs->driver->query_fast_dormancy(rs,
+					fast_dormancy_query_callback, rs);
+		dbus_message_unref(reply);
+		return NULL;
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -175,6 +193,67 @@ static void radio_rat_mode_query_callback(const struct=
 ofono_error *error,
 		__ofono_dbus_pending_reply(&rs->pending, reply);
 }
 =

+static void set_fast_dormancy(struct ofono_radio_settings *rs,
+			ofono_bool_t enable)
+{
+	if ((rs->flags & FAST_DORMANCY_SETTING_CACHED) &&
+		rs->fast_dormancy_current !=3D enable) {
+
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		const char *path =3D __ofono_atom_get_path(rs->atom);
+		dbus_bool_t value =3D enable;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_RADIO_SETTINGS_INTERFACE,
+						"FastDormancy",
+						DBUS_TYPE_BOOLEAN, &value);
+	}
+
+	rs->fast_dormancy_current =3D enable;
+	rs->flags |=3D FAST_DORMANCY_SETTING_CACHED;
+}
+
+static void fast_dormancy_set_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error setting fast dormancy");
+		rs->fast_dormancy_target =3D rs->fast_dormancy_current;
+		reply =3D __ofono_error_failed(rs->pending);
+		__ofono_dbus_pending_reply(&rs->pending, reply);
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(rs->pending);
+	__ofono_dbus_pending_reply(&rs->pending, reply);
+
+	set_fast_dormancy(rs, rs->fast_dormancy_target);
+}
+
+static void fast_dormancy_query_callback(const struct ofono_error *error,
+					ofono_bool_t enable,
+					void *data)
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
+	set_fast_dormancy(rs, enable);
+
+	reply =3D radio_get_properties_reply(rs->pending, rs);
+	if (reply)
+		__ofono_dbus_pending_reply(&rs->pending, reply);
+}
+
 static DBusMessage *radio_get_properties(DBusConnection *conn, DBusMessage=
 *msg,
 					void *data)
 {
@@ -236,6 +315,29 @@ static DBusMessage *radio_set_property(DBusConnection =
*conn, DBusMessage *msg,
 		rs->driver->set_rat_mode(rs, mode, radio_mode_set_callback, rs);
 =

 		return NULL;
+	} else if (g_strcmp0(property, "FastDormancy") =3D=3D 0) {
+		dbus_bool_t value;
+		ofono_bool_t target;
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
+		if (rs->fast_dormancy_target =3D=3D target)
+			return dbus_message_new_method_return(msg);
+
+		rs->pending =3D dbus_message_ref(msg);
+		rs->fast_dormancy_target =3D target;
+
+		rs->driver->set_fast_dormancy(rs, target,
+					fast_dormancy_set_callback, rs);
+
+		return NULL;
 	}
 =

 	return __ofono_error_invalid_args(msg);
-- =

1.7.0.4


--===============6729732618093824106==--

