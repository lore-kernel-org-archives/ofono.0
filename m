Content-Type: multipart/mixed; boundary="===============6176829238242083671=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 2/4] sim: Add SPN watch capability
Date: Mon, 09 Jan 2012 12:30:42 +0200
Message-ID: <1326105044-26408-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1326105044-26408-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6176829238242083671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    8 ++
 src/sim.c     |  242 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 250 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 6a5f067..b238868 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -196,6 +196,14 @@ void ofono_sim_remove_state_watch(struct ofono_sim *si=
m, unsigned int id);
 =

 enum ofono_sim_state ofono_sim_get_state(struct ofono_sim *sim);
 =

+typedef void (*ofono_sim_spn_cb_t)(const char *spn, const char *dc, void *=
data);
+
+gboolean ofono_sim_add_spn_watch(struct ofono_sim *sim, unsigned int *id,
+					ofono_sim_spn_cb_t cb, void *data,
+					ofono_destroy_func destroy);
+
+gboolean ofono_sim_remove_spn_watch(struct ofono_sim *sim, unsigned int *i=
d);
+
 void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d);
 =

 struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim);
diff --git a/src/sim.c b/src/sim.c
index 4ef14e3..93b3655 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -46,7 +46,11 @@
 #include "simfs.h"
 #include "stkutil.h"
 =

