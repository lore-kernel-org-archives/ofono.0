Content-Type: multipart/mixed; boundary="===============4669369001717499947=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 2/2] storage: Implement ofono_config_dir and ofono_storage_dir
Date: Mon, 27 Nov 2017 12:31:39 +0200
Message-ID: <1511778699-32054-2-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1511778699-32054-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4669369001717499947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/storage.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/storage.c b/src/storage.c
index bde0bea..9b7bfbc 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -23,6 +23,8 @@
 #include <config.h>
 #endif
 =

+#include <ofono/storage.h>
+
 #define _GNU_SOURCE
 #include <string.h>
 #include <stdarg.h>
@@ -35,6 +37,16 @@
 =

 #include "storage.h"
 =

+const char *ofono_config_dir(void)
+{
+	return CONFIGDIR;
+}
+
+const char *ofono_storage_dir(void)
+{
+	return STORAGEDIR;
+}
+
 int create_dirs(const char *filename, const mode_t mode)
 {
 	struct stat st;
-- =

1.9.1


--===============4669369001717499947==--

