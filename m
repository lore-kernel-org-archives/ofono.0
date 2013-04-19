Content-Type: multipart/mixed; boundary="===============5054769203732570295=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v4 2/3] hfp_ag_bluez5: Add watch for G_IO_HUP when connect
Date: Fri, 19 Apr 2013 12:00:59 -0300
Message-ID: <1366383661-26950-2-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366383661-26950-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5054769203732570295==
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
index edc76e6..67b6a8d 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -60,12 +60,24 @@ static void connection_removed_notify(gpointer data)
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

@@ -112,6 +124,15 @@ static DBusMessage *profile_new_connection(DBusConnect=
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


--===============5054769203732570295==--

