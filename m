Content-Type: multipart/mixed; boundary="===============4985199995416430089=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 2/3] bluetooth: make uuid profile detection more generic
Date: Fri, 01 Jul 2011 10:12:23 +0300
Message-ID: <1309504344-23058-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1309504344-23058-1-git-send-email-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4985199995416430089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/bluetooth.c |   31 ++++++++++++++++++-------------
 plugins/bluetooth.h |    4 +---
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index f9bc0b5..7e0705f 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -226,9 +226,9 @@ done:
 	g_slist_free(prop_handlers);
 }
 =

-static void has_uuid(DBusMessageIter *array, gpointer user_data)
+static void parse_uuids(DBusMessageIter *array, gpointer user_data)
 {
-	gboolean *profiles =3D user_data;
+	GSList **uuids =3D user_data;
 	DBusMessageIter value;
 =

 	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
@@ -241,8 +241,7 @@ static void has_uuid(DBusMessageIter *array, gpointer u=
ser_data)
 =

 		dbus_message_iter_get_basic(&value, &uuid);
 =

-		if (!strcasecmp(uuid, HFP_AG_UUID))
-			*profiles |=3D HFP_AG;
+		*uuids =3D g_slist_prepend(*uuids, (char *) uuid);
 =

 		dbus_message_iter_next(&value);
 	}
@@ -262,14 +261,13 @@ static void parse_string(DBusMessageIter *iter, gpoin=
ter user_data)
 static void device_properties_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
-	int have_uuid =3D 0;
 	const char *path =3D user_data;
 	const char *adapter =3D NULL;
 	const char *adapter_addr =3D NULL;
 	const char *device_addr =3D NULL;
 	const char *alias =3D NULL;
-	struct bluetooth_profile *profile;
 	struct DBusError derr;
+	GSList *uuids =3D NULL;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

@@ -284,7 +282,7 @@ static void device_properties_cb(DBusPendingCall *call,=
 gpointer user_data)
 =

 	DBG("");
 =

-	bluetooth_parse_properties(reply, "UUIDs", has_uuid, &have_uuid,
+	bluetooth_parse_properties(reply, "UUIDs", parse_uuids, &uuids,
 				"Adapter", parse_string, &adapter,
 				"Address", parse_string, &device_addr,
 				"Alias", parse_string, &alias, NULL);
@@ -293,15 +291,22 @@ static void device_properties_cb(DBusPendingCall *cal=
l, gpointer user_data)
 		adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
 							adapter);
 =

-	if ((have_uuid & HFP_AG) && device_addr && adapter_addr) {
-		profile =3D g_hash_table_lookup(uuid_hash, HFP_AG_UUID);
+	if (!device_addr && !adapter_addr)
+		goto done;
+
+	for (; uuids; uuids =3D uuids->next) {
+		struct bluetooth_profile *profile;
+		const char *uuid =3D uuids->data;
+
+		profile =3D g_hash_table_lookup(uuid_hash, uuid);
 		if (profile =3D=3D NULL || profile->create =3D=3D NULL)
-			goto done;
+			continue;
 =

 		profile->create(path, device_addr, adapter_addr, alias);
 	}
 =

 done:
+	g_slist_free(uuids);
 	dbus_message_unref(reply);
 }
 =

@@ -342,7 +347,7 @@ static gboolean property_changed(DBusConnection *connec=
tion, DBusMessage *msg,
 =

 	dbus_message_iter_get_basic(&iter, &property);
 	if (g_str_equal(property, "UUIDs") =3D=3D TRUE) {
-		int profiles =3D 0;
+		GSList *uuids =3D NULL;
 		const char *path =3D dbus_message_get_path(msg);
 		DBusMessageIter variant;
 =

@@ -354,13 +359,13 @@ static gboolean property_changed(DBusConnection *conn=
ection, DBusMessage *msg,
 =

 		dbus_message_iter_recurse(&iter, &variant);
 =

-		has_uuid(&variant, &profiles);
+		parse_uuids(&variant, &uuids);
 =

 		/* We need the full set of properties to be able to create
 		 * the modem properly, including Adapter and Alias, so
 		 * refetch everything again
 		 */
-		if (profiles)
+		if (uuids)
 			bluetooth_send_with_reply(path, BLUEZ_DEVICE_INTERFACE,
 					"GetProperties", device_properties_cb,
 					g_strdup(path), g_free, -1,
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 318e4b0..ff0ea52 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -28,9 +28,7 @@
 #define DBUS_TIMEOUT 15
 =

 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
-
-/* Profiles bitfield */
-#define HFP_AG 0x01
+#define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 =

 struct bluetooth_profile {
 	const char *name;
-- =

1.7.5.4


--===============4985199995416430089==--

