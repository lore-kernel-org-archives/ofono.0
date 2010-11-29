Content-Type: multipart/mixed; boundary="===============5104555305102824417=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] simfs: make sim_fs_read_block work for > 256 byte files
Date: Mon, 29 Nov 2010 11:13:12 -0800
Message-ID: <1291057992-14852-1-git-send-email-kristen@linux.intel.com>
In-Reply-To: <4CD026D7.5060806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5104555305102824417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfs.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 5f459ab..258a42f 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -59,6 +59,7 @@ static gboolean sim_fs_op_read_block(gpointer user_data);
 struct sim_fs_op {
 	int id;
 	unsigned char *buffer;
+	int bufoff;
 	enum ofono_sim_file_structure structure;
 	unsigned short offset;
 	gboolean info_only;
@@ -217,7 +218,6 @@ static void sim_fs_op_read_block_cb(const struct ofono_=
error *error,
 	struct sim_fs_op *op =3D g_queue_peek_head(fs->op_q);
 	int start_block;
 	int end_block;
-	int bufoff;
 	int dataoff;
 	int tocopy;
 =

@@ -230,25 +230,25 @@ static void sim_fs_op_read_block_cb(const struct ofon=
o_error *error,
 	end_block =3D (op->offset + (op->num_bytes - 1)) / 256;
 =

 	if (op->current =3D=3D start_block) {
-		bufoff =3D 0;
+		op->bufoff =3D 0;
 		dataoff =3D op->offset % 256;
 		tocopy =3D MIN(256 - op->offset % 256,
 				op->num_bytes - op->current * 256);
 	} else {
-		bufoff =3D (op->current - start_block - 1) * 256 +
-				op->offset % 256;
 		dataoff =3D 0;
 		tocopy =3D MIN(256, op->num_bytes - op->current * 256);
 	}
 =

 	DBG("bufoff: %d, dataoff: %d, tocopy: %d",
-				bufoff, dataoff, tocopy);
+				op->bufoff, dataoff, tocopy);
 =

-	memcpy(op->buffer + bufoff, data + dataoff, tocopy);
+	memcpy(op->buffer + op->bufoff, data + dataoff, tocopy);
 	cache_block(fs, op->current, 256, data, len);
 =

 	op->current++;
 =

+	op->bufoff +=3D tocopy;
+
 	if (op->current > end_block) {
 		ofono_sim_file_read_cb_t cb =3D op->cb;
 =

-- =

1.7.2.3


--===============5104555305102824417==--

