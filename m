Content-Type: multipart/mixed; boundary="===============5811195032045228805=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 12/17] Add parser for network access name objects
Date: Tue, 20 Apr 2010 14:15:07 +0800
Message-ID: <1271744112-32285-12-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271744112-32285-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5811195032045228805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index db5b8b8..fd44456 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1433,6 +1433,24 @@ static gboolean parse_dataobj_esn(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.70 */
+static gboolean parse_dataobj_network_access_name(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_network_access_name *nan =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len =3D=3D 0)
+		return TRUE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	nan->len =3D len;
+	memcpy(nan->name, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1601,6 +1619,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_remote_entity_address;
 	case STK_DATA_OBJECT_TYPE_ESN:
 		return parse_dataobj_esn;
+	case STK_DATA_OBJECT_TYPE_NETWORK_ACCESS_NAME:
+		return parse_dataobj_network_access_name;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 184c098..01597b3 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -663,6 +663,15 @@ struct stk_remote_entity_address {
 };
 =

 /*
+ * According to 102.223 Section 8.70 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_network_access_name {
+	unsigned char name[127];
+	unsigned char len;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.7.0.4


--===============5811195032045228805==--

