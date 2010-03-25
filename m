Content-Type: multipart/mixed; boundary="===============3636023952459857750=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 4/7] Add parser for imei objects
Date: Fri, 26 Mar 2010 00:07:33 +0800
Message-ID: <1269533256-29095-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269533256-29095-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3636023952459857750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index d67c5c4..af1200c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -553,6 +553,47 @@ static gboolean parse_dataobj_location_info(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.20.
+ *
+ * According to 3GPP TS 24.008, Section 10.5.1.4, IMEI is composed of
+ * 15 digits and totally 8 bytes are used to represent it.
+ *
+ * Bits 1-3 of first byte represent the type of identity, and they
+ * are 0 1 0 separately for IMEI. Bit 4 of first byte is the odd/even
+ * indication, and it's 1 to indicate IMEI has odd number of digits (15).
+ * The rest bytes are coded using BCD coding.
+ *
+ * For example, if the IMEI is "123456789012345", then it's coded as
+ * "1A 32 54 76 98 10 32 54".
+ */
+static gboolean parse_dataobj_imei(struct comprehension_tlv_iter *iter,
+						void *user)
+{
+	char **imei =3D user;
+	const unsigned char *data;
+	unsigned int len;
+	static const char digit_lut[] =3D "0123456789*#abc\0";
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D
+			STK_DATA_OBJECT_TYPE_IMEI)
+		return FALSE;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if (len !=3D 8)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	if ((data[0] & 0x0f) !=3D 0x0a)
+		return FALSE;
+
+	*imei =3D g_try_malloc(16);
+	(*imei)[0] =3D digit_lut[(data[0] & 0xf0) >> 4];
+	extract_bcd_number(data + 1, 7, *imei + 1);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -674,6 +715,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_file_list;
 	case STK_DATA_OBJECT_TYPE_LOCATION_INFO:
 		return parse_dataobj_location_info;
+	case STK_DATA_OBJECT_TYPE_IMEI:
+		return parse_dataobj_imei;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
-- =

1.6.3.3


--===============3636023952459857750==--

