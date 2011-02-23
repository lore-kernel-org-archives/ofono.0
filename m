Content-Type: multipart/mixed; boundary="===============1283221353809564231=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 07/18] isimodem: code points uicc sim wgmodem2.5
Date: Wed, 23 Feb 2011 12:43:18 +0100
Message-ID: <c6aec5fe93a1b7935937739208f7b7d8e56876d0.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1283221353809564231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 Makefile.am              |    4 +-
 drivers/isimodem/debug.c |   84 +++++++++++++++
 drivers/isimodem/debug.h |    1 +
 drivers/isimodem/uicc.h  |  265 ++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 353 insertions(+), 1 deletions(-)
 create mode 100644 drivers/isimodem/uicc.h

diff --git a/Makefile.am b/Makefile.am
index aa4f3f9..f34f9ec 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -137,7 +137,9 @@ builtin_sources +=3D $(gisi_sources) \
 				drivers/isimodem/gprs.c \
 				drivers/isimodem/gprs-context.c \
 				drivers/isimodem/gpds.h \
-				drivers/isimodem/audio-settings.c
+				drivers/isimodem/audio-settings.c \
+				drivers/isimodem/uicc.h
+
 =

 builtin_modules +=3D isiusb
 builtin_sources +=3D plugins/isiusb.c
diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 10d0201..89e4573 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -214,6 +214,90 @@ const char *mce_rf_state_name(enum mce_rf_state value)
 	return "MCE_RF<UNKNOWN>";
 }
 =

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
index b92b48f..db01f04 100644
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
diff --git a/drivers/isimodem/uicc.h b/drivers/isimodem/uicc.h
new file mode 100644
index 0000000..2400767
--- /dev/null
+++ b/drivers/isimodem/uicc.h
@@ -0,0 +1,265 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) ST-Ericsson SA 2011.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ISIMODEM25_UICC_H
+#define __ISIMODEM25_UICC_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <gisi/client.h>
+
+#define PN_UICC 0x8C
+
+#define UICC_APPL_ID_UNKNOWN			0x00
+#define UICC_SFI_NOT_PRESENT			0x00
+#define UICC_SESSION_ID_NOT_USED		0x00
+
+enum uicc_status {
+	UICC_STATUS_OK =3D			0x00,
+	UICC_STATUS_FAIL =3D			0x01,
+	UICC_STATUS_UNKNOWN =3D			0x02,
+	UICC_STATUS_NOT_READY =3D			0x10,
+	UICC_STATUS_START_UP_COMPLETED =3D	0x11,
+	UICC_STATUS_SHUTTING_DOWN =3D		0x12,
+	UICC_STATUS_CARD_NOT_READY =3D		0x20,
+	UICC_STATUS_CARD_READY =3D		0x21,
+	UICC_STATUS_CARD_DISCONNECTED =3D		0x22,
+	UICC_STATUS_CARD_NOT_PRESENT =3D		0x23,
+	UICC_STATUS_CARD_REJECTED =3D		0x24,
+	UICC_STATUS_APPL_ACTIVE =3D		0x30,
+	UICC_STATUS_APPL_NOT_ACTIVE =3D		0x31,
+	UICC_STATUS_PIN_ENABLED =3D		0x40,
+	UICC_STATUS_PIN_DISABLED =3D		0x41
+};
+
+enum uicc_subblock {
+	UICC_SB_SHUT_DOWN_CONFIG =3D		0x0023,
+	UICC_SB_CARD_STATUS =3D			0x0001,
+	UICC_SB_CARD_INFO =3D			0x0024,
+	UICC_SB_CARD_REJECT_CAUSE =3D		0x0025,
+	UICC_SB_CLIENT =3D			0x001F,
+	UICC_SB_APPL_DATA_OBJECT =3D		0x0002,
+	UICC_SB_APPLICATION =3D			0x0003,
+	UICC_SB_APPL_INFO =3D			0x0004,
+	UICC_SB_APPL_STATUS =3D			0x0005,
+	UICC_SB_FCP =3D				0x0007,
+	UICC_SB_FCI =3D				0x001C,
+	UICC_SB_CHV =3D				0x001B,
+	UICC_SB_PIN =3D				0x0008,
+	UICC_SB_PIN_REF =3D			0x0009,
+	UICC_SB_PUK =3D				0x000A,
+	UICC_SB_PIN_SUBST =3D			0x000B,
+	UICC_SB_PIN_INFO =3D			0x000C,
+	UICC_SB_APPL_PATH =3D			0x000D,
+	UICC_SB_SESSION =3D			0x000E,
+	UICC_SB_FILE_DATA =3D			0x000F,
+	UICC_SB_APDU =3D				0x0014,
+	UICC_SB_TRANSPARENT_READ =3D		0x0010,
+	UICC_SB_TRANSPARENT_UPDATE =3D		0x0011,
+	UICC_SB_TRANSPARENT =3D			0x0012,
+	UICC_SB_LINEAR_FIXED =3D			0x0013,
+	UICC_SB_CYCLIC =3D			0x0026,
+	UICC_SB_TERMINAL_PROFILE =3D		0x0015,
+	UICC_SB_TERMINAL_RESPONSE =3D		0x001D,
+	UICC_SB_ENVELOPE =3D			0x0021,
+	UICC_SB_POLLING_SET =3D			0x0016,
+	UICC_SB_REFRESH =3D			0x0017,
+	UICC_SB_AID =3D				0x0006,
+	UICC_SB_REFRESH_RESULT =3D		0x0018,
+	UICC_SB_APDU_ACTIONS =3D			0x0019,
+	UICC_SB_OBJECT_ID =3D			0x001A,
+	UICC_SB_STATUS_WORD =3D			0x0020,
+	UICC_SB_APDU_SAP_INFO =3D			0x0022,
+	UICC_SB_ACCESS_MODE =3D			0x0027,
+	UICC_SB_RESP_INFO =3D			0x0028,
+	UICC_SB_APDU_SAP_CONFIG =3D		0x0029
+
+};
+
+enum uicc_message_id {
+	UICC_REQ =3D				0x00,
+	UICC_RESP =3D				0x01,
+	UICC_IND =3D				0x02,
+	UICC_CARD_REQ =3D				0x03,
+	UICC_CARD_RESP =3D			0x04,
+	UICC_CARD_IND =3D				0x05,
+	UICC_APPLICATION_REQ =3D			0x06,
+	UICC_APPLICATION_RESP =3D			0x07,
+	UICC_APPLICATION_IND =3D			0x08,
+	UICC_PIN_REQ =3D				0x09,
+	UICC_PIN_RESP =3D				0x0A,
+	UICC_PIN_IND =3D				0x0B,
+	UICC_APPL_CMD_REQ =3D			0x0C,
+	UICC_APPL_CMD_RESP =3D			0x0D,
+	UICC_APPL_CMD_IND =3D			0x0E,
+	UICC_CONNECTOR_REQ =3D			0x0F,
+	UICC_CONNECTOR_RESP =3D			0x10,
+	UICC_CAT_REQ =3D				0x12,
+	UICC_CAT_RESP =3D				0x13,
+	UICC_CAT_IND =3D				0x14,
+	UICC_APDU_REQ =3D				0x15,
+	UICC_APDU_RESP =3D			0x16,
+	UICC_APDU_RESET_IND =3D			0x17,
+	UICC_REFRESH_REQ =3D			0x18,
+	UICC_REFRESH_RESP =3D			0x19,
+	UICC_REFRESH_IND =3D			0x1A,
+	UICC_SIMLOCK_REQ =3D			0x1B,
+	UICC_SIMLOCK_RESP =3D			0x1C,
+	UICC_APDU_SAP_REQ =3D			0x1E,
+	UICC_APDU_SAP_RESP =3D			0x1F,
+	UICC_APDU_SAP_IND =3D			0x20,
+	UICC_PWR_CTRL_REQ =3D			0x21,
+	UICC_PWR_CTRL_RESP =3D			0x22,
+	UICC_PWR_CTRL_IND =3D			0x23
+};
+
+enum uicc_service_type {
+	UICC_APPL_LIST =3D			0x01,
+	UICC_APPL_HOST_ACTIVATE =3D		0x03,
+	UICC_APPL_START_UP_COMPLETE =3D		0x05,
+	UICC_APPL_SHUT_DOWN_INITIATED =3D		0x06,
+	UICC_APPL_STATUS_GET =3D			0x07,
+	UICC_APPL_HOST_DEACTIVATE =3D		0x09,
+	UICC_PIN_VERIFY =3D			0x11,
+	UICC_PIN_UNBLOCK =3D			0x12,
+	UICC_PIN_DISABLE =3D			0x13,
+	UICC_PIN_ENABLE =3D			0x14,
+	UICC_PIN_CHANGE =3D			0x15,
+	UICC_PIN_SUBSTITUTE =3D			0x16,
+	UICC_PIN_INFO =3D				0x17,
+	UICC_PIN_PROMPT_VERIFY =3D		0x18,
+	UICC_APPL_READ_TRANSPARENT =3D		0x21,
+	UICC_APPL_UPDATE_TRANSPARENT =3D		0x22,
+	UICC_APPL_READ_LINEAR_FIXED =3D		0x23,
+	UICC_APPL_UPDATE_LINEAR_FIXED =3D		0x24,
+	UICC_APPL_FILE_INFO =3D			0x25,
+	UICC_APPL_APDU_SEND =3D			0x26,
+	UICC_APPL_CLEAR_CACHE =3D			0x27,
+	UICC_APPL_SESSION_START	=3D		0x28,
+	UICC_APPL_SESSION_END =3D			0x29,
+	UICC_APPL_READ_CYCLIC =3D			0x2A,
+	UICC_APPL_UPDATE_CYCLIC =3D		0x2B,
+	UICC_CONNECT =3D				0x31,
+	UICC_DISCONNECT =3D			0x32,
+	UICC_RECONNECT =3D			0x33,
+	UICC_CAT_ENABLE =3D			0x41,
+	UICC_CAT_DISABLE =3D			0x42,
+	UICC_CAT_TERMINAL_PROFILE =3D		0x43,
+	UICC_CAT_TERMINAL_RESPONSE =3D		0x44,
+	UICC_CAT_ENVELOPE =3D			0x45,
+	UICC_CAT_POLLING_SET =3D			0x46,
+	UICC_CAT_REFRESH =3D			0x47,
+	UICC_CAT_POLL =3D				0x48,
+	UICC_APDU_SEND =3D			0x51,
+	UICC_APDU_ATR_GET =3D			0x52,
+	UICC_APDU_CONTROL =3D			0x53,
+	UICC_REFRESH_STATUS =3D			0x61,
+	UICC_APPL_TERMINATED =3D			0x71,
+	UICC_APPL_RECOVERED =3D			0x72,
+	UICC_APPL_ACTIVATED =3D			0x75,
+	UICC_PIN_VERIFY_NEEDED =3D		0x81,
+	UICC_PIN_UNBLOCK_NEEDED =3D		0x82,
+	UICC_PIN_PERMANENTLY_BLOCKED =3D		0x83,
+	UICC_PIN_VERIFIED =3D			0x84,
+	UICC_CAT_FETCHED_CMD =3D			0x91,
+	UICC_CAT_NOT_SUPPORTED =3D		0x92,
+	UICC_CAT_REG_FAILED =3D			0x93,
+	UICC_CAT_REG_OK =3D			0x94,
+	UICC_REFRESH_PERMISSION =3D		0xA1,
+	UICC_REFRESH_STARTING =3D			0xA2,
+	UICC_REFRESH_CANCELLED =3D		0xA3,
+	UICC_REFRESH_NOW =3D			0xA4,
+	UICC_START_UP_COMPLETE =3D		0xB0,
+	UICC_STATUS_GET =3D			0xB1,
+	UICC_READY =3D				0xB2,
+	UICC_READY_FOR_ACTIVATION =3D		0xB3,
+	UICC_INITIALIZED =3D			0xB4,
+	UICC_SHUTTING_DOWN =3D			0xB5,
+	UICC_SHUT_DOWN_CONFIG =3D			0xB6,
+	UICC_ERROR =3D				0xB7,
+	UICC_CARD_DISCONNECTED =3D		0xC0,
+	UICC_CARD_REMOVED =3D			0xC1,
+	UICC_CARD_NOT_PRESENT =3D			0xC2,
+	UICC_CARD_READY =3D			0xC4,
+	UICC_CARD_STATUS_GET =3D			0xC5,
+	UICC_CARD_REJECTED =3D			0xC8,
+	UICC_CARD_INFO_GET =3D			0xC9,
+	UICC_SIMLOCK_ACTIVE =3D			0xD0,
+	UICC_APDU_SAP_ACTIVATE =3D		0xE1,
+	UICC_APDU_SAP_DEACTIVATE =3D		0xE2,
+	UICC_APDU_SAP_ATR_GET =3D			0xE3,
+	UICC_APDU_SAP_COLD_RESET =3D		0xE4,
+	UICC_APDU_SAP_WARM_RESET =3D		0xE5,
+	UICC_APDU_SAP_APDU_SEND =3D		0xE6,
+	UICC_APDU_SAP_RECOVERY =3D		0xE7,
+	UICC_APDU_SAP_CONFIG_GET =3D		0xE8,
+	UICC_PWR_CTRL_ENABLE =3D			0xF1,
+	UICC_PWR_CTRL_DISABLE =3D			0xF2,
+	UICC_PWR_CTRL_WAIT =3D			0xF3,
+	UICC_PWR_CTRL_PROCEED =3D			0xF4,
+	UICC_PWR_CTRL_PERMISSION =3D		0xFA
+};
+
+enum uicc_appl_type_table {
+	UICC_APPL_TYPE_UNKNOWN =3D		0x00,
+	UICC_APPL_TYPE_ICC_SIM =3D		0x01,
+	UICC_APPL_TYPE_UICC_USIM =3D		0x02
+};
+enum uicc_pin_qualifier {
+	UICC_PIN_NEW =3D				0x01,
+	UICC_PIN_OLD =3D				0x02
+};
+enum uicc_appl_start_up_type {
+	UICC_APPL_START_UP_NO_INIT_PROC =3D	0x00,
+	UICC_APPL_START_UP_INIT_PROC =3D		0x01
+};
+enum uicc_card_type {
+	UICC_CARD_TYPE_ICC =3D			0x01,
+	UICC_CARD_TYPE_UICC =3D			0x02
+};
+enum uicc_details {
+	UICC_NO_DETAILS =3D			0x00,
+	UICC_INVALID_PARAMETERS =3D		0x01,
+	UICC_FILE_NOT_FOUND =3D			0x02
+};
+enum uicc_simlock_status {
+	UICC_SIMLOCK_STATUS_ACTIVE =3D		0x01,
+	UICC_SIMLOCK_STATUS_INACTIVE =3D		0x02
+};
+
+enum uicc_apdu_status_words {
+	UICC_PIN_STATUS_AUTH_RETRIES =3D		0x63c0,
+	UICC_PIN_STATUS_AUTH_BLOCKED =3D		0x6983,
+	UICC_PIN_STATUS_AUTH_FAILED =3D		0x9840
+};
+
+int get_app_id(GIsiModem *modem);
+int get_app_type(GIsiModem *modem);
+int get_client_id(GIsiModem *modem);
+struct ofono_sim_driver *get_sim_driver_func(void);
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* __ISIMODEM25_UICC_H */
-- =

1.7.3.5


--===============1283221353809564231==--

