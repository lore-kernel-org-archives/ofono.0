Content-Type: multipart/mixed; boundary="===============4230075275003865095=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 1/9] Add parser for network measurement results objects
Date: Mon, 29 Mar 2010 16:03:41 +0000
Message-ID: <1269878605-12223-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4230075275003865095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 437dcdb..9a02658 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -619,6 +619,30 @@ static gboolean parse_dataobj_help_request(struct comp=
rehension_tlv_iter *iter,
 				STK_DATA_OBJECT_TYPE_HELP_REQUEST);
 }
 =

+/* Defined in TS 102.223 Section 8.22 */
+static gboolean parse_dataobj_network_measurement_results(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	char **nmr =3D user;
+	const unsigned char *data;
+	unsigned int len;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D
+			STK_DATA_OBJECT_TYPE_NETWORK_MEASUREMENT_RESULTS)
+		return FALSE;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if (len !=3D 0x10)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	/* Assume network measurement result is 16 bytes long */
+	memcpy(*nmr, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -734,6 +758,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_imei;
 	case STK_DATA_OBJECT_TYPE_HELP_REQUEST:
 		return parse_dataobj_help_request;
+	case STK_DATA_OBJECT_TYPE_NETWORK_MEASUREMENT_RESULTS:
+		return parse_dataobj_network_measurement_results;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
-- =

1.6.3.3


--===============4230075275003865095==--

