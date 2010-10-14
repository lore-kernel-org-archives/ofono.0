Content-Type: multipart/mixed; boundary="===============4728054708183005091=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] simfs: fix incorrect math again
Date: Thu, 14 Oct 2010 11:18:00 -0700
Message-ID: <1287080280-26368-1-git-send-email-kristen@linux.intel.com>
In-Reply-To: <4CB5B7D2.3070608@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4728054708183005091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfs.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index fd768ef..bcb6ff8 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -231,8 +231,7 @@ static void sim_fs_op_read_block_cb(const struct ofono_=
error *error,
 		tocopy =3D MIN(256 - op->offset % 256,
 				op->num_bytes - op->current * 256);
 	} else {
-		bufoff =3D (op->current - start_block - 1) * 256 +
-				op->offset % 256;
+		bufoff =3D op->current * 256;
 		dataoff =3D 0;
 		tocopy =3D MIN(256, op->num_bytes - op->current * 256);
 	}
@@ -294,8 +293,7 @@ static gboolean sim_fs_op_read_block(gpointer user_data)
 			toread =3D MIN(256 - op->offset % 256,
 					op->num_bytes - op->current * 256);
 		} else {
-			bufoff =3D (op->current - start_block - 1) * 256 +
-					op->offset % 256;
+			bufoff =3D op->current * 256;
 			seekoff =3D SIM_CACHE_HEADER_SIZE + op->current * 256;
 			toread =3D MIN(256, op->num_bytes - op->current * 256);
 		}
-- =

1.7.2.3


--===============4728054708183005091==--

