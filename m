Content-Type: multipart/mixed; boundary="===============2197600234384306242=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 05/10] Add parser for location status objects
Date: Tue, 30 Mar 2010 15:57:32 +0800
Message-ID: <1269935857-4234-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269935857-4234-4-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2197600234384306242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   30 ++++++++++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 14d3999..37cb81e 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -67,6 +67,26 @@ static gboolean parse_dataobj_common_bool(struct compreh=
ension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* For data object that only has one byte */
+static gboolean parse_dataobj_common_byte(
+		struct comprehension_tlv_iter *iter, void *user,
+		enum stk_data_object_type type)
+{
+	char *byte =3D user;
+	const unsigned char *data;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D type)
+		return FALSE;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	*byte =3D data[0];
+
+	return TRUE;
+}
+
 /* For data object that only has a byte array with variable length */
 static gboolean parse_dataobj_common_byte_array(
 			struct comprehension_tlv_iter *iter,
@@ -715,6 +735,14 @@ static gboolean parse_dataobj_cause(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.27 */
+static gboolean parse_dataobj_location_status(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	return parse_dataobj_common_byte(iter, user,
+					STK_DATA_OBJECT_TYPE_LOCATION_STATUS);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -838,6 +866,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_event_list;
 	case STK_DATA_OBJECT_TYPE_CAUSE:
 		return parse_dataobj_cause;
+	case STK_DATA_OBJECT_TYPE_LOCATION_STATUS:
+		return parse_dataobj_location_status;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index e719403..00e351b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -290,6 +290,12 @@ enum stk_event_type {
 	STK_EVENT_TYPE_MULTIPLE_ACCESS_TECHNOLOGIES_CHANGE =3D	0x14
 };
 =

+enum stk_service_state {
+	STK_NORMAL_SERVICE =3D 	0x00,
+	STK_LIMITED_SERVICE =3D 	0x01,
+	STK_NO_SERVICE =3D 	0x02
+};
+
 /* Defined in TS 102.223 Section 8.1 */
 struct stk_address {
 	unsigned char ton_npi;
-- =

1.6.3.3


--===============2197600234384306242==--

