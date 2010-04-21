Content-Type: multipart/mixed; boundary="===============4328166887653903139=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 06/15] Add parser for attribute information objects
Date: Wed, 21 Apr 2010 12:55:50 +0800
Message-ID: <1271825759-8898-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4328166887653903139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   29 +++++++++++++++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index fdeeee2..ca32e08 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1353,6 +1353,33 @@ static gboolean parse_dataobj_service_search(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.66 */
+static gboolean parse_dataobj_attribute_info(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_attribute_info *ai =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	if (len =3D=3D 1)
+		return TRUE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	ai->tech_id =3D data[0];
+	ai->len =3D len - 1;
+
+	ai->attr_info =3D g_try_malloc(ai->len);
+	if (ai->attr_info =3D=3D NULL)
+		return FALSE;
+
+	memcpy(ai->attr_info, data + 1, ai->len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1513,6 +1540,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_device_filter;
 	case STK_DATA_OBJECT_TYPE_SERVICE_SEARCH:
 		return parse_dataobj_service_search;
+	case STK_DATA_OBJECT_TYPE_ATTRIBUTE_INFO:
+		return parse_dataobj_attribute_info;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 57952ba..f15f38d 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -636,6 +636,13 @@ struct stk_service_search {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.66 */
+struct stk_attribute_info {
+	unsigned char tech_id;
+	unsigned char *attr_info;
+	unsigned int len;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.7.0.4


--===============4328166887653903139==--

