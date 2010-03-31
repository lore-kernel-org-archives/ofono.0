Content-Type: multipart/mixed; boundary="===============5386272826371083612=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 06/11] Add parser for transaction identifier objects
Date: Wed, 31 Mar 2010 17:16:58 +0800
Message-ID: <1270027023-21468-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5386272826371083612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b04ef4c..73dae2c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -675,6 +675,24 @@ static gboolean parse_dataobj_location_status(
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.28 */
+static gboolean parse_dataobj_transaction_id(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_transaction_id *ti =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len < 1) || (len > sizeof(ti->list)))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	ti->len =3D len;
+	memcpy(ti->list, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -789,6 +807,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_cause;
 	case STK_DATA_OBJECT_TYPE_LOCATION_STATUS:
 		return parse_dataobj_location_status;
+	case STK_DATA_OBJECT_TYPE_TRANSACTION_ID:
+		return parse_dataobj_transaction_id;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index a87b4ef..419cda7 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -418,6 +418,15 @@ struct stk_cause {
 };
 =

 /*
+ * According to 102.223 Section 8.28 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_transaction_id {
+	unsigned char list[127];
+	unsigned int len;
+};
+
+/*
  * Defined in TS 102.223 Section 8.31
  * Icon ID denotes a file on the SIM filesystem.  Since EF cannot have rec=
ord
  * ids of 0, we use icon_id with 0 to denote empty icon_identifier objects
-- =

1.6.3.3


--===============5386272826371083612==--

