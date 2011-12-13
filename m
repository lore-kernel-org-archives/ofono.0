Content-Type: multipart/mixed; boundary="===============6097139693519322361=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 07/16] elect: Manager append devices
Date: Tue, 13 Dec 2011 16:00:01 +0100
Message-ID: <1323788410-9988-8-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6097139693519322361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 elect/manager.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/elect/manager.c b/elect/manager.c
index 65c8242..99ad216 100644
--- a/elect/manager.c
+++ b/elect/manager.c
@@ -30,6 +30,26 @@
 =

 #include "elect.h"
 =

+static void append_device(struct elect_device *device, void *userdata)
+{
+	DBusMessageIter *array =3D userdata;
+	const char *path =3D __elect_device_get_path(device);
+	DBusMessageIter entry, dict;
+
+	dbus_message_iter_open_container(array, DBUS_TYPE_STRUCT,
+						NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+					&path);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_ARRAY,
+				OFONO_PROPERTIES_ARRAY_SIGNATURE,
+				&dict);
+
+	__elect_device_append_properties(device, &dict);
+
+	dbus_message_iter_close_container(&entry, &dict);
+	dbus_message_iter_close_container(array, &entry);
+}
+
 static DBusMessage *manager_get_devices(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -56,6 +76,8 @@ static DBusMessage *manager_get_devices(DBusConnection *c=
onn,
 					DBUS_STRUCT_END_CHAR_AS_STRING,
 					&array);
 =

+	__elect_device_foreach(append_device, &array);
+
 	dbus_message_iter_close_container(&iter, &array);
 =

 	return reply;
-- =

1.7.8.110.g4cb5d1


--===============6097139693519322361==--

