Content-Type: multipart/mixed; boundary="===============3331637022536197323=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 3/7] Add parser for location information objects
Date: Fri, 26 Mar 2010 00:07:32 +0800
Message-ID: <1269533256-29095-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269533256-29095-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3331637022536197323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   36 ++++++++++++++++++++++++++++++++++++
 src/stkutil.h |   11 +++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 9c83f49..d67c5c4 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -519,6 +519,40 @@ error:
 	return FALSE;
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
+	sim_parse_mcc_mnc(data, li->mcc, li->mnc);
+	li->lac_tac =3D (data[3] << 8) + data[4];
+
+	if (len >=3D 7) {
+		li->has_ci =3D TRUE;
+		li->ci =3D (data[5] << 8) + data[6];
+	}
+
+	if (len =3D=3D 9) {
+		li->has_ext_ci =3D TRUE;
+		li->ext_ci =3D (data[7] << 8) + data[8];
+	}
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -638,6 +672,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
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
index 23c6a3f..a9495de 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -347,6 +347,17 @@ struct stk_result {
 	unsigned char *additional;
 };
 =

+/* Defined in TS 102.223 Section 8.19 */
+struct stk_location_info {
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	unsigned short lac_tac;
+	ofono_bool_t has_ci;
+	unsigned short ci;
+	ofono_bool_t has_ext_ci;
+	unsigned short ext_ci;
+};
+
 /* Define the struct of single file in TS102.223 Section 8.18.
  * According to TS 11.11 Section 6.2, each file id has two bytes, and the
  * maximum Dedicated File level is 2. So the maximum size of file is 8, wh=
ich
-- =

1.6.3.3


--===============3331637022536197323==--

