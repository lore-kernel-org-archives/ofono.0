Content-Type: multipart/mixed; boundary="===============1374007714961331402=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 3/9] Add parser for event list objects
Date: Tue, 30 Mar 2010 00:24:38 +0800
Message-ID: <1269879884-12741-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269879884-12741-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1374007714961331402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   10 ++++++++++
 src/stkutil.h |   24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b997752..ecd5639 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -679,6 +679,14 @@ static gboolean parse_dataobj_items_next_action_indica=
tor(
 			STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR);
 }
 =

+/* Defined in TS 102.223 Section 8.25 */
+static gboolean parse_dataobj_event_list(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	return parse_dataobj_common_byte_array(iter, user,
+				STK_DATA_OBJECT_TYPE_EVENT_LIST);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -798,6 +806,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_network_measurement_results;
 	case STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR:
 		return parse_dataobj_items_next_action_indicator;
+	case STK_DATA_OBJECT_TYPE_EVENT_LIST:
+		return parse_dataobj_event_list;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index cd43ae2..108529c 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -266,6 +266,30 @@ enum stk_tone_type {
 	STK_TONE_TYPE_MELODY_8 =3D	0x47
 };
 =

+enum stk_event_type {
+	STK_EVENT_TYPE_MT_CALL =3D				0x00,
+	STK_EVENT_TYPE_CALL_CONNECTED =3D				0x01,
+	STK_EVENT_TYPE_CALL_DISCONNECTED =3D			0x02,
+	STK_EVENT_TYPE_LOCATION_STATUS =3D			0x03,
+	STK_EVENT_TYPE_USER_ACTIVITY =3D				0x04,
+	STK_EVENT_TYPE_IDLE_SCREEN_AVAILABLE =3D			0x05,
+	STK_EVENT_TYPE_CARD_READER_STATUS =3D			0x06,
+	STK_EVENT_TYPE_LANGUAGE_SELECTION =3D			0x07,
+	STK_EVENT_TYPE_BROWSER_TERMINATION =3D			0x08,
+	STK_EVENT_TYPE_DATA_AVAILABLE =3D				0x09,
+	STK_EVENT_TYPE_CHANNEL_STATUS =3D				0x0A,
+	STK_EVENT_TYPE_SINGLE_ACCESS_TECHNOLOGY_CHANGE =3D	0x0B,
+	STK_EVENT_TYPE_DISPLAY_PARAMETERS_CHANGED =3D		0x0C,
+	STK_EVENT_TYPE_LOCAL_CONNECTION =3D			0x0D,
+	STK_EVENT_TYPE_NETWORK_SEARCH_MODE_CHANGE =3D		0x0E,
+	STK_EVENT_TYPE_BROWSING_STATUS =3D			0x0F,
+	STK_EVENT_TYPE_FRAMES_INFORMATION_CHANGE =3D		0x10,
+	STK_EVENT_TYPE_I_WLAN_ACCESS_STATUS =3D			0x11,
+	STK_EVENT_TYPE_NETWORK_REJECTION =3D			0x12,
+	STK_EVENT_TYPE_HCI_CONNECTIVITY_EVENT =3D			0x13,
+	STK_EVENT_TYPE_MULTIPLE_ACCESS_TECHNOLOGIES_CHANGE =3D	0x14
+};
+
 struct stk_common_byte_array {
 	unsigned int len;
 	unsigned char *array;
-- =

1.6.3.3


--===============1374007714961331402==--

