Content-Type: multipart/mixed; boundary="===============1565619211126754657=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 02/10] Adjust the sequence of comprehension tlv structures
Date: Tue, 30 Mar 2010 15:57:29 +0800
Message-ID: <1269935857-4234-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269935857-4234-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1565619211126754657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index c4b8970..0a9c145 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -347,17 +347,6 @@ struct stk_result {
 	unsigned char *additional;
 };
 =

-/* Defined in TS 102.223 Section 8.19 */
-struct stk_location_info {
-	char mnc[OFONO_MAX_MNC_LENGTH + 1];
-	char mcc[OFONO_MAX_MCC_LENGTH + 1];
-	unsigned short lac_tac;
-	ofono_bool_t has_ci;
-	unsigned short ci;
-	ofono_bool_t has_ext_ci;
-	unsigned short ext_ci;
-};
-
 /* Define the struct of single file in TS102.223 Section 8.18.
  * According to TS 11.11 Section 6.2, each file id has two bytes, and the
  * maximum Dedicated File level is 2. So the maximum size of file is 8, wh=
ich
@@ -369,6 +358,17 @@ struct stk_file {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.19 */
+struct stk_location_info {
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	unsigned short lac_tac;
+	ofono_bool_t has_ci;
+	unsigned short ci;
+	ofono_bool_t has_ext_ci;
+	unsigned short ext_ci;
+};
+
 /*
  * According to 102.223 Section 8.24 the length of CTLV is 1 byte. This me=
ans
  * that the maximum size is 127 according to the rules of CTLVs.
-- =

1.6.3.3


--===============1565619211126754657==--

