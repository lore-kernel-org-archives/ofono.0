Content-Type: multipart/mixed; boundary="===============5975369564734098163=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 5/7] hfp_ag_bluez5: Create a hash to store emulators
Date: Fri, 12 Apr 2013 17:41:03 -0300
Message-ID: <1365799265-19946-6-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365799265-19946-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5975369564734098163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to store emulators so we can disconnect and free them at
RequestDisconnect().
---
 plugins/hfp_ag_bluez5.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 64ea8ca..b485e17 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -51,6 +51,19 @@
 static guint modemwatch_id;
 static GList *modems;
 static GHashTable *sim_hash =3D NULL;
+static GHashTable *emulator_hash;
+
+static gboolean emulator_remove(gpointer key, gpointer value,
+							gpointer user_data)
+{
+	struct ofono_emulator *em =3D value;
+
+	DBG("%p", em);
+
+	ofono_emulator_remove(em);
+
+	return TRUE;
+}
 =

 static DBusMessage *profile_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
@@ -254,6 +267,9 @@ static int hfp_ag_init(void)
 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 	__ofono_modem_foreach(call_modemwatch, NULL);
 =

+	emulator_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
+									NULL);
+
 	return 0;
 }
 =

@@ -265,6 +281,9 @@ static void hfp_ag_exit(void)
 	g_dbus_unregister_interface(conn, HFP_AG_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 =

+	g_hash_table_foreach_remove(emulator_hash, emulator_remove, NULL);
+	g_hash_table_destroy(emulator_hash);
+
 	g_list_free(modems);
 	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
 	g_hash_table_destroy(sim_hash);
-- =

1.7.9.5


--===============5975369564734098163==--

