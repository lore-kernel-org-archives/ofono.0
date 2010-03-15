Content-Type: multipart/mixed; boundary="===============7547829482446693205=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/8][RFC] Add functions to notify core of SIM
 insertion/removal or request polling.
Date: Mon, 15 Mar 2010 22:20:44 +0100
Message-ID: <1268688044-3568-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7547829482446693205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement optional polling.  Polling is mandatory according to the
specification but on most hardware it will me impractical because
there will be vendor specific unsolicited notifications that can be
used instead.  Modem plugins need to handle them.
---
 include/sim.h |   21 ++++++-
 src/sim.c     |  197 ++++++++++++++++++++++++++++++++++++++++++++++++++---=
----
 2 files changed, 195 insertions(+), 23 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 6ff29f7..fdfe2e8 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -106,6 +106,8 @@ typedef void (*ofono_sim_lock_unlock_cb_t)(const struct=
 ofono_error *error,
 typedef void (*ofono_sim_locked_cb_t)(const struct ofono_error *error,
 					int locked, void *data);
 =

+typedef void (*ofono_sim_cb_t)(const struct ofono_error *error, void *data=
);
+
 struct ofono_sim_driver {
 	const char *name;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
@@ -152,6 +154,12 @@ struct ofono_sim_driver {
 	void (*envelope)(struct ofono_sim *sim, int length,
 				const guint8 *command,
 				ofono_sim_read_cb_t cb, void *data);
+	void (*status)(struct ofono_sim *sim, ofono_sim_cb_t cb, void *data);
+	void (*fetch)(struct ofono_sim *sim, int length,
+			ofono_sim_read_cb_t cb, void *data);
+	void (*terminal_response)(struct ofono_sim *sim, int length,
+			const unsigned char *value, ofono_sim_write_cb_t cb,
+			void *data);
 };
 =

 int ofono_sim_driver_register(const struct ofono_sim_driver *d);
@@ -179,8 +187,19 @@ unsigned int ofono_sim_add_ready_watch(struct ofono_si=
m *sim,
 =

 void ofono_sim_remove_ready_watch(struct ofono_sim *sim, unsigned int id);
 =

+unsigned int ofono_sim_add_removed_watch(struct ofono_sim *sim,
+				ofono_sim_ready_notify_cb_t cb,
+				void *data, ofono_destroy_func destroy);
+
+void ofono_sim_remove_removed_watch(struct ofono_sim *sim, unsigned int id=
);
+
 int ofono_sim_get_ready(struct ofono_sim *sim);
-void ofono_sim_set_ready(struct ofono_sim *sim);
+
+void ofono_sim_inserted(struct ofono_sim *sim);
+void ofono_sim_removed(struct ofono_sim *sim);
+void ofono_sim_proactive_command_notify(struct ofono_sim *sim, int length);
+
+void ofono_sim_poll_enable(struct ofono_sim *sim);
 =

 /* This will queue an operation to read all available records with id from=
 the
  * SIM.  Callback cb will be called every time a record has been read, or =
once
diff --git a/src/sim.c b/src/sim.c
index 1ab8a8b..733e876 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -57,6 +57,8 @@ static gboolean sim_op_next(gpointer user_data);
 static gboolean sim_op_retrieve_next(gpointer user);
 static void sim_own_numbers_update(struct ofono_sim *sim);
 static void sim_pin_check(struct ofono_sim *sim);
+static void sim_set_ready(struct ofono_sim *sim);
+static gboolean sim_status_poll(gpointer user_data);
 =

 struct sim_file_op {
 	int id;
@@ -92,6 +94,13 @@ struct ofono_sim {
 	enum ofono_sim_cphs_phase cphs_phase;
 	unsigned char cphs_service_table[2];
 	struct ofono_watchlist *ready_watches;
+	struct ofono_watchlist *removed_watches;
+	int idle_poll_interval;
+	int incall_poll_interval;
+	gint status_timeout;
+	gint poll_timeout;
+	gboolean poll_enabled;
+	gboolean inserted;
 	const struct ofono_sim_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -973,7 +982,7 @@ static void sim_cphs_information_read_cb(int ok, int le=
ngth, int record,
 	memcpy(sim->cphs_service_table, data + 1, 2);
 =

 ready:
-	ofono_sim_set_ready(sim);
+	sim_set_ready(sim);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
@@ -1743,6 +1752,117 @@ const unsigned char *ofono_sim_get_cphs_service_tab=
le(struct ofono_sim *sim)
 	return sim->cphs_service_table;
 }
 =

+void ofono_sim_inserted(struct ofono_sim *sim)
+{
+	sim->inserted =3D TRUE;
+
+	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
+	 * The assumption here is that if sim manager is being initialized,
+	 * then sim commands are implemented, and the sim manager is then
+	 * responsible for checking the PIN, reading the IMSI and signaling
+	 * SIM ready condition.
+	 *
+	 * The procedure according to 31.102 is roughly:
+	 * Read EFecc
+	 * Read EFli and EFpl
+	 * SIM Pin check
+	 * Request SIM phase (only in 51.011)
+	 * Read EFust
+	 * Read EFest
+	 * Read IMSI
+	 *
+	 * At this point we signal the SIM ready condition and allow
+	 * arbitrary files to be written or read, assuming their presence
+	 * in the EFust
+	 */
+	sim_determine_phase(sim);
+}
+
+void ofono_sim_removed(struct ofono_sim *sim)
+{
+	GSList *l;
+	ofono_sim_ready_notify_cb_t notify;
+
+	if (sim =3D=3D NULL)
+		return;
+
+	sim->inserted =3D FALSE;
+
+	if (sim->ready =3D=3D FALSE)
+		return;
+
+	sim->ready =3D FALSE;
+
+	for (l =3D sim->removed_watches->items; l; l =3D l->next) {
+		struct ofono_watchlist_item *item =3D l->data;
+		notify =3D item->notify;
+
+		notify(item->notify_data);
+	}
+}
+
+void ofono_sim_proactive_command_notify(struct ofono_sim *sim, int length)
+{
+}
+
+static void sim_status_poll_schedule(struct ofono_sim *sim)
+{
+	/* TODO: Decide on the interval based on whether any call is active */
+	/* TODO: On idle, possibly only schedule if proactive commands enabled
+	 * as indicated by EFphase + EFsst (51.011: 11.6.1) */
+	int interval =3D sim->idle_poll_interval;
+
+	sim->poll_timeout =3D g_timeout_add_seconds(interval,
+			sim_status_poll, sim);
+}
+
+static void sim_status_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_sim *sim =3D data;
+
+	if (!sim->status_timeout)
+		/* The STATUS already timed out */
+		goto done;
+
+	g_source_remove(sim->status_timeout);
+	sim->status_timeout =3D 0;
+
+	if (sim->inserted !=3D TRUE)
+		ofono_sim_inserted(sim);
+
+done:
+	sim_status_poll_schedule(sim);
+}
+
+static gboolean sim_status_timeout(gpointer user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+
+	sim->status_timeout =3D 0;
+	if (sim->inserted =3D=3D TRUE)
+		ofono_sim_removed(sim);
+
+	sim_status_poll_schedule(sim);
+
+	return FALSE;
+}
+
+static gboolean sim_status_poll(gpointer user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+
+	sim->poll_timeout =3D 0;
+
+	/* The SIM must respond in a given time frame which is of at
+	 * least 5 seconds in TS 11.11.  */
+	sim->status_timeout =3D g_timeout_add_seconds(5,
+			sim_status_timeout, sim);
+
+	sim->driver->status(sim, sim_status_cb, sim);
+
+	return FALSE;
+}
+
 unsigned int ofono_sim_add_ready_watch(struct ofono_sim *sim,
 				ofono_sim_ready_notify_cb_t notify,
 				void *data, ofono_destroy_func destroy)
@@ -1771,6 +1891,34 @@ void ofono_sim_remove_ready_watch(struct ofono_sim *=
sim, unsigned int id)
 	__ofono_watchlist_remove_item(sim->ready_watches, id);
 }
 =

