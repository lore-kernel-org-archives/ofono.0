Content-Type: multipart/mixed; boundary="===============0137451099448833486=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 04/13] Add parser for meid objects
Date: Thu, 22 Apr 2010 23:12:21 +0800
Message-ID: <1271949150-9085-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0137451099448833486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f2b4fba..3dca39c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1651,6 +1651,24 @@ static gboolean parse_dataobj_frame_id(struct compre=
hension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.81 */
+static gboolean parse_dataobj_meid(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	unsigned char **meid =3D user;
+	const unsigned char *data;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 8)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	/* Assume meid is 8 bytes long */
+	memcpy(*meid, data, 8);
+
+	return TRUE;
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1800,6 +1818,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_frames_info;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
 		return parse_dataobj_frame_id;
+	case STK_DATA_OBJECT_TYPE_MEID:
+		return parse_dataobj_meid;
 	default:
 		return NULL;
 	};
-- =

1.7.0.4


--===============0137451099448833486==--

