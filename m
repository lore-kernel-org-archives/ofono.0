Content-Type: multipart/mixed; boundary="===============4726941805307253667=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 05/11] Add parser for location status objects
Date: Wed, 31 Mar 2010 17:16:57 +0800
Message-ID: <1270027023-21468-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-4-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4726941805307253667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   26 ++++++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 08d013b..b04ef4c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -97,6 +97,21 @@ static gboolean parse_dataobj_common_bool(struct compreh=
ension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* For data object that only has one byte */
+static gboolean parse_dataobj_common_byte(
+		struct comprehension_tlv_iter *iter, unsigned char *out)
+{
+	const unsigned char *data;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	*out =3D data[0];
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.1 */
 static gboolean parse_dataobj_address(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -651,6 +666,15 @@ static gboolean parse_dataobj_cause(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.27 */
+static gboolean parse_dataobj_location_status(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *byte =3D user;
+
+	return parse_dataobj_common_byte(iter, byte);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -763,6 +787,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
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
index 21f6e8a..a87b4ef 100644
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


--===============4726941805307253667==--

