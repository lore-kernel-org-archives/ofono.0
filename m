Content-Type: multipart/mixed; boundary="===============5122527351351641049=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] simfs: Fix reads beyond the first block
Date: Fri, 30 Jul 2021 15:07:51 +0300
Message-ID: <20210730120751.2682607-1-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5122527351351641049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfs.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 3d4f6283..cf770265 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -383,18 +383,18 @@ static void sim_fs_op_read_block_cb(const struct ofon=
o_error *error,
 	}
 =

 	start_block =3D op->offset / 256;
-	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
+	end_block =3D op->num_bytes ? (op->offset + op->num_bytes - 1) / 256 :
+								start_block;
 =

 	if (op->current =3D=3D start_block) {
 		bufoff =3D 0;
 		dataoff =3D op->offset % 256;
-		tocopy =3D MIN(256 - op->offset % 256,
-				op->num_bytes - op->current * 256);
+		tocopy =3D MIN(256 - dataoff, op->num_bytes);
 	} else {
-		bufoff =3D (op->current - start_block - 1) * 256 +
+		bufoff =3D (op->current - start_block) * 256 -
 				op->offset % 256;
 		dataoff =3D 0;
-		tocopy =3D MIN(256, op->num_bytes - op->current * 256);
+		tocopy =3D MIN(256, op->num_bytes - bufoff);
 	}
 =

 	DBG("bufoff: %d, dataoff: %d, tocopy: %d",
@@ -463,13 +463,12 @@ static gboolean sim_fs_op_read_block(gpointer user_da=
ta)
 			bufoff =3D 0;
 			seekoff =3D SIM_CACHE_HEADER_SIZE + op->current * 256 +
 				op->offset % 256;
-			toread =3D MIN(256 - op->offset % 256,
-					op->num_bytes - op->current * 256);
+			toread =3D MIN(256 - op->offset % 256, op->num_bytes);
 		} else {
-			bufoff =3D (op->current - start_block - 1) * 256 +
+			bufoff =3D (op->current - start_block) * 256 -
 					op->offset % 256;
 			seekoff =3D SIM_CACHE_HEADER_SIZE + op->current * 256;
-			toread =3D MIN(256, op->num_bytes - op->current * 256);
+			toread =3D MIN(256, op->num_bytes - bufoff);
 		}
 =

 		DBG("bufoff: %d, seekoff: %d, toread: %d",
-- =

2.25.1

--===============5122527351351641049==--

