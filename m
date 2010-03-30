Content-Type: multipart/mixed; boundary="===============4162132937065307573=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 09/10] Adjust the sequence of icon identifier structure
Date: Tue, 30 Mar 2010 15:57:36 +0800
Message-ID: <1269935857-4234-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269935857-4234-8-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4162132937065307573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index 0820dda..a3674e4 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -343,15 +343,6 @@ struct stk_ccp {
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
@@ -447,6 +438,16 @@ struct stk_call_control_requested_action {
 };
 =

 /*
+ * Defined in TS 102.223 Section 8.31
+ * Icon ID denotes a file on the SIM filesystem.  Since EF cannot have rec=
ord
+ * ids of 0, we use icon_id with 0 to denote empty icon_identifier objects
+ */
+struct stk_icon_identifier {
+	unsigned char qualifier;
+	unsigned char id;
+};
+
+/* =

  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.6.3.3


--===============4162132937065307573==--

