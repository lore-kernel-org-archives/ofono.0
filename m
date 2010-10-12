Content-Type: multipart/mixed; boundary="===============2526097028447255840=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 2/8] simfs: add logic to retrieve only only EF-info,
 but no EF-contents
Date: Tue, 12 Oct 2010 18:18:08 +0300
Message-ID: <1286896694-3054-3-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1286896694-3054-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2526097028447255840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handling of new parameter (file status) from the driver added.
This commit doesn't store EF-info into cache yet.
---
 src/simfs.c |   27 +++++++++++++++++++++++----
 src/simfs.h |    1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index b5b12b4..24ce7ec 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -58,6 +58,7 @@ struct sim_fs_op {
 	int id;
 	enum ofono_sim_file_structure structure;
 	unsigned short offset;
+	gboolean info_only;
 	int num_bytes;
 	int length;
 	int record_length;
@@ -426,7 +427,9 @@ static gboolean sim_fs_op_read_record(gpointer user)
 static void sim_fs_op_info_cb(const struct ofono_error *error, int length,
 				enum ofono_sim_file_structure structure,
 				int record_length,
-				const unsigned char access[3], void *data)
+				const unsigned char access[3],
+				const unsigned char file_status,
+				void *data)
 {
 	struct sim_fs *fs =3D data;
 	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
@@ -438,6 +441,7 @@ static void sim_fs_op_info_cb(const struct ofono_error =
*error, int length,
 	unsigned char fileinfo[SIM_CACHE_HEADER_SIZE];
 	gboolean cache;
 	char *path;
+	ofono_sim_file_read_cb_t cb =3D op->cb;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		sim_fs_op_error(fs);
@@ -473,11 +477,24 @@ static void sim_fs_op_info_cb(const struct ofono_erro=
r *error, int length,
 =

 		op->record_length =3D length;
 		op->current =3D op->offset / 256;
-		fs->op_source =3D g_idle_add(sim_fs_op_read_block, fs);
+		if (!op->info_only)
+			fs->op_source =3D g_idle_add(sim_fs_op_read_block, fs);
 	} else {
 		op->record_length =3D record_length;
 		op->current =3D 1;
-		fs->op_source =3D g_idle_add(sim_fs_op_read_record, fs);
+		if (!op->info_only)
+			fs->op_source =3D g_idle_add(sim_fs_op_read_record, fs);
+	}
+
+	if (op->info_only) {
+		/*
+		 * It's info-only request. So there is no need to request
+		 * actual contents of the EF-files. Just return the EF-info.
+		 */
+		cb(1, op->length, op->current,
+			&file_status, op->record_length, op->userdata);
+
+		sim_fs_end_current(fs);
 	}
 =

 	if (imsi =3D=3D NULL || cache =3D=3D FALSE)
@@ -522,7 +539,7 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *f=
s)
 	enum ofono_sim_file_structure structure;
 	int record_length;
 =

-	if (!imsi)
+	if (!imsi || !op->info_only)
 		return FALSE;
 =

 	path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
@@ -635,6 +652,7 @@ static gboolean sim_fs_op_next(gpointer user_data)
 =

 int sim_fs_read(struct sim_fs *fs, int id,
 		enum ofono_sim_file_structure expected_type,
+		gboolean info_only,
 		unsigned short offset, unsigned short num_bytes,
 		ofono_sim_file_read_cb_t cb, void *data)
 {
@@ -661,6 +679,7 @@ int sim_fs_read(struct sim_fs *fs, int id,
 	op->is_read =3D TRUE;
 	op->offset =3D offset;
 	op->num_bytes =3D num_bytes;
+	op->info_only =3D info_only;
 =

 	g_queue_push_tail(fs->op_q, op);
 =

diff --git a/src/simfs.h b/src/simfs.h
index 6d5dded..284d15b 100644
--- a/src/simfs.h
+++ b/src/simfs.h
@@ -26,6 +26,7 @@ struct sim_fs *sim_fs_new(struct ofono_sim *sim,
 =

 int sim_fs_read(struct sim_fs *fs, int id,
 		enum ofono_sim_file_structure expected_type,
+		gboolean info_only,
 		unsigned short offset, unsigned short num_bytes,
 		ofono_sim_file_read_cb_t cb, void *data);
 =

-- =

1.6.3.3



--===============2526097028447255840==--

