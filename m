Content-Type: multipart/mixed; boundary="===============0567441383937224850=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH] bluez5: Add bt_register_profile_with_role
Date: Fri, 01 Mar 2013 18:58:59 -0300
Message-ID: <1362175139-25370-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0567441383937224850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This function allows to specify which role is registering when the
profile does not have specific UUIDs for each role.
---
 plugins/bluez5.c |   15 +++++++++++++--
 plugins/bluez5.h |    4 ++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 9233a2b..7cc11fd 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -107,9 +107,9 @@ done:
 	dbus_message_unref(reply);
 }
 =

-int bt_register_profile(DBusConnection *conn, const char *uuid,
+int bt_register_profile_with_role(DBusConnection *conn, const char *uuid,
 					uint16_t version, const char *name,
-					const char *object)
+					const char *object, const char *role)
 {
 	DBusMessageIter iter, dict;
 	DBusPendingCall *c;
@@ -128,6 +128,9 @@ int bt_register_profile(DBusConnection *conn, const cha=
r *uuid,
 	ofono_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING, &name);
 	ofono_dbus_dict_append(&dict, "Version", DBUS_TYPE_UINT16, &version);
 =

+	if (role)
+		ofono_dbus_dict_append(&dict, "Role", DBUS_TYPE_STRING, &role);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	if (!dbus_connection_send_with_reply(conn, msg, &c, -1)) {
@@ -144,6 +147,14 @@ int bt_register_profile(DBusConnection *conn, const ch=
ar *uuid,
 	return 0;
 }
 =

+int bt_register_profile(DBusConnection *conn, const char *uuid,
+					uint16_t version, const char *name,
+							const char *object)
+{
+	return bt_register_profile_with_role(conn, uuid, version, name, object,
+									NULL);
+}
+
 void bt_unregister_profile(DBusConnection *conn, const char *object)
 {
 	DBusMessageIter iter;
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 1432068..f7f3d7e 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -69,6 +69,10 @@ int bt_ba2str(const bdaddr_t *ba, char *str);
 =

 int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2);
 =

+int bt_register_profile_with_role(DBusConnection *conn, const char *uuid,
+					uint16_t version, const char *name,
+					const char *object, const char *role);
+
 int bt_register_profile(DBusConnection *conn, const char *uuid,
 					uint16_t version, const char *name,
 					const char *object);
-- =

1.7.9.5


--===============0567441383937224850==--

