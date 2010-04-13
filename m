Content-Type: multipart/mixed; boundary="===============2294582925947177026=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/8] Refactor sim watchlist with atom watchlist
Date: Tue, 13 Apr 2010 22:18:14 +0800
Message-ID: <1271168299-4862-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1271168299-4862-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2294582925947177026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index f64c7d4..b9e6b4a 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -89,7 +89,6 @@ struct ofono_sim {
 	unsigned char efli_length;
 	enum ofono_sim_cphs_phase cphs_phase;
 	unsigned char cphs_service_table[2];
-	struct ofono_watchlist *ready_watches;
 	const struct ofono_sim_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -1779,28 +1778,20 @@ unsigned int ofono_sim_add_ready_watch(struct ofono=
_sim *sim,
 				ofono_sim_ready_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
 {
-	struct ofono_watchlist_item *item;
-
 	DBG("%p", sim);
 =

 	if (sim =3D=3D NULL)
 		return 0;
 =

-	if (notify =3D=3D NULL)
-		return 0;
-
-	item =3D g_new0(struct ofono_watchlist_item, 1);
-
-	item->notify =3D notify;
-	item->destroy =3D destroy;
-	item->notify_data =3D data;
-
-	return __ofono_watchlist_add_item(sim->ready_watches, item);
+	return __ofono_atom_add_signal_watch(sim->atom,
+					OFONO_SIGNAL_TYPE_SIM_READY,
+					(ofono_signal_watch_func) notify,
+					data, destroy);
 }
 =

 void ofono_sim_remove_ready_watch(struct ofono_sim *sim, unsigned int id)
 {
-	__ofono_watchlist_remove_item(sim->ready_watches, id);
+	__ofono_atom_remove_signal_watch(sim->atom, id);
 }
 =

 int ofono_sim_get_ready(struct ofono_sim *sim)
@@ -1816,6 +1807,7 @@ int ofono_sim_get_ready(struct ofono_sim *sim)
 =

 void ofono_sim_set_ready(struct ofono_sim *sim)
 {
+	GSList *ready_watches;
 	GSList *l;
 	ofono_sim_ready_notify_cb_t notify;
 =

@@ -1827,7 +1819,10 @@ void ofono_sim_set_ready(struct ofono_sim *sim)
 =

 	sim->ready =3D TRUE;
 =

-	for (l =3D sim->ready_watches->items; l; l =3D l->next) {
+	ready_watches =3D __ofono_atom_get_signal_watches(sim->atom,
+					OFONO_SIGNAL_TYPE_SIM_READY);
+
+	for (l =3D ready_watches; l; l =3D l->next) {
 		struct ofono_watchlist_item *item =3D l->data;
 		notify =3D item->notify;
 =

@@ -1895,10 +1890,6 @@ static void sim_unregister(struct ofono_atom *atom)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
-	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
-
-	__ofono_watchlist_free(sim->ready_watches);
-	sim->ready_watches =3D NULL;
 =

 	g_dbus_unregister_interface(conn, path, OFONO_SIM_MANAGER_INTERFACE);
 	ofono_modem_remove_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
@@ -2012,7 +2003,6 @@ void ofono_sim_register(struct ofono_sim *sim)
 	}
 =

 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
-	sim->ready_watches =3D __ofono_watchlist_new(g_free);
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
 =

-- =

1.6.6.1


--===============2294582925947177026==--

