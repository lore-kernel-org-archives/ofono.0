Content-Type: multipart/mixed; boundary="===============7577960698510456932=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 02/15] Add parser for display parameters objects
Date: Wed, 21 Apr 2010 12:55:46 +0800
Message-ID: <1271825759-8898-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7577960698510456932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 69d5a4a..d569f16 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1255,6 +1255,24 @@ static gboolean parse_dataobj_access_technology(
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.62 */
+static gboolean parse_dataobj_display_parameters(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_display_parameters *dp =3D user;
+	const unsigned char *data;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 3)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	dp->height =3D data[0];
+	dp->width =3D data[1];
+	dp->effects =3D data[2];
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1407,6 +1425,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_aid;
 	case STK_DATA_OBJECT_TYPE_ACCESS_TECHNOLOGY:
 		return parse_dataobj_access_technology;
+	case STK_DATA_OBJECT_TYPE_DISPLAY_PARAMETERS:
+		return parse_dataobj_display_parameters;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 67e7ef7..3cf9caa 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -599,6 +599,13 @@ struct stk_aid {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.62 */
+struct stk_display_parameters {
+	unsigned char height;
+	unsigned char width;
+	unsigned char effects;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.7.0.4


--===============7577960698510456932==--

