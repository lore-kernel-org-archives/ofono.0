Content-Type: multipart/mixed; boundary="===============1107626390706445563=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 01/10] gril: Move parcel processing to rilmodem
Date: Thu, 15 Oct 2015 18:46:54 +0200
Message-ID: <1444927623-31141-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444927623-31141-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1107626390706445563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move parcel creation/parsing from gril to rilmodem driver to make gril
more driver-agnostic.
---
 Makefile.am                                         | 14 +++++++++-----
 {gril =3D> drivers/rilmodem}/ril_constants.h          |  0
 gril/grilreply.c =3D> drivers/rilmodem/rilreply.c     |  4 ++--
 gril/grilreply.h =3D> drivers/rilmodem/rilreply.h     |  1 +
 gril/grilrequest.c =3D> drivers/rilmodem/rilrequest.c |  3 ++-
 gril/grilrequest.h =3D> drivers/rilmodem/rilrequest.h |  1 +
 gril/grilunsol.c =3D> drivers/rilmodem/rilunsol.c     |  3 ++-
 gril/grilunsol.h =3D> drivers/rilmodem/rilunsol.h     |  1 +
 8 files changed, 18 insertions(+), 9 deletions(-)
 rename {gril =3D> drivers/rilmodem}/ril_constants.h (100%)
 rename gril/grilreply.c =3D> drivers/rilmodem/rilreply.c (99%)
 rename gril/grilreply.h =3D> drivers/rilmodem/rilreply.h (99%)
 rename gril/grilrequest.c =3D> drivers/rilmodem/rilrequest.c (99%)
 rename gril/grilrequest.h =3D> drivers/rilmodem/rilrequest.h (99%)
 rename gril/grilunsol.c =3D> drivers/rilmodem/rilunsol.c (99%)
 rename gril/grilunsol.h =3D> drivers/rilmodem/rilunsol.h (98%)

diff --git a/Makefile.am b/Makefile.am
index 3ad1302..35ec7ce 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -99,10 +99,7 @@ gril_sources =3D gril/gril.h gril/gril.c gril/grilio.h \
 				gril/grilio.c gril/grilutil.h \
 				gril/grilutil.c gril/ringbuffer.h \
 				gril/gfunc.h gril/ril.h \
-				gril/parcel.c gril/parcel.h \
-				gril/grilreply.c gril/grilreply.h \
-				gril/grilrequest.c gril/grilrequest.h \
-				gril/grilunsol.c gril/grilunsol.h
+				gril/parcel.c gril/parcel.h
 =

 btio_sources =3D btio/btio.h btio/btio.c
 =

@@ -146,7 +143,14 @@ builtin_sources +=3D drivers/rilmodem/rilmodem.h \
 			drivers/rilmodem/call-settings.c \
 			drivers/rilmodem/call-forwarding.c \
 			drivers/rilmodem/radio-settings.c \
-			drivers/rilmodem/call-barring.c
+			drivers/rilmodem/call-barring.c \
+			drivers/rilmodem/drivers/ril_constants.h \
+			drivers/rilmodem/rilreply.c \
+			drivers/rilmodem/rilreply.h \
+			drivers/rilmodem/rilrequest.c \
+			drivers/rilmodem/rilrequest.h \
+			drivers/rilmodem/rilunsol.c \
+			drivers/rilmodem/rilunsol.h
 endif
 =

 if ISIMODEM
diff --git a/gril/ril_constants.h b/drivers/rilmodem/ril_constants.h
similarity index 100%
rename from gril/ril_constants.h
rename to drivers/rilmodem/ril_constants.h
diff --git a/gril/grilreply.c b/drivers/rilmodem/rilreply.c
similarity index 99%
rename from gril/grilreply.c
rename to drivers/rilmodem/rilreply.c
index 8792f47..9ac9ea6 100644
--- a/gril/grilreply.c
+++ b/drivers/rilmodem/rilreply.c
@@ -40,8 +40,8 @@
 =

 #include "common.h"
 #include "util.h"
-#include "grilreply.h"
-#include "grilutil.h"
+#include "rilreply.h"
+#include "rilutil.h"
 =

 #define OPERATOR_NUM_PARAMS 3
 =

diff --git a/gril/grilreply.h b/drivers/rilmodem/rilreply.h
similarity index 99%
rename from gril/grilreply.h
rename to drivers/rilmodem/rilreply.h
index b419762..ef6a980 100644
--- a/gril/grilreply.h
+++ b/drivers/rilmodem/rilreply.h
@@ -26,6 +26,7 @@
 #include <ofono/types.h>
 #include <ofono/sim.h>
 =

+#include "ril_constants.h"
 #include "gril.h"
 =

 #ifdef __cplusplus
diff --git a/gril/grilrequest.c b/drivers/rilmodem/rilrequest.c
similarity index 99%
rename from gril/grilrequest.c
rename to drivers/rilmodem/rilrequest.c
index a0a0540..ad37fce 100644
--- a/gril/grilrequest.c
+++ b/drivers/rilmodem/rilrequest.c
@@ -36,10 +36,11 @@
 #include <ofono/modem.h>
 #include <ofono/gprs-context.h>
 =

-#include "grilrequest.h"
+#include "rilrequest.h"
 #include "simutil.h"
 #include "util.h"
 #include "common.h"
+#include "rilutil.h"
 =

 /* DEACTIVATE_DATA_CALL request parameters */
 #define DEACTIVATE_DATA_CALL_NUM_PARAMS 2
diff --git a/gril/grilrequest.h b/drivers/rilmodem/rilrequest.h
similarity index 99%
rename from gril/grilrequest.h
rename to drivers/rilmodem/rilrequest.h
index 1de214e..1485524 100644
--- a/gril/grilrequest.h
+++ b/drivers/rilmodem/rilrequest.h
@@ -28,6 +28,7 @@
 #include <ofono/modem.h>
 #include <ofono/sim.h>
 =

+#include "ril_constants.h"
 #include "gril.h"
 =

 #ifdef __cplusplus
diff --git a/gril/grilunsol.c b/drivers/rilmodem/rilunsol.c
similarity index 99%
rename from gril/grilunsol.c
rename to drivers/rilmodem/rilunsol.c
index 9fd8900..3b844f6 100644
--- a/gril/grilunsol.c
+++ b/drivers/rilmodem/rilunsol.c
@@ -37,7 +37,8 @@
 #include "util.h"
 =

 #include "common.h"
-#include "grilunsol.h"
+#include "rilutil.h"
+#include "rilunsol.h"
 =

 /* Minimum size is two int32s version/number of calls */
 #define MIN_DATA_CALL_LIST_SIZE 8
diff --git a/gril/grilunsol.h b/drivers/rilmodem/rilunsol.h
similarity index 98%
rename from gril/grilunsol.h
rename to drivers/rilmodem/rilunsol.h
index a7ddfc9..f69aead 100644
--- a/gril/grilunsol.h
+++ b/drivers/rilmodem/rilunsol.h
@@ -25,6 +25,7 @@
 =

 #include <ofono/types.h>
 =

+#include "ril_constants.h"
 #include "gril.h"
 =

 #ifdef __cplusplus
-- =

2.1.4


--===============1107626390706445563==--

