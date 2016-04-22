Content-Type: multipart/mixed; boundary="===============2297000445965282914=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 16/24] simfs: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-17-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-16-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2297000445965282914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/simfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 03c8c9e..595dbad 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -74,8 +74,9 @@ struct sim_fs_op {
 	struct ofono_sim_context *context;
 };
 =

-static void sim_fs_op_free(struct sim_fs_op *node)
+static void sim_fs_op_free(gpointer pointer)
 {
+	struct sim_fs_op *node =3D pointer;
 	g_free(node->buffer);
 	g_free(node);
 }
@@ -105,8 +106,7 @@ void sim_fs_free(struct sim_fs *fs)
 	 * for operations still in progress
 	 */
 	if (fs->op_q) {
-		g_queue_foreach(fs->op_q, (GFunc) sim_fs_op_free, NULL);
-		g_queue_free(fs->op_q);
+		g_queue_free_full(fs->op_q, sim_fs_op_free);
 		fs->op_q =3D NULL;
 	}
 =

-- =

1.9.1

--===============2297000445965282914==--

