Content-Type: multipart/mixed; boundary="===============0105188293325152692=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 6/9] Add parser for transaction identifier objects
Date: Mon, 29 Mar 2010 16:05:01 +0000
Message-ID: <1269878605-12223-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269878605-12223-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0105188293325152692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3aae6bf..d573430 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -748,6 +748,14 @@ static gboolean parse_dataobj_location_status(
 					STK_DATA_OBJECT_TYPE_LOCATION_STATUS);
 }
 =

+/* Defined in TS 102.223 Section 8.28 */
+static gboolean parse_dataobj_transaction_id(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	return parse_dataobj_common_byte_array(iter, user,
+				STK_DATA_OBJECT_TYPE_TRANSACTION_ID);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -873,6 +881,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_cause;
 	case STK_DATA_OBJECT_TYPE_LOCATION_STATUS:
 		return parse_dataobj_location_status;
+	case STK_DATA_OBJECT_TYPE_TRANSACTION_ID:
+		return parse_dataobj_transaction_id;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
-- =

1.6.3.3


--===============0105188293325152692==--

