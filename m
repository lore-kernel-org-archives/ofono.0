Content-Type: multipart/mixed; boundary="===============6346988376249693501=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 5/5] stk: Add parser for timing advance objects
Date: Thu, 17 Jun 2010 18:35:11 +0800
Message-ID: <1276770911-8817-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276770911-8817-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6346988376249693501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c       |   22 ++++++++++++++++++++++
 src/stkutil.h       |   30 ++++++++++++++++++------------
 unit/test-stkutil.c |    2 +-
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f03b25c..6178059 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1151,6 +1151,26 @@ static gboolean parse_dataobj_language(struct compre=
hension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in 31.111 Section 8.46 */
+static gboolean parse_dataobj_timing_advance(
+			struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_timing_advance *ta =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len !=3D 2)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	ta->has_value =3D TRUE;
+	ta->status =3D data[0];
+	ta->advance =3D data[1];
+
+	return TRUE;
+}
+
 /* Defined in 102.223 Section 8.47 */
 static gboolean parse_dataobj_browser_id(struct comprehension_tlv_iter *it=
er,
 						void *user)
@@ -2074,6 +2094,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_language;
 	case STK_DATA_OBJECT_TYPE_BROWSER_ID:
 		return parse_dataobj_browser_id;
+	case STK_DATA_OBJECT_TYPE_TIMING_ADVANCE:
+		return parse_dataobj_timing_advance;
 	case STK_DATA_OBJECT_TYPE_URL:
 		return parse_dataobj_url;
 	case STK_DATA_OBJECT_TYPE_BEARER:
diff --git a/src/stkutil.h b/src/stkutil.h
index 6fb49e0..c2fcea7 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -552,6 +552,11 @@ enum stk_rejection_cause_code {
 	STK_CAUSE_EMM_PROTOCOL_ERROR			=3D 0x6f,
 };
 =

+enum stk_me_status {
+	STK_ME_STATUS_IDLE =3D 		0x00,
+	STK_ME_STATUS_NOT_IDLE =3D 	0x01
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -801,6 +806,18 @@ struct stk_bc_repeat {
 	unsigned char value;
 };
 =

+/* Defined in TS 31.111 Section 8.46 */
+struct stk_timing_advance {
+	ofono_bool_t has_value;
+	enum stk_me_status status;
+	/*
+	 * Contains bit periods number according to 3GPP TS
+	 * 44.118 Section 9.3.106 / 3GPP TS 44.018 Section
+	 * 10.5.2.40.1, not microseconds
+	 */
+	unsigned char advance;
+};
+
 /*
  * According to 102.223 Section 8.52 the length of CTLV is 1 byte. This me=
ans
  * that the maximum size is 127 according to the rules of CTLVs. This size=
 also
@@ -1381,18 +1398,7 @@ struct stk_response_local_info {
 		const char *language;
 		enum stk_battery_state battery_charge;
 		enum stk_access_technology_type access_technology;
-		struct stk_timing_advance {
-			enum {
-				STK_TIMING_ADVANCE_ME_IDLE =3D 0x00,
-				STK_TIMING_ADVANCE_ME_NOT_IDLE =3D 0x01,
-			} status;
-			/*
-			 * Contains bit periods number according to 3GPP TS
-			 * 44.118 Section 9.3.106 / 3GPP TS 44.018 Section
-			 * 10.5.2.40.1, not microseconds
-			 */
-			int advance;
-		} tadv;
+		struct stk_timing_advance tadv;
 		/* Bits[31:24]: manufacturer, bits[23:0]: serial number */
 		guint32 esn;
 		const char *imeisv;
diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index e498dd6..dd22912 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -18699,7 +18699,7 @@ static const struct terminal_response_test
 		},
 		{ .provide_local_info =3D {
 			{ .tadv =3D {
-				.status =3D STK_TIMING_ADVANCE_ME_IDLE,
+				.status =3D STK_ME_STATUS_IDLE,
 				.advance =3D 0,
 			}},
 		}},
-- =

1.7.0.4


--===============6346988376249693501==--

