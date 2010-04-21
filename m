Content-Type: multipart/mixed; boundary="===============7861775864214532974=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 07/15] Add parser for service availability objects
Date: Wed, 21 Apr 2010 12:55:51 +0800
Message-ID: <1271825759-8898-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7861775864214532974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ca32e08..f9d4ce7 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1380,6 +1380,14 @@ static gboolean parse_dataobj_attribute_info(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.67 */
+static gboolean parse_dataobj_service_availability(
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
@@ -1542,6 +1550,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_service_search;
 	case STK_DATA_OBJECT_TYPE_ATTRIBUTE_INFO:
 		return parse_dataobj_attribute_info;
+	case STK_DATA_OBJECT_TYPE_SERVICE_AVAILABILITY:
+		return parse_dataobj_service_availability;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.7.0.4


--===============7861775864214532974==--

