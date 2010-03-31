Content-Type: multipart/mixed; boundary="===============3206358394639757305=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 01/11] Adjust the sequence of comprehension tlv structures
Date: Wed, 31 Mar 2010 17:16:53 +0800
Message-ID: <1270027023-21468-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3206358394639757305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index a9495de..b0b09df 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -308,15 +308,6 @@ struct stk_ccp {
 };
 =

 /*
- * Icon ID denotes a file on the SIM filesystem.  Since EF cannot have rec=
ord
- * ids of 0, we use icon_id with 0 to denote empty icon_identifier objects
- */
-struct stk_icon_identifier {
-	unsigned char qualifier;
-	unsigned char id;
-};
-
-/*
  * According to 102.223 Section 8.8 interval values of 0x00 are reserved.
  * We use this to denote empty duration objects.
  */
@@ -347,6 +338,17 @@ struct stk_result {
 	unsigned char *additional;
 };
 =

+/* Define the struct of single file in TS102.223 Section 8.18.
+ * According to TS 11.11 Section 6.2, each file id has two bytes, and the
+ * maximum Dedicated File level is 2. So the maximum size of file is 8, wh=
ich
+ * contains two bytes of Master File, 2 bytes of 1st level Dedicated File,
+ * 2 bytes of 2nd level Dedicated File and 2 bytes of Elementary File.
+ */
+struct stk_file {
+	unsigned char file[8];
+	unsigned int len;
+};
+
 /* Defined in TS 102.223 Section 8.19 */
 struct stk_location_info {
 	char mnc[OFONO_MAX_MNC_LENGTH + 1];
@@ -358,15 +360,14 @@ struct stk_location_info {
 	unsigned short ext_ci;
 };
 =

-/* Define the struct of single file in TS102.223 Section 8.18.
- * According to TS 11.11 Section 6.2, each file id has two bytes, and the
- * maximum Dedicated File level is 2. So the maximum size of file is 8, wh=
ich
- * contains two bytes of Master File, 2 bytes of 1st level Dedicated File,
- * 2 bytes of 2nd level Dedicated File and 2 bytes of Elementary File.
+/*
+ * Defined in TS 102.223 Section 8.31
+ * Icon ID denotes a file on the SIM filesystem.  Since EF cannot have rec=
ord
+ * ids of 0, we use icon_id with 0 to denote empty icon_identifier objects
  */
-struct stk_file {
-	unsigned char file[8];
-	unsigned int len;
+struct stk_icon_identifier {
+	unsigned char qualifier;
+	unsigned char id;
 };
 =

 /*
-- =

1.6.3.3


--===============3206358394639757305==--

