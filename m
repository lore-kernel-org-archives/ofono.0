Content-Type: multipart/mixed; boundary="===============2601681073236817382=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 7/9] Add parser for call control requested action objects
Date: Tue, 30 Mar 2010 00:24:42 +0800
Message-ID: <1269879884-12741-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269879884-12741-6-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2601681073236817382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d573430..6619bc3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -756,6 +756,14 @@ static gboolean parse_dataobj_transaction_id(
 				STK_DATA_OBJECT_TYPE_TRANSACTION_ID);
 }
 =

+/* Defined in TS 102.223 Section 8.30 */
+static gboolean parse_dataobj_call_control_requested_action(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	return parse_dataobj_common_byte_array(iter, user,
+			STK_DATA_OBJECT_TYPE_CALL_CONTROL_REQUESTED_ACTION);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -883,6 +891,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_location_status;
 	case STK_DATA_OBJECT_TYPE_TRANSACTION_ID:
 		return parse_dataobj_transaction_id;
+	case STK_DATA_OBJECT_TYPE_CALL_CONTROL_REQUESTED_ACTION:
+		return parse_dataobj_call_control_requested_action;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
-- =

1.6.3.3


--===============2601681073236817382==--

