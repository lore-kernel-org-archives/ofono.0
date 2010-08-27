Content-Type: multipart/mixed; boundary="===============8291865935360759364=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/3] sim: read EFiidf
Date: Fri, 27 Aug 2010 09:19:24 -0700
Message-ID: <1282925966-14419-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1282925966-14419-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8291865935360759364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

EFiidf can be larger than 256 bytes, so allow callers to read
portions of the EFiidf from a specified offset.  Cache EFiidf
files as blocks of 256 bytes so that it's not necessary to
read the entire (potentially large) file.
---
 include/sim.h |    4 +
 src/sim.c     |  305 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 2 files changed, 297 insertions(+), 12 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 36a99b9..67f8a6e 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -202,6 +202,10 @@ int ofono_sim_write(struct ofono_sim *sim, int id,
 			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
 			const unsigned char *data, int length, void *userdata);
+
+int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
+			unsigned short offset, int num_bytes,
+			ofono_sim_file_read_cb_t cb, void *data);
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/sim.c b/src/sim.c
index f8884a2..bbcf609 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -46,7 +46,8 @@
 #define SIM_CACHE_MODE 0600
 #define SIM_CACHE_PATH STORAGEDIR "/%s-%i/%04x"
 #define SIM_CACHE_PATH_LEN(imsilen) (strlen(SIM_CACHE_PATH) - 3 + imsilen)
-#define SIM_CACHE_HEADER_SIZE 6
+#define SIM_CACHE_HEADER_SIZE 38
+#define SIM_FILE_INFO_SIZE 6
 =

 static GSList *g_drivers =3D NULL;
 =

@@ -55,11 +56,14 @@ static gboolean sim_op_retrieve_next(gpointer user);
 static void sim_own_numbers_update(struct ofono_sim *sim);
 static void sim_pin_check(struct ofono_sim *sim);
 static void sim_set_ready(struct ofono_sim *sim);
+static gboolean sim_op_read_block(gpointer user_data);
 =

 struct sim_file_op {
 	int id;
 	gboolean cache;
 	enum ofono_sim_file_structure structure;
+	unsigned short offset;
+	int num_bytes;
 	int length;
 	int record_length;
 	int current;
@@ -1517,23 +1521,45 @@ static void sim_op_error(struct ofono_sim *sim)
 }
 =

 static gboolean cache_record(const char *path, int current, int record_len,
-				const unsigned char *data)
+				const unsigned char *data, int num_bytes,
+				enum ofono_sim_file_structure type)
 {
 	int r =3D 0;
 	int fd;
 =

-	fd =3D TFR(open(path, O_WRONLY));
+	fd =3D TFR(open(path, O_RDWR));
 =

 	if (fd =3D=3D -1)
 		return FALSE;
 =

 	if (lseek(fd, (current - 1) * record_len +
 				SIM_CACHE_HEADER_SIZE, SEEK_SET) !=3D (off_t) -1)
-		r =3D TFR(write(fd, data, record_len));
+		r =3D TFR(write(fd, data, num_bytes));
+
+	/* update present bit for this block if we are a transparent file */
+	if (type =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT) {
+		/* figure out which byte the right bit location is */
+		int byte =3D (current - 1) / 8;
+		int bit =3D (current - 1) % 8;
+		guint8 cache;
+
+		/* lseek to correct byte (skip file info) */
+		lseek(fd, byte + SIM_FILE_INFO_SIZE, SEEK_SET);
+
+		/* read byte */
+		TFR(read(fd, &cache, 1));
+
+		/* set present bit */
+		cache |=3D (1 << bit);
+
+		/* write back */
+		lseek(fd, byte + SIM_FILE_INFO_SIZE, SEEK_SET);
+		TFR(write(fd, &cache, 1));
+	}
 =

 	TFR(close(fd));
 =

-	if (r < record_len) {
+	if (r < num_bytes) {
 		unlink(path);
 		return FALSE;
 	}
@@ -1562,7 +1588,8 @@ static void sim_op_retrieve_cb(const struct ofono_err=
or *error,
 						imsi, sim->phase, op->id);
 =

 		op->cache =3D cache_record(path, op->current, op->record_length,
-						data);
+						data, op->record_length,
+						op->structure);
 		g_free(path);
 	}
 =

