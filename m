Content-Type: multipart/mixed; boundary="===============2214091832871832232=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 08/13] storage: add __attribute__((format)) to {write,
 read}_file() for printf-like variable arg verification
Date: Wed, 26 May 2010 12:49:22 -0700
Message-ID: <dd78ba7c6214fd27cf945f4a5a3979107adbbeb0.1274903142.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2214091832871832232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 src/storage.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/storage.h b/src/storage.h
index d74de35..74cbba5 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -30,10 +30,12 @@
 int create_dirs(const char *filename, const mode_t mode);
 =

 ssize_t read_file(unsigned char *buffer, size_t len,
-			const char *path_fmt, ...);
+			const char *path_fmt, ...)
+	__attribute__((format(printf, 3, 4)));
 =

 ssize_t write_file(const unsigned char *buffer, size_t len, mode_t mode,
-			const char *path_fmt, ...);
+			const char *path_fmt, ...)
+	__attribute__((format(printf, 4, 5)));
 =

 GKeyFile *storage_open(const char *imsi, const char *store);
 void storage_sync(const char *imsi, const char *store, GKeyFile *keyfile);
-- =

1.6.6.1


--===============2214091832871832232==--

