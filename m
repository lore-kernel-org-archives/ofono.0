Content-Type: multipart/mixed; boundary="===============5187475224245725193=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Check write() return values in sim.c for errors.
Date: Mon, 03 Aug 2009 15:38:21 +0200
Message-ID: <1249306701-13374-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5187475224245725193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d4c7dbf..90e8251 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -322,7 +322,7 @@ static void sim_op_retrieve_cb(const struct ofono_error=
 *error,
 =

 	char *imsi =3D sim->imsi;
 	char *path;
-	int fd;
+	int r =3D 0, fd;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		sim_op_error(modem);
@@ -336,7 +336,6 @@ static void sim_op_retrieve_cb(const struct ofono_error=
 *error,
 		/* Cache the record */
 		path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, op->id);
 		fd =3D open(path, O_WRONLY);
-		g_free(path);
 =

 		if (fd =3D=3D -1)
 			goto next;
@@ -344,8 +343,15 @@ static void sim_op_retrieve_cb(const struct ofono_erro=
r *error,
 		if (lseek(fd, (op->current - 1) * op->record_length +
 					SIM_CACHE_HEADER_SIZE, SEEK_SET) !=3D
 				(off_t) -1)
-			write(fd, data, op->record_length);
+			r =3D write(fd, data, op->record_length);
 		close(fd);
+
+		if (r < op->record_length) {
+			op->cache =3D 0;
+			unlink(path);
+		}
+
+		g_free(path);
 	}
 =

 next:
@@ -416,7 +422,7 @@ static void sim_op_info_cb(const struct ofono_error *er=
ror, int length,
 	char *imsi =3D sim->imsi;
 	char *path;
 	unsigned char fileinfo[6];
-	int fd =3D -1;
+	int r, fd =3D -1;
 	enum sim_file_access update;
 	enum sim_file_access invalidate;
 	enum sim_file_access rehabilitate;
@@ -454,7 +460,6 @@ static void sim_op_info_cb(const struct ofono_error *er=
ror, int length,
 		path =3D g_strdup_printf(SIM_CACHE_PATH, imsi, op->id);
 		if (create_dirs(path, SIM_CACHE_MODE | S_IXUSR) =3D=3D 0)
 			fd =3D open(path, O_WRONLY | O_CREAT, SIM_CACHE_MODE);
-		g_free(path);
 =

 		if (fd =3D=3D -1) {
 			ofono_debug("Error %i creating cache file for "
@@ -470,8 +475,15 @@ static void sim_op_info_cb(const struct ofono_error *e=
rror, int length,
 		fileinfo[4] =3D record_length >> 8;
 		fileinfo[5] =3D record_length & 0xff;
 =

-		write(fd, fileinfo, 6);
+		r =3D write(fd, fileinfo, 6);
 		close(fd);
+
+		if (r < 6) {
+			op->cache =3D 0;
+			unlink(path);
+		}
+
+		g_free(path);
 	}
 }
 =

-- =

1.6.1


--===============5187475224245725193==--

