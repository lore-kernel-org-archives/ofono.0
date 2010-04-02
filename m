Content-Type: multipart/mixed; boundary="===============6496100961029301377=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 13/15] Add parser for dtmf string objects
Date: Fri, 02 Apr 2010 14:20:38 +0800
Message-ID: <1270189240-11650-13-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-12-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6496100961029301377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f205ce6..4951df3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -953,6 +953,28 @@ static gboolean parse_dataobj_imm_resp(struct comprehe=
nsion_tlv_iter *iter,
 	return parse_dataobj_common_bool(iter, ret);
 }
 =

+/* Defined in 102.223 Section 8.44 */
+static gboolean parse_dataobj_dtmf_string(struct comprehension_tlv_iter *i=
ter,
+					void *user)
+{
+	char **dtmf =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	*dtmf =3D g_try_malloc(len * 2 + 1);
+	if (*dtmf =3D=3D NULL)
+		return FALSE;
+
+	extract_bcd_number(data, len, *dtmf);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1071,6 +1093,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_bc_repeat_indicator;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
+	case STK_DATA_OBJECT_TYPE_DTMF_STRING:
+		return parse_dataobj_dtmf_string;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.6.3.3


--===============6496100961029301377==--

