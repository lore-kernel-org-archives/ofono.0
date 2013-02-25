Content-Type: multipart/mixed; boundary="===============4060593675270973223=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 1/3] bluez5: Add role parameter to bt_register_profile
Date: Mon, 25 Feb 2013 17:36:01 -0300
Message-ID: <1361824563-13618-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4060593675270973223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit allows asymmetric profiles that do not have UUIDs
available to uniquely identify which role is been registered.
---
 plugins/bluez5.c |    5 ++++-
 plugins/bluez5.h |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index 788f3a2..04dd39d 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -110,7 +110,7 @@ done:
 =

 int bt_register_profile(DBusConnection *conn, const char *uuid,
 					uint16_t version, const char *name,
-					const char *object)
+					const char *object, const char* role)
 {
 	DBusMessageIter iter, dict;
 	DBusPendingCall *c;
@@ -129,6 +129,9 @@ int bt_register_profile(DBusConnection *conn, const cha=
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
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 1432068..17e925f 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -71,7 +71,7 @@ int bt_bacmp(const bdaddr_t *ba1, const bdaddr_t *ba2);
 =

 int bt_register_profile(DBusConnection *conn, const char *uuid,
 					uint16_t version, const char *name,
-					const char *object);
+					const char *object, const char *role);
 =

 void bt_unregister_profile(DBusConnection *conn, const char *object);
 =

-- =

1.7.9.5


--===============4060593675270973223==--

