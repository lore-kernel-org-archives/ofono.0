Content-Type: multipart/mixed; boundary="===============3713940910810913515=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 03/17] Add parser for access technology objects
Date: Tue, 20 Apr 2010 14:14:58 +0800
Message-ID: <1271744112-32285-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271744112-32285-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3713940910810913515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 0d4be68..d690f51 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1243,6 +1243,24 @@ static gboolean parse_dataobj_aid(struct comprehensi=
on_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.61 */
+static gboolean parse_dataobj_access_technology(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_access_technology *at =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len =3D=3D 0)
+		return TRUE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	at->len =3D len;
+	memcpy(at->tech, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1393,6 +1411,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_uicc_te_interface;
 	case STK_DATA_OBJECT_TYPE_AID:
 		return parse_dataobj_aid;
+	case STK_DATA_OBJECT_TYPE_ACCESS_TECHNOLOGY:
+		return parse_dataobj_access_technology;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 67e7ef7..1e75533 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -600,6 +600,15 @@ struct stk_aid {
 };
 =

 /*
+ * According to 102.223 Section 8.61 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_access_technology {
+	unsigned char tech[127];
+	unsigned char len;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.7.0.4


--===============3713940910810913515==--

