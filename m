Content-Type: multipart/mixed; boundary="===============1589686420340770497=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 1/2] hfp_ag: start server on sim 'ready' state
Date: Wed, 20 Jul 2011 16:34:35 +0200
Message-ID: <1311172476-7157-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1589686420340770497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

update HFP AG server to start only when a modem has its SIM atom
in 'ready' state and has voice call capability
---
 plugins/hfp_ag.c |   85 ++++++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index 191708b..9fea282 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -40,6 +40,7 @@
 static struct server *server;
 static guint modemwatch_id;
 static GList *modems;
+static GHashTable *sim_hash =3D NULL;
 =

 static const gchar *hfp_ag_record =3D
 "<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
@@ -85,6 +86,11 @@ static const gchar *hfp_ag_record =3D
 "  </attribute>\n"
 "</record>\n";
 =

+struct sim_entry {
+	int watch;
+	struct ofono_modem *modem;
+};
+
 static void hfp_ag_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
 {
 	struct ofono_modem *modem;
@@ -115,27 +121,68 @@ static void hfp_ag_connect_cb(GIOChannel *io, GError =
*err, gpointer user_data)
 	ofono_emulator_register(em, fd);
 }
 =

-static void voicecall_watch(struct ofono_atom *atom,
-				enum ofono_atom_watch_condition cond,
-				void *data)
+static void sim_state_watch(enum ofono_sim_state new_state, void *data)
 {
 	struct ofono_modem *modem =3D data;
 =

-	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
-		modems =3D g_list_append(modems, modem);
-
-		if (modems->next =3D=3D NULL)
-			server =3D bluetooth_register_server(HFP_AG_CHANNEL,
-							hfp_ag_record,
-							hfp_ag_connect_cb,
-							NULL);
-	} else {
+	if (new_state !=3D OFONO_SIM_STATE_READY) {
 		modems =3D g_list_remove(modems, modem);
 		if (modems =3D=3D NULL && server !=3D NULL) {
 			bluetooth_unregister_server(server);
 			server =3D NULL;
 		}
+		return;
 	}
+
+	if (__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_VOICECALL)
+			=3D=3D NULL)
+		return;
+
+	modems =3D g_list_append(modems, modem);
+
+	if (modems->next =3D=3D NULL)
+		server =3D bluetooth_register_server(HFP_AG_CHANNEL,
+							hfp_ag_record,
+							hfp_ag_connect_cb,
+							NULL);
+}
+
+static gboolean sim_watch_remove(gpointer key, gpointer value,
+				gpointer user_data)
+{
+	struct ofono_sim *sim =3D key;
+	struct sim_entry *s =3D value;
+
+	ofono_sim_remove_state_watch(sim, s->watch);
+	sim_state_watch(OFONO_SIM_STATE_NOT_PRESENT, s->modem);
+
+	return TRUE;
+}
+
+static void sim_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D data;
+	struct sim_entry *s;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		sim_watch_remove(sim, g_hash_table_lookup(sim_hash, sim), NULL);
+		g_hash_table_remove(sim_hash, sim);
+		return;
+	}
+
+	s =3D g_try_new0(struct sim_entry, 1);
+	if (s =3D=3D NULL) {
+		ofono_error("Unable to allocate sim entry structure");
+		return;
+	}
+
+	s->modem =3D modem;
+	s->watch =3D ofono_sim_add_state_watch(sim, sim_state_watch, modem, NULL);
+	g_hash_table_insert(sim_hash, sim, s);
+	sim_state_watch(ofono_sim_get_state(sim), modem);
 }
 =

 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
@@ -145,8 +192,8 @@ static void modem_watch(struct ofono_modem *modem, gboo=
lean added, void *user)
 	if (added =3D=3D FALSE)
 		return;
 =

-	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_VOICECALL,
-					voicecall_watch, modem, NULL);
+	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SIM,
+					sim_watch, modem, NULL);
 }
 =

 static void call_modemwatch(struct ofono_modem *modem, void *user)
@@ -156,6 +203,9 @@ static void call_modemwatch(struct ofono_modem *modem, =
void *user)
 =

 static int hfp_ag_init()
 {
+	sim_hash =3D g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
+								g_free);
+
 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 	__ofono_modem_foreach(call_modemwatch, NULL);
 =

@@ -165,12 +215,9 @@ static int hfp_ag_init()
 static void hfp_ag_exit()
 {
 	__ofono_modemwatch_remove(modemwatch_id);
+	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
+	g_hash_table_destroy(sim_hash);
 	g_list_free(modems);
-
-	if (server) {
-		bluetooth_unregister_server(server);
-		server =3D NULL;
-	}
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_ag, "Hands-Free Audio Gateway Profile Plugins", VE=
RSION,
-- =

1.7.1


--===============1589686420340770497==--

