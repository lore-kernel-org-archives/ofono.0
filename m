Content-Type: multipart/mixed; boundary="===============1758418501726918862=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 05/15] Add parser for service search objects
Date: Wed, 21 Apr 2010 12:55:49 +0800
Message-ID: <1271825759-8898-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1758418501726918862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   29 +++++++++++++++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d6c7235..fdeeee2 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1326,6 +1326,33 @@ static gboolean parse_dataobj_device_filter(struct c=
omprehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.65 */
+static gboolean parse_dataobj_service_search(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_service_search *ss =3D user;
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
+	ss->tech_id =3D data[0];
+	ss->len =3D len - 1;
+
+	ss->ser_search =3D g_try_malloc(ss->len);
+	if (ss->ser_search =3D=3D NULL)
+		return FALSE;
+
+	memcpy(ss->ser_search, data + 1, ss->len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1484,6 +1511,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_service_record;
 	case STK_DATA_OBJECT_TYPE_DEVICE_FILTER:
 		return parse_dataobj_device_filter;
+	case STK_DATA_OBJECT_TYPE_SERVICE_SEARCH:
+		return parse_dataobj_service_search;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index cc2915d..57952ba 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -629,6 +629,13 @@ struct stk_device_filter {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.65 */
+struct stk_service_search {
+	unsigned char tech_id;
+	unsigned char *ser_search;
+	unsigned int len;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.7.0.4


--===============1758418501726918862==--

