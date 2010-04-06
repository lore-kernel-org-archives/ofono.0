Content-Type: multipart/mixed; boundary="===============5553691567967418975=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 10/13] Add parser for buffer size objects
Date: Tue, 06 Apr 2010 18:06:44 +0800
Message-ID: <1270548407-12042-10-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-9-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5553691567967418975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b841fa6..30c476d 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1127,6 +1127,22 @@ static gboolean parse_dataobj_channel_data_length(
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.55 */
+static gboolean parse_dataobj_buffer_size(struct comprehension_tlv_iter *i=
ter,
+						void *user)
+{
+	unsigned short *size =3D user;
+	const unsigned char *data;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 2)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	*size =3D (data[0] << 8) + data[1];
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1265,6 +1281,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_channel_data;
 	case STK_DATA_OBJECT_TYPE_CHANNEL_DATA_LENGTH:
 		return parse_dataobj_channel_data_length;
+	case STK_DATA_OBJECT_TYPE_BUFFER_SIZE:
+		return parse_dataobj_buffer_size;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.6.3.3


--===============5553691567967418975==--

