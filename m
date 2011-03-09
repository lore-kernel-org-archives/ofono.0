Content-Type: multipart/mixed; boundary="===============3753350482753757960=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] simfs: fix GLib-CRITICAL issue occuring when there is no SIM
 card.
Date: Wed, 09 Mar 2011 12:32:23 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5BA2@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3753350482753757960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

During modem release, when there is no SIM card, a GLib-CRITICAL
issue occurs during the free of the sim fs context.
---
 src/simfs.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 3a97a10..49f79dd 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -166,21 +166,23 @@ void sim_fs_context_free(struct ofono_sim_context *co=
ntext)
 	int n =3D 0;
 	struct sim_fs_op *op;
 =

-	while ((op =3D g_queue_peek_nth(fs->op_q, n)) !=3D NULL) {
-		if (op->context !=3D context) {
-			n +=3D 1;
-			continue;
-		}
+	if (fs->op_q) {
+		while ((op =3D g_queue_peek_nth(fs->op_q, n)) !=3D NULL) {
+			if (op->context !=3D context) {
+				n +=3D 1;
+				continue;
+			}
 =

-		if (n =3D=3D 0) {
-			op->cb =3D NULL;
+			if (n =3D=3D 0) {
+				op->cb =3D NULL;
 =

-			n +=3D 1;
-			continue;
-		}
+				n +=3D 1;
+				continue;
+			}
 =

-		sim_fs_op_free(op);
-		g_queue_remove(fs->op_q, op);
+			sim_fs_op_free(op);
+			g_queue_remove(fs->op_q, op);
+		}
 	}
 =

 	if (context->file_watches)
-- =

1.6.3.3

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============3753350482753757960==--

