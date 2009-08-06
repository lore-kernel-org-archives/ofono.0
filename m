Content-Type: multipart/mixed; boundary="===============8389639285618264412=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Reorder statements to make SIM op queue more robust.
Date: Thu, 06 Aug 2009 22:29:12 +0200
Message-ID: <1249590552-18714-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8389639285618264412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows ofono_sim_read and ofono_sim_write callbacks to queue new
read or write operations.  The callback must not be called between
removing the operation from queue and checking queue length.
---
 src/sim.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 3376462..b7832f5 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -304,6 +304,9 @@ static void sim_op_error(struct ofono_modem *modem)
 	struct sim_manager_data *sim =3D modem->sim_manager;
 	struct sim_file_op *op =3D g_queue_pop_head(sim->simop_q);
 =

+	if (g_queue_get_length(sim->simop_q) > 0)
+		g_timeout_add(0, sim_op_next, modem);
+
 	if (op->is_read =3D=3D TRUE)
 		((ofono_sim_file_read_cb_t) op->cb)
 			(modem, 0, 0, 0, 0, 0, 0, op->userdata);
@@ -312,9 +315,6 @@ static void sim_op_error(struct ofono_modem *modem)
 			(modem, 0, op->userdata);
 =

 	sim_file_op_free(op);
-
-	if (g_queue_get_length(sim->simop_q) > 0)
-		g_timeout_add(0, sim_op_next, modem);
 }
 =

 static gboolean cache_record(const char *path, int current, int record_len,
@@ -517,15 +517,15 @@ static void sim_op_write_cb(const struct ofono_error =
*error, void *data)
 	struct sim_file_op *op =3D g_queue_pop_head(sim->simop_q);
 	ofono_sim_file_write_cb_t cb =3D op->cb;
 =

+	if (g_queue_get_length(sim->simop_q) > 0)
+		g_timeout_add(0, sim_op_next, modem);
+
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		cb(modem, 1, op->userdata);
 	else
 		cb(modem, 0, op->userdata);
 =

 	sim_file_op_free(op);
-
-	if (g_queue_get_length(sim->simop_q) > 0)
-		g_timeout_add(0, sim_op_next, modem);
 }
 =

 static gboolean sim_op_next(gpointer user_data)
-- =

1.6.1


--===============8389639285618264412==--

