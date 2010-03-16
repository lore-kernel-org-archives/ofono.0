Content-Type: multipart/mixed; boundary="===============3999117488014915941=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 3/4] Add parser for file list objects
Date: Tue, 16 Mar 2010 18:01:39 +0800
Message-ID: <1268733700-30154-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1268733700-30154-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3999117488014915941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ceba2d5..9f3bc0b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -406,6 +406,46 @@ static gboolean parse_dataobj_tone(struct comprehensio=
n_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.18 */
+static gboolean parse_dataobj_file_list(struct comprehension_tlv_iter *ite=
r,
+						void *user)
+{
+	GSList **fl =3D user;
+	const unsigned char *data;
+	unsigned int len;
+	unsigned int i;
+	unsigned int start =3D 1;
+	struct stk_file *sf;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D
+			STK_DATA_OBJECT_TYPE_FILE_LIST)
+		return FALSE;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if (len < 5)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	if (data[start] !=3D 0x3f)
+		return FALSE;
+
+	for (i =3D start + 4; i <=3D len; i +=3D 2) {
+		if ((data[i] =3D=3D 0x3f) || (i =3D=3D len)) {
+			sf =3D g_new0(struct stk_file, 1);
+			sf->file =3D g_malloc(i-start);
+			memcpy(sf->file, data+start, i-start);
+			sf->len =3D i - start;
+			*fl =3D g_slist_prepend(*fl, sf);
+			start =3D i;
+		}
+	}
+
+	*fl =3D g_slist_reverse(*fl);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -523,6 +563,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_text;
 	case STK_DATA_OBJECT_TYPE_TONE:
 		return parse_dataobj_tone;
+	case STK_DATA_OBJECT_TYPE_FILE_LIST:
+		return parse_dataobj_file_list;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index b408f38..5b1a44b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -345,6 +345,12 @@ struct stk_result {
 	unsigned char *additional;
 };
 =

+/* Define the struct of single file in TS102.223 Section 8.18 */
+struct stk_file {
+	unsigned char *file;
+	unsigned int len;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.6.3.3


--===============3999117488014915941==--

