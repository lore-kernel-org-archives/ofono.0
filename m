Content-Type: multipart/mixed; boundary="===============1238394387047265439=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] sim: Cache flushing functions.
Date: Tue, 28 Dec 2010 10:17:54 +0100
Message-ID: <1293527879-3369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1238394387047265439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c   |   23 ++++++++++++++++++++
 src/simfs.c |   68 ++++++++++++++++++++++++++++++++++++++++++++-----------=
---
 src/simfs.h |    5 ++++
 3 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 335f611..27ff572 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2255,3 +2255,26 @@ void *ofono_sim_get_data(struct ofono_sim *sim)
 {
 	return sim->driver_data;
 }
+
+static void sim_file_changed_flush(struct ofono_sim *sim, int id)
+{
+	int i, imgid;
+
+	if (id =3D=3D SIM_EFIMG_FILEID)
+		/* All cached images become invalid */
+		sim_fs_image_cache_flush(sim->simfs);
+	else if (sim->efimg)
+		/*
+		 * Data and CLUT for image instances stored in the changed
+		 * file need to be re-read.
+		 */
+		for (i =3D sim->efimg_length / 9 - 1; i >=3D 0; i--) {
+			imgid =3D (sim->efimg[i * 9 + 3] << 8) |
+				sim->efimg[i * 9 + 4];
+
+			if (imgid =3D=3D id)
+				sim_fs_image_cache_flush_file(sim->simfs, i);
+		}
+
+	sim_fs_cache_flush_file(sim->simfs, id);
+}
diff --git a/src/simfs.c b/src/simfs.c
index 617af14..a99a2c6 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -907,9 +907,6 @@ void sim_fs_check_version(struct sim_fs *fs)
 	const char *imsi =3D ofono_sim_get_imsi(fs->sim);
 	enum ofono_sim_phase phase =3D ofono_sim_get_phase(fs->sim);
 	unsigned char version;
-	struct dirent **entries;
-	int len;
-	char *path;
 =

 	if (imsi =3D=3D NULL || phase =3D=3D OFONO_SIM_PHASE_UNKNOWN)
 		return;
@@ -918,10 +915,20 @@ void sim_fs_check_version(struct sim_fs *fs)
 		if (version =3D=3D SIM_FS_VERSION)
 			return;
 =

-	path =3D g_strdup_printf(SIM_CACHE_BASEPATH, imsi, phase);
+	sim_fs_cache_flush(fs);
+
+	version =3D SIM_FS_VERSION;
+	write_file(&version, 1, SIM_CACHE_MODE, SIM_CACHE_VERSION, imsi, phase);
+}
+
+void sim_fs_cache_flush(struct sim_fs *fs)
+{
+	const char *imsi =3D ofono_sim_get_imsi(fs->sim);
+	enum ofono_sim_phase phase =3D ofono_sim_get_phase(fs->sim);
+	char *path =3D g_strdup_printf(SIM_CACHE_BASEPATH, imsi, phase);
+	struct dirent **entries;
+	int len =3D scandir(path, &entries, NULL, alphasort);
 =

-	ofono_info("Detected old simfs version in %s, removing", path);
-	len =3D scandir(path, &entries, NULL, alphasort);
 	g_free(path);
 =

 	if (len > 0) {
@@ -934,20 +941,47 @@ void sim_fs_check_version(struct sim_fs *fs)
 		g_free(entries);
 	}
 =

-	path =3D g_strdup_printf(SIM_IMAGE_CACHE_BASEPATH, imsi, phase);
-	len =3D scandir(path, &entries, NULL, alphasort);
+	sim_fs_image_cache_flush(fs);
+}
+
+void sim_fs_cache_flush_file(struct sim_fs *fs, int id)
+{
+	const char *imsi =3D ofono_sim_get_imsi(fs->sim);
+	enum ofono_sim_phase phase =3D ofono_sim_get_phase(fs->sim);
+	char *path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, phase, id);
+
+	remove(path);
 	g_free(path);
+}
 =

-	if (len > 0) {
-		/* Remove everything */
-		while (len--) {
-			remove_imagefile(imsi, phase, entries[len]);
-			g_free(entries[len]);
-		}
+void sim_fs_image_cache_flush(struct sim_fs *fs)
+{
+	const char *imsi =3D ofono_sim_get_imsi(fs->sim);
+	enum ofono_sim_phase phase =3D ofono_sim_get_phase(fs->sim);
+	char *path =3D g_strdup_printf(SIM_IMAGE_CACHE_BASEPATH, imsi, phase);
+	struct dirent **entries;
+	int len =3D scandir(path, &entries, NULL, alphasort);
 =

-		g_free(entries);
+	g_free(path);
+
+	if (len =3D=3D 0)
+		return;
+
+	/* Remove everything */
+	while (len--) {
+		remove_imagefile(imsi, phase, entries[len]);
+		g_free(entries[len]);
 	}
 =

-	version =3D SIM_FS_VERSION;
-	write_file(&version, 1, SIM_CACHE_MODE, SIM_CACHE_VERSION, imsi, phase);
+	g_free(entries);
+}
+
+void sim_fs_image_cache_flush_file(struct sim_fs *fs, int id)
+{
+	const char *imsi =3D ofono_sim_get_imsi(fs->sim);
+	enum ofono_sim_phase phase =3D ofono_sim_get_phase(fs->sim);
+	char *path =3D g_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
+
+	remove(path);
+	g_free(path);
 }
diff --git a/src/simfs.h b/src/simfs.h
index ef962db..8c6f761 100644
--- a/src/simfs.h
+++ b/src/simfs.h
@@ -47,4 +47,9 @@ char *sim_fs_get_cached_image(struct sim_fs *fs, int id);
 =

 void sim_fs_cache_image(struct sim_fs *fs, const char *image, int id);
 =

+void sim_fs_cache_flush(struct sim_fs *fs);
+void sim_fs_cache_flush_file(struct sim_fs *fs, int id);
+void sim_fs_image_cache_flush(struct sim_fs *fs);
+void sim_fs_image_cache_flush_file(struct sim_fs *fs, int id);
+
 void sim_fs_free(struct sim_fs *fs);
-- =

1.7.1.86.g0e460.dirty


--===============1238394387047265439==--

