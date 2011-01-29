Content-Type: multipart/mixed; boundary="===============8605406470121957421=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] simfs: Use cache for sim_fs_read_info requests too.
Date: Sat, 29 Jan 2011 01:29:19 +0100
Message-ID: <1296260961-15155-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1296260961-15155-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8605406470121957421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There seems to be no reason that the fileinfo is cached for file
read or block read requests but not info_only requests, so move
code around to fix this.  O_RDWR is changed to O_WRONLY for the
cache file because the file is not being read in case of cache miss.
---
 src/simfs.c |  140 ++++++++++++++++++++++++++++++++++---------------------=
---
 1 files changed, 82 insertions(+), 58 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 73da80c..37e801a 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -45,12 +45,12 @@
 #define SIM_CACHE_BASEPATH STORAGEDIR "/%s-%i"
 #define SIM_CACHE_VERSION SIM_CACHE_BASEPATH "/version"
 #define SIM_CACHE_PATH SIM_CACHE_BASEPATH "/%04x"
-#define SIM_CACHE_HEADER_SIZE 38
-#define SIM_FILE_INFO_SIZE 6
+#define SIM_CACHE_HEADER_SIZE 39
+#define SIM_FILE_INFO_SIZE 7
 #define SIM_IMAGE_CACHE_BASEPATH STORAGEDIR "/%s-%i/images"
 #define SIM_IMAGE_CACHE_PATH SIM_IMAGE_CACHE_BASEPATH "/%d.xpm"
 =

-#define SIM_FS_VERSION 1
+#define SIM_FS_VERSION 2
 =

 static gboolean sim_fs_op_next(gpointer user_data);
 static gboolean sim_fs_op_read_record(gpointer user);
@@ -436,14 +436,14 @@ static gboolean sim_fs_op_read_record(gpointer user)
 	return FALSE;
 }
 =

