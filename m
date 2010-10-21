Content-Type: multipart/mixed; boundary="===============0218723756726932346=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 1/5] simfs: retrieve only EF-info without EF-contents
Date: Thu, 21 Oct 2010 17:58:09 +0300
Message-ID: <1287673093-3022-2-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1287673093-3022-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0218723756726932346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    5 ++++
 src/simfs.c   |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+--
 src/simfs.h   |    4 +++
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 7860e24..15e1ea0 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -102,6 +102,11 @@ typedef void (*ofono_sim_file_read_cb_t)(int ok, int t=
otal_length, int record,
 					const unsigned char *data,
 					int record_length, void *userdata);
 =

+typedef void (*ofono_sim_fs_read_info_cb_t)(int ok,
+					unsigned char file_status,
+					int total_length,
+					int record_length, void *userdata);
+
 typedef void (*ofono_sim_file_write_cb_t)(int ok, void *userdata);
 =

 typedef void (*ofono_sim_passwd_cb_t)(const struct ofono_error *error,
diff --git a/src/simfs.c b/src/simfs.c
index feca74f..7ff8c09 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -61,6 +61,7 @@ struct sim_fs_op {
 	unsigned char *buffer;
 	enum ofono_sim_file_structure structure;
 	unsigned short offset;
+	gboolean info_only;
 	int num_bytes;
 	int length;
 	int record_length;
@@ -482,11 +483,30 @@ static void sim_fs_op_info_cb(const struct ofono_erro=
r *error, int length,
 =

 		op->record_length =3D length;
 		op->current =3D op->offset / 256;
-		fs->op_source =3D g_idle_add(sim_fs_op_read_block, fs);
+
+		if (!op->info_only)
+			fs->op_source =3D g_idle_add(sim_fs_op_read_block, fs);
 	} else {
 		op->record_length =3D record_length;
 		op->current =3D 1;
-		fs->op_source =3D g_idle_add(sim_fs_op_read_record, fs);
+
+		if (!op->info_only)
+			fs->op_source =3D g_idle_add(sim_fs_op_read_record, fs);
+	}
+
+	if (op->info_only) {
+		/*
+		 * It's info-only request. So there is no need to request
+		 * actual contents of the EF-files. Just return the EF-info.
+		 */
+		ofono_sim_fs_read_info_cb_t cb =3D op->cb;
+
+		cb(1, file_status, op->length,
+			 op->record_length, op->userdata);
+
+		sim_fs_end_current(fs);
+
+		return;
 	}
 =

 	if (imsi =3D=3D NULL || phase =3D=3D OFONO_SIM_PHASE_UNKNOWN || cache =3D=
=3D FALSE)
@@ -531,7 +551,7 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *f=
s)
 	enum ofono_sim_file_structure structure;
 	int record_length;
 =

-	if (!imsi)
+	if (!imsi || !op->info_only)
 		return FALSE;
 =

 	path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
@@ -642,6 +662,43 @@ static gboolean sim_fs_op_next(gpointer user_data)
 	return FALSE;
 }
 =

+int sim_fs_read_info(struct sim_fs *fs, int id,
+		enum ofono_sim_file_structure expected_type,
+		ofono_sim_fs_read_info_cb_t cb, void *data)
+{
+	struct sim_fs_op *op;
+
+	if (!cb)
+		return -1;
+
+	if (!fs->driver)
+		return -1;
+
+	if (!fs->driver->read_file_info)
+		return -1;
+
+	if (!fs->op_q)
+		fs->op_q =3D g_queue_new();
+
+	op =3D g_new0(struct sim_fs_op, 1);
+
+	op->id =3D id;
+	op->structure =3D expected_type;
+	op->cb =3D cb;
+	op->userdata =3D data;
+	op->is_read =3D TRUE;
+	op->offset =3D 0;
+	op->num_bytes =3D 0;
+	op->info_only =3D TRUE;
+
+	g_queue_push_tail(fs->op_q, op);
+
+	if (g_queue_get_length(fs->op_q) =3D=3D 1)
+		fs->op_source =3D g_idle_add(sim_fs_op_next, fs);
+
+	return 0;
+}
+
 int sim_fs_read(struct sim_fs *fs, int id,
 		enum ofono_sim_file_structure expected_type,
 		unsigned short offset, unsigned short num_bytes,
@@ -670,6 +727,7 @@ int sim_fs_read(struct sim_fs *fs, int id,
 	op->is_read =3D TRUE;
 	op->offset =3D offset;
 	op->num_bytes =3D num_bytes;
+	op->info_only =3D FALSE;
 =

 	g_queue_push_tail(fs->op_q, op);
 =

diff --git a/src/simfs.h b/src/simfs.h
index c0b4c51..f7851df 100644
--- a/src/simfs.h
+++ b/src/simfs.h
@@ -29,6 +29,10 @@ int sim_fs_read(struct sim_fs *fs, int id,
 		unsigned short offset, unsigned short num_bytes,
 		ofono_sim_file_read_cb_t cb, void *data);
 =

+int sim_fs_read_info(struct sim_fs *fs, int id,
+		enum ofono_sim_file_structure expected_type,
+		ofono_sim_fs_read_info_cb_t cb, void *data);
+
 void sim_fs_check_version(struct sim_fs *fs);
 =

 int sim_fs_write(struct sim_fs *fs, int id, ofono_sim_file_write_cb_t cb,
-- =

1.6.3.3



--===============0218723756726932346==--

