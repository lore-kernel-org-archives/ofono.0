Content-Type: multipart/mixed; boundary="===============7524149123780433275=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 13/13] Add parser for broadcast network information objects
Date: Thu, 22 Apr 2010 23:12:30 +0800
Message-ID: <1271949150-9085-13-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7524149123780433275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   25 +++++++++++++++++++++++++
 src/stkutil.h |   19 +++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 75b0035..a457e36 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1803,6 +1803,29 @@ static gboolean parse_dataobj_activate_descriptor(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.90 */
+static gboolean parse_dataobj_broadcast_network_info(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_broadcast_network_information *bni =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 2)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	if (data[0] > 0x03)
+		return FALSE;
+
+	bni->tech =3D data[0];
+	bni->len =3D len - 1;
+	memcpy(bni->loc_info, data + 1, bni->len);
+
+	return TRUE;
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1970,6 +1993,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_registry_application_data;
 	case STK_DATA_OBJECT_TYPE_ACTIVATE_DESCRIPTOR:
 		return parse_dataobj_activate_descriptor;
+	case STK_DATA_OBJECT_TYPE_BROADCAST_NETWORK_INFO:
+		return parse_dataobj_broadcast_network_info;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index b7341c7..5d2a818 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -370,6 +370,13 @@ enum stk_frame_layout_type {
 	STK_LAYOUT_VERTICAL =3D 		0x02
 };
 =

+enum stk_broadcast_network_technology {
+	STK_BROADCAST_NETWORK_DVB_H =3D 0x00,
+	STK_BROADCAST_NETWORK_DVB_T =3D 0x01,
+	STK_BROADCAST_NETWORK_DVB_SH =3D 0x02,
+	STK_BROADCAST_NETWORK_T_DMB =3D 0x03
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -764,6 +771,18 @@ struct stk_registry_application_data {
 	char *name;
 };
 =

+/*
+ * According to 102.223 Section 8.90 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum length is 127 bytes for the total length of broadcast
+ * network technology and location information. Thus the maximum length of
+ * location information is 126 bytes.
+ */
+struct stk_broadcast_network_information {
+	unsigned char tech;
+	unsigned char loc_info[126];
+	unsigned int len;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
-- =

1.7.0.4


--===============7524149123780433275==--