+unsigned int ofono_sim_add_removed_watch(struct ofono_sim *sim,
+				ofono_sim_ready_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", sim);
+
+	if (sim =3D=3D NULL)
+		return 0;
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	item =3D g_new0(struct ofono_watchlist_item, 1);
+
+	item->notify =3D notify;
+	item->destroy =3D destroy;
+	item->notify_data =3D data;
+
+	return __ofono_watchlist_add_item(sim->removed_watches, item);
+}
+
+void ofono_sim_remove_removed_watch(struct ofono_sim *sim, unsigned int id)
+{
+	__ofono_watchlist_remove_item(sim->removed_watches, id);
+}
+
 int ofono_sim_get_ready(struct ofono_sim *sim)
 {
 	if (sim =3D=3D NULL)
@@ -1782,7 +1930,7 @@ int ofono_sim_get_ready(struct ofono_sim *sim)
 	return 0;
 }
 =

-void ofono_sim_set_ready(struct ofono_sim *sim)
+static void sim_set_ready(struct ofono_sim *sim)
 {
 	GSList *l;
 	ofono_sim_ready_notify_cb_t notify;
@@ -1867,6 +2015,8 @@ static void sim_unregister(struct ofono_atom *atom)
 =

 	__ofono_watchlist_free(sim->ready_watches);
 	sim->ready_watches =3D NULL;
+	__ofono_watchlist_free(sim->removed_watches);
+	sim->removed_watches =3D NULL;
 =

 	g_dbus_unregister_interface(conn, path,
 					SIM_MANAGER_INTERFACE);
@@ -1925,6 +2075,16 @@ static void sim_remove(struct ofono_atom *atom)
 		sim->simop_q =3D NULL;
 	}
 =

