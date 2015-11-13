Content-Type: multipart/mixed; boundary="===============2164034823005833504=="
MIME-Version: 1.0
From: Petr Vorel <petr.vorel@gmail.com>
Subject: [PATCH] gobi: Add missing _GNU_SOURCE
Date: Sat, 14 Nov 2015 00:00:48 +0100
Message-ID: <1447455648-5917-1-git-send-email-petr.vorel@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2164034823005833504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

as we're using O_CLOEXEC

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 plugins/gobi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 4daa459..061ee04 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -23,6 +23,7 @@
 #include <config.h>
 #endif
 =

+#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
-- =

1.8.0


--===============2164034823005833504==--

