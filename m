Content-Type: multipart/mixed; boundary="===============0220530729653291556=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v5 3/3] hfp_ag_bluez5: Implement RequestDisconnection()
Date: Fri, 19 Apr 2013 19:19:05 -0300
Message-ID: <1366409945-31401-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366409945-31401-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0220530729653291556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a RequestDisconnect() is received, the socket must be closed.
This way, the related emulator will be freed.
---
 plugins/hfp_ag_bluez5.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index a0203b1..59e84d2 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -162,11 +162,35 @@ static DBusMessage *profile_cancel(DBusConnection *co=
nn,
 static DBusMessage *profile_disconnection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	DBusMessageIter iter;
+	const char *device;
+	gpointer fd;
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
+	fd =3D g_hash_table_lookup(connection_hash, device);
+	if (fd =3D=3D NULL)
+		goto invalid;
+
+	shutdown(GPOINTER_TO_INT(fd), SHUT_RDWR);
+
+	g_hash_table_remove(connection_hash, device);
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


--===============0220530729653291556==--

