Content-Type: multipart/mixed; boundary="===============7120792070431489734=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 2/2] huaweicdma: remove unneeded include.
Date: Tue, 26 Jul 2011 11:09:54 +0200
Message-ID: <1311671394-9586-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1311671394-9586-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7120792070431489734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huaweicdma.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 4f45fec..7288850 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
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
 struct huaweicdma_data {
 	GAtChat *chat;
 };
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

--===============7120792070431489734==--

