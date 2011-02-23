Content-Type: multipart/mixed; boundary="===============4304611578938010201=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 15/18] isimodem: code points for sms wgmodem2.5
Date: Wed, 23 Feb 2011 12:43:26 +0100
Message-ID: <838c559b62794111303f718abf1b9fd9d632f384.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4304611578938010201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/debug.c |   56 ++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/isimodem/debug.h |    1 +
 drivers/isimodem/sms.h   |   34 ++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 33e4dcb..1fd2226 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -53,6 +53,7 @@ const char *pn_resource_name(int value)
 		_(PN_GSS);
 		_(PN_GPDS);
 		_(PN_WRAN);
+		_(PN_UICC);
 	}
 	return "PN_<UNKNOWN>";
 }
@@ -218,6 +219,47 @@ const char *mce_rf_state_name(enum mce_rf_state value)
 	return "MCE_RF<UNKNOWN>";
 }
 =

+const char *uicc_message_id_name(enum uicc_message_id value)
+{
+	switch (value) {
+		_(UICC_REQ);
+		_(UICC_RESP);
+		_(UICC_IND);
+		_(UICC_CARD_REQ);
+		_(UICC_CARD_RESP);
+		_(UICC_CARD_IND);
+		_(UICC_APPLICATION_REQ);
+		_(UICC_APPLICATION_RESP);
+		_(UICC_APPLICATION_IND);
+		_(UICC_PIN_REQ);
+		_(UICC_PIN_RESP);
+		_(UICC_PIN_IND);
+		_(UICC_APPL_CMD_REQ);
+		_(UICC_APPL_CMD_RESP);
+		_(UICC_APPL_CMD_IND);
+		_(UICC_CONNECTOR_REQ);
+		_(UICC_CONNECTOR_RESP);
+		_(UICC_CAT_REQ);
+		_(UICC_CAT_RESP);
+		_(UICC_CAT_IND);
+		_(UICC_APDU_REQ);
+		_(UICC_APDU_RESP);
+		_(UICC_APDU_RESET_IND);
+		_(UICC_REFRESH_REQ);
+		_(UICC_REFRESH_RESP);
+		_(UICC_REFRESH_IND);
+		_(UICC_SIMLOCK_REQ);
+		_(UICC_SIMLOCK_RESP);
+		_(UICC_APDU_SAP_REQ);
+		_(UICC_APDU_SAP_RESP);
+		_(UICC_APDU_SAP_IND);
+		_(UICC_PWR_CTRL_REQ);
+		_(UICC_PWR_CTRL_RESP);
+		_(UICC_PWR_CTRL_IND);
+	}
+	return "UICC_<UNKNOWN>";
+}
+
 const char *uicc_status_name(uint8_t value)
 {
 	switch (value) {
@@ -403,6 +445,15 @@ const char *sms_message_id_name(enum sms_message_id va=
lue)
 		_(SMS_GSM_CB_ROUTING_RESP);
 		_(SMS_GSM_CB_ROUTING_NTF);
 		_(SMS_MESSAGE_SEND_STATUS_IND);
+		_(SMS_SETTINGS_UPDATE_REQ);
+		_(SMS_SETTINGS_UPDATE_RESP);
+		_(SMS_SETTINGS_READ_REQ);
+		_(SMS_SETTINGS_READ_RESP);
+		_(SMS_RECEIVED_MSG_REPORT_REQ);
+		_(SMS_RECEIVED_MSG_REPORT_RESP);
+		_(SMS_RECEIVE_MESSAGE_REQ);
+		_(SMS_RECEIVE_MESSAGE_RESP);
+		_(SMS_RECEIVED_MSG_IND);
 		_(SMS_COMMON_MESSAGE);
 	}
 	return "SMS_<UNKNOWN>";
@@ -420,6 +471,9 @@ const char *sms_subblock_name(enum sms_subblock value)
 		_(SMS_GSM_ROUTING);
 		_(SMS_GSM_CB_MESSAGE);
 		_(SMS_GSM_TPDU);
+		_(SMS_GSM_TPDU_25);
+		_(SMS_GSM_ROUTE_INFO);
+		_(SMS_GSM_PARAMETERS);
 		_(SMS_COMMON_DATA);
 		_(SMS_ADDRESS);
 	}
