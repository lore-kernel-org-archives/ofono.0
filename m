Content-Type: multipart/mixed; boundary="===============0362795208063442131=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/4] simfs: cache images
Date: Mon, 04 Oct 2010 15:33:19 -0700
Message-ID: <1286231602-18692-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1286231602-18692-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0362795208063442131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfs.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simfs.h |    4 +++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index b5b12b4..5fbee8b 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -47,6 +47,7 @@
 #define SIM_CACHE_PATH SIM_CACHE_BASEPATH "/%04x"
 #define SIM_CACHE_HEADER_SIZE 38
 #define SIM_FILE_INFO_SIZE 6
+#define SIM_IMAGE_CACHE_PATH STORAGEDIR "/%s-%i/images/%d.xpm"
 =

 #define SIM_FS_VERSION 1
 =

@@ -722,6 +723,67 @@ int sim_fs_write(struct sim_fs *fs, int id, ofono_sim_=
file_write_cb_t cb,
 	return 0;
 }
 =

+void sim_fs_cache_image(struct sim_fs *fs, const char *image, int id)
+{
+	const char *imsi;
+	enum ofono_sim_phase phase;
+
+	if (fs =3D=3D NULL || image =3D=3D NULL)
+		return;
+
+	imsi =3D ofono_sim_get_imsi(fs->sim);
+	phase =3D ofono_sim_get_phase(fs->sim);
+
+	if (imsi)
+		write_file((const unsigned char *) image, strlen(image),
+				SIM_CACHE_MODE, SIM_IMAGE_CACHE_PATH, imsi,
+				phase, id);
+}
+
+char *sim_fs_get_cached_image(struct sim_fs *fs, int id)
+{
+	const char *imsi;
+	enum ofono_sim_phase phase;
+	unsigned short image_length;
+	int fd;
+	char *buffer;
+	char *path;
+	int len;
+	struct stat st_buf;
+
+	if (fs =3D=3D NULL)
+		return NULL;
+
+	imsi =3D ofono_sim_get_imsi(fs->sim);
+	phase =3D ofono_sim_get_phase(fs->sim);
+
+	path =3D g_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
+
+	TFR(stat(path, &st_buf));
+
+	fd =3D TFR(open(path, O_RDONLY));
+
+	g_free(path);
+
+	if (fd < 0)
+		return NULL;
+
+	image_length =3D st_buf.st_size;
+
+	buffer =3D g_try_malloc0(image_length + 1);
+
+	len =3D TFR(read(fd, buffer, image_length));
+
+	TFR(close(fd));
+
+	if (len !=3D image_length) {
+		g_free(buffer);
+		return NULL;
+	}
+
+	return buffer;
+}
+
 static void remove_cachefile(const char *imsi, enum ofono_sim_phase phase,
 				const struct dirent *file)
 {
diff --git a/src/simfs.h b/src/simfs.h
index 6d5dded..c0b4c51 100644
--- a/src/simfs.h
+++ b/src/simfs.h
@@ -35,4 +35,8 @@ int sim_fs_write(struct sim_fs *fs, int id, ofono_sim_fil=
e_write_cb_t cb,
 			enum ofono_sim_file_structure structure, int record,
 			const unsigned char *data, int length, void *userdata);
 =

+char *sim_fs_get_cached_image(struct sim_fs *fs, int id);
+
+void sim_fs_cache_image(struct sim_fs *fs, const char *image, int id);
+
 void sim_fs_free(struct sim_fs *fs);
-- =

1.7.2.1


--===============0362795208063442131==--

