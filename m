Content-Type: multipart/mixed; boundary="===============5861360112218521904=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 09/13] Add parser for multimedia message notification objects
Date: Thu, 22 Apr 2010 23:12:26 +0800
Message-ID: <1271949150-9085-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5861360112218521904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b4702b2..f1a6738 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1741,6 +1741,14 @@ static gboolean parse_dataobj_mms_content_id(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.86 */
+static gboolean parse_dataobj_mms_notification(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_common_byte_array *array =3D user;
+	return parse_dataobj_common_byte_array(iter, array);
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1900,6 +1908,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_mms_transfer_status;
 	case STK_DATA_OBJECT_TYPE_MMS_CONTENT_ID:
 		return parse_dataobj_mms_content_id;
+	case STK_DATA_OBJECT_TYPE_MMS_NOTIFICATION:
+		return parse_dataobj_mms_notification;
 	default:
 		return NULL;
 	};
-- =

1.7.0.4


--===============5861360112218521904==--

