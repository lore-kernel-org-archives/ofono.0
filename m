Content-Type: multipart/mixed; boundary="===============4236033157420352489=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] More const pointers
Date: Sat, 11 Jan 2014 13:32:10 +0200
Message-ID: <1389439930-5802-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4236033157420352489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h | 12 ++++++------
 src/dbus.c     | 20 +++++++++++---------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index e7ccb0b..3d39eff 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -77,29 +77,29 @@ extern "C" {
 DBusConnection *ofono_dbus_get_connection(void);
 =

 void ofono_dbus_dict_append(DBusMessageIter *dict, const char *key, int ty=
pe,
-				void *value);
+				const void *value);
 =

 void ofono_dbus_dict_append_array(DBusMessageIter *dict, const char *key,
-					int type, void *val);
+					int type, const void *val);
 =

 void ofono_dbus_dict_append_dict(DBusMessageIter *dict, const char *key,
-					int type, void *val);
+					int type, const void *val);
 =

 int ofono_dbus_signal_property_changed(DBusConnection *conn, const char *p=
ath,
 					const char *interface, const char *name,
-					int type, void *value);
+					int type, const void *value);
 =

 int ofono_dbus_signal_array_property_changed(DBusConnection *conn,
 						const char *path,
 						const char *interface,
 						const char *name, int type,
-						void *value);
+						const void *value);
 =

 int ofono_dbus_signal_dict_property_changed(DBusConnection *conn,
 						const char *path,
 						const char *interface,
 						const char *name, int type,
-						void *value);
+						const void *value);
 =

 #ifdef __cplusplus
 }
diff --git a/src/dbus.c b/src/dbus.c
index 1558a51..45becc1 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -48,7 +48,7 @@ struct error_mapping_entry cme_errors_mapping[] =3D {
 };
 =

 static void append_variant(DBusMessageIter *iter,
-				int type, void *value)
+				int type, const void *value)
 {
 	char sig[2];
 	DBusMessageIter valueiter;
@@ -65,7 +65,7 @@ static void append_variant(DBusMessageIter *iter,
 }
 =

 void ofono_dbus_dict_append(DBusMessageIter *dict,
-			const char *key, int type, void *value)
+			const char *key, int type, const void *value)
 {
 	DBusMessageIter keyiter;
 =

@@ -85,7 +85,8 @@ void ofono_dbus_dict_append(DBusMessageIter *dict,
 	dbus_message_iter_close_container(dict, &keyiter);
 }
 =

-static void append_array_variant(DBusMessageIter *iter, int type, void *va=
l)
+static void append_array_variant(DBusMessageIter *iter, int type,
+				const void *val)
 {
 	DBusMessageIter variant, array;
 	char typesig[2];
@@ -113,7 +114,7 @@ static void append_array_variant(DBusMessageIter *iter,=
 int type, void *val)
 }
 =

 void ofono_dbus_dict_append_array(DBusMessageIter *dict, const char *key,
-				int type, void *val)
+				int type, const void *val)
 {
 	DBusMessageIter entry;
 =

@@ -127,7 +128,8 @@ void ofono_dbus_dict_append_array(DBusMessageIter *dict=
, const char *key,
 	dbus_message_iter_close_container(dict, &entry);
 }
 =

-static void append_dict_variant(DBusMessageIter *iter, int type, void *val)
+static void append_dict_variant(DBusMessageIter *iter, int type,
+				const void *val)
 {
 	DBusMessageIter variant, array, entry;
 	char typesig[5];
@@ -182,7 +184,7 @@ static void append_dict_variant(DBusMessageIter *iter, =
int type, void *val)
 }
 =

 void ofono_dbus_dict_append_dict(DBusMessageIter *dict, const char *key,
-				int type, void *val)
+				int type, const void *val)
 {
 	DBusMessageIter entry;
 =

@@ -200,7 +202,7 @@ int ofono_dbus_signal_property_changed(DBusConnection *=
conn,
 					const char *path,
 					const char *interface,
 					const char *name,
-					int type, void *value)
+					int type, const void *value)
 {
 	DBusMessage *signal;
 	DBusMessageIter iter;
@@ -225,7 +227,7 @@ int ofono_dbus_signal_array_property_changed(DBusConnec=
tion *conn,
 						const char *path,
 						const char *interface,
 						const char *name,
-						int type, void *value)
+						int type, const void *value)
 =

 {
 	DBusMessage *signal;
@@ -251,7 +253,7 @@ int ofono_dbus_signal_dict_property_changed(DBusConnect=
ion *conn,
 						const char *path,
 						const char *interface,
 						const char *name,
-						int type, void *value)
+						int type, const void *value)
 =

 {
 	DBusMessage *signal;
-- =

1.8.3.2


--===============4236033157420352489==--

