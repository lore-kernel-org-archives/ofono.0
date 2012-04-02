Content-Type: multipart/mixed; boundary="===============4293034909026107418=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v6 10/16] dundee: Manager append devices
Date: Mon, 02 Apr 2012 18:20:08 +0200
Message-ID: <1333383614-4921-11-git-send-email-wagi@monom.org>
In-Reply-To: <1333383614-4921-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4293034909026107418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/manager.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/dundee/manager.c b/dundee/manager.c
index 9ffe5c0..58a5804 100644
--- a/dundee/manager.c
+++ b/dundee/manager.c
@@ -30,6 +30,26 @@
 =

 #include "dundee.h"
 =

+static void append_device(struct dundee_device *device, void *userdata)
+{
+	DBusMessageIter *array =3D userdata;
+	const char *path =3D __dundee_device_get_path(device);
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
+	__dundee_device_append_properties(device, &dict);
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

+	__dundee_device_foreach(append_device, &array);
+
 	dbus_message_iter_close_container(&iter, &array);
 =

 	return reply;
-- =

1.7.10.rc3.1.gb3065


--===============4293034909026107418==--

