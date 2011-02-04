Content-Type: multipart/mixed; boundary="===============5038046920841440880=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] sim: Implement file watching and basic refresh.
Date: Fri, 04 Feb 2011 02:20:32 +0100
Message-ID: <1296782434-11008-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1296782434-11008-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5038046920841440880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In this version watches are asssigned to simfs contexts so that
there's less free()ing for users to do.  This patch includes part of
EF cache flushing patch from the previous version.
---
 src/ofono.h |    4 +
 src/sim.c   |  226 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simfs.c |    5 ++
 src/simfs.h |    2 +
 4 files changed, 237 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 6ba0187..b7fed13 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -299,6 +299,10 @@ ofono_bool_t __ofono_sim_service_available(struct ofon=
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
index 52261c8..55d4d75 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -97,6 +97,7 @@ struct ofono_sim {
 =

 	struct sim_fs *simfs;
 	struct ofono_sim_context *context;
+	GSList *fs_watches;
 =

 	unsigned char *iidf_image;
 =

@@ -118,6 +119,14 @@ struct service_number {
 	struct ofono_phone_number ph;
 };
 =

+struct fs_watch {
+	int id;
+	enum ofono_sim_state reset_state;
+	ofono_sim_file_notify_t notify;
+	void *notify_data;
+	struct ofono_sim_context *context;
+};
+
 static const char *const passwd_name[] =3D {
 	[OFONO_SIM_PASSWORD_NONE] =3D "none",
 	[OFONO_SIM_PASSWORD_SIM_PIN] =3D "pin",
@@ -203,6 +212,51 @@ static enum ofono_sim_password_type puk2pin(enum ofono=
_sim_password_type type)
 	}
 }
 =

+static gint fs_watch_compare_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct fs_watch *w =3D a;
+	const int *id =3D b;
+
+	return w->id - *id;
+}
+
+static gint fs_watch_compare_by_context(gconstpointer a, gconstpointer b)
+{
+	const struct fs_watch *w =3D a;
+
+	return (void *) w->context - b;
+}
+
+static int sim_add_file_watch(struct ofono_sim_context *context, int id,
+				gboolean remove_atoms,
+				ofono_sim_file_notify_t notify, void *userdata)
+{
+	struct ofono_sim *sim =3D sim_fs_context_get_sim(context);
+	struct fs_watch *item;
+
+	DBG("%p", sim);
+
+	if (sim =3D=3D NULL)
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
+	item->reset_state =3D remove_atoms ? OFONO_SIM_STATE_INSERTED :
+		OFONO_SIM_STATE_READY;
+	item->context =3D context;
+
+	sim->fs_watches =3D g_slist_prepend(sim->fs_watches, item);
+
+	return id;
+}
+
 static char **get_own_numbers(GSList *own_numbers)
 {
 	int nelem =3D 0;
@@ -1957,6 +2011,15 @@ struct ofono_sim_context *ofono_sim_context_create(s=
truct ofono_sim *sim)
 =

 void ofono_sim_context_free(struct ofono_sim_context *context)
 {
+	struct ofono_sim *sim =3D sim_fs_context_get_sim(context);
+	GSList *l;
+
+	while ((l =3D g_slist_find_custom(sim->fs_watches, context,
+					fs_watch_compare_by_context))) {
+		g_free(l->data);
+		sim->fs_watches =3D g_slist_remove(sim->fs_watches, l->data);
+	}
+
 	return sim_fs_context_free(context);
 }
 =

@@ -2278,6 +2341,12 @@ static void sim_remove(struct ofono_atom *atom)
 	sim_fs_free(sim->simfs);
 	sim->simfs =3D NULL;
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

@@ -2364,3 +2433,160 @@ void *ofono_sim_get_data(struct ofono_sim *sim)
 {
 	return sim->driver_data;
 }
+
+static void sim_file_changed_flush(struct ofono_sim *sim, int id)
+{
+	int i, imgid;
+
+	if (id =3D=3D SIM_EFIMG_FILEID)
+		/* All cached images become invalid */
+		sim_fs_image_cache_flush(sim->simfs);
+	else if (sim->efimg) {
+		/*
+		 * Data and CLUT for image instances stored in the changed
+		 * file need to be re-read.
+		 */
+		for (i =3D sim->efimg_length / 9 - 1; i >=3D 0; i--) {
+			imgid =3D (sim->efimg[i * 9 + 3] << 8) |
+				sim->efimg[i * 9 + 4];
+
+			if (imgid =3D=3D id)
+				sim_fs_image_cache_flush_file(sim->simfs, i);
+		}
+	}
+
+	sim_fs_cache_flush_file(sim->simfs, id);
+}
+
+int ofono_sim_add_file_watch(struct ofono_sim_context *context, int id,
+			ofono_sim_file_notify_t notify, void *userdata)
+{
+	return sim_add_file_watch(context, id, FALSE, notify, userdata);
+}
+
+void ofono_sim_remove_file_watch(struct ofono_sim_context *context, int id,
+				ofono_sim_file_notify_t notify, void *userdata)
+{
+	struct ofono_sim *sim =3D sim_fs_context_get_sim(context);
+	GSList *item =3D g_slist_find_custom(sim->fs_watches,
+						&id, fs_watch_compare_by_id);
+
+	DBG("%p", sim);
+
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
+	GSList *l, *fl;
+	enum sim_reset {
+		RESET_REMOVE_ATOMS	=3D OFONO_SIM_STATE_INSERTED,
+		RESET_SIGNAL_READY	=3D OFONO_SIM_STATE_READY,
+		RESET_NONE,
+	} reset_state =3D RESET_NONE;
+
+	/* Flush cached content for affected files */
+	if (full_file_change)
+		sim_fs_cache_flush(sim->simfs);
+	else {
+		for (fl =3D file_list; fl; fl =3D fl->next) {
+			struct stk_file *file =3D fl->data;
+			int id =3D (file->file[file->len - 2] << 8) |
+				(file->file[file->len - 1] << 0);
+
+			sim_file_changed_flush(sim, id);
+		}
+	}
+
+	if (naa_init)
+		reset_state =3D RESET_REMOVE_ATOMS;
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
+		for (fl =3D file_list; fl; fl =3D fl->next) {
+			struct stk_file *file =3D fl->data;
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
+		for (fl =3D file_list; fl; fl =3D fl->next) {
+			struct stk_file *file =3D fl->data;
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
+	case RESET_REMOVE_ATOMS:
+		/*
+		 * REVISIT: There's some concern that on re-insertion the
+		 * atoms will start to talk to the SIM before it becomes
+		 * ready, on certain SIMs.
+		 */
+		ofono_sim_inserted_notify(sim, FALSE);
+		ofono_sim_inserted_notify(sim, TRUE);
+		break;
+	case RESET_SIGNAL_READY:
+		sim->state =3D OFONO_SIM_STATE_INSERTED;
+		sim_set_ready(sim);
+		break;
+	case RESET_NONE:
+		break;
+	}
+}
diff --git a/src/simfs.c b/src/simfs.c
index 0459447..f829161 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -167,6 +167,11 @@ void sim_fs_context_free(struct ofono_sim_context *con=
text)
 	g_free(context);
 }
 =

+struct ofono_sim *sim_fs_context_get_sim(struct ofono_sim_context *context)
+{
+	return context->fs->sim;
+}
+
 static void sim_fs_end_current(struct sim_fs *fs)
 {
 	struct sim_fs_op *op =3D g_queue_pop_head(fs->op_q);
diff --git a/src/simfs.h b/src/simfs.h
index d93d96e..5623175 100644
--- a/src/simfs.h
+++ b/src/simfs.h
@@ -56,3 +56,5 @@ void sim_fs_image_cache_flush_file(struct sim_fs *fs, int=
 id);
 =

 void sim_fs_free(struct sim_fs *fs);
 void sim_fs_context_free(struct ofono_sim_context *context);
+
+struct ofono_sim *sim_fs_context_get_sim(struct ofono_sim_context *context=
);
-- =

1.7.1.86.g0e460.dirty


--===============5038046920841440880==--

