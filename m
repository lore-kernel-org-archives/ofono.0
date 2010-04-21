Content-Type: multipart/mixed; boundary="===============0988469836727361768=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 01/15] Add parser for access technology objects
Date: Wed, 21 Apr 2010 12:55:45 +0800
Message-ID: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0988469836727361768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 0d4be68..69d5a4a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1243,6 +1243,18 @@ static gboolean parse_dataobj_aid(struct comprehensi=
on_tlv_iter *iter,
 	return TRUE;
 }
 =

+/*
+ * Defined in TS 102.223 Section 8.61. According to it, the technology fie=
ld
+ * can have at most 127 bytes. However, all the defined values are only 1 =
byte,
+ * so we just use 1 byte to represent it.
+ */
+static gboolean parse_dataobj_access_technology(
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
@@ -1393,6 +1405,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_uicc_te_interface;
 	case STK_DATA_OBJECT_TYPE_AID:
 		return parse_dataobj_aid;
+	case STK_DATA_OBJECT_TYPE_ACCESS_TECHNOLOGY:
+		return parse_dataobj_access_technology;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.7.0.4


--===============0988469836727361768==--

