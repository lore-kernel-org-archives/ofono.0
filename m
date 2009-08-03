Content-Type: multipart/mixed; boundary="===============7065924988281302560=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Loop on EINTR returned from file io calls in sim.c
Date: Mon, 03 Aug 2009 15:38:49 +0200
Message-ID: <1249306729-13403-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7065924988281302560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 90e8251..b437b75 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -23,6 +23,9 @@
 #include <config.h>
 #endif
 =

+#define _GNU_SOURCE
+#include <unistd.h>
+
 #include <string.h>
 #include <stdio.h>
 =

@@ -32,7 +35,6 @@
 #include <sys/types.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <unistd.h>
 =

 #include "ofono.h"
 =

@@ -45,6 +47,12 @@
 =

 #define SIM_MANAGER_INTERFACE "org.ofono.SimManager"
 =

+#ifdef TEMP_FAILURE_RETRY
+#define TFR TEMP_FAILURE_RETRY
+#else
+#define TFR
+#endif
+
 static gboolean sim_op_next(gpointer user_data);
 static gboolean sim_op_retrieve_next(gpointer user);
 =

@@ -335,7 +343,7 @@ static void sim_op_retrieve_cb(const struct ofono_error=
 *error,
 	if (op->cache && imsi) {
 		/* Cache the record */
 		path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, op->id);
-		fd =3D open(path, O_WRONLY);
+		fd =3D TFR(open(path, O_WRONLY));
 =

 		if (fd =3D=3D -1)
 			goto next;
@@ -343,8 +351,8 @@ static void sim_op_retrieve_cb(const struct ofono_error=
 *error,
 		if (lseek(fd, (op->current - 1) * op->record_length +
 					SIM_CACHE_HEADER_SIZE, SEEK_SET) !=3D
 				(off_t) -1)
-			r =3D write(fd, data, op->record_length);
-		close(fd);
+			r =3D TFR(write(fd, data, op->record_length));
+		TFR(close(fd));
 =

 		if (r < op->record_length) {
 			op->cache =3D 0;
@@ -459,7 +467,8 @@ static void sim_op_info_cb(const struct ofono_error *er=
ror, int length,
 	if (op->cache && imsi) {
 		path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, op->id);
 		if (create_dirs(path, SIM_CACHE_MODE | S_IXUSR) =3D=3D 0)
-			fd =3D open(path, O_WRONLY | O_CREAT, SIM_CACHE_MODE);
+			fd =3D TFR(open(path, O_WRONLY | O_CREAT,
+						SIM_CACHE_MODE));
 =

 		if (fd =3D=3D -1) {
 			ofono_debug("Error %i creating cache file for "
@@ -475,8 +484,8 @@ static void sim_op_info_cb(const struct ofono_error *er=
ror, int length,
 		fileinfo[4] =3D record_length >> 8;
 		fileinfo[5] =3D record_length & 0xff;
 =

-		r =3D write(fd, fileinfo, 6);
-		close(fd);
+		r =3D TFR(write(fd, fileinfo, 6));
+		TFR(close(fd));
 =

 		if (r < 6) {
 			op->cache =3D 0;
@@ -571,7 +580,7 @@ static gboolean sim_op_cached_callback(gpointer user)
 	}
 =

 	for (record =3D 0; record < cbs->total; record++) {
-		if (read(cbs->fd, buffer, cbs->record_length) <
+		if (TFR(read(cbs->fd, buffer, cbs->record_length)) <
 				(int) cbs->record_length) {
 			cbs->cb(cbs->modem, 0, 0, 0, 0, 0, 0, 0);
 			break;
@@ -583,7 +592,7 @@ static gboolean sim_op_cached_callback(gpointer user)
 	}
 =

 cleanup:
-	close(cbs->fd);
+	TFR(close(cbs->fd));
 	g_free(cbs);
 =

 	return FALSE;
@@ -608,7 +617,7 @@ static gboolean sim_op_check_cached(struct ofono_modem =
*modem, int fileid,
 		return FALSE;
 =

 	path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, fileid);
-	fd =3D open(path, O_RDONLY);
+	fd =3D TFR(open(path, O_RDONLY));
 	g_free(path);
 =

 	if (fd =3D=3D -1) {
@@ -620,7 +629,7 @@ static gboolean sim_op_check_cached(struct ofono_modem =
*modem, int fileid,
 		return FALSE;
 	}
 =

-	len =3D read(fd, fileinfo, SIM_CACHE_HEADER_SIZE);
+	len =3D TFR(read(fd, fileinfo, SIM_CACHE_HEADER_SIZE));
 	if (len !=3D SIM_CACHE_HEADER_SIZE)
 		return FALSE;
 =

-- =

1.6.1


--===============7065924988281302560==--