+#define SIM_FLAG_READING_SPN	0x1
+
 struct ofono_sim {
+	int flags;
+
 	/* Contents of the SIM file system, in rough initialization order */
 	char *iccid;
 =

@@ -91,6 +95,13 @@ struct ofono_sim {
 	enum ofono_sim_state state;
 	struct ofono_watchlist *state_watches;
 =

+	char *spn;
+	char *spn_dc;
+	struct ofono_watchlist *spn_watches;
+	unsigned int ef_spn_watch;
+	unsigned int cphs_spn_watch;
+	unsigned int cphs_spn_short_watch;
+
 	struct sim_fs *simfs;
 	struct ofono_sim_context *context;
 	struct ofono_sim_context *early_context;
@@ -2358,6 +2369,234 @@ enum ofono_sim_state ofono_sim_get_state(struct ofo=
no_sim *sim)
 	return sim->state;
 }
 =

+static void spn_watch_cb(gpointer data, gpointer user_data)
+{
+	struct ofono_watchlist_item *item =3D data;
+	struct ofono_sim *sim =3D user_data;
+
+	if (item->notify)
+		((ofono_sim_spn_cb_t) item->notify)(sim->spn, sim->spn_dc,
+							item->notify_data);
+}
+
+static inline void spn_watches_notify(struct ofono_sim *sim)
+{
+	if (sim->spn_watches->items)
+		g_slist_foreach(sim->spn_watches->items, spn_watch_cb, sim);
+
+	sim->flags &=3D ~SIM_FLAG_READING_SPN;
+}
+
+static void sim_spn_set(struct ofono_sim *sim, const void *data, int lengt=
h,
+						const unsigned char *dc)
+{
+	char *spn;
+
+	/*
+	 * TS 31.102 says:
+	 *
+	 * the string shall use:
+	 *
+	 * - either the SMS default 7-bit coded alphabet as defined in
+	 *   TS 23.038 [5] with bit 8 set to 0. The string shall be left
+	 *   justified. Unused bytes shall be set to 'FF'.
+	 *
+	 * - or one of the UCS2 code options defined in the annex of TS
+	 *   31.101 [11].
+	 *
+	 * 31.101 has no such annex though.  51.101 refers to Annex B of
+	 * itself which is not there either.  11.11 contains the same
+	 * paragraph as 51.101 and has an Annex B which we implement.
+	 */
+	spn =3D sim_string_to_utf8(data, length);
+	if (spn =3D=3D NULL) {
+		ofono_error("EFspn read successfully, but couldn't parse");
+		goto notify;
+	}
+
+	if (strlen(spn) =3D=3D 0) {
+		g_free(spn);
+		goto notify;
+	}
+
+	sim->spn =3D spn;
+
+	if (dc)
+		sim->spn_dc =3D g_memdup(dc, 1);
+
+notify:
+	spn_watches_notify(sim);
+}
+
+static void sim_cphs_spn_short_read_cb(int ok, int length, int record,
+					const unsigned char *data,
+					int record_length, void *user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+
+	if (!ok) {
+		spn_watches_notify(sim);
+		return;
+	}
+
+	sim_spn_set(sim, data, length, NULL);
+}
+
+static void sim_cphs_spn_read_cb(int ok, int length, int record,
+					const unsigned char *data,
+					int record_length, void *user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+
+	if (!ok) {
+		if (__ofono_sim_cphs_service_available(sim,
+						SIM_CPHS_SERVICE_SHORT_SPN))
+			ofono_sim_read(sim->context,
+					SIM_EF_CPHS_SPN_SHORT_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					sim_cphs_spn_short_read_cb, sim);
+		else
+			spn_watches_notify(sim);
+
+		return;
+	}
+
+	sim_spn_set(sim, data, length, NULL);
+}
+
+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+
+	if (!ok) {
+		ofono_sim_read(sim->context, SIM_EF_CPHS_SPN_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				sim_cphs_spn_read_cb, sim);
+
+		return;
+	}
+
+	sim_spn_set(sim, data + 1, length - 1, data);
+}
+
+static void sim_spn_changed(int id, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+
+	if (sim->flags & SIM_FLAG_READING_SPN)
+		return;
+
+	g_free(sim->spn);
+	sim->spn =3D NULL;
+
+	g_free(sim->spn_dc);
+	sim->spn_dc =3D NULL;
+
+	sim->flags |=3D SIM_FLAG_READING_SPN;
+	ofono_sim_read(sim->context, SIM_EFSPN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_spn_read_cb, sim);
+}
+
+static void sim_spn_init(struct ofono_sim *sim)
+{
+	sim->ef_spn_watch =3D ofono_sim_add_file_watch(sim->context,
+					SIM_EFSPN_FILEID, sim_spn_changed, sim,
+					NULL);
+
+	sim->cphs_spn_watch =3D ofono_sim_add_file_watch(sim->context,
+					SIM_EF_CPHS_SPN_FILEID,
+					sim_spn_changed, sim, NULL);
+
+	if (__ofono_sim_cphs_service_available(sim,
+						SIM_CPHS_SERVICE_SHORT_SPN))
+		sim->cphs_spn_short_watch =3D ofono_sim_add_file_watch(
+				sim->context, SIM_EF_CPHS_SPN_SHORT_FILEID,
+				sim_spn_changed, sim, NULL);
+}
+
+static void sim_spn_close(struct ofono_sim *sim)
+{
+	__ofono_watchlist_free(sim->spn_watches);
+	sim->spn_watches =3D NULL;
+
+	ofono_sim_remove_file_watch(sim->context, sim->ef_spn_watch);
+	sim->ef_spn_watch =3D 0;
+
+	ofono_sim_remove_file_watch(sim->context, sim->cphs_spn_watch);
+	sim->cphs_spn_watch =3D 0;
+
+	if (sim->cphs_spn_short_watch) {
+		ofono_sim_remove_file_watch(sim->context,
+						sim->cphs_spn_short_watch);
+		sim->cphs_spn_short_watch =3D 0;
+	}
+
+	sim->flags &=3D ~SIM_FLAG_READING_SPN;
+
+	g_free(sim->spn);
+	sim->spn =3D NULL;
+
+	g_free(sim->spn_dc);
+	sim->spn_dc =3D NULL;
+}
+
+gboolean ofono_sim_add_spn_watch(struct ofono_sim *sim, unsigned int *id,
+					ofono_sim_spn_cb_t cb, void *data,
+					ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+	unsigned int watch_id;
+
+	DBG("%p", sim);
+
+	if (sim =3D=3D NULL)
+		return 0;
+
+	item =3D g_new0(struct ofono_watchlist_item, 1);
+
+	item->notify =3D cb;
+	item->destroy =3D destroy;
+	item->notify_data =3D data;
+
+	watch_id =3D __ofono_watchlist_add_item(sim->spn_watches, item);
+	if (watch_id =3D=3D 0)
+		return FALSE;
+
+	*id =3D watch_id;
+
+	if (sim->ef_spn_watch =3D=3D 0) {
+		sim_spn_init(sim);
+		sim_spn_changed(0, sim);
+		return TRUE;
+	}
+
+	if (sim->flags & SIM_FLAG_READING_SPN)
+		return TRUE;
+
+	((ofono_sim_spn_cb_t) item->notify)(sim->spn, sim->spn_dc,
+							item->notify_data);
+	return TRUE;
+}
+
+gboolean ofono_sim_remove_spn_watch(struct ofono_sim *sim, unsigned int *i=
d)
+{
+	gboolean ret;
+
+	DBG("%p", sim);
+
+	if (sim =3D=3D NULL)
+		return FALSE;
+
+	ret =3D __ofono_watchlist_remove_item(sim->spn_watches, *id);
+	if (ret =3D=3D TRUE)
+		*id =3D 0;
+
+	return ret;
+}
+
 static void sim_pin_query_cb(const struct ofono_error *error,
 				enum ofono_sim_password_type pin_type,
 				void *data)
@@ -2477,6 +2716,8 @@ static void sim_unregister(struct ofono_atom *atom)
 	__ofono_watchlist_free(sim->state_watches);
 	sim->state_watches =3D NULL;
 =

+	sim_spn_close(sim);
+
 	g_dbus_unregister_interface(conn, path, OFONO_SIM_MANAGER_INTERFACE);
 	ofono_modem_remove_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
 }
@@ -2606,6 +2847,7 @@ void ofono_sim_register(struct ofono_sim *sim)
 =

 	ofono_modem_add_interface(modem, OFONO_SIM_MANAGER_INTERFACE);
 	sim->state_watches =3D __ofono_watchlist_new(g_free);
+	sim->spn_watches =3D __ofono_watchlist_new(g_free);
 	sim->simfs =3D sim_fs_new(sim, sim->driver);
 =

 	__ofono_atom_register(sim->atom, sim_unregister);
-- =

1.7.5.4


--===============6176829238242083671==--

