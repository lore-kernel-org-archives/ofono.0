Content-Type: multipart/mixed; boundary="===============3710007208212306806=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 10/12] stk: Add parser for timing advance objects
Date: Sun, 13 Jun 2010 17:43:20 +0800
Message-ID: <1276422202-16240-10-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3710007208212306806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c       |   22 ++++++++++++++++++++++
 src/stkutil.h       |   28 ++++++++++++++++++----------
 unit/test-stkutil.c |    2 +-
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 1631610..35d9be6 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1145,6 +1145,26 @@ static gboolean parse_dataobj_language(struct compre=
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
@@ -2029,6 +2049,8 @@ static dataobj_handler handler_for_type(enum stk_data=
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
index 20c3c02..6ccf307 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -447,6 +447,11 @@ enum stk_broadcast_network_technology {
 	STK_BROADCAST_NETWORK_T_DMB =3D 0x03
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
@@ -671,6 +676,18 @@ struct stk_timer_value {
 	unsigned char second;
 };
 =

+/* Defined in TS 31.111 Section 8.46 */
+struct stk_timing_advance {
+	ofono_bool_t has_value;
+	unsigned char status;
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
@@ -1229,16 +1246,7 @@ struct stk_response_local_info {
 		const char *language;
 		enum stk_battery_state battery_charge;
 		enum stk_access_technology_type access_technology;
-		struct stk_timing_advance {
-			enum {
-				STK_TIMING_ADVANCE_ME_IDLE =3D 0x00,
-				STK_TIMING_ADVANCE_ME_NOT_IDLE =3D 0x01,
-			} status;
-			/* Contains bit periods number according to 3GPP TS
-			 * 44.118 Section 9.3.106 / 3GPP TS 44.018 Section
-			 * 10.5.2.40.1, not microseconds */
-			int advance;
-		} tadv;
+		struct stk_timing_advance tadv;
 		/* Bits[31:24]: manufacturer, bits[23:0]: serial number */
 		guint32 esn;
 		const char *imeisv;
diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 507d86d..eab62f0 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -18695,7 +18695,7 @@ static const struct terminal_response_test
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


--===============3710007208212306806==--

