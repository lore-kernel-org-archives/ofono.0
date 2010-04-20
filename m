Content-Type: multipart/mixed; boundary="===============5975694852714976517=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 13/17] Add parser for cdma sms tpdu objects
Date: Tue, 20 Apr 2010 14:15:08 +0800
Message-ID: <1271744112-32285-13-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271744112-32285-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5975694852714976517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index fd44456..e6d69ef 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1451,6 +1451,14 @@ static gboolean parse_dataobj_network_access_name(
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
@@ -1621,6 +1629,8 @@ static dataobj_handler handler_for_type(enum stk_data=
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


--===============5975694852714976517==--

