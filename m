Content-Type: multipart/mixed; boundary="===============2559717821725134055=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 07/17] Add parser for service search objects
Date: Tue, 20 Apr 2010 14:15:02 +0800
Message-ID: <1271744112-32285-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271744112-32285-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2559717821725134055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   26 ++++++++++++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 827ea9c..2baaeab 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1329,6 +1329,30 @@ static gboolean parse_dataobj_device_filter(struct c=
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
+	if (len < 2)
+		return FALSE;
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
@@ -1487,6 +1511,8 @@ static dataobj_handler handler_for_type(enum stk_data=
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
index 96c4363..9c4ff20 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -638,6 +638,13 @@ struct stk_device_filter {
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


--===============2559717821725134055==--

