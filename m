Content-Type: multipart/mixed; boundary="===============1143615511048357604=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] ril driver: commented out pragma\n\ngcc 4.8.4 rejects the
 line:\n#pragma GCC diagnostic ignored "-Wrestrict"\nand this breaks the
 default compilation.\nsince they may be needed for other compilers,
 \nI have just commented them out with '//', so that they stand out.
Date: Thu, 20 Sep 2018 06:00:45 +0200
Message-ID: <1537416045-10187-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1143615511048357604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/call-forwarding.c      | 2 +-
 drivers/rilmodem/network-registration.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rilmodem/call-forwarding.c b/drivers/rilmodem/call-for=
warding.c
index 4aff4d3..0bdab3f 100644
--- a/drivers/rilmodem/call-forwarding.c
+++ b/drivers/rilmodem/call-forwarding.c
@@ -38,7 +38,7 @@
 #include <ofono/call-forwarding.h>
 #include "common.h"
 =

-#pragma GCC diagnostic ignored "-Wrestrict"
+//#pragma GCC diagnostic ignored "-Wrestrict"
 =

 #include "gril.h"
 =

diff --git a/drivers/rilmodem/network-registration.c b/drivers/rilmodem/net=
work-registration.c
index 809b3bc..9895c6d 100644
--- a/drivers/rilmodem/network-registration.c
+++ b/drivers/rilmodem/network-registration.c
@@ -37,7 +37,7 @@
 #include <ofono/modem.h>
 #include <ofono/netreg.h>
 =

-#pragma GCC diagnostic ignored "-Wrestrict"
+//#pragma GCC diagnostic ignored "-Wrestrict"
 =

 #include <gril/gril.h>
 =

-- =

1.9.1


--===============1143615511048357604==--

