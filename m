Content-Type: multipart/mixed; boundary="===============1786445748263552901=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 11/13] Add parser for channel status objects
Date: Tue, 06 Apr 2010 18:06:45 +0800
Message-ID: <1270548407-12042-11-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-10-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1786445748263552901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 30c476d..01124a5 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1143,6 +1143,24 @@ static gboolean parse_dataobj_buffer_size(struct com=
prehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.56 */
+static gboolean parse_dataobj_channel_status(
+			struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *status =3D user;
+	const unsigned char *data;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 2)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	/* Assume channel status is 2 bytes long */
+	memcpy(status, data, 2);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1283,6 +1301,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_channel_data_length;
 	case STK_DATA_OBJECT_TYPE_BUFFER_SIZE:
 		return parse_dataobj_buffer_size;
+	case STK_DATA_OBJECT_TYPE_CHANNEL_STATUS:
+		return parse_dataobj_channel_status;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.6.3.3


--===============1786445748263552901==--

