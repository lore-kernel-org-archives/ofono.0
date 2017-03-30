Content-Type: multipart/mixed; boundary="===============1726888163188751533=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 24/28] udevng: drop unused headers
Date: Thu, 30 Mar 2017 22:53:05 +0200
Message-ID: <20170330205309.25850-25-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1726888163188751533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1fe7d34..2d9ddbe 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -24,9 +24,7 @@
 #endif
 =

 #include <errno.h>
-#include <ctype.h>
 #include <stdlib.h>
-#include <string.h>
 =

 #include <libudev.h>
 =

-- =

2.9.3


--===============1726888163188751533==--

