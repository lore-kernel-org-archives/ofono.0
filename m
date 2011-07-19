Content-Type: multipart/mixed; boundary="===============9114496812948753106=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/3] hfp_ag: start server on sim 'ready' state
Date: Tue, 19 Jul 2011 18:49:10 +0200
Message-ID: <1311094151-9765-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1311094151-9765-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9114496812948753106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

update HFP AG server to start only when a modem has its SIM atom
in 'ready' state and has voice call capability
---
 plugins/hfp_ag.c |   52 ++++++++++++++++++++++++++++++++++++++++++++------=
--
 1 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index 191708b..70f0944 100644
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
@@ -115,13 +116,16 @@ static void hfp_ag_connect_cb(GIOChannel *io, GError =
*err, gpointer user_data)
 	ofono_emulator_register(em, fd);
 }
 =

-static void voicecall_watch(struct ofono_atom *atom,
-				enum ofono_atom_watch_condition cond,
-				void *data)
+static void sim_state_watch(enum ofono_sim_state new_state, void *user)
 {
-	struct ofono_modem *modem =3D data;
+	struct ofono_modem *modem =3D user;
+
+	switch (new_state) {
+	case OFONO_SIM_STATE_READY:
+		if (__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_VOICECALL)
+				=3D=3D NULL)
+			break;
 =

-	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
 		modems =3D g_list_append(modems, modem);
 =

 		if (modems->next =3D=3D NULL)
@@ -129,15 +133,44 @@ static void voicecall_watch(struct ofono_atom *atom,
 							hfp_ag_record,
 							hfp_ag_connect_cb,
 							NULL);
-	} else {
+		break;
+
+	default:
 		modems =3D g_list_remove(modems, modem);
 		if (modems =3D=3D NULL && server !=3D NULL) {
 			bluetooth_unregister_server(server);
 			server =3D NULL;
 		}
+		break;
 	}
 }
 =

+static void sim_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D data;
+	int watch;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		sim_state_watch(OFONO_SIM_STATE_NOT_PRESENT, modem);
+
+		watch =3D GPOINTER_TO_UINT(g_hash_table_lookup(sim_hash, sim));
+		if (watch =3D=3D 0)
+			return;
+
+		ofono_sim_remove_state_watch(sim, watch);
+		g_hash_table_remove(sim_hash, sim);
+
+		return;
+	}
+
+	watch =3D ofono_sim_add_state_watch(sim, sim_state_watch, modem, NULL);
+	g_hash_table_insert(sim_hash, sim, GUINT_TO_POINTER(watch));
+	sim_state_watch(ofono_sim_get_state(sim), modem);
+}
+
 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
 {
 	DBG("modem: %p, added: %d", modem, added);
@@ -145,8 +178,8 @@ static void modem_watch(struct ofono_modem *modem, gboo=
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
@@ -156,6 +189,8 @@ static void call_modemwatch(struct ofono_modem *modem, =
void *user)
 =

 static int hfp_ag_init()
 {
+	sim_hash =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+
 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 	__ofono_modem_foreach(call_modemwatch, NULL);
 =

@@ -166,6 +201,7 @@ static void hfp_ag_exit()
 {
 	__ofono_modemwatch_remove(modemwatch_id);
 	g_list_free(modems);
+	g_hash_table_destroy(sim_hash);
 =

 	if (server) {
 		bluetooth_unregister_server(server);
-- =

1.7.1


--===============9114496812948753106==--

