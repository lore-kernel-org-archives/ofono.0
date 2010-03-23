Content-Type: multipart/mixed; boundary="===============3674483794093564391=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2] Add parser for file list objects
Date: Tue, 23 Mar 2010 12:33:49 +0800
Message-ID: <1269318829-24022-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3674483794093564391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   11 +++++++
 2 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 940eee2..833073b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -416,6 +416,92 @@ static gboolean parse_dataobj_tone(struct comprehensio=
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
+	unsigned int start =3D 0;
+	struct stk_file *sf;
+	unsigned char last_type =3D 0x2f;
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
+	for (i =3D 1; i < len; i +=3D 2) {
+		/* Check the validity of file type.
+		 * According to TS 11.11, each file id contains of two bytes,
+		 * in which the first byte is the type of file. For GSM is:
+		 * 0x3f: master file
+		 * 0x7f: 1st level dedicated file
+		 * 0x5f: 2nd level dedicated file
+		 * 0x2f: elementary file under the master file
+		 * 0x6f: elementary file under 1st level dedicated file
+		 * 0x4f: elementary file under 2nd level dedicated file
+		 */
+		if (data[i] =3D=3D 0x3f) {
+			if ((last_type !=3D 0x2f) && (last_type !=3D 0x6f) &&
+							(last_type !=3D 0x4f))
+				goto error;
+			start =3D i;
+		} else if (data[i] =3D=3D 0x2f) {
+			if (last_type !=3D 0x3f)
+				goto error;
+		} else if (data[i] =3D=3D 0x6f) {
+			if (last_type !=3D 0x7f)
+				goto error;
+		} else if (data[i] =3D=3D 0x4f) {
+			if (last_type !=3D 0x5f)
+				goto error;
+		} else if (data[i] =3D=3D 0x7f) {
+			if (last_type !=3D 0x3f)
+				goto error;
+		} else if (data[i] =3D=3D 0x5f) {
+			if (last_type !=3D 0x7f)
+				goto error;
+		} else
+			goto error;
+
+		if ((data[i] =3D=3D 0x2f) || (data[i] =3D=3D 0x6f) ||
+						(data[i] =3D=3D 0x4f)) {
+			if (i + 1 >=3D len)
+				goto error;
+
+			sf =3D g_try_new0(struct stk_file, 1);
+			if (sf =3D=3D NULL)
+				goto error;
+
+			sf->len =3D i - start + 2;
+			memcpy(sf->file, data + start, i - start + 2);
+			*fl =3D g_slist_prepend(*fl, sf);
+		}
+
+		last_type =3D data[i];
+	}
+
+	if ((data[len - 2] !=3D 0x2f) && (data[len - 2] !=3D 0x6f) &&
+						(data[len - 2] !=3D 0x4f))
+		goto error;
+
+	*fl =3D g_slist_reverse(*fl);
+	return TRUE;
+
+error:
+	g_slist_foreach(*fl, (GFunc)g_free, NULL);
+	g_slist_free(*fl);
+	return FALSE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -533,6 +619,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
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
index 1d690b5..93ac854 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -345,6 +345,17 @@ struct stk_result {
 	unsigned char *additional;
 };
 =

+/* Define the struct of single file in TS102.223 Section 8.18.
+ * According to TS 11.11 Section 6.2, each file id has two bytes, and the
+ * maximum Dedicated File level is 2. So the maximum size of file is 8, wh=
ich
+ * contains two bytes of Master File, 2 bytes of 1st level Dedicated File,
+ * 2 bytes of 2nd level Dedicated File and 2 bytes of Elementary File.
+ */
+struct stk_file {
+	unsigned char file[8];
+	unsigned int len;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.6.3.3


--===============3674483794093564391==--

