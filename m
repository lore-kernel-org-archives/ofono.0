Content-Type: multipart/mixed; boundary="===============8166959746187066456=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Cache EF-PNN, EF-OPL sim files on disk.
Date: Sat, 18 Jul 2009 06:34:48 +0200
Message-ID: <1247891688-10028-1-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <200907141554.22706.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8166959746187066456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This uses plain files in /var/cache/ofono for storing contents of the
operator lists to avoid possibly numerous queries to the SIM on every
startup.  Files are indexed with IMSI.  I'm not 100% sure about the
autoconf magic.

Users need to rerun bootstrap-configure after applying this.

File format slightly changed in this second version (make it as simple as
possible).
---
 bootstrap-configure |    3 +-
 configure.ac        |    5 ++
 src/sim.c           |  193 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 200 insertions(+), 1 deletions(-)

diff --git a/bootstrap-configure b/bootstrap-configure
index cc82e1a..cea17bf 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -12,4 +12,5 @@ fi
 		--prefix=3D/usr \
 		--mandir=3D/usr/share/man \
 		--sysconfdir=3D/etc \
-		--disable-datafiles
+		--disable-datafiles \
+		--localstatedir=3D/var
diff --git a/configure.ac b/configure.ac
index 640c3cd..a7cf947 100644
--- a/configure.ac
+++ b/configure.ac
@@ -96,6 +96,11 @@ AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-dataf=
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
index 86f2e98..e3590ba 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -29,6 +29,10 @@
 #include <dbus/dbus.h>
 #include <glib.h>
 #include <gdbus.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <errno.h>
 =

 #include "ofono.h"
 =

@@ -267,6 +271,34 @@ static gboolean sim_retrieve_imsi(void *user_data)
 	return FALSE;
 }
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
 static void sim_op_error(struct ofono_modem *modem)
 {
 	struct sim_manager_data *sim =3D modem->sim_manager;
@@ -280,6 +312,11 @@ static void sim_op_error(struct ofono_modem *modem)
 		g_timeout_add(0, sim_op_next, modem);
 }
 =

