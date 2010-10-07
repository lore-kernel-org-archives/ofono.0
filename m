Content-Type: multipart/mixed; boundary="===============2438867882271210847=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/4] radio settings: allow for more than one property
Date: Thu, 07 Oct 2010 16:37:30 +0300
Message-ID: <1286458653-12096-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1286458653-12096-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2438867882271210847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Restructure code to allow other properties besides
TechnologyPreference to be returned.
---
 src/radio-settings.c |   59 +++++++++++++++++++++++++---------------------=
---
 1 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/src/radio-settings.c b/src/radio-settings.c
index f70d870..5b6ef9e 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -77,15 +77,17 @@ static int string_to_radio_access_mode(const char *mode)
 	return -1;
 }
 =

+static void radio_rat_mode_query_callback(const struct ofono_error *error,
+					enum ofono_radio_access_mode mode,
+					void *data);
+
 static DBusMessage *radio_get_properties_reply(DBusMessage *msg,
-						struct ofono_radio_settings *rs)
+					       struct ofono_radio_settings *rs)
 {
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 =

-	const char *mode =3D radio_access_mode_to_string(rs->mode);
-
 	reply =3D dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
@@ -96,8 +98,17 @@ static DBusMessage *radio_get_properties_reply(DBusMessa=
ge *msg,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

-	ofono_dbus_dict_append(&dict, "TechnologyPreference", DBUS_TYPE_STRING,
-				&mode);
+	if (rs->flags & RADIO_SETTINGS_MODE_CACHED) {
+		const char *mode =3D radio_access_mode_to_string(rs->mode);
+		ofono_dbus_dict_append(&dict, "TechnologyPreference",
+				DBUS_TYPE_STRING, &mode);
+	} else if (rs->driver->query_rat_mode) {
+		rs->pending =3D dbus_message_ref(msg);
+		rs->driver->query_rat_mode(rs,
+					radio_rat_mode_query_callback, rs);
+		dbus_message_unref(reply);
+		return NULL;
+	}
 =

 	dbus_message_iter_close_container(&iter, &dict);
 =

@@ -107,23 +118,21 @@ static DBusMessage *radio_get_properties_reply(DBusMe=
ssage *msg,
 static void radio_set_rat_mode(struct ofono_radio_settings *rs,
 				enum ofono_radio_access_mode mode)
 {
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path;
-	const char *str_mode;
+	if ((rs->flags & RADIO_SETTINGS_MODE_CACHED) &&
+		rs->mode !=3D (int)mode) {
 =

-	if (rs->mode =3D=3D (int)mode)
-		return;
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		const char *path =3D __ofono_atom_get_path(rs->atom);
+		const char *str_mode =3D radio_access_mode_to_string(rs->mode);
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_RADIO_SETTINGS_INTERFACE,
+						"TechnologyPreference",
+						DBUS_TYPE_STRING, &str_mode);
+	}
 =

 	rs->mode =3D mode;
 	rs->flags |=3D RADIO_SETTINGS_MODE_CACHED;
-
-	path =3D __ofono_atom_get_path(rs->atom);
-	str_mode =3D radio_access_mode_to_string(rs->mode);
-
-	ofono_dbus_signal_property_changed(conn, path,
-					OFONO_RADIO_SETTINGS_INTERFACE,
-					"TechnologyPreference", DBUS_TYPE_STRING,
-					&str_mode);
 }
 =

 static void radio_mode_set_callback(const struct ofono_error *error, void =
*data)
@@ -162,7 +171,8 @@ static void radio_rat_mode_query_callback(const struct =
ofono_error *error,
 	radio_set_rat_mode(rs, mode);
 =

 	reply =3D radio_get_properties_reply(rs->pending, rs);
-	__ofono_dbus_pending_reply(&rs->pending, reply);
+	if (reply)
+		__ofono_dbus_pending_reply(&rs->pending, reply);
 }
 =

 static DBusMessage *radio_get_properties(DBusConnection *conn, DBusMessage=
 *msg,
@@ -170,19 +180,10 @@ static DBusMessage *radio_get_properties(DBusConnecti=
on *conn, DBusMessage *msg,
 {
 	struct ofono_radio_settings *rs =3D data;
 =

-	if (rs->flags & RADIO_SETTINGS_MODE_CACHED)
-		return radio_get_properties_reply(msg, rs);
-
-	if (!rs->driver->query_rat_mode)
-		return __ofono_error_not_implemented(msg);
-
 	if (rs->pending)
 		return __ofono_error_busy(msg);
 =

-	rs->pending =3D dbus_message_ref(msg);
-	rs->driver->query_rat_mode(rs, radio_rat_mode_query_callback, rs);
-
-	return NULL;
+	return radio_get_properties_reply(msg, rs);
 }
 =

 static DBusMessage *radio_set_property(DBusConnection *conn, DBusMessage *=
msg,
-- =

1.7.0.4


--===============2438867882271210847==--