-static void sim_fs_op_info_cb(const struct ofono_error *error, int length,
-				enum ofono_sim_file_structure structure,
-				int record_length,
-				const unsigned char access[3],
-				unsigned char file_status,
-				void *data)
+static void sim_fs_op_cache_fileinfo(struct sim_fs *fs,
+					const struct ofono_error *error,
+					int length,
+					enum ofono_sim_file_structure structure,
+					int record_length,
+					const unsigned char access[3],
+					unsigned char file_status)
 {
-	struct sim_fs *fs =3D data;
 	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
 	const char *imsi =3D ofono_sim_get_imsi(fs->sim);
 	enum ofono_sim_phase phase =3D ofono_sim_get_phase(fs->sim);
@@ -454,11 +454,65 @@ static void sim_fs_op_info_cb(const struct ofono_erro=
r *error, int length,
 	gboolean cache;
 	char *path;
 =

+	/* TS 11.11, Section 9.3 */
+	update =3D file_access_condition_decode(access[0] & 0xf);
+	rehabilitate =3D file_access_condition_decode((access[2] >> 4) & 0xf);
+	invalidate =3D file_access_condition_decode(access[2] & 0xf);
+
+	/* Never cache card holder writable files */
+	cache =3D (update =3D=3D SIM_FILE_ACCESS_ADM ||
+			update =3D=3D SIM_FILE_ACCESS_NEVER) &&
+			(invalidate =3D=3D SIM_FILE_ACCESS_ADM ||
+				invalidate =3D=3D SIM_FILE_ACCESS_NEVER) &&
+			(rehabilitate =3D=3D SIM_FILE_ACCESS_ADM ||
+				rehabilitate =3D=3D SIM_FILE_ACCESS_NEVER);
+
+	if (imsi =3D=3D NULL || phase =3D=3D OFONO_SIM_PHASE_UNKNOWN || cache =3D=
=3D FALSE)
+		return;
+
+	memset(fileinfo, 0, SIM_CACHE_HEADER_SIZE);
+
+	fileinfo[0] =3D error->type;
+	fileinfo[1] =3D length >> 8;
+	fileinfo[2] =3D length & 0xff;
+	fileinfo[3] =3D structure;
+	fileinfo[4] =3D record_length >> 8;
+	fileinfo[5] =3D record_length & 0xff;
+	fileinfo[6] =3D file_status;
+
+	path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
+	fs->fd =3D TFR(open(path, O_WRONLY | O_CREAT | O_TRUNC, SIM_CACHE_MODE));
+	g_free(path);
+
+	if (fs->fd =3D=3D -1)
+		return;
+
+	if (TFR(write(fs->fd, fileinfo, SIM_CACHE_HEADER_SIZE)) =3D=3D
+			SIM_CACHE_HEADER_SIZE)
+		return;
+
+	TFR(close(fs->fd));
+	fs->fd =3D -1;
+}
+
+static void sim_fs_op_info_cb(const struct ofono_error *error, int length,
+				enum ofono_sim_file_structure structure,
+				int record_length,
+				const unsigned char access[3],
+				unsigned char file_status,
+				void *data)
+{
+	struct sim_fs *fs =3D data;
+	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
+
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		sim_fs_op_error(fs);
 		return;
 	}
 =

+	sim_fs_op_cache_fileinfo(fs, error, length, structure, record_length,
+					access, file_status);
+
 	if (structure !=3D op->structure) {
 		ofono_error("Requested file structure differs from SIM: %x",
 				op->id);
@@ -466,22 +520,9 @@ static void sim_fs_op_info_cb(const struct ofono_error=
 *error, int length,
 		return;
 	}
 =

-	/* TS 11.11, Section 9.3 */
-	update =3D file_access_condition_decode(access[0] & 0xf);
-	rehabilitate =3D file_access_condition_decode((access[2] >> 4) & 0xf);
-	invalidate =3D file_access_condition_decode(access[2] & 0xf);
-
 	op->structure =3D structure;
 	op->length =3D length;
 =

-	/* Never cache card holder writable files */
-	cache =3D (update =3D=3D SIM_FILE_ACCESS_ADM ||
-			update =3D=3D SIM_FILE_ACCESS_NEVER) &&
-			(invalidate =3D=3D SIM_FILE_ACCESS_ADM ||
-				invalidate =3D=3D SIM_FILE_ACCESS_NEVER) &&
-			(rehabilitate =3D=3D SIM_FILE_ACCESS_ADM ||
-				rehabilitate =3D=3D SIM_FILE_ACCESS_NEVER);
-
 	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT) {
 		if (op->num_bytes =3D=3D 0)
 			op->num_bytes =3D op->length;
@@ -501,8 +542,8 @@ static void sim_fs_op_info_cb(const struct ofono_error =
*error, int length,
 =

 	if (op->info_only =3D=3D TRUE) {
 		/*
-		 * It's info-only request. So there is no need to request
-		 * actual contents of the EF-files. Just return the EF-info.
+		 * It's an info-only request, so there is no need to request
+		 * actual contents of the EF. Just return the EF-info.
 		 */
 		sim_fs_read_info_cb_t cb =3D op->cb;
 =

@@ -510,35 +551,7 @@ static void sim_fs_op_info_cb(const struct ofono_error=
 *error, int length,
 			op->record_length, op->userdata);
 =

 		sim_fs_end_current(fs);
-
-		return;
 	}
-
-	if (imsi =3D=3D NULL || phase =3D=3D OFONO_SIM_PHASE_UNKNOWN || cache =3D=
=3D FALSE)
-		return;
-
-	memset(fileinfo, 0, SIM_CACHE_HEADER_SIZE);
-
-	fileinfo[0] =3D error->type;
-	fileinfo[1] =3D length >> 8;
-	fileinfo[2] =3D length & 0xff;
-	fileinfo[3] =3D structure;
-	fileinfo[4] =3D record_length >> 8;
-	fileinfo[5] =3D record_length & 0xff;
-
-	path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
-	fs->fd =3D TFR(open(path, O_RDWR | O_CREAT | O_TRUNC, SIM_CACHE_MODE));
-	g_free(path);
-
-	if (fs->fd =3D=3D -1)
-		return;
-
-	if (TFR(write(fs->fd, fileinfo, SIM_CACHE_HEADER_SIZE)) =3D=3D
-			SIM_CACHE_HEADER_SIZE)
-		return;
-
-	TFR(close(fs->fd));
-	fs->fd =3D -1;
 }
 =

 static gboolean sim_fs_op_check_cached(struct sim_fs *fs)
@@ -546,7 +559,6 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *f=
s)
 	const char *imsi =3D ofono_sim_get_imsi(fs->sim);
 	enum ofono_sim_phase phase =3D ofono_sim_get_phase(fs->sim);
 	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
-	gboolean ret =3D FALSE;
 	char *path;
 	int fd;
 	ssize_t len;
@@ -555,9 +567,9 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *f=
s)
 	int file_length;
 	enum ofono_sim_file_structure structure;
 	int record_length;
+	unsigned char file_status;
 =

-	if (imsi =3D=3D NULL || phase =3D=3D OFONO_SIM_PHASE_UNKNOWN ||
-			op->info_only =3D=3D TRUE)
+	if (imsi =3D=3D NULL || phase =3D=3D OFONO_SIM_PHASE_UNKNOWN)
 		return FALSE;
 =

 	path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
@@ -586,6 +598,7 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *f=
s)
 	file_length =3D (fileinfo[1] << 8) | fileinfo[2];
 	structure =3D fileinfo[3];
 	record_length =3D (fileinfo[4] << 8) | fileinfo[5];
+	file_status =3D fileinfo[6];
 =

 	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
 		record_length =3D file_length;
@@ -605,7 +618,18 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *=
fs)
 		return TRUE;
 	}
 =

-	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT) {
+	if (op->info_only =3D=3D TRUE) {
+		/*
+		 * It's an info-only request, so there is no need to request
+		 * actual contents of the EF. Just return the EF-info.
+		 */
+		sim_fs_read_info_cb_t cb =3D op->cb;
+
+		cb(1, file_status, op->length,
+			op->record_length, op->userdata);
+
+		sim_fs_end_current(fs);
+	} else if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT) {
 		if (op->num_bytes =3D=3D 0)
 			op->num_bytes =3D op->length;
 =

@@ -620,7 +644,7 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *f=
s)
 =

 error:
 	TFR(close(fd));
-	return ret;
+	return FALSE;
 }
 =

 static gboolean sim_fs_op_next(gpointer user_data)
-- =

1.7.1.86.g0e460.dirty


--===============8605406470121957421==--

