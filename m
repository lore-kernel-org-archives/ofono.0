Content-Type: multipart/mixed; boundary="===============0492068892329440441=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv9 06/16] lookup-apn: Remove unused includes
Date: Wed, 05 Oct 2011 16:18:29 +0300
Message-ID: <1317820719-23609-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317820719-23609-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0492068892329440441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/lookup-apn.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 2969baf..b192c7c 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -24,12 +24,7 @@
 #endif
 =

 #include <stdio.h>
-#include <fcntl.h>
-#include <unistd.h>
 #include <stdlib.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
 =

 #include <glib.h>
 =

-- =

1.7.4.1


--===============0492068892329440441==--

