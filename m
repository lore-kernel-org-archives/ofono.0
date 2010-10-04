Content-Type: multipart/mixed; boundary="===============8659037675487637845=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/4] simfs: fix incorrect math when calculating length to copy
Date: Mon, 04 Oct 2010 15:33:21 -0700
Message-ID: <1286231602-18692-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1286231602-18692-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8659037675487637845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfs.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 5fbee8b..bfcdf23 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -229,14 +229,16 @@ static void sim_fs_op_read_block_cb(const struct ofon=
o_error *error,
 	if (op->current =3D=3D start_block) {
 		bufoff =3D 0;
 		dataoff =3D op->offset % 256;
-		tocopy =3D MIN(256 - op->offset % 256, len);
 	} else {
-		bufoff =3D (op->current - start_block - 1) * 256 +
-				op->offset % 256;
+		bufoff =3D op->current * 256;
 		dataoff =3D 0;
-		tocopy =3D len;
 	}
 =

+	tocopy =3D op->num_bytes % 256;
+
+	if ((tocopy =3D=3D 0) || (op->current !=3D end_block))
+		tocopy =3D 256;
+
 	memcpy(fs->buffer + bufoff, data + dataoff, tocopy);
 	cache_block(fs, op->current, 256, data, len);
 =

@@ -288,15 +290,16 @@ static gboolean sim_fs_op_read_block(gpointer user_da=
ta)
 			bufoff =3D 0;
 			seekoff =3D SIM_CACHE_HEADER_SIZE + op->current * 256 +
 				op->offset % 256;
-			toread =3D MIN(256 - op->offset % 256,
-					op->length - op->current * 256);
 		} else {
-			bufoff =3D (op->current - start_block - 1) * 256 +
-					op->offset % 256;
+			bufoff =3D op->current * 256;
 			seekoff =3D SIM_CACHE_HEADER_SIZE + op->current * 256;
-			toread =3D MIN(256, op->length - op->current * 256);
 		}
 =

+		toread =3D op->num_bytes % 256;
+
+		if ((toread =3D=3D 0) || (op->current !=3D end_block))
+			toread =3D 256;
+
 		if (lseek(fs->fd, seekoff, SEEK_SET) =3D=3D (off_t) -1)
 			break;
 =

-- =

1.7.2.1


--===============8659037675487637845==--

