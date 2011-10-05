Content-Type: multipart/mixed; boundary="===============7343308390417064539=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 01/16] mbpi: Remove unused includes
Date: Wed, 05 Oct 2011 16:18:24 +0300
Message-ID: <1317820719-23609-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7343308390417064539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/mbpi.c b/plugins/mbpi.c
index 683ce03..91c1ce0 100644
--- a/plugins/mbpi.c
+++ b/plugins/mbpi.c
@@ -23,12 +23,12 @@
 #include <config.h>
 #endif
 =

-#include <string.h>
-#include <fcntl.h>
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


--===============7343308390417064539==--

