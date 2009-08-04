Content-Type: multipart/mixed; boundary="===============6805337580485800309=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Fix a copy+paste error in SIM write callback.
Date: Tue, 04 Aug 2009 05:39:40 +0200
Message-ID: <1249357180-15346-1-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1249303898-8929-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6805337580485800309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[Please ignore the first patch, I was fixing the wrong thing]
---
 src/sim.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 36ed90b..fb3af83 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -503,12 +503,10 @@ static void sim_op_write_cb(const struct ofono_error =
*error, void *data)
 	struct sim_file_op *op =3D g_queue_pop_head(sim->simop_q);
 	ofono_sim_file_write_cb_t cb =3D op->cb;
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		sim_op_error(modem);
-		return;
-	}
-
-	cb(modem, 1, op->userdata);
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		cb(modem, 1, op->userdata);
+	else
+		cb(modem, 0, op->userdata);
 =

 	sim_file_op_free(op);
 =

-- =

1.6.1


--===============6805337580485800309==--

