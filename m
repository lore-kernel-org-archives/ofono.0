Content-Type: multipart/mixed; boundary="===============1879936051282935886=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 7/7] hfp_ag_bluez5: Remove unused includes
Date: Mon, 15 Apr 2013 18:41:50 -0300
Message-ID: <1366062110-28031-8-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366062110-28031-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1879936051282935886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 3b76179..f9e7dff 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -29,17 +29,13 @@
 #include <sys/socket.h>
 #include <glib.h>
 #include <ofono.h>
-
 #include <gdbus.h>
-#include <gatchat.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
 =

-#include <drivers/hfpmodem/slc.h>
-
 #include "hfp.h"
 #include "bluez5.h"
 =

-- =

1.7.9.5


--===============1879936051282935886==--

