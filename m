Content-Type: multipart/mixed; boundary="===============4915865702417848033=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 01/13] Add parser for browsing status objects
Date: Thu, 22 Apr 2010 23:12:18 +0800
Message-ID: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4915865702417848033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 50471ee..b855b0f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1570,6 +1570,14 @@ static gboolean parse_dataobj_battery_state(struct c=
omprehension_tlv_iter *iter,
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.77 */
+static gboolean parse_dataobj_browsing_status(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_common_byte_array *array =3D user;
+	return parse_dataobj_common_byte_array(iter, array);
+}
+
 /* Defined in TS 102.223 Section 8.80 */
 static gboolean parse_dataobj_frame_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1731,6 +1739,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_network_search_mode;
 	case STK_DATA_OBJECT_TYPE_BATTERY_STATE:
 		return parse_dataobj_battery_state;
+	case STK_DATA_OBJECT_TYPE_BROWSING_STATUS:
+		return parse_dataobj_browsing_status;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
 		return parse_dataobj_frame_id;
 	default:
-- =

1.7.0.4


--===============4915865702417848033==--

