Content-Type: multipart/mixed; boundary="===============2401503003867345681=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Tue, 01 Feb 2011 15:13:19 +0100
Message-ID: <ee97ff346483182ef6af8e5d023b10ffe12dd28f.1296569048.git.jessica.j.nilsson@stericsson.com>
In-Reply-To: <cover.1296569048.git.jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2401503003867345681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/debug.c   |  132 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/isimodem/debug.h   |    9 +++
 drivers/isimodem/mtc.h     |   38 +++++++++++++
 drivers/isimodem/version.h |   26 +++++++++
 4 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100644 drivers/isimodem/version.h

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 3d667b4..8b5fa16 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -165,6 +165,138 @@ const char *mtc_modem_state_name(enum mtc_modem_state=
 value)
 	return "MTC_<UNKNOWN>";
 }
 =

+const char *mce_message_id_name(enum mce_message_id value)
+{
+	switch (value) {
+		_(MCE_MODEM_STATE_IND);
+		_(MCE_MODEM_STATE_QUERY_REQ);
+		_(MCE_MODEM_STATE_QUERY_RESP);
+		_(MCE_RF_STATE_REQ);
+		_(MCE_RF_STATE_RESP);
+		_(MCE_RF_STATE_IND);
+		_(MCE_RF_STATE_QUERY_REQ);
+		_(MCE_RF_STATE_QUERY_RESP);
+		_(MCE_POWER_OFF_REQ);
+		_(MCE_POWER_OFF_RESP);
+	}
+	return "MCE_<UNKNOWN>";
+}
+
+const char *mce_modem_state_name(enum mce_modem_state value)
+{
+	switch (value) {
+		_(MCE_NORMAL);
+		_(MCE_LOCAL);
+		_(MCE_SW_RESET);
+		_(MCE_POWER_OFF);
+	}
+	return "MCE_<UNKNOWN>";
+}
+
+const char *mce_status_info(enum mce_status_info value)
+{
+	switch (value) {
+		_(MCE_OK);
+		_(MCE_FAIL);
+		_(MCE_ALREADY_ACTIVE);
+		_(MCE_TRANSITION_ONGOING);
+	}
+	return "MCE_<UNKNOWN>";
+}
+
+const char *mce_rf_state_name(enum mce_rf_state value)
+{
+	switch (value) {
+		_(MCE_RF_OFF);
+		_(MCE_RF_ON);
+	}
+	return "MCE_RF<UNKNOWN>";
+}
+
+const char *uicc_status_name(uint8_t value)
+{
+	switch (value) {
+		/* Request performed successfully */
+		_(UICC_STATUS_OK);
+		/* Error in performing the command */
+		_(UICC_STATUS_FAIL);
+		/* Status is Unknown */
+		_(UICC_STATUS_UNKNOWN);
+		/* Server is not ready */
+		_(UICC_STATUS_NOT_READY);
+		/* Server start up is completed */
+		_(UICC_STATUS_START_UP_COMPLETED);
+		/* Server is shutting down */
+		_(UICC_STATUS_SHUTTING_DOWN);
+		/* Smart card is not ready */
+		_(UICC_STATUS_CARD_NOT_READY);
+		/* Smart card is ready */
+		_(UICC_STATUS_CARD_READY);
+		/* Smart card is disconnected */
+		_(UICC_STATUS_CARD_DISCONNECTED);
+		/* Smart card is not present */
+		_(UICC_STATUS_CARD_NOT_PRESENT);
+		/* Smart card has been rejected */
+		_(UICC_STATUS_CARD_REJECTED);
+		/* Application is active */
+		_(UICC_STATUS_APPL_ACTIVE);
+		/* Application is not active */
+		_(UICC_STATUS_APPL_NOT_ACTIVE);
+		/* PIN verification used */
+		_(UICC_STATUS_PIN_ENABLED);
+		/* PIN verification not used */
+		_(UICC_STATUS_PIN_DISABLED);
+	}
+	return "UICC_STATUS<UNKNOWN>";
+}
+
+const char *uicc_subblock_name(uint8_t value)
+{
+	switch (value) {
+		_(UICC_SB_SHUT_DOWN_CONFIG);
+		_(UICC_SB_CARD_STATUS);
+		_(UICC_SB_CARD_INFO);
+		_(UICC_SB_CARD_REJECT_CAUSE);
+		_(UICC_SB_CLIENT);
+		_(UICC_SB_APPL_DATA_OBJECT);
+		_(UICC_SB_APPLICATION);
+		_(UICC_SB_APPL_INFO);
+		_(UICC_SB_APPL_STATUS);
+		_(UICC_SB_FCP);
+		_(UICC_SB_FCI);
+		_(UICC_SB_CHV);
+		_(UICC_SB_PIN);
+		_(UICC_SB_PIN_REF);
+		_(UICC_SB_PUK);
+		_(UICC_SB_PIN_SUBST);
+		_(UICC_SB_PIN_INFO);
+		_(UICC_SB_APPL_PATH);
+		_(UICC_SB_SESSION);
+		_(UICC_SB_FILE_DATA);
+		_(UICC_SB_APDU);
+		_(UICC_SB_TRANSPARENT_READ);
+		_(UICC_SB_TRANSPARENT_UPDATE);
+		_(UICC_SB_TRANSPARENT);
+		_(UICC_SB_LINEAR_FIXED);
+		_(UICC_SB_CYCLIC);
+		_(UICC_SB_TERMINAL_PROFILE);
+		_(UICC_SB_TERMINAL_RESPONSE);
+		_(UICC_SB_ENVELOPE);
+		_(UICC_SB_POLLING_SET);
+		_(UICC_SB_REFRESH);
+		_(UICC_SB_AID);
+		_(UICC_SB_REFRESH_RESULT);
+		_(UICC_SB_APDU_ACTIONS);
+		_(UICC_SB_OBJECT_ID);
+		_(UICC_SB_STATUS_WORD);
+		_(UICC_SB_APDU_SAP_INFO);
+		_(UICC_SB_ACCESS_MODE);
+		_(UICC_SB_RESP_INFO);
+		_(UICC_SB_APDU_SAP_CONFIG);
+	}
+	return "UICC_<UNKNOWN>";
+}
+
 const char *sms_isi_cause_name(enum sms_isi_cause value)
 {
 	switch (value) {
diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index e149c2c..db01f04 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -27,6 +27,7 @@
 #include "ss.h"
 #include "mtc.h"
 #include "sms.h"
+#include "uicc.h"
 #include "sim.h"
 #include "info.h"
 #include "call.h"
@@ -41,6 +42,14 @@ const char *ss_ussd_type_name(enum ss_ussd_type value);
 const char *mtc_isi_cause_name(enum mtc_isi_cause value);
 const char *mtc_message_id_name(enum mtc_message_id value);
 const char *mtc_modem_state_name(enum mtc_modem_state value);
+const char *mce_rf_state_name(enum mce_rf_state value);
+
+const char *mce_message_id_name(enum mce_message_id value);
+const char *mce_modem_state_name(enum mce_modem_state value);
+const char *mce_status_info(enum mce_status_info value);
+
+const char *uicc_subblock_name(uint8_t value);
+const char *uicc_status_name(uint8_t value);
 =

 const char *sms_gsm_cause_name(enum sms_gsm_cause value);
 const char *sms_isi_cause_name(enum sms_isi_cause value);
diff --git a/drivers/isimodem/mtc.h b/drivers/isimodem/mtc.h
index 2db3e94..57e5040 100644
--- a/drivers/isimodem/mtc.h
+++ b/drivers/isimodem/mtc.h
@@ -27,9 +27,47 @@ extern "C" {
 #endif
 =

 #define PN_MTC				0x15
+#define PN_MODEM_MCE			0xC2
 #define MTC_TIMEOUT			5
 #define MTC_STATE_REQ_TIMEOUT		(6 + 5)
 =

+enum mce_message_id {
+	MCE_MODEM_STATE_IND =3D		0x00,
+	MCE_MODEM_STATE_QUERY_REQ =3D     0x01,
+	MCE_MODEM_STATE_QUERY_RESP =3D    0x02,
+	MCE_RF_STATE_REQ =3D		0x03,
+	MCE_RF_STATE_RESP =3D		0x04,
+	MCE_RF_STATE_IND =3D		0x05,
+	MCE_RF_STATE_QUERY_REQ =3D	0x06,
+	MCE_RF_STATE_QUERY_RESP =3D       0x07,
+	MCE_POWER_OFF_REQ =3D		0x08,
+	MCE_POWER_OFF_RESP =3D		0x09
+};
+
+enum mce_rf_state {
+	MCE_RF_OFF =3D			0x00,
+	MCE_RF_ON =3D			0x01
+};
+
+enum mce_status_info {
+	MCE_OK =3D			0x00,
+	MCE_FAIL =3D			0x01,
+	MCE_ALREADY_ACTIVE =3D		0x06,
+	MCE_TRANSITION_ONGOING =3D	0x16
+};
+
+enum mce_modem_state {
+	MCE_NORMAL =3D			0x00,
+	MCE_LOCAL =3D			0x01,
+	MCE_SW_RESET =3D			0x80,
+	MCE_POWER_OFF =3D			0x81
+};
+
+enum mce_isi_action {
+	MCE_START =3D			0x03,
+	MCE_READY =3D			0x04
+};
+
 enum mtc_isi_cause {
 	MTC_OK =3D			0x00,
 	MTC_FAIL =3D			0x01,
diff --git a/drivers/isimodem/version.h b/drivers/isimodem/version.h
new file mode 100644
index 0000000..9b0a993
--- /dev/null
+++ b/drivers/isimodem/version.h
@@ -0,0 +1,26 @@
+
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) ST-Ericsson SA 2011.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+enum isi_version {
+	ISI_20 =3D 0,
+	ISI_25 =3D 1
+};
-- =

1.7.3.5


--===============2401503003867345681==--

