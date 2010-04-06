Content-Type: multipart/mixed; boundary="===============8411761164281376453=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 08/13] Add parser for channel data objects
Date: Tue, 06 Apr 2010 18:06:42 +0800
Message-ID: <1270548407-12042-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-7-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8411761164281376453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f27ff69..0c9108f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1111,6 +1111,14 @@ static gboolean parse_dataobj_bearer_description(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.53 */
+static gboolean parse_dataobj_channel_data(struct comprehension_tlv_iter *=
iter,
+						void *user)
+{
+	struct stk_common_byte_array *array =3D user;
+	return parse_dataobj_common_byte_array(iter, array);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1245,6 +1253,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_browser_termination_cause;
 	case STK_DATA_OBJECT_TYPE_BEARER_DESCRIPTION:
 		return parse_dataobj_bearer_description;
+	case STK_DATA_OBJECT_TYPE_CHANNEL_DATA:
+		return parse_dataobj_channel_data;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.6.3.3


--===============8411761164281376453==--

