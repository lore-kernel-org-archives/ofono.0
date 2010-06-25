Content-Type: multipart/mixed; boundary="===============6819635844450924642=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 04/23] write_file: make transaction-safe
Date: Fri, 25 Jun 2010 16:15:26 -0700
Message-ID: <a283c18ee155df3cbd35b94a448cbfa0002c54e2.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6819635844450924642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

write_file(), as written wasn't transaction-safe; a crash bewtween a
file being open and the buffer being written before a safe close would
leave the file with a set of undetermined contents.

Modified to the file is written to a temporary file name; once
completed, it is renamed to the final name. This way, a crash in the
middle doesn't leave half-baked files.
---
 src/storage.c |   42 +++++++++++++++++++++++++++++++-----------
 1 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index cac5835..b8451de 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -98,11 +98,21 @@ ssize_t read_file(unsigned char *buffer, size_t len,
 	return r;
 }
 =

+/* =

+ * Write a buffer to a file in a transactionally safe form
+ *
+ * Given a buffer, write it to a file named after
+ * @path_fmt+args. However, to make sure the file contents are
+ * consistent (ie: a crash right after opening or during write()
+ * doesn't leave a file half baked), the contents are written to a
+ * file with a temporary name and when closed, it is renamed to the
+ * specified name (@path_fmt+args).
+ */ =

 ssize_t write_file(const unsigned char *buffer, size_t len, mode_t mode,
 			const char *path_fmt, ...)
 {
 	va_list ap;
-	char *path;
+	char *tmp_path, *path;
 	ssize_t r;
 	int fd;
 =

@@ -110,26 +120,36 @@ ssize_t write_file(const unsigned char *buffer, size_=
t len, mode_t mode,
 	path =3D g_strdup_vprintf(path_fmt, ap);
 	va_end(ap);
 =

-	if (create_dirs(path, mode | S_IXUSR) !=3D 0) {
-		g_free(path);
-		return -1;
-	}
+	tmp_path =3D g_strdup_printf("%s.XXXXXX.tmp", path);
 =

-	fd =3D TFR(open(path, O_WRONLY | O_CREAT | O_TRUNC, mode));
-	if (fd =3D=3D -1) {
-		g_free(path);
-		return -1;
-	}
+	r =3D -1;
+	if (create_dirs(path, mode | S_IXUSR) !=3D 0)
+		goto error_create_dirs;
+	fd =3D TFR(g_mkstemp_full(tmp_path, O_WRONLY | O_CREAT | O_TRUNC, mode));
+	if (fd =3D=3D -1)
+		goto error_mkstemp_full;
 =

 	r =3D TFR(write(fd, buffer, len));
 =

 	TFR(close(fd));
 =

 	if (r !=3D (ssize_t) len) {
-		unlink(path);
 		r =3D -1;
+		goto error_write;
 	}
 =

+	/* Now that the file contents are written, rename to the real
+	 * file name; this way we are uniquely sure that the whole
+	 * thing is there. */
+	unlink(path);
+	/* conserve @r's value from 'write' */
+	if (link(tmp_path, path) =3D=3D -1)
+		r =3D -1;
+error_write:
+	unlink(tmp_path);
+error_mkstemp_full:
+error_create_dirs:
+	g_free(tmp_path);		=

 	g_free(path);
 	return r;
 }
-- =

1.6.6.1


--===============6819635844450924642==--

