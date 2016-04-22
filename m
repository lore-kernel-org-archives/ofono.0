Content-Type: multipart/mixed; boundary="===============8637977535222959417=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 2/5] bluez4: track and clean up atom watches
Date: Fri, 22 Apr 2016 13:07:15 +0000
Message-ID: <1461330431-20206-3-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330431-20206-2-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8637977535222959417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

Prevents glib from causing SIGFPE during certain circumstances of modem
removal.
---
 plugins/dun_gw_bluez4.c | 24 ++++++++++++++++++++++--
 plugins/hfp_ag_bluez4.c | 25 ++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/plugins/dun_gw_bluez4.c b/plugins/dun_gw_bluez4.c
index a1de7a4..570da7f 100644
--- a/plugins/dun_gw_bluez4.c
+++ b/plugins/dun_gw_bluez4.c
@@ -40,6 +40,7 @@
 static struct server *server;
 static guint modemwatch_id;
 static GList *modems;
+static GHashTable *gprs_watches =3D NULL;
 =

 static const gchar *dun_record =3D
 "<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
@@ -129,15 +130,29 @@ static void gprs_watch(struct ofono_atom *atom,
 	}
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
@@ -149,6 +164,8 @@ static int dun_gw_init(void)
 {
 	DBG("");
 =

+	gprs_watches =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+
 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 =

 	__ofono_modem_foreach(call_modemwatch, NULL);
@@ -161,6 +178,9 @@ static void dun_gw_exit(void)
 	__ofono_modemwatch_remove(modemwatch_id);
 	g_list_free(modems);
 =

+	g_hash_table_foreach_remove(gprs_watches, atom_watch_remove, NULL);
+	g_hash_table_destroy(gprs_watches);
+
 	if (server) {
 		bluetooth_unregister_server(server);
 		server =3D NULL;
diff --git a/plugins/hfp_ag_bluez4.c b/plugins/hfp_ag_bluez4.c
index 039b665..b931ae1 100644
--- a/plugins/hfp_ag_bluez4.c
+++ b/plugins/hfp_ag_bluez4.c
@@ -41,6 +41,7 @@ static struct server *server;
 static guint modemwatch_id;
 static GList *modems;
 static GHashTable *sim_hash =3D NULL;
+static GHashTable *sim_watches =3D NULL;
 =

 static const gchar *hfp_ag_record =3D
 "<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
@@ -142,6 +143,16 @@ static void sim_state_watch(enum ofono_sim_state new_s=
tate, void *data)
 						hfp_ag_connect_cb, NULL);
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
@@ -176,13 +187,17 @@ static void sim_watch(struct ofono_atom *atom,
 =

 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
 {
+	int sim;
 	DBG("modem: %p, added: %d", modem, added);
 =

-	if (added =3D=3D FALSE)
+	if (added =3D=3D FALSE) {
+		g_hash_table_remove(sim_watches, modem);
 		return;
+	}
 =

-	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SIM,
-					sim_watch, modem, NULL);
+	sim =3D __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SIM,
+						sim_watch, modem, NULL);
+	g_hash_table_insert(sim_watches, modem, GUINT_TO_POINTER(sim));
 }
 =

 static void call_modemwatch(struct ofono_modem *modem, void *user)
@@ -193,6 +208,7 @@ static void call_modemwatch(struct ofono_modem *modem, =
void *user)
 static int hfp_ag_init(void)
 {
 	sim_hash =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+	sim_watches =3D g_hash_table_new(g_direct_hash, g_direct_equal);
 =

 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 	__ofono_modem_foreach(call_modemwatch, NULL);
@@ -207,6 +223,9 @@ static void hfp_ag_exit(void)
 	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
 	g_hash_table_destroy(sim_hash);
 =

+	g_hash_table_foreach_remove(sim_watches, atom_watch_remove, NULL);
+	g_hash_table_destroy(sim_watches);
+
 	if (server) {
 		bluetooth_unregister_server(server);
 		server =3D NULL;
-- =

1.9.1

--===============8637977535222959417==--

