Content-Type: multipart/mixed; boundary="===============6406663419322894542=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 5/7] hfp_ag_bluez5: Include hfp.h
Date: Mon, 15 Apr 2013 18:41:48 -0300
Message-ID: <1366062110-28031-6-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366062110-28031-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6406663419322894542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index cc59cf7..3b76179 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -40,6 +40,7 @@
 =

 #include <drivers/hfpmodem/slc.h>
 =

+#include "hfp.h"
 #include "bluez5.h"
 =

 #ifndef DBUS_TYPE_UNIX_FD
-- =

1.7.9.5


--===============6406663419322894542==--

