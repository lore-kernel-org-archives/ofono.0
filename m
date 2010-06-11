Content-Type: multipart/mixed; boundary="===============5645668434116653452=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 03/15] stkutil: Refactor struct stk_other_address
Date: Fri, 11 Jun 2010 12:39:48 +0200
Message-ID: <1276252800-27515-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5645668434116653452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c           |    1 +
 src/stkutil.c       |    5 ++++-
 src/stkutil.h       |    5 +++--
 unit/test-stkutil.c |    1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 14d1a0c..e307a4e 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -26,6 +26,7 @@
 #define _GNU_SOURCE
 #include <string.h>
 #include <stdio.h>
+#include <stdint.h>
 =

 #include <glib.h>
 #include <gdbus.h>
diff --git a/src/stkutil.c b/src/stkutil.c
index da7cd78..9012234 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -25,6 +25,7 @@
 =

 #include <string.h>
 #include <stdlib.h>
+#include <stdint.h>
 =

 #include <glib.h>
 =

@@ -1210,8 +1211,10 @@ static gboolean parse_dataobj_other_address(
 	const unsigned char *data;
 	unsigned char len =3D comprehension_tlv_iter_get_length(iter);
 =

-	if (len =3D=3D 0)
+	if (len =3D=3D 0) {
+		oa->type =3D STK_ADDRESS_AUTO;
 		return TRUE;
+	}
 =

 	if ((len !=3D 5) && (len !=3D 17))
 		return FALSE;
diff --git a/src/stkutil.h b/src/stkutil.h
index 86c0e20..d5b3c02 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -404,6 +404,7 @@ enum stk_bearer_type {
 };
 =

 enum stk_address_type {
+	STK_ADDRESS_AUTO =3D 	-1,
 	STK_ADDRESS_IPV4 =3D 	0x21,
 	STK_ADDRESS_IPV6 =3D 	0x57
 };
@@ -692,10 +693,10 @@ struct stk_card_reader_id {
 struct stk_other_address {
 	union {
 		/* Network Byte Order */
-		unsigned int ipv4;
+		uint32_t ipv4;
 		unsigned char ipv6[16];
 	} addr;
-	unsigned char type;
+	enum stk_address_type type;
 };
 =

 /* Defined in TS 102.223 Section 8.59 */
diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 389a865..88a9870 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -27,6 +27,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <stdint.h>
 =

 #include <glib.h>
 #include <glib/gprintf.h>
-- =

1.7.1.86.g0e460.dirty


--===============5645668434116653452==--

