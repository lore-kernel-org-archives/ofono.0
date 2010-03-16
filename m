Content-Type: multipart/mixed; boundary="===============7082122672268231985=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 4/4] Add parser for location information objects
Date: Tue, 16 Mar 2010 18:01:40 +0800
Message-ID: <1268733700-30154-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1268733700-30154-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7082122672268231985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |    2 +-
 src/simutil.h |    1 +
 src/stkutil.c |   40 +++++++++++++++++++++++++++++++++++++---
 src/stkutil.h |    9 +++++++++
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index d9383b7..65ffa36 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -538,7 +538,7 @@ static char *sim_network_name_parse(const unsigned char=
 *buffer, int length,
 	return ret;
 }
 =

-static void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc)
+void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc)
 {
 	static const char digit_lut[] =3D "0123456789*#abd\0";
 	guint8 digit;
diff --git a/src/simutil.h b/src/simutil.h
index 043c21f..09964a8 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -181,6 +181,7 @@ const struct sim_eons_operator_info *sim_eons_lookup(st=
ruct sim_eons *eons,
 						const char *mnc);
 void sim_eons_free(struct sim_eons *eons);
 =

+void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc);
 struct sim_spdi *sim_spdi_new(const guint8 *tlv, int length);
 gboolean sim_spdi_lookup(struct sim_spdi *spdi,
 				const char *mcc, const char *mnc);
diff --git a/src/stkutil.c b/src/stkutil.c
index 9f3bc0b..9fa7705 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -413,7 +413,7 @@ static gboolean parse_dataobj_file_list(struct comprehe=
nsion_tlv_iter *iter,
 	GSList **fl =3D user;
 	const unsigned char *data;
 	unsigned int len;
-	unsigned int i;
+	unsigned int i =3D 1;
 	unsigned int start =3D 1;
 	struct stk_file *sf;
 =

@@ -430,8 +430,10 @@ static gboolean parse_dataobj_file_list(struct compreh=
ension_tlv_iter *iter,
 	if (data[start] !=3D 0x3f)
 		return FALSE;
 =

-	for (i =3D start + 4; i <=3D len; i +=3D 2) {
-		if ((data[i] =3D=3D 0x3f) || (i =3D=3D len)) {
+	for (i =3D start + 4; i < len; i +=3D 2) {
+		if ((data[i] =3D=3D 0x3f) || (i+2 >=3D len)) {
+			if (i + 2 >=3D len)
+				i +=3D 2;
 			sf =3D g_new0(struct stk_file, 1);
 			sf->file =3D g_malloc(i-start);
 			memcpy(sf->file, data+start, i-start);
@@ -446,6 +448,36 @@ static gboolean parse_dataobj_file_list(struct compreh=
ension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.19 */
+static gboolean parse_dataobj_location_info(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_location_info *li =3D user;
+	const unsigned char *data;
+	unsigned int len;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D
+			STK_DATA_OBJECT_TYPE_LOCATION_INFO)
+		return FALSE;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if ((len !=3D 5) && (len !=3D 7) && (len !=3D 9))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	parse_mcc_mnc(data, li->mcc, li->mnc);
+	li->lac_tac =3D data[3] << 8 | data[4];
+
+	if (len >=3D 7)
+		memcpy(li->cell_id, data+5, 2);
+
+	if (len =3D=3D 9)
+		memcpy(li->ext_cell_id, data+7, 2);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -565,6 +597,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_tone;
 	case STK_DATA_OBJECT_TYPE_FILE_LIST:
 		return parse_dataobj_file_list;
+	case STK_DATA_OBJECT_TYPE_LOCATION_INFO:
+		return parse_dataobj_location_info;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index 5b1a44b..def2555 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -351,6 +351,15 @@ struct stk_file {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.19 */
+struct stk_location_info {
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	guint16 lac_tac;
+	char cell_id[2];
+	char ext_cell_id[2];
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.6.3.3


--===============7082122672268231985==--