@@ -1667,12 +1694,17 @@ static void sim_op_info_cb(const struct ofono_error=
 *error, int length,
 	else
 		op->record_length =3D record_length;
 =

-	op->current =3D 1;
-
-	sim->simop_source =3D g_timeout_add(0, sim_op_retrieve_next, sim);
+	if (op->num_bytes > 0)
+		sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
+	else {
+		op->current =3D 1;
+		sim->simop_source =3D g_timeout_add(0, sim_op_retrieve_next, sim);
+	}
 =

 	if (op->cache && imsi) {
-		unsigned char fileinfo[6];
+		unsigned char fileinfo[SIM_CACHE_HEADER_SIZE];
+
+		memset(fileinfo, 0, SIM_CACHE_HEADER_SIZE);
 =

 		fileinfo[0] =3D error->type;
 		fileinfo[1] =3D length >> 8;
@@ -1681,8 +1713,9 @@ static void sim_op_info_cb(const struct ofono_error *=
error, int length,
 		fileinfo[4] =3D record_length >> 8;
 		fileinfo[5] =3D record_length & 0xff;
 =

-		if (write_file(fileinfo, 6, SIM_CACHE_MODE, SIM_CACHE_PATH,
-					imsi, sim->phase, op->id) !=3D 6)
+		if (write_file(fileinfo, SIM_CACHE_HEADER_SIZE, SIM_CACHE_MODE,
+					SIM_CACHE_PATH, imsi, sim->phase,
+					op->id) !=3D SIM_CACHE_HEADER_SIZE)
 			op->cache =3D FALSE;
 	}
 }
@@ -1751,6 +1784,12 @@ static gboolean sim_op_check_cached(struct ofono_sim=
 *sim)
 	structure =3D fileinfo[3];
 	record_length =3D (fileinfo[4] << 8) | fileinfo[5];
 =

+	if (op->num_bytes > 0) {
+		op->length =3D file_length;
+		ret =3D TRUE;
+		goto cleanup;
+	}
+
 	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
 		record_length =3D file_length;
 =

@@ -1790,6 +1829,199 @@ cleanup:
 	return ret;
 }
 =

