Content-Type: multipart/mixed; boundary="===============9127534877777952047=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5][RfC] sim: Implement file watching and basic refresh.
Date: Fri, 10 Dec 2010 14:59:22 +0100
Message-ID: <1291989564-28694-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1291989564-28694-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9127534877777952047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    4 ++
 src/sim.c   |  175 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 179 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 792134b..6c660b6 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -296,6 +296,10 @@ ofono_bool_t __ofono_sim_service_available(struct ofon=
o_sim *sim,
 						int ust_service,
 						int sst_service);
 =

+void __ofono_sim_refresh(struct ofono_sim *sim, GSList *file_list,
+				ofono_bool_t full_file_change,
+				ofono_bool_t naa_init);
+
 #include <ofono/stk.h>
 =

 typedef void (*__ofono_sms_sim_download_cb_t)(ofono_bool_t ok,
diff --git a/src/sim.c b/src/sim.c
index c523982..da098b7 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -92,6 +92,7 @@ struct ofono_sim {
 	struct ofono_watchlist *state_watches;
 =

 	struct sim_fs *simfs;
+	GSList *fs_watches;
 =

 	unsigned char *iidf_image;
 =

@@ -113,6 +114,13 @@ struct service_number {
 	struct ofono_phone_number ph;
 };
 =

+struct fs_watch {
+	int id;
+	enum ofono_sim_state reset_state;
+	ofono_sim_file_notify_t notify;
+	void *notify_data;
+};
+
 static const char *const passwd_name[] =3D {
 	[OFONO_SIM_PASSWORD_NONE] =3D "none",
 	[OFONO_SIM_PASSWORD_SIM_PIN] =3D "pin",
@@ -2172,6 +2180,12 @@ static void sim_remove(struct ofono_atom *atom)
 		sim->simfs =3D NULL;
 	}
 =

+	if (sim->fs_watches !=3D NULL) {
+		g_slist_foreach(sim->fs_watches, (GFunc) g_free, NULL);
+		g_slist_free(sim->fs_watches);
+		sim->fs_watches =3D NULL;
+	}
+
 	g_free(sim);
 }
 =

@@ -2253,3 +2267,164 @@ void *ofono_sim_get_data(struct ofono_sim *sim)
 {
 	return sim->driver_data;
 }
+
+static gint fs_watch_compare_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct fs_watch *w =3D a;
+	const int *id =3D b;
+
+	return w->id - *id;
+}
+
+int ofono_sim_add_file_watch(struct ofono_sim *sim, int id,
+			enum ofono_sim_state reset_state,
+			ofono_sim_file_notify_t notify, void *userdata)
+{
+	struct fs_watch *item;
+
+	DBG("%p", sim);
+
+	if (sim =3D=3D NULL)
+		return 0;
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	/* Currently there's no need for multiple watches per file */
+	if (g_slist_find_custom(sim->fs_watches, &id, fs_watch_compare_by_id))
+		return -EEXIST;
+
+	item =3D g_new0(struct fs_watch, 1);
+
+	item->id =3D id;
+	item->notify =3D notify;
+	item->notify_data =3D userdata;
+	item->reset_state =3D reset_state;
+
+	sim->fs_watches =3D g_slist_prepend(sim->fs_watches, item);
+
+	return id;
+}
+
+void ofono_sim_remove_file_watch(struct ofono_sim *sim, int id,
+			ofono_sim_file_notify_t notify, void *userdata)
+{
+	GSList *item =3D g_slist_find_custom(sim->fs_watches,
+						&id, fs_watch_compare_by_id);
+	if (!item)
+		return;
+
+	g_free(item->data);
+	sim->fs_watches =3D g_slist_remove(sim->fs_watches, item->data);
+}
+
+void __ofono_sim_refresh(struct ofono_sim *sim, GSList *file_list,
+			ofono_bool_t full_file_change, ofono_bool_t naa_init)
+{
+	GSList *l;
+	enum sim_reset_state {
+		RESET_STATE_NOT_PRESENT	=3D OFONO_SIM_STATE_NOT_PRESENT,
+		RESET_STATE_INSERTED	=3D OFONO_SIM_STATE_INSERTED,
+		RESET_STATE_READY	=3D OFONO_SIM_STATE_READY,
+		RESET_STATE_NONE,
+	} reset_state =3D RESET_STATE_NONE;
+
+	/* Flush cached content for affected files */
+	if (full_file_change)
+		sim_fs_cache_flush(sim->simfs, 0);
+	else
+		for (l =3D file_list; l; l =3D l->next) {
+			struct stk_file *file =3D l->data;
+			int id =3D (file->file[file->len - 2] << 8) |
+				(file->file[file->len - 1] << 0);
+
+			sim_fs_cache_flush(sim->simfs, id);
+		}
+
+	if (naa_init)
+		reset_state =3D RESET_STATE_INSERTED;
+
+	/*
+	 * Check if we have file change handlers for all of the affected
+	 * files.  If not, we will fall back to re-initialising the
+	 * application which ensures that all files are re-read.
+	 */
+	for (l =3D sim->fs_watches; l; l =3D l->next) {
+		struct fs_watch *w =3D l->data;
+
+		if (full_file_change) {
+			if (w->notify)
+				continue;
+
+			if (w->reset_state < reset_state)
+				reset_state =3D reset_state;
+
+			continue;
+		}
+
+		for (l =3D file_list; l; l =3D l->next) {
+			struct stk_file *file =3D l->data;
+			int id =3D (file->file[file->len - 2] << 8) |
+				(file->file[file->len - 1] << 0);
+
+			if (id !=3D w->id)
+				continue;
+
+			if (w->notify)
+				break;
+
+			if (w->reset_state < reset_state)
+				reset_state =3D reset_state;
+
+			break;
+		}
+	}
+
+	/*
+	 * Notify the subscribers of files that have changed unless we
+	 * have determined that a re-initialisation is necessary and
+	 * will trigger re-reading of those files anyway.
+	 */
+	for (l =3D sim->fs_watches; l; l =3D l->next) {
+		struct fs_watch *w =3D l->data;
+
+		if (full_file_change) {
+			if (w->reset_state < reset_state)
+				w->notify(w->id, w->notify_data);
+
+			continue;
+		}
+
+		for (l =3D file_list; l; l =3D l->next) {
+			struct stk_file *file =3D l->data;
+			int id =3D (file->file[file->len - 2] << 8) |
+				(file->file[file->len - 1] << 0);
+
+			if (id !=3D w->id)
+				continue;
+
+			if (w->reset_state < reset_state)
+				w->notify(w->id, w->notify_data);
+
+			break;
+		}
+	}
+
+	switch (reset_state) {
+	case RESET_STATE_NOT_PRESENT:
+		ofono_sim_inserted_notify(sim, FALSE);
+		ofono_sim_inserted_notify(sim, TRUE);
+		break;
+	case RESET_STATE_INSERTED:
+		sim_free_state(sim);
+		sim->state =3D OFONO_SIM_STATE_INSERTED;
+		sim_initialize(sim);
+		break;
+	case RESET_STATE_READY:
+		sim->state =3D OFONO_SIM_STATE_INSERTED;
+		sim_set_ready(sim);
+		break;
+	case RESET_STATE_NONE:
+		break;
+	}
+}
-- =

1.7.1.86.g0e460.dirty


--===============9127534877777952047==--

