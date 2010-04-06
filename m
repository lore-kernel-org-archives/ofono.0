Content-Type: multipart/mixed; boundary="===============6966602432128849947=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 13/13] Add parser for other address objects
Date: Tue, 06 Apr 2010 18:06:47 +0800
Message-ID: <1270548407-12042-13-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-12-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6966602432128849947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   23 +++++++++++++++++++++++
 src/stkutil.h |   14 ++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 28a09d9..7d9e2e0 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1179,6 +1179,27 @@ static gboolean parse_dataobj_card_reader_id(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.58 */
+static gboolean parse_dataobj_other_address(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_other_address *oa =3D user;
+	const unsigned char *data;
+	unsigned char len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len =3D=3D 0)
+		return TRUE;
+
+	if ((len !=3D 5) && (len !=3D 17))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	oa->type =3D data[0];
+	memcpy(oa->addr, data + 1, len - 1);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1323,6 +1344,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_channel_status;
 	case STK_DATA_OBJECT_TYPE_CARD_READER_ID:
 		return parse_dataobj_card_reader_id;
+	case STK_DATA_OBJECT_TYPE_OTHER_ADDRESS:
+		return parse_dataobj_other_address;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 511b912..0811048 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -332,6 +332,11 @@ enum stk_bearer_type {
 	STK_BEARER_TYPE_USB =3D 			0x10
 };
 =

+enum stk_address_type {
+	STK_ADDRESS_IPV4 =3D 	0x21,
+	STK_ADDRESS_IPV6 =3D 	0x57
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -553,6 +558,15 @@ struct stk_card_reader_id {
 };
 =

 /*
+ * According to 102.223 Section 8.58 the address can be either ipv4 or ipv=
6.
+ * So the maximum size is 16 (for ipv6).
+ */
+struct stk_other_address {
+	unsigned char addr[16];
+	unsigned char type;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.6.3.3


--===============6966602432128849947==--

