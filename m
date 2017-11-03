Content-Type: multipart/mixed; boundary="===============1805050311082029736=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 2/4] sim: AID session management
Date: Fri, 03 Nov 2017 15:34:42 -0700
Message-ID: <1509748484-8773-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509748484-8773-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1805050311082029736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Accessing an AID requires opening a channel to that application.
This patch implements session management API's so that other atoms
can access a given AID. Now any atom can get a session ID from the
sim atom. This will either reuse an existing session or open a new
channel. Once done, the atom should release the session which will
automatically close the channel when no atoms are using it.

The major functional change to the sim atom is the AID discovery
phase of initialization. Now, the sim atom is not 'ready' until AID
discovery finishes where before, the sim was 'ready' after the IMSI
had been obtained. If application discovery is not supported then
the the sim atom behaves as it did before.
---
 src/sim.c | 255 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 255 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index 155f421..3a084c6 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -48,6 +48,26 @@
 =

 #define SIM_FLAG_READING_SPN	0x1
 =

+/*
+ * A new session object will be created if a USim/ISim applications are
+ * found during app discovery. Any concurrent file/logical access to
+ * these applications will share the same session ID.
+ */
+enum session_state {
+	SESSION_STATE_INACTIVE,
+	SESSION_STATE_OPENING,
+	SESSION_STATE_CLOSING,
+	SESSION_STATE_OPEN
+};
+
+struct ofono_sim_aid_session {
+	struct sim_app_record *record;
+	int session_id;
+	struct ofono_sim *sim;
+	struct ofono_watchlist *watches;
+	enum session_state state;
+};
+
 struct ofono_sim {
 	int flags;
 =

@@ -114,6 +134,9 @@ struct ofono_sim {
 	void *driver_data;
 	struct ofono_atom *atom;
 	unsigned int hfp_watch;
+
+	GSList *aid_sessions;
+	GSList *aid_list;
 };
 =

 struct msisdn_set_request {
@@ -1434,6 +1457,36 @@ static void sim_set_ready(struct ofono_sim *sim)
 	call_state_watches(sim);
 }
 =

+static void discover_apps_cb(const struct ofono_error *error,
+		const unsigned char *dataobj,
+		int len, void *data)
+{
+	GSList *iter;
+	struct ofono_sim *sim =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		return;
+
+	sim->aid_list =3D sim_parse_app_template_entries(dataobj, len);
+
+	iter =3D sim->aid_list;
+
+	while (iter) {
+		struct sim_app_record *app =3D iter->data;
+		struct ofono_sim_aid_session *s =3D g_try_new0(
+				struct ofono_sim_aid_session, 1);
+
+		s->watches =3D __ofono_watchlist_new(g_free);
+		s->record =3D app;
+		s->sim =3D sim;
+		s->session_id =3D -1;
+		s->state =3D SESSION_STATE_INACTIVE;
+		sim->aid_sessions =3D g_slist_prepend(sim->aid_sessions, s);
+
+		iter =3D g_slist_next(iter);
+	}
+}
+
 static void sim_imsi_obtained(struct ofono_sim *sim, const char *imsi)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1844,6 +1897,12 @@ static void sim_initialize_after_pin(struct ofono_si=
m *sim)
 {
 	sim->context =3D ofono_sim_context_create(sim);
 =

+	/*
+	 * Discover applications on SIM
+	 */
+	if (sim->driver->list_apps)
+		sim->driver->list_apps(sim, discover_apps_cb, sim);
+
 	ofono_sim_read(sim->context, SIM_EFPHASE_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efphase_read_cb, sim);
@@ -2386,6 +2445,15 @@ static void sim_spn_close(struct ofono_sim *sim)
 	sim->spn_dc =3D NULL;
 }
 =

+static void aid_session_free(gpointer data)
+{
+	struct ofono_sim_aid_session *session =3D data;
+
+	__ofono_watchlist_free(session->watches);
+
+	g_free(session);
+}
+
 static void sim_free_main_state(struct ofono_sim *sim)
 {
 	if (sim->imsi) {
@@ -2450,6 +2518,9 @@ static void sim_free_main_state(struct ofono_sim *sim)
 		ofono_sim_context_free(sim->context);
 		sim->context =3D NULL;
 	}
+
+	if (sim->aid_sessions)
+		g_slist_free_full(sim->aid_sessions, aid_session_free);
 }
 =

 static void sim_free_state(struct ofono_sim *sim)
@@ -3304,3 +3375,187 @@ void __ofono_sim_refresh(struct ofono_sim *sim, GSL=
ist *file_list,
 		}
 	}
 }
