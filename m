Content-Type: multipart/mixed; boundary="===============2588432684922940376=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v4 3/3] hfp_ag_bluez5: Implement RequestDisconnection()
Date: Fri, 19 Apr 2013 12:01:00 -0300
Message-ID: <1366383661-26950-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366383661-26950-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2588432684922940376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a RequestDisconnect() is received, the socket must be closed.
This way, the related emulator will be freed.
---
 plugins/hfp_ag_bluez5.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 67b6a8d..4383161 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -163,11 +163,29 @@ static DBusMessage *profile_cancel(DBusConnection *co=
nn,
 static DBusMessage *profile_disconnection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	DBusMessageIter iter;
+	const char *device;
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
+	if (!g_hash_table_remove(connection_hash, device))
+		goto invalid;
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


--===============2588432684922940376==--

