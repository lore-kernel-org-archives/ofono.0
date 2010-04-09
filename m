Content-Type: multipart/mixed; boundary="===============2739446006684316831=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/8] Extend sim-ready watch with card insert/eject events.
Date: Fri, 09 Apr 2010 08:48:34 +0200
Message-ID: <1270795714-7098-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2739446006684316831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |   17 ++++++++++++-----
 src/cbs.c     |    2 +-
 src/modem.c   |   11 ++++++-----
 src/sim.c     |   49 +++++++++++++++++++++++++------------------------
 4 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 6ff29f7..23b1905 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -71,6 +71,12 @@ enum ofono_sim_cphs_phase {
 	OFONO_SIM_CPHS_PHASE_2G,
 };
 =

+enum ofono_sim_state {
+	OFONO_SIM_STATE_NOT_PRESENT,
+	OFONO_SIM_STATE_INSERTED,
+	OFONO_SIM_STATE_READY,
+};
+
 typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
 					int filelength,
 					enum ofono_sim_file_structure structure,
@@ -88,7 +94,8 @@ typedef void (*ofono_sim_write_cb_t)(const struct ofono_e=
rror *error,
 typedef void (*ofono_sim_imsi_cb_t)(const struct ofono_error *error,
 					const char *imsi, void *data);
 =

-typedef void (*ofono_sim_ready_notify_cb_t)(void *data);
+typedef void (*ofono_sim_state_event_notify_cb_t)(void *data,
+					enum ofono_sim_state new_state);
 =

 typedef void (*ofono_sim_file_read_cb_t)(int ok, int total_length, int rec=
ord,
 					const unsigned char *data,
@@ -173,13 +180,13 @@ enum ofono_sim_phase ofono_sim_get_phase(struct ofono=
_sim *sim);
 enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
 const unsigned char *ofono_sim_get_cphs_service_table(struct ofono_sim *si=
m);
 =

-unsigned int ofono_sim_add_ready_watch(struct ofono_sim *sim,
-				ofono_sim_ready_notify_cb_t cb,
+unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
+				ofono_sim_state_event_notify_cb_t cb,
 				void *data, ofono_destroy_func destroy);
 =

-void ofono_sim_remove_ready_watch(struct ofono_sim *sim, unsigned int id);
+void ofono_sim_remove_state_watch(struct ofono_sim *sim, unsigned int id);
 =

-int ofono_sim_get_ready(struct ofono_sim *sim);
+enum ofono_sim_state ofono_sim_get_state(struct ofono_sim *sim);
 void ofono_sim_set_ready(struct ofono_sim *sim);
 =

 /* This will queue an operation to read all available records with id from=
 the
diff --git a/src/cbs.c b/src/cbs.c
index d04404e..2fa33c1 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -1046,7 +1046,7 @@ void ofono_cbs_register(struct ofono_cbs *cbs)
 	if (sim_atom) {
 		cbs->sim =3D __ofono_atom_get_data(sim_atom);
 =

-		if (ofono_sim_get_ready(cbs->sim) =3D=3D TRUE)
+		if (ofono_sim_get_state(cbs->sim) =3D=3D OFONO_SIM_STATE_READY)
 			cbs_got_imsi(cbs);
 	}
 =

diff --git a/src/modem.c b/src/modem.c
index b935328..df74be3 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1117,10 +1117,13 @@ static void emit_modems()
 	g_free(modems);
 }
 =

-static void modem_sim_ready(void *user)
+static void modem_sim_ready(void *user, enum ofono_sim_state new_state)
 {
 	struct ofono_modem *modem =3D user;
 =

+	if (new_state !=3D OFONO_SIM_STATE_READY)
+		return;
+
 	if (modem->driver->post_sim)
 		modem->driver->post_sim(modem);
 =

@@ -1138,12 +1141,10 @@ static void sim_watch(struct ofono_atom *atom,
 	}
 =

 	modem->sim =3D __ofono_atom_get_data(atom);
-	modem->sim_ready_watch =3D ofono_sim_add_ready_watch(modem->sim,
+	modem->sim_ready_watch =3D ofono_sim_add_state_watch(modem->sim,
 							modem_sim_ready,
 							modem, NULL);
-
-	if (ofono_sim_get_ready(modem->sim))
-		modem_sim_ready(modem);
+	modem_sim_ready(modem, ofono_sim_get_state(modem->sim));
 }
 =

 int ofono_modem_register(struct ofono_modem *modem)
diff --git a/src/sim.c b/src/sim.c
index f64c7d4..58de191 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -77,7 +77,7 @@ struct ofono_sim {
 	GSList *new_numbers;
 	GSList *service_numbers;
 	gboolean sdn_ready;
-	gboolean ready;
+	enum ofono_sim_state state;
 	enum ofono_sim_password_type pin_type;
 	gboolean locked_pins[OFONO_SIM_PASSWORD_INVALID];
 	char **language_prefs;
@@ -89,7 +89,7 @@ struct ofono_sim {
 	unsigned char efli_length;
 	enum ofono_sim_cphs_phase cphs_phase;
 	unsigned char cphs_service_table[2];
-	struct ofono_watchlist *ready_watches;
+	struct ofono_watchlist *state_watches;
 	const struct ofono_sim_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -968,10 +968,13 @@ static void sim_own_numbers_update(struct ofono_sim *=
sim)
 			sim_msisdn_read_cb, sim);
 }
 =

-static void sim_ready(void *user)
+static void sim_ready(void *user, enum ofono_sim_state new_state)
 {
 	struct ofono_sim *sim =3D user;
 =

+	if (new_state !=3D OFONO_SIM_STATE_READY)
+		return;
+
 	sim_own_numbers_update(sim);
 =

 	ofono_sim_read(sim, SIM_EFAD_FILEID,
@@ -1775,8 +1778,8 @@ const unsigned char *ofono_sim_get_cphs_service_table=
(struct ofono_sim *sim)
 	return sim->cphs_service_table;
 }
 =

-unsigned int ofono_sim_add_ready_watch(struct ofono_sim *sim,
-				ofono_sim_ready_notify_cb_t notify,
+unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
+				ofono_sim_state_event_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
 {
 	struct ofono_watchlist_item *item;
@@ -1795,43 +1798,40 @@ unsigned int ofono_sim_add_ready_watch(struct ofono=
_sim *sim,
 	item->destroy =3D destroy;
 	item->notify_data =3D data;
 =

-	return __ofono_watchlist_add_item(sim->ready_watches, item);
+	return __ofono_watchlist_add_item(sim->state_watches, item);
 }
 =

-void ofono_sim_remove_ready_watch(struct ofono_sim *sim, unsigned int id)
+void ofono_sim_remove_state_watch(struct ofono_sim *sim, unsigned int id)
 {
-	__ofono_watchlist_remove_item(sim->ready_watches, id);
+	__ofono_watchlist_remove_item(sim->state_watches, id);
 }
 =

-int ofono_sim_get_ready(struct ofono_sim *sim)
+enum ofono_sim_state ofono_sim_get_state(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
-		return 0;
+		return OFONO_SIM_STATE_NOT_PRESENT;
 =

-	if (sim->ready =3D=3D TRUE)
-		return 1;
-
-	return 0;
+	return sim->state;
 }
 =

 void ofono_sim_set_ready(struct ofono_sim *sim)
 {
 	GSList *l;
-	ofono_sim_ready_notify_cb_t notify;
+	ofono_sim_state_event_notify_cb_t notify;
 =

 	if (sim =3D=3D NULL)
 		return;
 =

-	if (sim->ready =3D=3D TRUE)
+	if (sim->state !=3D OFONO_SIM_STATE_INSERTED)
 		return;
 =

-	sim->ready =3D TRUE;
+	sim->state =3D OFONO_SIM_STATE_READY;
 =

-	for (l =3D sim->ready_watches->items; l; l =3D l->next) {
+	for (l =3D sim->state_watches->items; l; l =3D l->next) {
 		struct ofono_watchlist_item *item =3D l->data;
 		notify =3D item->notify;
 =

-		notify(item->notify_data);
+		notify(item->notify_data, sim->state);
 	}
 }
 =

@@ -1851,7 +1851,7 @@ void __ofono_cbs_sim_download(struct ofono_sim *sim,
 {
 	guint8 tlv[pdu_len + 8];
 =

-	if (sim->ready !=3D TRUE)
+	if (sim->state !=3D OFONO_SIM_STATE_READY)
 		return;
 =

 	if (sim->driver->envelope =3D=3D NULL)
@@ -1897,8 +1897,8 @@ static void sim_unregister(struct ofono_atom *atom)
 	const char *path =3D __ofono_atom_get_path(atom);
 	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
 =

-	__ofono_watchlist_free(sim->ready_watches);
-	sim->ready_watches =3D NULL;
+	__ofono_watchlist_free(sim->state_watches);
+	sim->state_watches =3D NULL;
 =

 	g_dbus_unregister_interface(conn, path, OFONO_SIM_MANAGER_INTERFACE);
 	ofono_modem_remove_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
@@ -2012,11 +2012,12 @@ void ofono_sim_register(struct ofono_sim *sim)
 	}
 =

 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
-	sim->ready_watches =3D __ofono_watchlist_new(g_free);
+	sim->state_watches =3D __ofono_watchlist_new(g_free);
+	sim->state =3D OFONO_SIM_STATE_INSERTED;
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
 =

-	ofono_sim_add_ready_watch(sim, sim_ready, sim, NULL);
+	ofono_sim_add_state_watch(sim, sim_ready, sim, NULL);
 =

 	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
 	 * The assumption here is that if sim manager is being initialized,
-- =

1.6.1


--===============2739446006684316831==--

