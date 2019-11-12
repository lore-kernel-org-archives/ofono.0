Content-Type: multipart/mixed; boundary="===============3065782825326004679=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 02/13] Replace deprecated headers
Date: Tue, 12 Nov 2019 22:37:08 +0100
Message-ID: <20191112213719.9309-3-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3065782825326004679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Done using the modernize-deprecated-headers check of clang-tidy
---
 src/main.cpp        | 2 +-
 src/phonesim.h      | 6 +++---
 src/qsmsmessage.cpp | 2 +-
 src/qwsppdu.cpp     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/main.cpp b/src/main.cpp
index b320140..712e767 100644
--- a/src/main.cpp
+++ b/src/main.cpp
@@ -22,7 +22,7 @@
 #include <qapplication.h>
 #include <qstring.h>
 #include <qdebug.h>
-#include <stdlib.h>
+#include <cstdlib>

 static void usage()
 {
diff --git a/src/phonesim.h b/src/phonesim.h
index fef97d4..65ea794 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -33,11 +33,11 @@
 #include <qpointer.h>
 #include <qsimcontrolevent.h>

-#include <string.h>
-#include <stdlib.h>
+#include <cstring>
+#include <cstdlib>
 #include <sys/types.h>
 #include <unistd.h>
-#include <signal.h>
+#include <csignal>
 #include <sys/time.h>
 #include <sys/wait.h>
 #include <sys/select.h>
diff --git a/src/qsmsmessage.cpp b/src/qsmsmessage.cpp
index ec158ef..518e542 100644
--- a/src/qsmsmessage.cpp
+++ b/src/qsmsmessage.cpp
@@ -17,7 +17,7 @@
 **
 **************************************************************************=
**/

-#include <stdlib.h>
+#include <cstdlib>

 #include <qsmsmessage.h>
 #include <qcbsmessage.h>
diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index f487a35..def5675 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -24,7 +24,7 @@
 #include <qiodevice.h>
 #include <qbuffer.h>
 #include <netinet/in.h>
-#include <stdlib.h>
+#include <cstdlib>

 // Reference: WAP-230-WSP
 //            Wireless Application Protocol
--
2.24.0

--===============3065782825326004679==--

