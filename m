Content-Type: multipart/mixed; boundary="===============7255932184349842948=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 01/15] Add parser for card reader status objects
Date: Fri, 02 Apr 2010 14:20:26 +0800
Message-ID: <1270189240-11650-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7255932184349842948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b61ff39..5b258ab 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -762,6 +762,15 @@ static gboolean parse_dataobj_item_icon_id_list(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.33 */
+static gboolean parse_dataobj_card_reader_status(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *byte =3D user;
+
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -866,6 +875,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_ITEM_ICON_ID_LIST:
 		return parse_dataobj_item_icon_id_list;
+	case STK_DATA_OBJECT_TYPE_CARD_READER_STATUS:
+		return parse_dataobj_card_reader_status;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
-- =

1.6.3.3


--===============7255932184349842948==--

