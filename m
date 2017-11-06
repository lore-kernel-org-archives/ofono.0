Content-Type: multipart/mixed; boundary="===============2644243014577325259=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/5] simfs: read files from specific AID's
Date: Mon, 06 Nov 2017 09:49:30 -0800
Message-ID: <1509990574-19950-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2644243014577325259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The simfs atom could not read EF's that did not exist on the
'default' ADF directory. This implements a new way to read EF's
that exist on a given AID. A new fs object/context can be
initialized for a given AID. Using this fs context with
the existing read file API will read from that AID rather than
the default ADF.
---
 src/simfs.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 src/simfs.h |   3 ++
 2 files changed, 118 insertions(+), 9 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 37a232a..daf3135 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -70,13 +70,26 @@ struct sim_fs_op {
 	unsigned char path_len;
 	gconstpointer cb;
 	gboolean is_read;
+	int session_id;
+	unsigned int watch_id;
 	void *userdata;
 	struct ofono_sim_context *context;
 };
 =

+struct ofono_sim_context {
+	struct sim_fs *fs;
+	struct ofono_watchlist *file_watches;
+	struct ofono_sim_aid_session *session;
+};
+
 static void sim_fs_op_free(gpointer pointer)
 {
 	struct sim_fs_op *node =3D pointer;
+
+	if (node->context->session)
+		__ofono_sim_remove_session_watch(node->context->session,
+				node->watch_id);
+
 	g_free(node->buffer);
 	g_free(node);
 }
@@ -121,11 +134,6 @@ struct file_watch {
 	int ef;
 };
 =

-struct ofono_sim_context {
-	struct sim_fs *fs;
-	struct ofono_watchlist *file_watches;
-};
-
 struct sim_fs *sim_fs_new(struct ofono_sim *sim,
 				const struct ofono_sim_driver *driver)
 {
@@ -156,6 +164,21 @@ struct ofono_sim_context *sim_fs_context_new(struct si=
m_fs *fs)
 	return context;
 }
 =

+struct ofono_sim_context *sim_fs_context_new_with_aid(struct sim_fs *fs,
+		unsigned char *aid)
+{
+	struct ofono_sim_context *context =3D sim_fs_context_new(fs);
+
+	if (context =3D=3D NULL)
+		return NULL;
+
+	context->session =3D __ofono_sim_get_session_by_aid(fs->sim, aid);
+	if (!context->session)
+		return NULL;
+
+	return context;
+}
+
 void sim_fs_context_free(struct ofono_sim_context *context)
 {
 	struct sim_fs *fs =3D context->fs;
@@ -805,6 +828,83 @@ error:
 	return FALSE;
 }
 =

+static void sim_fs_read_session_cb(const struct ofono_error *error,
+		const unsigned char *sdata, int length, void *data)
+{
+	struct sim_fs *fs =3D data;
+	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
+	ofono_sim_file_read_cb_t cb;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		sim_fs_op_error(fs);
+		return;
+	}
+
+	cb =3D op->cb;
+	cb(TRUE, length, 0, sdata, length, op->userdata);
+
+	sim_fs_end_current(fs);
+}
+
+static void session_read_info_cb(const struct ofono_error *error,
+					int filelength,
+					enum ofono_sim_file_structure structure,
+					int recordlength,
+					const unsigned char access[3],
+					unsigned char file_status,
+					void *data)
+{
+	struct sim_fs *fs =3D data;
+	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		sim_fs_op_error(fs);
+		return;
+	}
+
+	sim_fs_op_cache_fileinfo(fs, error, filelength, structure, recordlength,
+			access, file_status);
+
+	if (op->info_only) {
+		sim_fs_read_info_cb_t cb =3D op->cb;
+
+		cb(1, file_status, filelength, recordlength, op->userdata);
+
+		sim_fs_end_current(fs);
+		return;
+	}
+
+	if (op->structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
+		fs->driver->session_read_binary(fs->sim, op->session_id,
+				op->id, op->offset, filelength, op->path,
+				op->path_len, sim_fs_read_session_cb, fs);
+	else
+		fs->driver->session_read_record(fs->sim, op->session_id,
+				op->id, op->offset, recordlength, op->path,
+				op->path_len, sim_fs_read_session_cb, fs);
+}
+
+static void get_session_cb(ofono_bool_t active, int session_id,
+		void *data)
+{
+	struct sim_fs *fs =3D data;
+	struct sim_fs_op *op;
+
+	if (!active) {
+		sim_fs_op_error(fs);
+		return;
+	}
+
+	fs->op_source =3D 0;
+
+	op =3D g_queue_peek_head(fs->op_q);
+
+	op->session_id =3D session_id;
+
+	fs->driver->session_read_info(fs->sim, session_id, op->id, op->path,
+			op->path_len, session_read_info_cb, fs);
+}
+
 static gboolean sim_fs_op_next(gpointer user_data)
 {
 	struct sim_fs *fs =3D user_data;
@@ -827,10 +927,16 @@ static gboolean sim_fs_op_next(gpointer user_data)
 		if (sim_fs_op_check_cached(fs))
 			return FALSE;
 =

-		driver->read_file_info(fs->sim, op->id,
-					op->path_len ? op->path : NULL,
-					op->path_len,
-					sim_fs_op_info_cb, fs);
+		if (!op->context->session) {
+			driver->read_file_info(fs->sim, op->id,
+						op->path_len ? op->path : NULL,
+						op->path_len,
+						sim_fs_op_info_cb, fs);
+		} else {
+			op->watch_id =3D __ofono_sim_add_session_watch(
+					op->context->session, get_session_cb,
+					fs, NULL);
+		}
 	} else {
 		switch (op->structure) {
 		case OFONO_SIM_FILE_STRUCTURE_TRANSPARENT:
diff --git a/src/simfs.h b/src/simfs.h
index bb3ab0f..39af6a3 100644
--- a/src/simfs.h
+++ b/src/simfs.h
@@ -29,6 +29,9 @@ struct sim_fs *sim_fs_new(struct ofono_sim *sim,
 				const struct ofono_sim_driver *driver);
 struct ofono_sim_context *sim_fs_context_new(struct sim_fs *fs);
 =

+struct ofono_sim_context *sim_fs_context_new_with_aid(struct sim_fs *fs,
+		unsigned char *aid);
+
 unsigned int sim_fs_file_watch_add(struct ofono_sim_context *context,
 					int id, ofono_sim_file_changed_cb_t cb,
 					void *userdata,
-- =

2.7.4


--===============2644243014577325259==--

