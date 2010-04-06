Content-Type: multipart/mixed; boundary="===============3211401884035442392=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 03/13] Add parser for bearer objects
Date: Tue, 06 Apr 2010 18:06:37 +0800
Message-ID: <1270548407-12042-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3211401884035442392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2fc5287..c249a3a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1022,6 +1022,14 @@ static gboolean parse_dataobj_url(struct comprehensi=
on_tlv_iter *iter,
 	return parse_dataobj_common_text(iter, url);
 }
 =

+/* Defined in TS 102.223 Section 8.49 */
+static gboolean parse_dataobj_bearer(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	struct stk_common_byte_array *array =3D user;
+	return parse_dataobj_common_byte_array(iter, array);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1148,6 +1156,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_browser_id;
 	case STK_DATA_OBJECT_TYPE_URL:
 		return parse_dataobj_url;
+	case STK_DATA_OBJECT_TYPE_BEARER:
+		return parse_dataobj_bearer;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 3f96159..3dcb2c3 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -309,6 +309,13 @@ enum stk_browser_id {
 	STK_BROWSER_ID_CHTML =3D		0x04
 };
 =

+enum stk_bearer {
+	STK_BEARER_SMS =3D 	0x00,
+	STK_BEARER_CS_DATA =3D	0x01,
+	STK_BEARER_GSM_3G =3D	0x02,
+	STK_BEARER_PS =3D 	0x03
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
-- =

1.6.3.3


--===============3211401884035442392==--

