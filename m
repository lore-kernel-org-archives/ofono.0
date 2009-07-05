Content-Type: multipart/mixed; boundary="===============3343143095998753530=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Cache EF-PNN, EF-OPL sim files on disk.
Date: Sun, 05 Jul 2009 05:14:32 +0200
Message-ID: <1246763672-17349-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3343143095998753530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This uses plain files in /var/cache/ofono for storing contents of the
operator lists to avoid possibly numerous queries to the SIM on every
startup.  Files are indexed with IMSI.  I'm not 100% sure about the
autoconf magic.

Users need to rerun bootstrap-configure after applying this.
---
 bootstrap-configure |    3 +-
 configure.ac        |    5 +
 src/sim.c           |  233 +++++++++++++++++++++++++++++++++++++++++++++++=
++--
 3 files changed, 233 insertions(+), 8 deletions(-)

diff --git a/bootstrap-configure b/bootstrap-configure
index 2519f22..2c4d9a2 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -10,4 +10,5 @@ fi
 		--prefix=3D/usr \
 		--mandir=3D/usr/share/man \
 		--sysconfdir=3D/etc \
-		--disable-datafiles
+		--disable-datafiles \
+		--localstatedir=3D/var
diff --git a/configure.ac b/configure.ac
index 2d16fae..dd1d7aa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -87,6 +87,11 @@ AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-dataf=
iles],
 =

 AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" !=3D "no")
 =

