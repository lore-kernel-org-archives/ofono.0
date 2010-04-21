Content-Type: multipart/mixed; boundary="===============1038346992187055945=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 11/15] Add parser for cdma sms tpdu objects
Date: Wed, 21 Apr 2010 12:55:55 +0800
Message-ID: <1271825759-8898-11-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1038346992187055945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 6b3500e..b1ba4d4 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1454,6 +1454,14 @@ static gboolean parse_dataobj_network_access_name(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.71 */
+static gboolean parse_dataobj_cdma_sms_tpdu(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_common_byte_array *array =3D user;
+	return parse_dataobj_common_byte_array(iter, array);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1624,6 +1632,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_esn;
 	case STK_DATA_OBJECT_TYPE_NETWORK_ACCESS_NAME:
 		return parse_dataobj_network_access_name;
+	case STK_DATA_OBJECT_TYPE_CDMA_SMS_TPDU:
+		return parse_dataobj_cdma_sms_tpdu;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.7.0.4


--===============1038346992187055945==--

