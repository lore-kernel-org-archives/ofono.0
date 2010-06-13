Content-Type: multipart/mixed; boundary="===============7430561109611690834=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 11/12] stk: Add parser for PDP activation param objects
Date: Sun, 13 Jun 2010 17:43:21 +0800
Message-ID: <1276422202-16240-11-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7430561109611690834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   23 +++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 35d9be6..696e2e0 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1623,6 +1623,27 @@ static gboolean parse_dataobj_text_attr(struct compr=
ehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 31.111 Section 8.72 */
+static gboolean parse_dataobj_pdp_act_par(
+			struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_pdp_act_par *pcap =3D user;
+	const unsigned char *data;
+	unsigned int len;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len > sizeof(pcap->par))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	memcpy(pcap->par, data, len);
+	pcap->len =3D len;
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.73 */
 static gboolean parse_dataobj_item_text_attribute_list(
 		struct comprehension_tlv_iter *iter, void *user)
@@ -2101,6 +2122,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_cdma_sms_tpdu;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
+	case STK_DATA_OBJECT_TYPE_PDP_ACTIVATION_PARAMETER:
+		return parse_dataobj_pdp_act_par;
 	case STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST:
 		return parse_dataobj_item_text_attribute_list;
 	case STK_DATA_OBJECT_TYPE_IMEISV:
diff --git a/src/stkutil.h b/src/stkutil.h
index 6ccf307..c6c1af0 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -806,6 +806,12 @@ struct stk_text_attribute {
 	unsigned char len;
 };
 =

+/* Defined in TS 31.111 Section 8.72 */
+struct stk_pdp_act_par {
+	unsigned char par[127];
+	unsigned char len;
+};
+
 /*
  * According to 102.223 Section 8.73 the length of CTLV is 1 byte. This me=
ans
  * that the maximum size is 127 according to the rules of CTLVs. In additi=
on,
-- =

1.7.0.4


--===============7430561109611690834==--

