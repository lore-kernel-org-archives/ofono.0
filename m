Content-Type: multipart/mixed; boundary="===============1108828517371857778=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v5 1/3] hfp_ag_bluez5: Create a hash to store connections
Date: Fri, 19 Apr 2013 19:19:03 -0300
Message-ID: <1366409945-31401-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1108828517371857778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to store active connections so we can disconnect them at
RequestDisconnect().

When we remove a connection from the hash, we also close it.
---
 plugins/hfp_ag_bluez5.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index c171c87..bbced26 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -48,6 +48,16 @@
 static guint modemwatch_id;
 static GList *modems;
 static GHashTable *sim_hash =3D NULL;
+static GHashTable *connection_hash;
+
+static void connection_destroy(gpointer data)
+{
+	int fd =3D GPOINTER_TO_INT(data);
+
+	DBG("fd %d", fd);
+
+	close(fd);
+}
 =

 static DBusMessage *profile_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
@@ -251,6 +261,9 @@ static int hfp_ag_init(void)
 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 	__ofono_modem_foreach(call_modemwatch, NULL);
 =

+	connection_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+					g_free, connection_destroy);
+
 	return 0;
 }
 =

@@ -262,6 +275,8 @@ static void hfp_ag_exit(void)
 	g_dbus_unregister_interface(conn, HFP_AG_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 =

+	g_hash_table_destroy(connection_hash);
+
 	g_list_free(modems);
 	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
 	g_hash_table_destroy(sim_hash);
-- =

1.7.9.5


--===============1108828517371857778==--

