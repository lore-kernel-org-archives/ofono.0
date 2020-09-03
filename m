Content-Type: multipart/mixed; boundary="===============0268543195578458262=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [RFC PATCH] xmm7xxx: Fix non compiling file
Date: Thu, 03 Sep 2020 11:43:21 +0200
Message-ID: <20200903094321.3696246-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0268543195578458262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

I get a compilation error on plugins/xmm7xx.c:

  CC       plugins/xmm7xxx.o
../plugins/xmm7xxx.c:63:10: fatal error: dbus.h: No such file or directory
   63 | #include "dbus.h"
      |          ^~~~~~~~
compilation terminated.

The commit that introduced this for me is: d2fd1721.
I do out-of-tree builds.
The fix is to simply delete the failing include. Since no other file in
ofono uses such an include i consider this as a mistake.
---
 plugins/xmm7xxx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index bf90833d..5efdbe26 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -60,7 +60,6 @@
 #include "ofono.h"
 #include "gdbus.h"
 #include "util.h"
-#include "dbus.h"
 =

 #define OFONO_COEX_INTERFACE OFONO_SERVICE ".intel.LteCoexistence"
 #define OFONO_COEX_AGENT_INTERFACE OFONO_SERVICE ".intel.LteCoexistenceAge=
nt"
-- =

2.28.0

--===============0268543195578458262==--

