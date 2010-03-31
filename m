Content-Type: multipart/mixed; boundary="===============8661479974872450589=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 03/11] Add parser for event list objects
Date: Wed, 31 Mar 2010 17:16:55 +0800
Message-ID: <1270027023-21468-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8661479974872450589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 37db3c3..ec64af3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -610,6 +610,24 @@ static gboolean parse_dataobj_items_next_action_indica=
tor(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.25 */
+static gboolean parse_dataobj_event_list(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_event_list *el =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len < 1) || (len > sizeof(el->list)))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	el->len =3D len;
+	memcpy(el->list, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -718,6 +736,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_default_text;
 	case STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR:
 		return parse_dataobj_items_next_action_indicator;
+	case STK_DATA_OBJECT_TYPE_EVENT_LIST:
+		return parse_dataobj_event_list;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index fb7a2d0..be89c9b 100644
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
 /* Defined in TS 102.223 Section 8.1 */
 struct stk_address {
 	unsigned char ton_npi;
@@ -370,6 +394,15 @@ struct stk_items_next_action_indicator {
 };
 =

 /*
+ * According to 102.223 Section 8.25, there are 21 kinds of event type and=
 no
+ * one should appear more than once.
+ */
+struct stk_event_list {
+	unsigned char list[21];
+	unsigned int len;
+};
+
+/*
  * Defined in TS 102.223 Section 8.31
  * Icon ID denotes a file on the SIM filesystem.  Since EF cannot have rec=
ord
  * ids of 0, we use icon_id with 0 to denote empty icon_identifier objects
-- =

1.6.3.3


--===============8661479974872450589==--