+static void sim_op_read_block_cb(const struct ofono_error *error,
+				const unsigned char *data, int len, void *user)
+{
+	struct ofono_sim *sim =3D user;
+	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
+	char *imsi =3D sim->imsi;
+	int start_block, end_block;
+	int start, length;
+	unsigned char *buf;
+
+	if ((error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) || (len =3D=3D 0)) {
+		sim_op_error(sim);
+		return;
+	}
+
+	/* buffer this block */
+	start_block =3D op->offset / 256;
+	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
+
+	if (op->current =3D=3D start_block) {
+		start =3D op->offset % 256;
+		buf =3D op->buffer;
+	} else {
+		start =3D 0;
+		buf =3D op->buffer + (op->current * 256);
+	}
+
+	length =3D op->num_bytes % 256;
+
+	if ((length =3D=3D 0) || (op->current !=3D end_block))
+		length =3D 256;
+
+	memcpy(buf, &data[start], length);
+
+	/* cache this block */
+	if (op->cache && imsi) {
+		char *path =3D g_strdup_printf(SIM_CACHE_PATH,
+						sim->imsi, sim->phase, op->id);
+		op->cache =3D cache_record(path, op->current + 1, 256, data,
+						length, op->structure);
+
+		g_free(path);
+	}
+
+	op->current++;
+
+	sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
+}
+
+static gboolean sim_op_check_cached_block(struct ofono_sim *sim)
+{
+	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
+	char *path;
+	int fd;
+	char *imsi =3D sim->imsi;
+	int start_block, end_block;
+	int start, length, len;
+	unsigned char *buf;
+	int bit, byte;
+	guint8 cache;
+	gboolean ret;
+
+	if (!imsi)
+		return FALSE;
+
+	path =3D g_strdup_printf(SIM_CACHE_PATH, sim->imsi, sim->phase, op->id);
+
+	if (path =3D=3D NULL)
+		return FALSE;
+
+	fd =3D TFR(open(path, O_RDONLY));
+	g_free(path);
+
+	if (fd =3D=3D -1) {
+		if (errno !=3D ENOENT)
+			DBG("Error %i opening cache file for "
+					"fileid %04x, IMSI %s",
+					errno, op->id, imsi);
+
+		return FALSE;
+	}
+
+	/* read cache header to see if current block is present */
+	byte =3D op->current / 8;
+	bit =3D op->current % 8;
+
+	lseek(fd, SIM_FILE_INFO_SIZE + byte, SEEK_SET);
+
+	len =3D TFR(read(fd, &cache, 1));
+
+	if ((len !=3D 1) || ((cache & (1 << bit)) =3D=3D FALSE)) {
+		ret =3D FALSE;
+		goto cleanup;
+	}
+
+	/* figure out where we should start reading from */
+	start_block =3D op->offset / 256;
+	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
+
+	if (op->current =3D=3D start_block) {
+		start =3D op->offset % 256;
+		buf =3D op->buffer;
+	} else {
+		start =3D 0;
+		buf =3D op->buffer + (op->current * 256);
+	}
+
+	length =3D op->num_bytes % 256;
+
+	if ((length =3D=3D 0) || (op->current !=3D end_block))
+		length =3D 256;
+
+	/* lseek to the right place in the file */
+	TFR(lseek(fd, start + SIM_CACHE_HEADER_SIZE, SEEK_SET));
+
+	len =3D TFR(read(fd, buf, length));
+
+	if (len !=3D length) {
+		ret =3D FALSE;
+		goto cleanup;
+	}
+
+	ret =3D TRUE;
+
+	op->current++;
+
+	sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
+
+cleanup:
+	TFR(close(fd));
+
+	return ret;
+}
+
+static gboolean sim_op_read_block(gpointer user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
+	int end_block;
+	ofono_sim_file_read_cb_t cb =3D op->cb;
+	int read_bytes;
+
+	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
+
+	if (op->current > end_block) {
+		cb(1, op->num_bytes, op->current, op->buffer,
+				op->record_length, op->userdata);
+
+		op =3D g_queue_pop_head(sim->simop_q);
+
+		g_free(op->buffer);
+
+		sim_file_op_free(op);
+
+		if (g_queue_get_length(sim->simop_q) > 0)
+			sim->simop_source =3D g_timeout_add(0, sim_op_next, sim);
+
+		return FALSE;
+	}
+
+	/* see if this block is cached */
+	if (sim_op_check_cached_block(sim) =3D=3D TRUE)
+		return FALSE;
+
+	if (op->length < ((op->current + 1) * 256))
+		read_bytes =3D op->length % 256;
+	else
+		read_bytes =3D 256;
+
+	sim->driver->read_file_transparent(sim, op->id,
+						op->current * 256,
+						read_bytes,
+						sim_op_read_block_cb, sim);
+	return FALSE;
+}
+
+static void sim_op_get_blocks(struct ofono_sim *sim)
+{
+	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
+
+	/* allocate space to buffer the data till we've collected it all */
+	op->buffer =3D g_try_malloc0(op->num_bytes);
+
+	/* initialize current */
+	op->current =3D op->offset / 256;
+
+	/* need to get the length of the file */
+	if (sim_op_check_cached(sim) =3D=3D FALSE)
+		sim->driver->read_file_info(sim, op->id, sim_op_info_cb, sim);
+	else
+		sim->simop_source =3D g_timeout_add(0, sim_op_read_block, sim);
+}
+
 static gboolean sim_op_next(gpointer user_data)
 {
 	struct ofono_sim *sim =3D user_data;
@@ -1802,6 +2034,11 @@ static gboolean sim_op_next(gpointer user_data)
 =

 	op =3D g_queue_peek_head(sim->simop_q);
 =

+	if (op->num_bytes > 0) {
+		sim_op_get_blocks(sim);
+		return FALSE;
+	}
+
 	if (op->is_read =3D=3D TRUE) {
 		if (sim_op_check_cached(sim)) {
 			op =3D g_queue_pop_head(sim->simop_q);
@@ -1844,6 +2081,49 @@ static gboolean sim_op_next(gpointer user_data)
 	return FALSE;
 }
 =

+int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
+			unsigned short offset, int num_bytes,
+			ofono_sim_file_read_cb_t cb, void *data)
+{
+	struct sim_file_op *op;
+
+	if (!cb)
+		return -1;
+
+	if (sim =3D=3D NULL)
+		return -1;
+
+	if (!sim->driver)
+		return -1;
+
+	if (!sim->driver->read_file_info)
+		return -1;
+
+	/* TODO: We must first check the EFust table to see whether
+	 * this file can be read at all
+	 */
+
+	if (!sim->simop_q)
+		sim->simop_q =3D g_queue_new();
+
+	op =3D g_new0(struct sim_file_op, 1);
+
+	op->id =3D id;
+	op->structure =3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT;
+	op->cb =3D cb;
+	op->userdata =3D data;
+	op->is_read =3D TRUE;
+	op->offset =3D offset;
+	op->num_bytes =3D num_bytes;
+
+	g_queue_push_tail(sim->simop_q, op);
+
+	if (g_queue_get_length(sim->simop_q) =3D=3D 1)
+		sim->simop_source =3D g_timeout_add(0, sim_op_next, sim);
+
+	return 0;
+}
+
 int ofono_sim_read(struct ofono_sim *sim, int id,
 			enum ofono_sim_file_structure expected_type,
 			ofono_sim_file_read_cb_t cb, void *data)
@@ -1876,6 +2156,7 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
 	op->cb =3D cb;
 	op->userdata =3D data;
 	op->is_read =3D TRUE;
+	op->num_bytes =3D -1;
 =

 	g_queue_push_tail(sim->simop_q, op);
 =

-- =

1.7.2.1


--===============8291865935360759364==--

