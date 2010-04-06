Content-Type: multipart/mixed; boundary="===============7874756372000522538=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 09/13] Add parser for channel data length objects
Date: Tue, 06 Apr 2010 18:06:43 +0800
Message-ID: <1270548407-12042-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-8-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7874756372000522538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 0c9108f..b841fa6 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1119,6 +1119,14 @@ static gboolean parse_dataobj_channel_data(struct co=
mprehension_tlv_iter *iter,
 	return parse_dataobj_common_byte_array(iter, array);
 }
 =

+/* Defined in TS 102.223 Section 8.54 */
+static gboolean parse_dataobj_channel_data_length(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *byte =3D user;
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1255,6 +1263,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_bearer_description;
 	case STK_DATA_OBJECT_TYPE_CHANNEL_DATA:
 		return parse_dataobj_channel_data;
+	case STK_DATA_OBJECT_TYPE_CHANNEL_DATA_LENGTH:
+		return parse_dataobj_channel_data_length;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.6.3.3


--===============7874756372000522538==--

