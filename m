Content-Type: multipart/mixed; boundary="===============1403356369544084872=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH] unit: rilmodem-test - add missing string.h
Date: Tue, 28 Mar 2017 11:32:42 +0100
Message-ID: <1490697162-10441-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1403356369544084872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Remove warnings of undeclared memcpy, strncpy, etc.
---
 unit/rilmodem-test-engine.c | 1 +
 unit/rilmodem-test-server.c | 1 +
 unit/test-rilmodem-cs.c     | 1 +
 unit/test-rilmodem-sms.c    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/unit/rilmodem-test-engine.c b/unit/rilmodem-test-engine.c
index c569360..7cbc1ad 100644
--- a/unit/rilmodem-test-engine.c
+++ b/unit/rilmodem-test-engine.c
@@ -29,6 +29,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
+#include <string.h>
 =

 #include <ofono/types.h>
 =

diff --git a/unit/rilmodem-test-server.c b/unit/rilmodem-test-server.c
index 17e5090..5a3b03a 100644
--- a/unit/rilmodem-test-server.c
+++ b/unit/rilmodem-test-server.c
@@ -28,6 +28,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
+#include <string.h>
 =

 #include <ofono/types.h>
 =

diff --git a/unit/test-rilmodem-cs.c b/unit/test-rilmodem-cs.c
index bfa2a72..ae7abec 100644
--- a/unit/test-rilmodem-cs.c
+++ b/unit/test-rilmodem-cs.c
@@ -32,6 +32,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
+#include <string.h>
 =

 #include <ofono/modem.h>
 #include <ofono/types.h>
diff --git a/unit/test-rilmodem-sms.c b/unit/test-rilmodem-sms.c
index 1ed1b51..70c7386 100644
--- a/unit/test-rilmodem-sms.c
+++ b/unit/test-rilmodem-sms.c
@@ -32,6 +32,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
+#include <string.h>
 =

 #include <ofono/modem.h>
 #include <ofono/types.h>
-- =

2.7.4


--===============1403356369544084872==--

