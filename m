Content-Type: multipart/mixed; boundary="===============3976344703285001642=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 08/15] Add parser for remote entity address objects
Date: Wed, 21 Apr 2010 12:55:52 +0800
Message-ID: <1271825759-8898-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3976344703285001642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   31 +++++++++++++++++++++++++++++++
 src/stkutil.h |   12 ++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f9d4ce7..33bdb21 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1388,6 +1388,35 @@ static gboolean parse_dataobj_service_availability(
 	return parse_dataobj_common_byte_array(iter, array);
 }
 =

+/* Defined in TS 102.223 Section 8.68 */
+static gboolean parse_dataobj_remote_entity_address(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_remote_entity_address *rea =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	rea->coding_type =3D data[0];
+	switch (rea->coding_type) {
+	case 0x00:
+		if (len !=3D 7)
+			return FALSE;
+		break;
+	case 0x01:
+		if (len !=3D 5)
+			return FALSE;
+		break;
+	default:
+		return FALSE;
+	}
+
+	memcpy(&rea->addr, data + 1, len - 1);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1552,6 +1581,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_attribute_info;
 	case STK_DATA_OBJECT_TYPE_SERVICE_AVAILABILITY:
 		return parse_dataobj_service_availability;
+	case STK_DATA_OBJECT_TYPE_REMOTE_ENTITY_ADDRESS:
+		return parse_dataobj_remote_entity_address;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index f15f38d..39d159b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -644,6 +644,18 @@ struct stk_attribute_info {
 };
 =

 /*
+ * According to TS 102.223 Section 8.68, remote entity address can be eith=
er
+ * 6-bytes IEEE-802 address, or 4-bytes IrDA device address.
+ */
+struct stk_remote_entity_address {
+	unsigned char coding_type;
+	union {
+		unsigned char ieee802[6];
+		unsigned char irda[4];
+	} addr;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.7.0.4


--===============3976344703285001642==--

