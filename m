Content-Type: multipart/mixed; boundary="===============3921321627149044855=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv10 1/9] mbpi: Minor style tweaks
Date: Tue, 18 Oct 2011 14:04:57 +0300
Message-ID: <1318935905-9087-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1318935905-9087-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3921321627149044855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index ecb08eb..c5537d8 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -23,12 +23,13 @@
 #include <config.h>
 #endif
 =

-#include <string.h>
-#include <fcntl.h>
+#include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
-#include <sys/types.h>
+
+#include <fcntl.h>
 #include <errno.h>
+#include <string.h>
 #include <unistd.h>
 =

 #include <glib.h>
-- =

1.7.4.1


--===============3921321627149044855==--

