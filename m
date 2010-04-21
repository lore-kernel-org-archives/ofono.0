Content-Type: multipart/mixed; boundary="===============5274774822661004899=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 04/15] Add parser for device filter objects
Date: Wed, 21 Apr 2010 12:55:48 +0800
Message-ID: <1271825759-8898-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5274774822661004899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   29 +++++++++++++++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 0e0135f..d6c7235 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1299,6 +1299,33 @@ static gboolean parse_dataobj_service_record(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.64 */
+static gboolean parse_dataobj_device_filter(struct comprehension_tlv_iter =
*iter,
+						void *user)
+{
+	struct stk_device_filter *df =3D user;
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
+	df->tech_id =3D data[0];
+	df->len =3D len - 1;
+
+	df->dev_filter =3D g_try_malloc(df->len);
+	if (df->dev_filter =3D=3D NULL)
+		return FALSE;
+
+	memcpy(df->dev_filter, data + 1, df->len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1455,6 +1482,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_display_parameters;
 	case STK_DATA_OBJECT_TYPE_SERVICE_RECORD:
 		return parse_dataobj_service_record;
+	case STK_DATA_OBJECT_TYPE_DEVICE_FILTER:
+		return parse_dataobj_device_filter;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 581d947..cc2915d 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -622,6 +622,13 @@ struct stk_service_record {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.64 */
+struct stk_device_filter {
+	unsigned char tech_id;
+	unsigned char *dev_filter;
+	unsigned int len;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.7.0.4


--===============5274774822661004899==--