+#define SIM_CACHE_MODE 0600
+#define SIM_CACHE_PATH CONFIG_LOCALSTATEDIR "/cache/ofono/%s/%04x"
+#define SIM_CACHE_PATH_LEN(imsilen) (strlen(SIM_CACHE_PATH) - 2 + imsilen)
+#define SIM_CACHE_HEADER_SIZE 6
+
 static void sim_op_retrieve_cb(const struct ofono_error *error,
 				const unsigned char *data, int len, void *user)
 {
@@ -288,6 +325,10 @@ static void sim_op_retrieve_cb(const struct ofono_erro=
r *error,
 	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
 	int total =3D op->length / op->record_length;
 =

+	char *imsi =3D sim->imsi;
+	char *path;
+	int fd, ret;
+
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		if (op->current =3D=3D 1)
 			sim_op_error(modem);
@@ -298,6 +339,23 @@ static void sim_op_retrieve_cb(const struct ofono_erro=
r *error,
 	op->cb(modem, 1, op->structure, op->length, op->current,
 		data, op->record_length, op->userdata);
 =

+	if (imsi) {
+		/* Cache the record */
+		path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, op->id);
+		fd =3D open(path, O_WRONLY);
+		g_free(path);
+
+		if (fd =3D=3D -1)
+			goto next;
+
+		if (lseek(fd, (op->current - 1) * op->record_length +
+					SIM_CACHE_HEADER_SIZE, SEEK_SET) !=3D
+				(off_t) -1)
+			write(fd, data, op->record_length);
+		close(fd);
+	}
+
+next:
 	if (op->current =3D=3D total) {
 		op =3D g_queue_pop_head(sim->simop_q);
 =

@@ -362,6 +420,38 @@ static void sim_op_info_cb(const struct ofono_error *e=
rror, int length,
 	struct sim_manager_data *sim =3D modem->sim_manager;
 	struct sim_file_op *op =3D g_queue_peek_head(sim->simop_q);
 =

+	char *imsi =3D sim->imsi;
+	char *path;
+	unsigned char fileinfo[6];
+	int fd =3D -1;
+
+	/* Even if the file doesn't exist, cache this fact so we don't
+	 * try and fail every time.  */
+	if (imsi) {
+		path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, op->id);
+		if (create_dirs(path, SIM_CACHE_MODE | S_IXUSR) =3D=3D 0)
+			fd =3D open(path, O_WRONLY | O_CREAT, SIM_CACHE_MODE);
+		g_free(path);
+
+		if (fd =3D=3D -1) {
+			ofono_debug("Error %i creating cache file for "
+					"fileid %04x, IMSI %s",
+					errno, op->id, imsi);
+			goto process_result;
+		}
+
+		fileinfo[0] =3D error->type;
+		fileinfo[1] =3D length >> 8;
+		fileinfo[2] =3D length & 0xff;
+		fileinfo[3] =3D structure;
+		fileinfo[4] =3D record_length >> 8;
+		fileinfo[5] =3D record_length & 0xff;
+
+		write(fd, fileinfo, 6);
+		close(fd);
+	}
+
+process_result:
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		sim_op_error(modem);
 		return;
@@ -396,6 +486,106 @@ static gboolean sim_op_next(gpointer user_data)
 	return FALSE;
 }
 =

+struct sim_cache_callback {
+	ofono_sim_file_read_cb_t cb;
+	void *userdata;
+	struct ofono_modem *modem;
+	int error;
+	int fd;
+	enum ofono_sim_file_structure structure;
+	unsigned int record_length;
+	unsigned int total;
+};
+
+static gboolean sim_op_cached_callback(gpointer user)
+{
+	struct sim_cache_callback *cbs =3D user;
+	guint8 buffer[cbs->record_length];
+	unsigned int record;
+
+	if (cbs->error !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		cbs->cb(cbs->modem, 0, 0, 0, 0, 0, 0, 0);
+		goto cleanup;
+	}
+
+	for (record =3D 0; record < cbs->total; record++) {
+		if (read(cbs->fd, buffer, cbs->record_length) <
+				(int) cbs->record_length) {
+			cbs->cb(cbs->modem, 0, 0, 0, 0, 0, 0, 0);
+			break;
+		}
+
+		cbs->cb(cbs->modem, 1, cbs->structure,
+				cbs->record_length * cbs->total, record + 1,
+				buffer, cbs->record_length, cbs->userdata);
+	}
+
+cleanup:
+	close(cbs->fd);
+	g_free(cbs);
+
+	return FALSE;
+}
+
+static gboolean sim_op_check_cached(struct ofono_modem *modem, int fileid,
+			ofono_sim_file_read_cb_t cb, void *data)
+{
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	char *imsi =3D sim->imsi;
+	char *path;
+	int fd;
+	unsigned char fileinfo[SIM_CACHE_HEADER_SIZE];
+	ssize_t len;
+	struct ofono_error error;
+	unsigned int file_length;
+	enum ofono_sim_file_structure structure;
+	unsigned int record_length;
+	struct sim_cache_callback *cbs;
+
+	if (!imsi)
+		return FALSE;
+
+	path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, fileid);
+	fd =3D open(path, O_RDONLY);
+	g_free(path);
+
+	if (fd =3D=3D -1) {
+		if (errno !=3D ENOENT)
+			ofono_debug("Error %i opening cache file for "
+					"fileid %04x, IMSI %s",
+					errno, fileid, imsi);
+
+		return FALSE;
+	}
+
+	len =3D read(fd, fileinfo, SIM_CACHE_HEADER_SIZE);
+	if (len !=3D SIM_CACHE_HEADER_SIZE)
+		return FALSE;
+
+	error.type =3D fileinfo[0];
+	file_length =3D (fileinfo[1] << 8) | fileinfo[2];
+	structure =3D fileinfo[3];
+	record_length =3D (fileinfo[4] << 8) | fileinfo[5];
+
+	if (structure =3D=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
+		record_length =3D file_length;
+	if (record_length =3D=3D 0 || file_length < record_length)
+		return FALSE;
+
+	cbs =3D g_new(struct sim_cache_callback, 1);
+	cbs->cb =3D cb;
+	cbs->userdata =3D data;
+	cbs->modem =3D modem;
+	cbs->error =3D error.type;
+	cbs->fd =3D fd;
+	cbs->structure =3D structure;
+	cbs->record_length =3D record_length;
+	cbs->total =3D file_length / record_length;
+	g_timeout_add(0, sim_op_cached_callback, cbs);
+
+	return TRUE;
+}
+
 int ofono_sim_read(struct ofono_modem *modem, int id,
 			ofono_sim_file_read_cb_t cb, void *data)
 {
@@ -408,6 +598,9 @@ int ofono_sim_read(struct ofono_modem *modem, int id,
 	if (modem->sim_manager =3D=3D NULL)
 		return -1;
 =

+	if (sim_op_check_cached(modem, id, cb, data))
+		return 0;
+
 	if (!sim->ops)
 		return -1;
 =

-- =

1.6.0


--===============8166959746187066456==--

