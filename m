Content-Type: multipart/mixed; boundary="===============4944561293334229559=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v5 2/3] hfp_ag_bluez5: Add watch for G_IO_HUP when connect
Date: Fri, 19 Apr 2013 19:19:04 -0300
Message-ID: <1366409945-31401-2-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366409945-31401-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4944561293334229559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A watch to G_IO_HUP is added to remove the file descriptor when the
emulator is automatically disconnected when its GAtServer closes.

We use a dupped file descriptor because the events aren't delivered to
the file descriptor who originated them.
---
 plugins/hfp_ag_bluez5.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index bbced26..a0203b1 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -59,12 +59,24 @@ static void connection_destroy(gpointer data)
 	close(fd);
 }
 =

+static gboolean io_hup_cb(GIOChannel *io, GIOCondition cond, gpointer data)
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
-	int fd;
+	GIOChannel *io;
+	int fd, fd_dup;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
 =

@@ -111,6 +123,15 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 =

 	ofono_emulator_register(em, fd);
 =

+	fd_dup =3D dup(fd);
+	io =3D g_io_channel_unix_new(fd_dup);
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, G_IO_HUP, io_hup_cb,
+						g_strdup(device), g_free);
+	g_io_channel_unref(io);
+
+	g_hash_table_insert(connection_hash, g_strdup(device),
+						GINT_TO_POINTER(fd_dup));
+
 	return dbus_message_new_method_return(msg);
 =

 invalid:
-- =

1.7.9.5


--===============4944561293334229559==--

