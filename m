Content-Type: multipart/mixed; boundary="===============7662055111072099491=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 04/15] Add parser for r-apdu objects
Date: Fri, 02 Apr 2010 14:20:29 +0800
Message-ID: <1270189240-11650-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7662055111072099491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   26 ++++++++++++++++++++++++++
 src/stkutil.h |   10 ++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 99e6622..2efa5a4 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -831,6 +831,30 @@ static gboolean parse_dataobj_c_apdu(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.36 */
+static gboolean parse_dataobj_r_apdu(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_r_apdu *ra =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len < 2) || (len > 239))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	ra->sw1 =3D data[len-2];
+	ra->sw2 =3D data[len-1];
+
+	if (len > 2) {
+		ra->len =3D len - 2;
+		memcpy(ra->data, data, ra->len);
+	} else
+		ra->len =3D 0;
+
+	return TRUE;
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -941,6 +965,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_card_atr;
 	case STK_DATA_OBJECT_TYPE_C_APDU:
 		return parse_dataobj_c_apdu;
+	case STK_DATA_OBJECT_TYPE_R_APDU:
+		return parse_dataobj_r_apdu;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
diff --git a/src/stkutil.h b/src/stkutil.h
index c6bd4e1..1cbf407 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -483,6 +483,16 @@ struct stk_c_apdu {
 	unsigned char le;
 };
 =

+/* Defined in TS 102.223 Section 8.36. According to it, the maximum size
+ * of data is 237.
+ */
+struct stk_r_apdu {
+	unsigned char sw1;
+	unsigned char sw2;
+	unsigned char data[237];
+	unsigned int len;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.6.3.3


--===============7662055111072099491==--