+	if (sim->status_timeout) {
+		g_source_remove(sim->status_timeout);
+		sim->status_timeout =3D 0;
+	}
+
+	if (sim->poll_timeout) {
+		g_source_remove(sim->poll_timeout);
+		sim->poll_timeout =3D 0;
+	}
+
 	g_free(sim);
 }
 =

@@ -1982,31 +2142,19 @@ void ofono_sim_register(struct ofono_sim *sim)
 =

 	ofono_modem_add_interface(modem, SIM_MANAGER_INTERFACE);
 	sim->ready_watches =3D __ofono_watchlist_new(g_free);
+	sim->removed_watches =3D __ofono_watchlist_new(g_free);
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
 =

 	ofono_sim_add_ready_watch(sim, sim_ready, sim, NULL);
 =

-	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
-	 * The assumption here is that if sim manager is being initialized,
-	 * then sim commands are implemented, and the sim manager is then
-	 * responsible for checking the PIN, reading the IMSI and signaling
-	 * SIM ready condition.
-	 *
-	 * The procedure according to 31.102 is roughly:
-	 * Read EFecc
-	 * Read EFli and EFpl
-	 * SIM Pin check
-	 * Request SIM phase (only in 51.011)
-	 * Read EFust
-	 * Read EFest
-	 * Read IMSI
-	 *
-	 * At this point we signal the SIM ready condition and allow
-	 * arbitrary files to be written or read, assuming their presence
-	 * in the EFust
-	 */
-	sim_determine_phase(sim);
+	if (sim->poll_enabled && sim->driver->status) {
+		sim->idle_poll_interval =3D 30;
+		sim->incall_poll_interval =3D 30;
+
+		sim_status_poll(sim);
+	} else
+		ofono_sim_inserted(sim);
 }
 =

 void ofono_sim_remove(struct ofono_sim *sim)
@@ -2023,3 +2171,8 @@ void *ofono_sim_get_data(struct ofono_sim *sim)
 {
 	return sim->driver_data;
 }
+
+void ofono_sim_poll_enable(struct ofono_sim *sim)
+{
+	sim->poll_enabled =3D TRUE;
+}
-- =

1.6.1


--===============7547829482446693205==--

