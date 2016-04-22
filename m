Content-Type: multipart/mixed; boundary="===============0470037349550938729=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 3/5] bluez5: track and clean up atom watches
Date: Fri, 22 Apr 2016 13:07:15 +0000
Message-ID: <1461330431-20206-4-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330431-20206-3-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0470037349550938729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

Prevents glib from causing SIGFPE during certain circumstances of modem
removal.
---
 plugins/dun_gw_bluez5.c | 24 ++++++++++++++++++++++--
 plugins/hfp_ag_bluez5.c | 36 +++++++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/plugins/dun_gw_bluez5.c b/plugins/dun_gw_bluez5.c
index faea12b..af78795 100644
--- a/plugins/dun_gw_bluez5.c
+++ b/plugins/dun_gw_bluez5.c
@@ -48,6 +48,7 @@
 =

 static guint modemwatch_id;
 static GList *modems;
+static GHashTable *gprs_watches =3D NULL;
 =

 static DBusMessage *profile_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
@@ -151,6 +152,16 @@ static const GDBusMethodTable profile_methods[] =3D {
 	{ }
 };
 =

+static gboolean atom_watch_remove(gpointer key, gpointer value,
+					gpointer user_data)
+{
+	struct ofono_modem *modem =3D key;
+
+	__ofono_modem_remove_atom_watch(modem, GPOINTER_TO_UINT(value));
+
+	return TRUE;
+}
+
 static void gprs_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
@@ -177,13 +188,17 @@ static void gprs_watch(struct ofono_atom *atom,
 =

 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
 {
+	int gprs;
 	DBG("modem: %p, added: %d", modem, added);
 =

-	if (added =3D=3D FALSE)
+	if (added =3D=3D FALSE) {
+		g_hash_table_remove(gprs_watches, modem);
 		return;
+	}
 =

-	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_GPRS,
+	gprs =3D __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_GPRS,
 						gprs_watch, modem, NULL);
+	g_hash_table_insert(gprs_watches, modem, GUINT_TO_POINTER(gprs));
 }
 =

 static void call_modemwatch(struct ofono_modem *modem, void *user)
@@ -210,6 +225,8 @@ static int dun_gw_init(void)
 		return -EIO;
 	}
 =

+	gprs_watches =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+
 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 =

 	__ofono_modem_foreach(call_modemwatch, NULL);
@@ -228,6 +245,9 @@ static void dun_gw_exit(void)
 	bt_unregister_profile(conn, DUN_GW_EXT_PROFILE_PATH);
 	g_dbus_unregister_interface(conn, DUN_GW_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
+
+	g_hash_table_foreach_remove(gprs_watches, atom_watch_remove, NULL);
+	g_hash_table_destroy(gprs_watches);
 }
 =

 OFONO_PLUGIN_DEFINE(dun_gw_bluez5, "Dial-up Networking Profile Plugins",
diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 22faeb7..ba0f802 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -60,6 +60,8 @@ static guint modemwatch_id;
 static GList *modems;
 static GHashTable *sim_hash =3D NULL;
 static GHashTable *connection_hash;
+static GHashTable *sim_atom_watches =3D NULL;
+static GHashTable *vc_atom_watches =3D NULL;
 =

 static int hfp_card_probe(struct ofono_handsfree_card *card,
 					unsigned int vendor, void *data)
@@ -374,6 +376,16 @@ static void sim_state_watch(enum ofono_sim_state new_s=
tate, void *data)
 					HFP_AG_EXT_PROFILE_PATH, NULL, 0);
 }
 =

+static gboolean atom_watch_remove(gpointer key, gpointer value,
+					gpointer user_data)
+{
+	struct ofono_modem *modem =3D key;
+
+	__ofono_modem_remove_atom_watch(modem, GPOINTER_TO_UINT(value));
+
+	return TRUE;
+}
+
 static gboolean sim_watch_remove(gpointer key, gpointer value,
 				gpointer user_data)
 {
@@ -443,15 +455,21 @@ static void voicecall_watch(struct ofono_atom *atom,
 =

 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
 {
+	int sim, vc;
 	DBG("modem: %p, added: %d", modem, added);
 =

-	if (added =3D=3D FALSE)
+	if (added =3D=3D FALSE) {
+		g_hash_table_remove(sim_atom_watches, modem);
+		g_hash_table_remove(vc_atom_watches, modem);
 		return;
+	}
 =

-	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SIM,
-					sim_watch, modem, NULL);
-	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_VOICECALL,
-					voicecall_watch, modem, NULL);
+	sim =3D __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SIM,
+						sim_watch, modem, NULL);
+	vc =3D __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_VOICECALL,
+						voicecall_watch, modem, NULL);
+	g_hash_table_insert(sim_atom_watches, modem, GUINT_TO_POINTER(sim));
+	g_hash_table_insert(vc_atom_watches, modem, GUINT_TO_POINTER(vc));
 }
 =

 static void call_modemwatch(struct ofono_modem *modem, void *user)
@@ -485,6 +503,8 @@ static int hfp_ag_init(void)
 	}
 =

 	sim_hash =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+	sim_atom_watches =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+	vc_atom_watches =3D g_hash_table_new(g_direct_hash, g_direct_equal);
 =

 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 	__ofono_modem_foreach(call_modemwatch, NULL);
@@ -513,6 +533,12 @@ static void hfp_ag_exit(void)
 	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
 	g_hash_table_destroy(sim_hash);
 =

+	g_hash_table_foreach_remove(sim_atom_watches, atom_watch_remove, NULL);
+	g_hash_table_destroy(sim_atom_watches);
+
+	g_hash_table_foreach_remove(vc_atom_watches, atom_watch_remove, NULL);
+	g_hash_table_destroy(vc_atom_watches);
+
 	ofono_handsfree_audio_unref();
 }
 =

-- =

1.9.1

--===============0470037349550938729==--

