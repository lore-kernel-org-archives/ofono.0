Content-Type: multipart/mixed; boundary="===============3047065467819031067=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 4/7] phonesim: Include hfp.h
Date: Mon, 15 Apr 2013 18:41:47 -0300
Message-ID: <1366062110-28031-5-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366062110-28031-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3047065467819031067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 26f96d0..b56b3ca 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -65,6 +65,7 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/hfpmodem/slc.h>
 =

+#include "hfp.h"
 #include "ofono.h"
 =

 static const char *none_prefix[] =3D { NULL };
-- =

1.7.9.5


--===============3047065467819031067==--

