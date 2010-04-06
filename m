Content-Type: multipart/mixed; boundary="===============8842899646248012508=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 05/13] Add parser for provisioning file reference objects
Date: Tue, 06 Apr 2010 18:06:39 +0800
Message-ID: <1270548407-12042-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-4-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8842899646248012508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 8b53e6d..2b551e2 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1058,6 +1058,32 @@ static gboolean parse_dataobj_bearer(struct comprehe=
nsion_tlv_iter *iter,
 	return parse_dataobj_common_byte_array(iter, array);
 }
 =

+/* Defined in TS 102.223 Section 8.50 */
+static gboolean parse_dataobj_provisioning_file_reference(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_file *f =3D user;
+	const unsigned char *data;
+	struct stk_file_iter sf_iter;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len < 1) || (len > 8))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	stk_file_iter_init(&sf_iter, data, len);
+	stk_file_iter_next(&sf_iter);
+
+	if (sf_iter.pos !=3D sf_iter.max)
+		return FALSE;
+
+	f->len =3D len;
+	memcpy(f->file, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1186,6 +1212,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_url;
 	case STK_DATA_OBJECT_TYPE_BEARER:
 		return parse_dataobj_bearer;
+	case STK_DATA_OBJECT_TYPE_PROVISIONING_FILE_REFERENCE:
+		return parse_dataobj_provisioning_file_reference;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.6.3.3


--===============8842899646248012508==--

