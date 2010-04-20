Content-Type: multipart/mixed; boundary="===============1993641611307134473=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 01/17] Add parser for item text attribute list objects
Date: Tue, 20 Apr 2010 14:14:56 +0800
Message-ID: <1271744112-32285-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1993641611307134473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 43c06cd..5b97aeb 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1207,6 +1207,24 @@ static gboolean parse_dataobj_other_address(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.59 */
+static gboolean parse_dataobj_uicc_te_interface(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_uicc_te_interface *uti =3D user;
+	const unsigned char *data;
+	unsigned char len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len !=3D 3)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	uti->protocol =3D data[0];
+	uti->port =3D (data[1] << 8) + data[2];
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1353,6 +1371,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_card_reader_id;
 	case STK_DATA_OBJECT_TYPE_OTHER_ADDRESS:
 		return parse_dataobj_other_address;
+	case STK_DATA_OBJECT_TYPE_UICC_TE_INTERFACE:
+		return parse_dataobj_uicc_te_interface;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 1c05440..1c7c970 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -570,6 +570,12 @@ struct stk_other_address {
 	unsigned char type;
 };
 =

+/* Defined in TS 102.223 Section 8.59 */
+struct stk_uicc_te_interface {
+	unsigned char protocol;
+	unsigned short port;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.7.0.4


--===============1993641611307134473==--

