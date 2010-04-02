Content-Type: multipart/mixed; boundary="===============6359395583273666447=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 07/15] Add parser for timer value objects
Date: Fri, 02 Apr 2010 14:20:32 +0800
Message-ID: <1270189240-11650-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-6-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6359395583273666447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d999846..5fea3a5 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -864,6 +864,24 @@ static gboolean parse_dataobj_timer_id(
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.38 */
+static gboolean parse_dataobj_timer_value(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_timer_value *tv =3D user;
+	const unsigned char *data;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 3)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	tv->hour =3D sms_decode_semi_octet(data[0]);
+	tv->minute =3D sms_decode_semi_octet(data[1]);
+	tv->second =3D sms_decode_semi_octet(data[2]);
+
+	return TRUE;
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -978,6 +996,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_r_apdu;
 	case STK_DATA_OBJECT_TYPE_TIMER_ID:
 		return parse_dataobj_timer_id;
+	case STK_DATA_OBJECT_TYPE_TIMER_VALUE:
+		return parse_dataobj_timer_value;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
diff --git a/src/stkutil.h b/src/stkutil.h
index 1cbf407..0d22bea 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -493,6 +493,13 @@ struct stk_r_apdu {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.38 */
+struct stk_timer_value {
+	unsigned char hour;
+	unsigned char minute;
+	unsigned char second;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.6.3.3


--===============6359395583273666447==--

