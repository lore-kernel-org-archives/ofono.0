Content-Type: multipart/mixed; boundary="===============0918810602666039062=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 15/15] Add parser for browser identity objects
Date: Fri, 02 Apr 2010 14:20:40 +0800
Message-ID: <1270189240-11650-15-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-14-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0918810602666039062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 src/stkutil.h |    8 ++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 0e42ece..b23409e 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -994,6 +994,14 @@ static gboolean parse_dataobj_language(struct comprehe=
nsion_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in 102.223 Section 8.47 */
+static gboolean parse_dataobj_browser_id(struct comprehension_tlv_iter *it=
er,
+					void *user)
+{
+	unsigned char *byte =3D user;
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1116,6 +1124,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_dtmf_string;
 	case STK_DATA_OBJECT_TYPE_LANGUAGE:
 		return parse_dataobj_language;
+	case STK_DATA_OBJECT_TYPE_BROWSER_ID:
+		return parse_dataobj_browser_id;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 0d22bea..3f96159 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -301,6 +301,14 @@ enum stk_icon_qualifier {
 	STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY =3D	0x01
 };
 =

+enum stk_browser_id {
+	STK_BROWSER_ID_DEFAULT =3D	0x00,
+	STK_BROWSER_ID_WML =3D		0x01,
+	STK_BROWSER_ID_HTML =3D		0x02,
+	STK_BROWSER_ID_XHTML =3D		0x03,
+	STK_BROWSER_ID_CHTML =3D		0x04
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
-- =

1.6.3.3


--===============0918810602666039062==--

