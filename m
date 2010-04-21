Content-Type: multipart/mixed; boundary="===============6256360860243775185=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 09/15] Add parser for esn objects
Date: Wed, 21 Apr 2010 12:55:53 +0800
Message-ID: <1271825759-8898-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6256360860243775185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 33bdb21..1856c93 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1417,6 +1417,25 @@ static gboolean parse_dataobj_remote_entity_address(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.69 */
+static gboolean parse_dataobj_esn(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char **esn =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len !=3D 4)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	/* Assume esn is 4 bytes long */
+	memcpy(*esn, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1583,6 +1602,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_service_availability;
 	case STK_DATA_OBJECT_TYPE_REMOTE_ENTITY_ADDRESS:
 		return parse_dataobj_remote_entity_address;
+	case STK_DATA_OBJECT_TYPE_ESN:
+		return parse_dataobj_esn;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
-- =

1.7.0.4


--===============6256360860243775185==--

