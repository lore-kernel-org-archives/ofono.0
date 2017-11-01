Content-Type: multipart/mixed; boundary="===============5644794228030292810=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 5/8] simfs: read files from specific AID's
Date: Wed, 01 Nov 2017 10:33:45 -0700
Message-ID: <1509557628-15121-5-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509557628-15121-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5644794228030292810==
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
 src/simfs.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 src/simfs.h |  3 +++
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 37a232a..6b70df0 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -124,6 +124,7 @@ struct file_watch {
 struct ofono_sim_context {
 	struct sim_fs *fs;
 	struct ofono_watchlist *file_watches;
+	unsigned char *aid;
 };
 =

 struct sim_fs *sim_fs_new(struct ofono_sim *sim,
@@ -156,6 +157,19 @@ struct ofono_sim_context *sim_fs_context_new(struct si=
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
+	context->aid =3D g_memdup(aid, 16);
+
+	return context;
+}
+
 void sim_fs_context_free(struct ofono_sim_context *context)
 {
 	struct sim_fs *fs =3D context->fs;
@@ -181,6 +195,9 @@ void sim_fs_context_free(struct ofono_sim_context *cont=
ext)
 		}
 	}
 =

+	if (context->aid)
+		g_free(context->aid);
+
 	if (context->file_watches)
 		__ofono_watchlist_free(context->file_watches);
 =

@@ -805,6 +822,43 @@ error:
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
+}
+
+static void get_session_cb(int session_id, void *data)
+{
+	struct sim_fs *fs =3D data;
+	struct sim_fs_op *op;
+
+	if (session_id =3D=3D -1) {
+		sim_fs_op_error(fs);
+		return;
+	}
+
+	fs->op_source =3D 0;
+
+	op =3D g_queue_peek_head(fs->op_q);
+
+	fs->driver->read_file_session(fs->sim, session_id, op->id, op->offset,
+			op->num_bytes, op->path, op->path_len,
+			sim_fs_read_session_cb, fs);
+
+	ofono_sim_release_session(fs->sim, session_id);
+}
+
 static gboolean sim_fs_op_next(gpointer user_data)
 {
 	struct sim_fs *fs =3D user_data;
@@ -827,10 +881,20 @@ static gboolean sim_fs_op_next(gpointer user_data)
 		if (sim_fs_op_check_cached(fs))
 			return FALSE;
 =

-		driver->read_file_info(fs->sim, op->id,
-					op->path_len ? op->path : NULL,
-					op->path_len,
-					sim_fs_op_info_cb, fs);
+		if (op->context->aid =3D=3D NULL) {
+			driver->read_file_info(fs->sim, op->id,
+						op->path_len ? op->path : NULL,
+						op->path_len,
+						sim_fs_op_info_cb, fs);
+		} else {
+			if (!ofono_sim_get_session(fs->sim, op->context->aid,
+					get_session_cb, fs)) {
+				ofono_sim_file_read_cb_t cb =3D op->cb;
+
+				DBG("Could not get session for AID");
+				cb(FALSE, 0, 0, NULL, 0, op->userdata);
+			}
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


--===============5644794228030292810==--

