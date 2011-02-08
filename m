Content-Type: multipart/mixed; boundary="===============0973790370124029482=="
MIME-Version: 1.0
From: Kai Vehmanen <kai.vehmanen@nokia.com>
Subject: [RFC 1/1] storage: make write_file synchronous with fsync
Date: Tue, 08 Feb 2011 13:47:52 +0200
Message-ID: <1297165672-3217-2-git-send-email-kai.vehmanen@nokia.com>
In-Reply-To: <1297165672-3217-1-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0973790370124029482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kai Vehmanen <kai.vehmanen@nokia.com>

Extend the implementation to perform data flushing in addition
to being transactionally safe.

An explicit fsync() is needed as neither close() nor rename()
guarantee the file data is flushed from kernel buffers.
---
 src/storage.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 530439d..0b84f69 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -106,7 +106,9 @@ ssize_t read_file(unsigned char *buffer, size_t len,
  * consistent (ie: a crash right after opening or during write()
  * doesn't leave a file half baked), the contents are written to a
  * file with a temporary name and when closed, it is renamed to the
- * specified name (@path_fmt+args).
+ * specified name (@path_fmt+args). Operation is also synchronous,
+ * guaranteeing data is flushed from kernel buffers (e.g. with
+ * fsync()) before returning.
  */
 ssize_t write_file(const unsigned char *buffer, size_t len, mode_t mode,
 			const char *path_fmt, ...)
@@ -132,6 +134,13 @@ ssize_t write_file(const unsigned char *buffer, size_t=
 len, mode_t mode,
 =

 	r =3D TFR(write(fd, buffer, len));
 =

+	/**
+	 * Make sure file contents are flushed from kernel buffers
+	 * before renaming. fsyncdata() would be sufficient, but let's
+	 * be more portable and just use fsync().
+	 */
+	TFR(fsync(fd));
+
 	TFR(close(fd));
 =

 	if (r !=3D (ssize_t) len) {
-- =

1.7.0.4


--===============0973790370124029482==--

