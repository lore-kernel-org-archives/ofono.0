Content-Type: multipart/mixed; boundary="===============4073797585874963813=="
MIME-Version: 1.0
From: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] src/storage.h: include unistd.h
Date: Fri, 04 Jan 2013 10:21:44 -0800
Message-ID: <1357323704-2610-1-git-send-email-raj.khem@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4073797585874963813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ssize_t is otherwise reported as undefined when compiling ofono
with glibc 2.17

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 src/storage.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/storage.h b/src/storage.h
index c455bae..dbb51bc 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -26,6 +26,7 @@
 #endif
 =

 #include <fcntl.h>
+#include <unistd.h>
 =

 int create_dirs(const char *filename, const mode_t mode);
 =

-- =

1.7.9.5


--===============4073797585874963813==--

