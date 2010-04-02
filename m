Content-Type: multipart/mixed; boundary="===============6225459897660953280=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 03/15] Add parser for c-apdu objects
Date: Fri, 02 Apr 2010 14:20:28 +0800
Message-ID: <1270189240-11650-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6225459897660953280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |   15 +++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a96132c..99e6622 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -789,6 +789,48 @@ static gboolean parse_dataobj_card_atr(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.35 */
+static gboolean parse_dataobj_c_apdu(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_c_apdu *ca =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len < 4) || (len > 241))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	ca->cla =3D data[0];
+	ca->ins =3D data[1];
+	ca->p1 =3D data[2];
+	ca->p2 =3D data[3];
+
+	/* lc is 0 has the same meaning as lc is absent. But le is 0 means
+	 * the maximum number of bytes expected in the response data field
+	 * is 256. So we need to rely on has_le to know if it presents.
+	 */
+	if (len > 5) {
+		ca->lc =3D data[4];
+		if (ca->lc > sizeof(ca->data))
+			return FALSE;
+
+		memcpy(ca->data, data+5, ca->lc);
+
+		if ((len - ca->lc) =3D=3D 6) {
+			ca->le =3D data[len-1];
+			ca->has_le =3D TRUE;
+		} else if (len - ca->lc !=3D 5)
+			return FALSE;
+	} else if (len =3D=3D 5) {
+		ca->lc =3D 0;
+		ca->le =3D data[4];
+		ca->has_le =3D TRUE;
+	}
+
+	return TRUE;
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -897,6 +939,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_card_reader_status;
 	case STK_DATA_OBJECT_TYPE_CARD_ATR:
 		return parse_dataobj_card_atr;
+	case STK_DATA_OBJECT_TYPE_C_APDU:
+		return parse_dataobj_c_apdu;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
diff --git a/src/stkutil.h b/src/stkutil.h
index 8047ed1..c6bd4e1 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -469,6 +469,21 @@ struct stk_card_atr {
 };
 =

 /*
+ * Defined in TS 102.223 Section 8.35. According to it, the maximum size
+ * of data is 236.
+ */
+struct stk_c_apdu {
+	unsigned char cla;
+	unsigned char ins;
+	unsigned char p1;
+	unsigned char p2;
+	unsigned char lc;
+	unsigned char data[236];
+	ofono_bool_t has_le;
+	unsigned char le;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.6.3.3


--===============6225459897660953280==--

