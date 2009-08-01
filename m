Content-Type: multipart/mixed; boundary="===============9128191523744483767=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Implement ofono_sim_write.
Date: Sat, 01 Aug 2009 15:48:37 +0200
Message-ID: <1249134517-3107-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9128191523744483767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Writes use sim->simop_q queue together with reads.
---
 src/sim.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
---
 src/sim.h |    5 ++-
 2 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 1fcb63e..3d998e2 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -55,7 +55,9 @@ struct sim_file_op {
 	int length;
 	int record_length;
 	int current;
-	ofono_sim_file_read_cb_t cb;
+	gconstpointer cb;
+	int is_read;
+	void *buffer;
 	void *userdata;
 };
 =

@@ -288,7 +290,12 @@ static void sim_op_error(struct ofono_modem *modem)
 	struct sim_manager_data *sim =3D modem->sim_manager;
 	struct sim_file_op *op =3D g_queue_pop_head(sim->simop_q);
 =

-	op->cb(modem, 0, 0, 0, 0, 0, 0, op->userdata);
+	if (op->is_read)
+		((ofono_sim_file_read_cb_t) op->cb)
+			(modem, 0, 0, 0, 0, 0, 0, op->userdata);
+	else
+		((ofono_sim_file_write_cb_t) op->cb)
+			(modem, 0, op->userdata);
 =

 	sim_file_op_free(op);
 =

@@ -308,6 +315,7 @@ static void sim_op_retrieve_cb(const struct ofono_error=
 *error,
 	struct sim_manager_data *sim =3D modem->sim_manager;
 	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
 	int total =3D op->length / op->record_length;
+	ofono_sim_file_read_cb_t cb =3D op->cb;
 =

 	char *imsi =3D sim->imsi;
 	char *path;
@@ -318,7 +326,7 @@ static void sim_op_retrieve_cb(const struct ofono_error=
 *error,
 		return;
 	}
 =

-	op->cb(modem, 1, op->structure, op->length, op->current,
+	cb(modem, 1, op->structure, op->length, op->current,
 		data, op->record_length, op->userdata);
 =

 	if (op->cache && imsi) {
@@ -464,6 +472,26 @@ static void sim_op_info_cb(const struct ofono_error *e=
rror, int length,
 	}
 }
 =

+static void sim_op_write_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	struct sim_file_op *op =3D g_queue_pop_head(sim->simop_q);
+	ofono_sim_file_write_cb_t cb =3D op->cb;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		sim_op_error(modem);
+		return;
+	}
+
+	cb(modem, 1, op->userdata);
+
+	sim_file_op_free(op);
+
+	if (g_queue_get_length(sim->simop_q) > 0)
+		g_timeout_add(0, sim_op_next, modem);
+}
+
 static gboolean sim_op_next(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -475,7 +503,32 @@ static gboolean sim_op_next(gpointer user_data)
 =

 	op =3D g_queue_peek_head(sim->simop_q);
 =

-	sim->ops->read_file_info(modem, op->id, sim_op_info_cb, modem);
+	if (op->is_read) {
+		sim->ops->read_file_info(modem, op->id, sim_op_info_cb, modem);
+	} else {
+		switch (op->structure) {
+		case OFONO_SIM_FILE_STRUCTURE_TRANSPARENT:
+			sim->ops->write_file_transparent(modem, op->id, 0,
+					op->length, op->buffer,
+					sim_op_write_cb, modem);
+			break;
+		case OFONO_SIM_FILE_STRUCTURE_FIXED:
+			sim->ops->write_file_linear(modem, op->id, op->current,
+					op->length, op->buffer,
+					sim_op_write_cb, modem);
+			break;
+		case OFONO_SIM_FILE_STRUCTURE_CYCLIC:
+			sim->ops->write_file_cyclic(modem, op->id,
+					op->length, op->buffer,
+					sim_op_write_cb, modem);
+			break;
+		default:
+			ofono_error("Unrecognized file structure, "
+					"this can't happen");
+		}
+
+		g_free(op->buffer);
+	}
 =

 	return FALSE;
 }
@@ -613,6 +666,7 @@ int ofono_sim_read(struct ofono_modem *modem, int id,
 	op->id =3D id;
 	op->cb =3D cb;
 	op->userdata =3D data;
+	op->is_read =3D 1;
 =

 	g_queue_push_tail(sim->simop_q, op);
 =

@@ -623,10 +677,60 @@ int ofono_sim_read(struct ofono_modem *modem, int id,
 }
 =

 int ofono_sim_write(struct ofono_modem *modem, int id,
+			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
-			const unsigned char *data, int length)
+			const unsigned char *data, int length, void *userdata)
 {
-	return -1;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	struct sim_file_op *op;
+	gconstpointer fn =3D NULL;
+
+	if (!cb)
+		return -1;
+
+	if (sim =3D=3D NULL)
+		return -1;
+
+	if (!sim->ops)
+		return -1;
+
+	switch (structure) {
+	case OFONO_SIM_FILE_STRUCTURE_TRANSPARENT:
+		fn =3D sim->ops->write_file_transparent;
+		break;
+	case OFONO_SIM_FILE_STRUCTURE_FIXED:
+		fn =3D sim->ops->write_file_linear;
+		break;
+	case OFONO_SIM_FILE_STRUCTURE_CYCLIC:
+		fn =3D sim->ops->write_file_cyclic;
+		break;
+	default:
+		ofono_error("Unrecognized file structure, this can't happen");
+	}
+
+	if (fn =3D=3D NULL)
+		return -1;
+
+	if (!sim->simop_q)
+		sim->simop_q =3D g_queue_new();
+
+	op =3D g_new0(struct sim_file_op, 1);
+
+	op->id =3D id;
+	op->cb =3D cb;
+	op->userdata =3D userdata;
+	op->is_read =3D 0;
+	op->buffer =3D g_memdup(data, length);
+	op->structure =3D structure;
+	op->length =3D length;
+	op->current =3D record;
+
+	g_queue_push_tail(sim->simop_q, op);
+
+	if (g_queue_get_length(sim->simop_q) =3D=3D 1)
+		g_timeout_add(0, sim_op_next, modem);
+
+	return 0;
 }
 =

 static void initialize_sim_manager(struct ofono_modem *modem)
diff --git a/src/sim.h b/src/sim.h
index 8e7870d..88a165c 100644
--- a/src/sim.h
+++ b/src/sim.h
@@ -26,6 +26,8 @@ typedef void (*ofono_sim_file_read_cb_t)(struct ofono_mod=
em *modem, int ok,
 					int total_length, int record,
 					const unsigned char *data,
 					int record_length, void *userdata);
+typedef void (*ofono_sim_file_write_cb_t)(struct ofono_modem *modem, int o=
k,
+					void *userdata);
 =

 void ofono_sim_manager_init(struct ofono_modem *modem);
 void ofono_sim_manager_exit(struct ofono_modem *modem);
@@ -51,5 +53,6 @@ int ofono_sim_read(struct ofono_modem *modem, int id,
 			ofono_sim_file_read_cb_t cb, void *data);
 =

 int ofono_sim_write(struct ofono_modem *modem, int id,
+			ofono_sim_file_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
-			const unsigned char *data, int length);
+			const unsigned char *data, int length, void *userdata);
-- =

1.6.1


--===============9128191523744483767==--

