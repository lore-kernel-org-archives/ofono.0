Content-Type: multipart/mixed; boundary="===============0753714984987601293=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 14/15] Add parser for language objects
Date: Fri, 02 Apr 2010 14:20:39 +0800
Message-ID: <1270189240-11650-14-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-13-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0753714984987601293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 4951df3..0e42ece 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -975,6 +975,25 @@ static gboolean parse_dataobj_dtmf_string(struct compr=
ehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in 102.223 Section 8.45 */
+static gboolean parse_dataobj_language(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	char **lang =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len !=3D 2)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	/* Assume network measurement result is 2 bytes long */
+	memcpy(*lang, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1095,6 +1114,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_DTMF_STRING:
 		return parse_dataobj_dtmf_string;
+	case STK_DATA_OBJECT_TYPE_LANGUAGE:
+		return parse_dataobj_language;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.6.3.3


--===============0753714984987601293==--

