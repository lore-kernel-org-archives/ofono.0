Content-Type: multipart/mixed; boundary="===============5019030416100081642=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/4] simfs: Call callback with failure if driver is not
 implemented
Date: Mon, 21 Nov 2011 11:54:03 +0100
Message-ID: <1321872845-24754-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1321872845-24754-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5019030416100081642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 875e194..58dc41d 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -901,8 +901,10 @@ int sim_fs_read(struct ofono_sim_context *context, int=
 id,
 	if (fs->driver =3D=3D NULL)
 		return -EINVAL;
 =

-	if (fs->driver->read_file_info =3D=3D NULL)
+	if (fs->driver->read_file_info =3D=3D NULL) {
+		cb(0, 0, 0, NULL, 0, data);
 		return -ENOSYS;
+	}
 =

 	if (fs->op_q =3D=3D NULL)
 		fs->op_q =3D g_queue_new();
-- =

1.7.1


--===============5019030416100081642==--

