Content-Type: multipart/mixed; boundary="===============1845692553655386595=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Correct a copy+paste error in SIM write callback.
Date: Mon, 03 Aug 2009 14:51:38 +0200
Message-ID: <1249303898-8929-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1845692553655386595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d432e1b..d4c7dbf 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -479,7 +479,7 @@ static void sim_op_write_cb(const struct ofono_error *e=
rror, void *data)
 {
 	struct ofono_modem *modem =3D data;
 	struct sim_manager_data *sim =3D modem->sim_manager;
-	struct sim_file_op *op =3D g_queue_pop_head(sim->simop_q);
+	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
 	ofono_sim_file_write_cb_t cb =3D op->cb;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-- =

1.6.1


--===============1845692553655386595==--

