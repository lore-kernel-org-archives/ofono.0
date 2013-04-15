Content-Type: multipart/mixed; boundary="===============7675038617883101459=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 3/7] hfp_ag_bluez5: Remove fd from hash when disconnect
Date: Mon, 15 Apr 2013 18:41:46 -0300
Message-ID: <1366062110-28031-4-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366062110-28031-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7675038617883101459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a RequestDisconnect() is received, the file descriptor must be
closed. This way, the related emulator will be freed.

But the emulator can also be disconnected automatically if its
GAtServer closes. In this case, the hash will hold an invalid file
descriptor.

So, after the emulator is registered, we watch for G_IO_HUP in
the corresponding file descriptor. If this condition happens, we
can safely remove the file descriptor from the hash.
---
 plugins/hfp_ag_bluez5.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index e53709d..cc59cf7 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -62,11 +62,24 @@ static void connection_removed_notify(gpointer data)
 	close(fd);
 }
 =

+static gboolean emulator_disconnected_cb(GIOChannel *io, GIOCondition cond,
+								gpointer data)
+{
+	char *device =3D data;
+
+	DBG("Remove %s", device);
+
+	g_hash_table_remove(connection_hash, device);
+
+	return FALSE;
+}
+
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	DBusMessageIter entry;
 	const char *device;
+	GIOChannel *io;
 	int fd;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
@@ -113,6 +126,12 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	}
 =

 	ofono_emulator_register(em, fd);
+
+	io =3D g_io_channel_unix_new(fd);
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, G_IO_HUP,
+			emulator_disconnected_cb, g_strdup(device), g_free);
+	g_io_channel_unref(io);
+
 	g_hash_table_insert(connection_hash, g_strdup(device),
 							GINT_TO_POINTER(fd));
 =

@@ -146,11 +165,29 @@ static DBusMessage *profile_cancel(DBusConnection *co=
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


--===============7675038617883101459==--

