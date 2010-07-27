Content-Type: multipart/mixed; boundary="===============7141906427603843644=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] sim: allow partial reads of tranparent files
Date: Tue, 27 Jul 2010 16:22:07 -0700
Message-ID: <1280272927-21803-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7141906427603843644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement ofono_sim_read_bytes().  For transparent files, this
will read num_bytes from a specified offset of a given fileid.
---
 include/sim.h |    5 +++++
 src/sim.c     |   27 ++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 36a99b9..15cd6b8 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -198,6 +198,11 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
 			enum ofono_sim_file_structure expected,
 			ofono_sim_file_read_cb_t cb, void *data);
 =

+int ofono_sim_read_bytes(struct ofono_sim *sim, int id,
+			enum ofono_sim_file_structure expected,
+			unsigned short offset, int num_bytes,
+			ofono_sim_file_read_cb_t cb, void *data);
+
 int ofono_sim_write(struct ofono_sim *sim, int id,
 			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
diff --git a/src/sim.c b/src/sim.c
index 2514e7b..63dea19 100644
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
@@ -1434,7 +1436,7 @@ static void sim_op_retrieve_cb(const struct ofono_err=
or *error,
 		return;
 	}
 =

-	cb(1, op->length, op->current, data, op->record_length, op->userdata);
+	cb(1, len, op->current, data, op->record_length, op->userdata);
 =

 	if (op->cache && imsi) {
 		char *path =3D g_strdup_printf(SIM_CACHE_PATH,
@@ -1472,7 +1474,16 @@ static gboolean sim_op_retrieve_next(gpointer user)
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
@@ -1723,8 +1734,9 @@ static gboolean sim_op_next(gpointer user_data)
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
@@ -1755,6 +1767,8 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
 	op->cb =3D cb;
 	op->userdata =3D data;
 	op->is_read =3D TRUE;
+	op->offset =3D offset;
+	op->num_bytes =3D num_bytes;
 =

 	g_queue_push_tail(sim->simop_q, op);
 =

@@ -1764,6 +1778,13 @@ int ofono_sim_read(struct ofono_sim *sim, int id,
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


--===============7141906427603843644==--

