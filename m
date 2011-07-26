Content-Type: multipart/mixed; boundary="===============5358327117680035961=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 1/2] speedupcdma: remove unneeded include.
Date: Tue, 26 Jul 2011 11:09:53 +0200
Message-ID: <1311671394-9586-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5358327117680035961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedupcdma.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
index b7e54a1..d11afb7 100644
--- a/plugins/speedupcdma.c
+++ b/plugins/speedupcdma.c
@@ -23,7 +23,6 @@
 #include <config.h>
 #endif
 =

-#include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
 =

@@ -38,8 +37,6 @@
 #include <ofono/cdma-connman.h>
 #include <ofono/log.h>
 =

-#include <drivers/atmodem/atutil.h>
-
 static const char *none_prefix[] =3D { NULL };
 =

 struct speedupcdma_data {
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5358327117680035961==--

