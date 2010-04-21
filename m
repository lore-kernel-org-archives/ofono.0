Content-Type: multipart/mixed; boundary="===============2940774059189205167=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 03/15] Add parser for service record objects
Date: Wed, 21 Apr 2010 12:55:47 +0800
Message-ID: <1271825759-8898-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2940774059189205167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   28 ++++++++++++++++++++++++++++
 src/stkutil.h |   16 ++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d569f16..0e0135f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1273,6 +1273,32 @@ static gboolean parse_dataobj_display_parameters(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.63 */
+static gboolean parse_dataobj_service_record(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_service_record *sr =3D user;
+	const unsigned char *data;
+	unsigned int len;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if (len < 3)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	sr->tech_id =3D data[0];
+	sr->serv_id =3D data[1];
+	sr->len =3D len - 2;
+
+	sr->serv_rec =3D g_try_malloc(sr->len);
+	if (sr->serv_rec =3D=3D NULL)
+		return FALSE;
+
+	memcpy(sr->serv_rec, data + 2, sr->len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1427,6 +1453,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_access_technology;
 	case STK_DATA_OBJECT_TYPE_DISPLAY_PARAMETERS:
 		return parse_dataobj_display_parameters;
+	case STK_DATA_OBJECT_TYPE_SERVICE_RECORD:
+		return parse_dataobj_service_record;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 3cf9caa..581d947 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -349,6 +349,14 @@ enum stk_access_technology_type {
 	STK_ACCESS_TECHNOLOGY_EUTRAN =3D 		0x08
 };
 =

+enum stk_technology_id {
+	STK_TECHNOLOGY_INDEPENDENT =3D 	0x00,
+	STK_TECHNOLOGY_BLUETOOTH =3D 	0x01,
+	STK_TECHNOLOGY_IRDA =3D 		0x02,
+	STK_TECHNOLOGY_RS232 =3D 		0x03,
+	STK_TECHNOLOGY_USB =3D 		0x04
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -606,6 +614,14 @@ struct stk_display_parameters {
 	unsigned char effects;
 };
 =

+/* Defined in TS 102.223 Section 8.63 */
+struct stk_service_record {
+	unsigned char tech_id;
+	unsigned char serv_id;
+	unsigned char *serv_rec;
+	unsigned int len;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.7.0.4


--===============2940774059189205167==--