+eval "eval LOCALSTATE_DIR=3D$localstatedir"
+AC_SUBST(LOCALSTATE_DIR)
+AC_DEFINE_UNQUOTED(CONFIG_LOCALSTATEDIR, "$LOCALSTATE_DIR",
+		   [Define to the location where state is stored.])
+
 COMPILER_FLAGS
 =

 AC_OUTPUT(Makefile gdbus/Makefile gatchat/Makefile gisi/Makefile
diff --git a/src/sim.c b/src/sim.c
index 13557bf..f7992c7 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -25,6 +25,10 @@
 =

 #include <string.h>
 #include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <errno.h>
 =

 #include <dbus/dbus.h>
 #include <glib.h>
@@ -70,6 +74,219 @@ struct sim_manager_data {
 	int pnn_current;
 };
 =

+static int create_dirs(const char *filename, const mode_t mode)
+{
+	struct stat st;
+	char *dir;
+	const char *prev, *next;
+	int err;
+
+	err =3D stat(filename, &st);
+	if (!err && S_ISREG(st.st_mode))
+		return 0;
+
+	dir =3D g_malloc(strlen(filename) + 1);
+	strcpy(dir, "/");
+
+	for (prev =3D filename; next =3D strchr(prev + 1, '/'); prev =3D next)
+		if (next > prev + 1) {
+			strncat(dir, prev + 1, next - prev);
+
+			if (mkdir(dir, mode) && errno !=3D EEXIST) {
+				g_free(dir);
+				return -1;
+			}
+		}
+
+	g_free(dir);
+	return 0;
+}
+
+#define SIM_CACHE_MODE 0600
+#define SIM_CACHE_PATH CONFIG_LOCALSTATEDIR "/cache/ofono/%s/%04x"
+#define SIM_CACHE_PATH_LEN(imsilen) (strlen(SIM_CACHE_PATH) - 2 + imsilen)
+
+struct sim_cache_callback {
+	struct sim_manager_data *sim;
+	void *cb;
+	void *data;
+	int fileid;
+	int record;
+};
+
+static void read_file_info_cached_cb(const struct ofono_error *error,
+		int file_length, enum ofono_sim_file_structure structure,
+		int record_length, void *data)
+{
+	struct sim_cache_callback *cbs =3D data;
+	ofono_sim_file_info_cb_t cb =3D cbs->cb;
+	char *path;
+	char *imsi =3D cbs->sim->imsi;
+	unsigned char fileinfo[6];
+	int fd =3D -1, fileid, ret;
+
+	cb(error, file_length, structure, record_length, cbs->data);
+
+	fileid =3D cbs->fileid;
+	g_free(cbs);
+
+	/* Even if the file doesn't exist, cache this fact so we don't
+	 * try and fail every time.  */
+	if (imsi) {
+		path =3D g_strdup_printf(SIM_CACHE_PATH ".info", imsi, fileid);
+		if (create_dirs(path, SIM_CACHE_MODE | S_IXUSR) =3D=3D 0)
+			fd =3D open(path, O_WRONLY | O_CREAT, SIM_CACHE_MODE);
+		g_free(path);
+
+		if (fd =3D=3D -1) {
+			ofono_debug("Error %i creating cache file for "
+					"fileid %04x, IMSI %s",
+					errno, fileid, imsi);
+			return;
+		}
+
+		fileinfo[0] =3D error->type;
+		fileinfo[1] =3D file_length >> 8;
+		fileinfo[2] =3D file_length & 0xff;
+		fileinfo[3] =3D structure;
+		fileinfo[4] =3D record_length >> 8;
+		fileinfo[5] =3D record_length & 0xff;
+
+		write(fd, fileinfo, 6);
+		close(fd);
+	}
+}
+
+static void read_file_info_cached(struct ofono_modem *modem, int fileid,
+		ofono_sim_file_info_cb_t cb, void *data)
+{
+	char *path;
+	char *imsi =3D modem->sim_manager->imsi;
+	int fd;
+	unsigned char fileinfo[6];
+	ssize_t len;
+	struct ofono_error error;
+	int file_length;
+	enum ofono_sim_file_structure structure;
+	int record_length;
+	struct sim_cache_callback *cbs;
+
+	if (!imsi)
+		goto uncached;
+
+	path =3D g_strdup_printf(SIM_CACHE_PATH ".info", imsi, fileid);
+	fd =3D open(path, O_RDONLY);
+	g_free(path);
+
+	if (fd =3D=3D -1) {
+		if (errno !=3D ENOENT)
+			ofono_debug("Error %i opening cache file for "
+					"fileid %04x, IMSI %s",
+					errno, fileid, imsi);
+
+		goto uncached;
+	}
+
+	len =3D read(fd, fileinfo, 6);
+	close(fd);
+
+	if (len =3D=3D 6) {
+		error.type =3D fileinfo[0];
+		file_length =3D (fileinfo[1] << 8) | fileinfo[2];
+		structure =3D fileinfo[3];
+		record_length =3D (fileinfo[4] << 8) | fileinfo[5];
+
+		return cb(&error, file_length, structure, record_length, data);
+	}
+
+uncached:
+	cbs =3D g_new(struct sim_cache_callback, 1);
+	cbs->sim =3D modem->sim_manager;
+	cbs->cb =3D cb;
+	cbs->data =3D data;
+	cbs->fileid =3D fileid;
+	return modem->sim_manager->ops->read_file_info(modem,
+			fileid, read_file_info_cached_cb, cbs);
+}
+
+static void read_file_linear_cached_cb(const struct ofono_error *error,
+		const unsigned char *buffer, int length, void *data)
+{
+	struct sim_cache_callback *cbs =3D data;
+	ofono_sim_read_cb_t cb =3D cbs->cb;
+	char *path;
+	char *imsi =3D cbs->sim->imsi;
+	int fd =3D -1, fileid, ret, record;
+
+	cb(error, buffer, length, cbs->data);
+
+	fileid =3D cbs->fileid;
+	record =3D cbs->record;
+	g_free(cbs);
+
+	/* If read was successful, store the record contents */
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR && imsi) {
+		path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, fileid);
+		if (create_dirs(path, SIM_CACHE_MODE | S_IXUSR) =3D=3D 0)
+			fd =3D open(path, O_WRONLY | O_CREAT, SIM_CACHE_MODE);
+		g_free(path);
+
+		if (fd =3D=3D -1)
+			return;
+
+		if (!record || lseek(fd, length * record, SEEK_SET) !=3D
+				(off_t) -1)
+			write(fd, buffer, length);
+		close(fd);
+	}
+}
+
+static void read_file_linear_cached(struct ofono_modem *modem, int fileid,
+		int record, int length, ofono_sim_read_cb_t cb, void *data)
+{
+	char *path;
+	char *imsi =3D modem->sim_manager->imsi;
+	int fd;
+	unsigned char buffer[length];
+	ssize_t rlength =3D 0;
+	struct ofono_error error;
+	struct sim_cache_callback *cbs;
+
+	if (!imsi)
+		goto uncached;
+
+	path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, fileid);
+	fd =3D open(path, O_RDONLY);
+	g_free(path);
+
+	if (fd =3D=3D -1) {
+		if (errno !=3D ENOENT)
+			ofono_debug("Error %i opening cache file for "
+					"fileid %04x, IMSI %s", fileid, imsi);
+
+		goto uncached;
+	}
+
+	if (!record || lseek(fd, length * record, SEEK_SET) !=3D (off_t) -1)
+		rlength =3D read(fd, buffer, length);
+	close(fd);
+
+	if (rlength =3D=3D length) {
+		error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		return cb(&error, buffer, length, data);
+	}
+
+uncached:
+	cbs =3D g_new(struct sim_cache_callback, 1);
+	cbs->sim =3D modem->sim_manager;
+	cbs->cb =3D cb;
+	cbs->data =3D data;
+	cbs->fileid =3D fileid;
+	cbs->record =3D record;
+	return modem->sim_manager->ops->read_file_linear(modem, fileid,
+			record, length, read_file_linear_cached_cb, cbs);
+}
+
 static char **get_own_numbers(GSList *own_numbers)
 {
 	int nelem =3D 0;
@@ -762,7 +979,7 @@ static void sim_opl_read_cb(const struct ofono_error *e=
rror,
 skip:
 	sim->opl_current ++;
 	if (sim->opl_current < sim->opl_num)
-		sim->ops->read_file_linear(modem, SIM_EFOPL_FILEID,
+		read_file_linear_cached(modem, SIM_EFOPL_FILEID,
 						sim->opl_current,
 						sim->opl_size,
 						sim_opl_read_cb, modem);
@@ -787,7 +1004,7 @@ static void sim_opl_info_cb(const struct ofono_error *=
error, int length,
 	sim->opl_current =3D 0;
 	sim->opl_size =3D record_length;
 	sim->opl_num =3D length / record_length;
-	sim->ops->read_file_linear(modem, SIM_EFOPL_FILEID, 0,
+	read_file_linear_cached(modem, SIM_EFOPL_FILEID, 0,
 			record_length, sim_opl_read_cb, modem);
 }
 =

@@ -796,7 +1013,7 @@ static gboolean sim_retrieve_opl(void *user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct sim_manager_data *sim =3D modem->sim_manager;
 =

-	sim->ops->read_file_info(modem, SIM_EFOPL_FILEID,
+	read_file_info_cached(modem, SIM_EFOPL_FILEID,
 			sim_opl_info_cb, modem);
 =

 	return FALSE;
@@ -861,7 +1078,7 @@ static void sim_pnn_read_cb(const struct ofono_error *=
error,
 skip:
 	sim->pnn_current ++;
 	if (sim->pnn_current < sim->pnn_num)
-		sim->ops->read_file_linear(modem, SIM_EFPNN_FILEID,
+		read_file_linear_cached(modem, SIM_EFPNN_FILEID,
 						sim->pnn_current,
 						sim->pnn_size,
 						sim_pnn_read_cb, modem);
@@ -892,7 +1109,7 @@ static void sim_pnn_info_cb(const struct ofono_error *=
error, int length,
 	sim->pnn_size =3D record_length;
 	sim->pnn_num =3D length / record_length;
 	sim->pnn =3D g_new0(struct pnn_operator, sim->pnn_num);
-	sim->ops->read_file_linear(modem, SIM_EFPNN_FILEID, 0,
+	read_file_linear_cached(modem, SIM_EFPNN_FILEID, 0,
 			record_length, sim_pnn_read_cb, modem);
 }
 =

@@ -901,7 +1118,7 @@ static gboolean sim_retrieve_pnn(void *user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct sim_manager_data *sim =3D modem->sim_manager;
 =

-	sim->ops->read_file_info(modem, SIM_EFPNN_FILEID,
+	read_file_info_cached(modem, SIM_EFPNN_FILEID,
 			sim_pnn_info_cb, modem);
 =

 	return FALSE;
@@ -940,8 +1157,10 @@ static void initialize_sim_manager(struct ofono_modem=
 *modem)
 	if (modem->sim_manager->ops->read_file_transparent)
 		g_timeout_add(0, sim_retrieve_spdi, modem);
 =

+	/* Schedule later than IMSI so that there's a chance we can
+	 * use SIM cache, which is IMSI-indexed.  */
 	if (modem->sim_manager->ops->read_file_linear)
-		g_timeout_add(0, sim_retrieve_pnn, modem);
+		g_timeout_add_seconds(1, sim_retrieve_pnn, modem);
 }
 =

 int ofono_sim_manager_register(struct ofono_modem *modem,
-- =

1.6.0


--===============3343143095998753530==--

