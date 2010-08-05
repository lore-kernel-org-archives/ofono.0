Content-Type: multipart/mixed; boundary="===============1596850752463286989=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 4/7] sim: allow partial reads of files
Date: Thu, 05 Aug 2010 14:32:37 -0700
Message-ID: <1281043960-9616-5-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1281043960-9616-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1596850752463286989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    5 +++++
 src/sim.c     |   54 ++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 36a99b9..6c5a657 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -198,6 +198,11 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
 			enum ofono_sim_file_structure expected,
 			ofono_sim_file_read_cb_t cb, void *data);
 =

+int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
+			enum ofono_sim_file_structure expected_type,
+			unsigned short offset, int num_bytes,
+			ofono_sim_file_read_cb_t cb, void *data);
+
 int ofono_sim_write(struct ofono_sim *sim, int id,
 			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
diff --git a/src/sim.c b/src/sim.c
index 6d723bb..fa3823b 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -60,6 +60,8 @@ struct sim_file_op {
 	int id;
 	gboolean cache;
 	enum ofono_sim_file_structure structure;
+	unsigned short offset;
+	int num_bytes;
 	int length;
 	int record_length;
 	int current;
@@ -1498,7 +1500,7 @@ static void sim_op_retrieve_cb(const struct ofono_err=
or *error,
 		return;
 	}
 =

-	cb(1, op->length, op->current, data, op->record_length, op->userdata);
+	cb(1, len, op->current, data, op->record_length, op->userdata);
 =

 	if (op->cache && imsi) {
 		char *path =3D g_strdup_printf(SIM_CACHE_PATH,
@@ -1536,7 +1538,16 @@ static gboolean sim_op_retrieve_next(gpointer user)
 			return FALSE;
 		}
 =

-		sim->driver->read_file_transparent(sim, op->id, 0, op->length,
+		if (op->num_bytes < 0)
+			op->num_bytes =3D op->length;
+
+		if (op->offset + op->num_bytes > op->length) {
+			sim_op_error(sim);
+			return FALSE;
+		}
+
+		sim->driver->read_file_transparent(sim, op->id, op->offset,
+						op->num_bytes,
 						sim_op_retrieve_cb, sim);
 		break;
 	case OFONO_SIM_FILE_STRUCTURE_FIXED:
@@ -1663,6 +1674,8 @@ static gboolean sim_op_check_cached(struct ofono_sim =
*sim)
 	unsigned int record;
 	guint8 *buffer =3D NULL;
 	gboolean ret =3D FALSE;
+	unsigned int read_bytes;
+	unsigned int num_records;
 =

 	if (!imsi)
 		return FALSE;
@@ -1694,8 +1707,19 @@ static gboolean sim_op_check_cached(struct ofono_sim=
 *sim)
 	structure =3D fileinfo[3];
 	record_length =3D (fileinfo[4] << 8) | fileinfo[5];
 =

-	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
-		record_length =3D file_length;
+	if (op->num_bytes < 0)
+		op->num_bytes =3D file_length;
+
+	read_bytes =3D op->num_bytes;
+
+	num_records =3D file_length / record_length;
+
+	/* add a seek to the correct offset here */
+	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT) {
+		TFR(lseek(fd, op->offset, SEEK_CUR));
+		num_records =3D 1;
+		record_length =3D read_bytes;
+	}
 =

 	if (record_length =3D=3D 0 || file_length < record_length)
 		goto cleanup;
@@ -1707,18 +1731,18 @@ static gboolean sim_op_check_cached(struct ofono_si=
m *sim)
 		goto cleanup;
 	}
 =

-	buffer =3D g_try_malloc(file_length);
+	buffer =3D g_try_malloc(read_bytes);
 =

 	if (buffer =3D=3D NULL)
 		goto cleanup;
 =

-	len =3D TFR(read(fd, buffer, file_length));
+	len =3D TFR(read(fd, buffer, read_bytes));
 =

-	if (len < (ssize_t)file_length)
+	if (len < (ssize_t) read_bytes)
 		goto cleanup;
 =

-	for (record =3D 0; record < file_length / record_length; record++) {
-		cb(1, file_length, record + 1, &buffer[record * record_length],
+	for (record =3D 0; record < num_records; record++) {
+		cb(1, read_bytes, record + 1, &buffer[record * record_length],
 			record_length, op->userdata);
 	}
 =

@@ -1787,8 +1811,9 @@ static gboolean sim_op_next(gpointer user_data)
 	return FALSE;
 }
 =

-int ofono_sim_read(struct ofono_sim *sim, int id,
+int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
 			enum ofono_sim_file_structure expected_type,
+			unsigned short offset, int num_bytes,
 			ofono_sim_file_read_cb_t cb, void *data)
 {
 	struct sim_file_op *op;
@@ -1819,6 +1844,8 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
 	op->cb =3D cb;
 	op->userdata =3D data;
 	op->is_read =3D TRUE;
+	op->offset =3D offset;
+	op->num_bytes =3D num_bytes;
 =

 	g_queue_push_tail(sim->simop_q, op);
 =

@@ -1828,6 +1855,13 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
 	return 0;
 }
 =

+int ofono_sim_read(struct ofono_sim *sim, int id,
+			enum ofono_sim_file_structure expected_type,
+			ofono_sim_file_read_cb_t cb, void *data)
+{
+	return ofono_sim_read_bytes(sim, id, expected_type, 0, -1, cb, data);
+}
+
 int ofono_sim_write(struct ofono_sim *sim, int id,
 			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
-- =

1.7.1.1


--===============1596850752463286989==--

