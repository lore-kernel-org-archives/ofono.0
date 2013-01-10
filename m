Content-Type: multipart/mixed; boundary="===============4911498069442342682=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/4] storage: Include sys/types.h for ssize_t
Date: Thu, 10 Jan 2013 13:28:09 -0200
Message-ID: <1357831689-28679-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1357831689-28679-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4911498069442342682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

src/storage.h:32:1: error: unknown type name 'ssize_t'
src/storage.h:36:1: error: unknown type name 'ssize_t'
---
 src/storage.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/storage.h b/src/storage.h
index c455bae..70446ad 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -26,6 +26,7 @@
 #endif
 =

 #include <fcntl.h>
+#include <sys/types.h>
 =

 int create_dirs(const char *filename, const mode_t mode);
 =

-- =

1.8.1


--===============4911498069442342682==--

