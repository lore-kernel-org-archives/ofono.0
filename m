Content-Type: multipart/mixed; boundary="===============3412455656631836128=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 7/7] hfp_ag_bluez5: Remove emulator when disconnect
Date: Fri, 12 Apr 2013 17:41:05 -0300
Message-ID: <1365799265-19946-8-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365799265-19946-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3412455656631836128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a RequestDisconnect() is received, the emulator must be both
disconnected and removed from the hash.

But an emulator can also be disconnected and freed automatically if its
GAtServer closes. In this case, the hash can hold an invalid pointer.

So, after the emulator is registered, a function is set to be called
when the emulator is about to be freed and this function removes the
emulator from the hash.
---
 plugins/hfp_ag_bluez5.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index dbf053b..36c22f3 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -65,11 +65,21 @@ static gboolean emulator_remove(gpointer key, gpointer =
value,
 	return TRUE;
 }
 =

+static void emulator_removed_cb(void *user_data)
+{
+	char *device =3D user_data;
+
+	DBG("%s", device);
+
+	g_hash_table_remove(emulator_hash, device);
+}
+
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	DBusMessageIter entry;
 	const char *device;
+	char *key;
 	int fd;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
@@ -115,8 +125,11 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 						"Not enough resources");
 	}
 =

+	key =3D g_strdup(device);
+
 	ofono_emulator_register(em, fd);
-	g_hash_table_insert(emulator_hash, g_strdup(device), em);
+	ofono_emulator_set_removed_cb(em, emulator_removed_cb, key);
+	g_hash_table_insert(emulator_hash, key, em);
 =

 	return dbus_message_new_method_return(msg);
 =

@@ -148,11 +161,33 @@ static DBusMessage *profile_cancel(DBusConnection *co=
nn,
 static DBusMessage *profile_disconnection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	DBusMessageIter iter;
+	const char *device;
+	struct ofono_emulator *em;
+
 	DBG("Profile handler RequestDisconnection");
 =

-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-					".NotImplemented",
-					"Implementation not provided");
+	if (!dbus_message_iter_init(msg, &iter))
+		goto invalid;
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_OBJECT_PATH)
+		goto invalid;
+
+	dbus_message_iter_get_basic(&iter, &device);
+
+	DBG("%s", device);
+
+	em =3D g_hash_table_lookup(emulator_hash, device);
+	if (em =3D=3D NULL)
+		goto invalid;
+
+	ofono_emulator_remove(em);
+
+	return dbus_message_new_method_return(msg);
+
+invalid:
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
 }
 =

 static const GDBusMethodTable profile_methods[] =3D {
-- =

1.7.9.5


--===============3412455656631836128==--

