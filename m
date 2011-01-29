Content-Type: multipart/mixed; boundary="===============3510902196870472978=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] simfs: Return from sim_fs_op_check_cached on error.
Date: Sat, 29 Jan 2011 01:29:18 +0100
Message-ID: <1296260961-15155-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1296260961-15155-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3510902196870472978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 35045a1..73da80c 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -600,8 +600,10 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *=
fs)
 	fs->fd =3D fd;
 =

 	if (error_type !=3D OFONO_ERROR_TYPE_NO_ERROR ||
-			structure !=3D op->structure)
+			structure !=3D op->structure) {
 		sim_fs_op_error(fs);
+		return TRUE;
+	}
 =

 	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT) {
 		if (op->num_bytes =3D=3D 0)
-- =

1.7.1.86.g0e460.dirty


--===============3510902196870472978==--

