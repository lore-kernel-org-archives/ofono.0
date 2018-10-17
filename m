Content-Type: multipart/mixed; boundary="===============6972432639282204966=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/voicecall: dropped unneeded _GNU_SOURCE
Date: Wed, 17 Oct 2018 11:09:05 +0200
Message-ID: <20181017090905.24492-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6972432639282204966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index aa56f1ee..03b69971 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#define _GNU_SOURCE
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
-- =

2.17.1


--===============6972432639282204966==--

