Content-Type: multipart/mixed; boundary="===============2649156085967439455=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 6/6] hfp_ag_bluez5: Remove emulator when disconnect
Date: Wed, 10 Apr 2013 16:24:47 -0300
Message-ID: <1365621887-16940-7-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365621887-16940-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2649156085967439455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 2046e7d..0301fdb 100644
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


--===============2649156085967439455==--

