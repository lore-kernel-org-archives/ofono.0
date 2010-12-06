Content-Type: multipart/mixed; boundary="===============3828331697079627526=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/2] simfs: Add unknown sim phase check
Date: Mon, 06 Dec 2010 10:39:17 -0800
Message-ID: <1291660757-6684-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1291660757-6684-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3828331697079627526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfs.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 8e52f7b..617af14 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -554,7 +554,8 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *f=
s)
 	enum ofono_sim_file_structure structure;
 	int record_length;
 =

-	if (imsi =3D=3D NULL || op->info_only =3D=3D TRUE)
+	if (imsi =3D=3D NULL || phase =3D=3D OFONO_SIM_PHASE_UNKNOWN ||
+			op->info_only =3D=3D TRUE)
 		return FALSE;
 =

 	path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
@@ -836,6 +837,9 @@ char *sim_fs_get_cached_image(struct sim_fs *fs, int id)
 		return NULL;
 =

 	phase =3D ofono_sim_get_phase(fs->sim);
+	if (phase =3D=3D OFONO_SIM_PHASE_UNKNOWN)
+		return NULL;
+
 	path =3D g_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
 =

 	TFR(stat(path, &st_buf));
@@ -907,6 +911,9 @@ void sim_fs_check_version(struct sim_fs *fs)
 	int len;
 	char *path;
 =

+	if (imsi =3D=3D NULL || phase =3D=3D OFONO_SIM_PHASE_UNKNOWN)
+		return;
+
 	if (read_file(&version, 1, SIM_CACHE_VERSION, imsi, phase) =3D=3D 1)
 		if (version =3D=3D SIM_FS_VERSION)
 			return;
-- =

1.7.0.4


--===============3828331697079627526==--

