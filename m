Content-Type: multipart/mixed; boundary="===============5337400846523570884=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] simfs: Cache flushing functions.
Date: Fri, 10 Dec 2010 14:59:20 +0100
Message-ID: <1291989564-28694-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5337400846523570884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfs.c |   35 +++++++++++++++++++++++++++--------
 src/simfs.h |    2 ++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 8e52f7b..2f58d9b 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -903,17 +903,39 @@ void sim_fs_check_version(struct sim_fs *fs)
 	const char *imsi =3D ofono_sim_get_imsi(fs->sim);
 	enum ofono_sim_phase phase =3D ofono_sim_get_phase(fs->sim);
 	unsigned char version;
-	struct dirent **entries;
-	int len;
-	char *path;
 =

 	if (read_file(&version, 1, SIM_CACHE_VERSION, imsi, phase) =3D=3D 1)
 		if (version =3D=3D SIM_FS_VERSION)
 			return;
 =

-	path =3D g_strdup_printf(SIM_CACHE_BASEPATH, imsi, phase);
+	sim_fs_cache_flush(fs,  0);
+
+	version =3D SIM_FS_VERSION;
+	write_file(&version, 1, SIM_CACHE_MODE, SIM_CACHE_VERSION, imsi, phase);
+}
+
+void sim_fs_cache_flush(struct sim_fs *fs, int id)
+{
+	const char *imsi =3D ofono_sim_get_imsi(fs->sim);
+	enum ofono_sim_phase phase =3D ofono_sim_get_phase(fs->sim);
+	int len;
+	char *path;
+	struct dirent **entries;
+
+	/* Id of 0 flushes all cache content */
+	if (id > 0) {
+		path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, phase, id);
+		remove(path);
+		g_free(path);
+
+		path =3D g_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
+		remove(path);
+		g_free(path);
+
+		return;
+	}
 =

-	ofono_info("Detected old simfs version in %s, removing", path);
+	path =3D g_strdup_printf(SIM_CACHE_BASEPATH, imsi, phase);
 	len =3D scandir(path, &entries, NULL, alphasort);
 	g_free(path);
 =

@@ -940,7 +962,4 @@ void sim_fs_check_version(struct sim_fs *fs)
 =

 		g_free(entries);
 	}
-
-	version =3D SIM_FS_VERSION;
-	write_file(&version, 1, SIM_CACHE_MODE, SIM_CACHE_VERSION, imsi, phase);
 }
diff --git a/src/simfs.h b/src/simfs.h
index ef962db..ace25bf 100644
--- a/src/simfs.h
+++ b/src/simfs.h
@@ -47,4 +47,6 @@ char *sim_fs_get_cached_image(struct sim_fs *fs, int id);
 =

 void sim_fs_cache_image(struct sim_fs *fs, const char *image, int id);
 =

+void sim_fs_cache_flush(struct sim_fs *fs, int id);
+
 void sim_fs_free(struct sim_fs *fs);
-- =

1.7.1.86.g0e460.dirty


--===============5337400846523570884==--