+
+static void open_channel_cb(const struct ofono_error *error, int session_i=
d,
+		void *data);
+
+static void close_channel_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_sim_aid_session *session =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		DBG("session %d failed to close", session->session_id);
+
+	if (g_slist_length(session->watches->items) > 0 &&
+				session->state =3D=3D SESSION_STATE_OPENING) {
+		/*
+		 * An atom requested to open during a close, we can re-open
+		 * here.
+		 */
+		session->sim->driver->open_channel(session->sim,
+				session->record->aid, open_channel_cb,
+				session);
+		return;
+	}
+
+	session->state =3D SESSION_STATE_INACTIVE;
+}
+
+static void open_channel_cb(const struct ofono_error *error, int session_i=
d,
+		void *data)
+{
+	struct ofono_sim_aid_session *session =3D data;
+	GSList *iter =3D session->watches->items;
+	ofono_bool_t active =3D TRUE;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		session->state =3D SESSION_STATE_INACTIVE;
+		session->session_id =3D 0;
+		active =3D FALSE;
+		goto end;
+	}
+
+	if (g_slist_length(iter) =3D=3D 0) {
+		/*
+		 * All watchers stopped watching before the channel could open.
+		 * Close the channel.
+		 */
+		session->state =3D SESSION_STATE_CLOSING;
+		session->sim->driver->close_channel(session->sim,
+				session->session_id, close_channel_cb, session);
+		return;
+	}
+
+	session->session_id =3D session_id;
+	session->state =3D SESSION_STATE_OPEN;
+end:
+	/*
+	 * Notify any watchers, after this point, all future watchers will be
+	 * immediately notified with the session ID.
+	 */
+	while (iter) {
+		struct ofono_watchlist_item *item =3D iter->data;
+		ofono_sim_session_event_cb_t notify =3D item->notify;
+
+		notify(active, session->session_id, item->notify_data);
+
+		iter =3D g_slist_next(iter);
+	}
+}
+
+unsigned int __ofono_sim_add_session_watch(
+		struct ofono_sim_aid_session *session,
+		ofono_sim_session_event_cb_t notify, void *data,
+		ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", session);
+
+	if (session =3D=3D NULL)
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
+	if (g_slist_length(session->watches->items) =3D=3D 0 &&
+			session->state =3D=3D SESSION_STATE_INACTIVE) {
+		/*
+		 * If the session is inactive and there are no watchers, open
+		 * a new session.
+		 */
+		session->state =3D SESSION_STATE_OPENING;
+		session->sim->driver->open_channel(session->sim,
+				session->record->aid, open_channel_cb,
+				session);
+	} else if (session->state =3D=3D SESSION_STATE_OPEN) {
+		/*
+		 * Session is already open and available, just call the
+		 * notify callback immediately.
+		 */
+		notify(TRUE, session->session_id, data);
+	} else if (session->state =3D=3D SESSION_STATE_CLOSING) {
+		/*
+		 * There is a pending close, the close callback will handle
+		 * re-opening the session.
+		 */
+		session->state =3D SESSION_STATE_OPENING;
+	}
+
+	return __ofono_watchlist_add_item(session->watches, item);
+}
+
+void __ofono_sim_remove_session_watch(struct ofono_sim_aid_session *sessio=
n,
+		unsigned int id)
+{
+	if (g_slist_length(session->watches->items) =3D=3D 1) {
+		/* last watcher, close session */
+		session->state =3D SESSION_STATE_CLOSING;
+		session->sim->driver->close_channel(session->sim,
+				session->session_id, close_channel_cb, session);
+	}
+
+	__ofono_watchlist_remove_item(session->watches, id);
+}
+
+struct ofono_sim_aid_session *__ofono_sim_get_session_by_aid(
+		struct ofono_sim *sim, unsigned char *aid)
+{
+	GSList *iter =3D sim->aid_sessions;
+
+	while (iter) {
+		struct ofono_sim_aid_session *session =3D iter->data;
+
+		if (!memcmp(session->record->aid, aid, 16))
+			return session;
+
+		iter =3D g_slist_next(iter);
+	}
+
+	return NULL;
+}
+
+struct ofono_sim_aid_session *__ofono_sim_get_session_by_type(
+		struct ofono_sim *sim, enum sim_app_type type)
+{
+	GSList *iter =3D sim->aid_sessions;
+
+	while (iter) {
+		struct ofono_sim_aid_session *session =3D iter->data;
+
+		if (session->record->type =3D=3D type)
+			return session;
+
+		iter =3D g_slist_next(iter);
+	}
+
+	return NULL;
+}
+
+int __ofono_sim_session_get_id(struct ofono_sim_aid_session *session)
+{
+	return session->session_id;
+}
+
+enum sim_app_type __ofono_sim_session_get_type(
+		struct ofono_sim_aid_session *session)
+{
+	return session->record->type;
+}
+
+unsigned char *__ofono_sim_session_get_aid(
+		struct ofono_sim_aid_session *session)
+{
+	return session->record->aid;
+}
+
+GSList *__ofono_sim_get_aid_list(struct ofono_sim *sim)
+{
+	return sim->aid_list;
+}
-- =

2.7.4


--===============1805050311082029736==--

