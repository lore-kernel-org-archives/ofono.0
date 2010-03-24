Content-Type: multipart/mixed; boundary="===============5850857891573615174=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 5/6] Add parser for imei objects
Date: Wed, 24 Mar 2010 17:35:46 +0800
Message-ID: <1269423347-15508-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269423347-15508-4-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5850857891573615174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a6b0284..3e423b5 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -549,6 +549,28 @@ static gboolean parse_dataobj_location_info(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.20 */
+static gboolean parse_dataobj_imei(struct comprehension_tlv_iter *iter,
+						void *user)
+{
+	char **imei =3D user;
+	const unsigned char *data;
+	unsigned int len;
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
+	memcpy(*imei, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -670,6 +692,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
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


--===============5850857891573615174==--