@@ -1224,6 +1278,8 @@ static const char *res_to_name(uint8_t res, uint8_t i=
d)
 		return gss_message_id_name(id);
 	case PN_GPDS:
 		return gpds_message_id_name(id);
+	case PN_UICC:
+		return uicc_message_id_name(id);
 	}
 	return "UNKNOWN";
 }
diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index db01f04..5648f7a 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -48,6 +48,7 @@ const char *mce_message_id_name(enum mce_message_id value=
);
 const char *mce_modem_state_name(enum mce_modem_state value);
 const char *mce_status_info(enum mce_status_info value);
 =

+const char *uicc_message_id_name(enum uicc_message_id value);
 const char *uicc_subblock_name(uint8_t value);
 const char *uicc_status_name(uint8_t value);
 =

diff --git a/drivers/isimodem/sms.h b/drivers/isimodem/sms.h
index cbfb124..a51adf2 100644
--- a/drivers/isimodem/sms.h
+++ b/drivers/isimodem/sms.h
@@ -55,6 +55,7 @@ enum sms_isi_cause {
 };
 =

 enum sms_isi_cause_type {
+	SMS_CAUSE_TYPE_COMMON =3D 0x00,
 	SMS_CAUSE_TYPE_GSM =3D 0x01,
 };
 =

@@ -125,6 +126,15 @@ enum sms_message_id {
 	SMS_GSM_CB_ROUTING_RESP =3D 0x0C,
 	SMS_GSM_CB_ROUTING_NTF =3D 0x0D,
 	SMS_MESSAGE_SEND_STATUS_IND =3D 0x22,
+	SMS_SETTINGS_UPDATE_REQ =3D 0x30,
+	SMS_SETTINGS_UPDATE_RESP =3D 0x31,
+	SMS_SETTINGS_READ_REQ =3D  0x32,
+	SMS_SETTINGS_READ_RESP =3D 0x33,
+	SMS_RECEIVED_MSG_REPORT_REQ =3D 0x3B,
+	SMS_RECEIVED_MSG_REPORT_RESP =3D 0x3C,
+	SMS_RECEIVE_MESSAGE_REQ =3D 0x41,
+	SMS_RECEIVE_MESSAGE_RESP =3D 0x42,
+	SMS_RECEIVED_MSG_IND =3D 0x43,
 	SMS_COMMON_MESSAGE =3D 0xF0
 };
 =

@@ -138,6 +148,9 @@ enum sms_subblock {
 	SMS_GSM_ROUTING =3D 0x0D,
 	SMS_GSM_CB_MESSAGE =3D 0x0E,
 	SMS_GSM_TPDU =3D 0x11,
+	SMS_GSM_TPDU_25 =3D 0x001C,
+	SMS_GSM_ROUTE_INFO =3D 0x0023,
+	SMS_GSM_PARAMETERS =3D 0x0031,
 	SMS_COMMON_DATA =3D 0x80,
 	SMS_ADDRESS =3D 0x82,
 };
@@ -175,6 +188,7 @@ enum sms_address_type {
 	SMS_UNICODE_ADDRESS =3D 0x00,
 	SMS_GSM_0340_ADDRESS =3D 0x01,
 	SMS_GSM_0411_ADDRESS =3D 0x02,
+	SMS_SMSC_ADDRESS =3D 0x02
 };
 =

 enum sms_sender_type {
@@ -192,6 +206,26 @@ enum sms_subject_list_type {
 	SMS_CB_NOT_ALLOWED_IDS_LIST =3D 0x01
 };
 =

+enum sms_reception_command {
+	SMS_RECEPTION_ACTIVATE =3D 0x01,
+	SMS_RECEPTION_DEACTIVATE =3D 0x02
+};
+
+enum sms_reception_status {
+	SMS_RECEPTION_ACTIVE =3D 0x01,
+	SMS_RECEPTION_INACTIVE =3D 0x02
+};
+
+enum sms_setting_type {
+	SMS_SETTING_TYPE_ROUTE =3D 0x02
+};
+
+enum sms_route_priority {
+	SMS_ROUTE_NOT_AVAILABLE =3D 0x00,
+	SMS_ROUTE_PRIORITY_1 =3D 0x01,
+	SMS_ROUTE_PRIORITY_2 =3D 0x02
+};
+
 #ifdef __cplusplus
 };
 #endif
-- =

1.7.3.5


--===============4304611578938010201==--

