Content-Type: multipart/mixed; boundary="===============8542464735916282038=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 12/12] stk: Add parser for UTRAN meas qualifier objects
Date: Sun, 13 Jun 2010 17:43:22 +0800
Message-ID: <1276422202-16240-12-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8542464735916282038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 src/stkutil.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 696e2e0..5282d17 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1663,6 +1663,14 @@ static gboolean parse_dataobj_item_text_attribute_li=
st(
 	return TRUE;
 }
 =

+/* Defined in TS 31.111 Section 8.73 */
+static gboolean parse_dataobj_utran_meas_qualifier(
+			struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *byte =3D user;
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /*
  * Defined in TS 102.223 Section 8.74.
  *
@@ -2126,6 +2134,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_pdp_act_par;
 	case STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST:
 		return parse_dataobj_item_text_attribute_list;
+	case STK_DATA_OBJECT_TYPE_UTRAN_MEASUREMENT_QUALIFIER:
+		return parse_dataobj_utran_meas_qualifier;
 	case STK_DATA_OBJECT_TYPE_IMEISV:
 		return parse_dataobj_imeisv;
 	case STK_DATA_OBJECT_TYPE_NETWORK_SEARCH_MODE:
diff --git a/src/stkutil.h b/src/stkutil.h
index c6c1af0..4efb1d9 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -164,6 +164,7 @@ enum stk_data_object_type {
 	STK_DATA_OBJECT_TYPE_FRAME_LAYOUT =3D			0x66,
 	STK_DATA_OBJECT_TYPE_FRAMES_INFO =3D			0x67,
 	STK_DATA_OBJECT_TYPE_FRAME_ID =3D				0x68,
+	STK_DATA_OBJECT_TYPE_UTRAN_MEASUREMENT_QUALIFIER =3D	0x69,
 	STK_DATA_OBJECT_TYPE_MMS_REFERENCE =3D			0x6A,
 	STK_DATA_OBJECT_TYPE_MMS_ID =3D				0x6B,
 	STK_DATA_OBJECT_TYPE_MMS_TRANSFER_STATUS =3D		0x6C,
-- =

1.7.0.4


--===============8542464735916282038==--

