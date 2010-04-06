Content-Type: multipart/mixed; boundary="===============1162122403784081795=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 07/13] Add parser for bearer description objects
Date: Tue, 06 Apr 2010 18:06:41 +0800
Message-ID: <1270548407-12042-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-6-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1162122403784081795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   21 +++++++++++++++++++++
 src/stkutil.h |   23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 4998440..f27ff69 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1092,6 +1092,25 @@ static gboolean parse_dataobj_browser_termination_ca=
use(
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.52 */
+static gboolean parse_dataobj_bearer_description(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_bearer_description *bd =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	bd->type =3D data[0];
+	bd->len =3D len - 1;
+	memcpy(bd->pars, data + 1, bd->len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1224,6 +1243,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_provisioning_file_reference;
 	case STK_DATA_OBJECT_TYPE_BROWSER_TERMINATION_CAUSE:
 		return parse_dataobj_browser_termination_cause;
+	case STK_DATA_OBJECT_TYPE_BEARER_DESCRIPTION:
+		return parse_dataobj_bearer_description;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 746c5ff..c1b9af0 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -321,6 +321,17 @@ enum stk_browser_termination_cause {
 	STK_BROWSER_ERROR_TERMINATION =3D 	0x01
 };
 =

+enum stk_bearer_type {
+	STK_BEARER_TYPE_DEFAULT =3D 		0x03,
+	STK_BEARER_TYPE_INDEPENDENT =3D 		0x04,
+	STK_BEARER_TYPE_BLUETOOTH =3D		0x05,
+	STK_BEARER_TYPE_IRDA =3D			0x06,
+	STK_BEARER_TYPE_RS232 =3D 		0x07,
+	STK_BEARER_TYPE_PACKET_DATA_SERVICE =3D 	0x08,
+	STK_BEARER_TYPE_I_WLAN =3D 		0x0a,
+	STK_BEARER_TYPE_USB =3D 			0x10
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -521,6 +532,18 @@ struct stk_timer_value {
 };
 =

 /*
+ * According to 102.223 Section 8.52 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs. This size=
 also
+ * includes bearer type for 1 byte, so the maxmimum size of bearer paramet=
ers
+ * is 126.
+ */
+struct stk_bearer_description {
+	unsigned char type;
+	unsigned char pars[126];
+	unsigned int len;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.6.3.3


--===============1162122403784081795==--

