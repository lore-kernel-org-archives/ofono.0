Content-Type: multipart/mixed; boundary="===============7995279310264637257=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 2/5] isimodem: Add functionality to UICC
Date: Wed, 03 Aug 2011 10:42:24 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB240F8@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7995279310264637257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 2e44037..41246b3 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -228,6 +228,127 @@ const char *mce_rf_state_name(enum mce_rf_state value)
 	return "MCE_RF<UNKNOWN>";
 }
 =

+const char *uicc_service_type_name(uint8_t value)
+{
+	switch (value) {
+		_(UICC_APPL_LIST);
+		_(UICC_APPL_HOST_ACTIVATE);
+		/*_(UICC_APPL_DEACTIVATE);*/
+		_(UICC_APPL_START_UP_COMPLETE);
+		/*_(UICC_SHUT_DOWN_INITIATED);*/
+		_(UICC_APPL_SHUT_DOWN_INITIATED);
+		_(UICC_APPL_STATUS_GET);
+		_(UICC_APPL_HOST_DEACTIVATE);
+		_(UICC_PIN_VERIFY);
+		_(UICC_PIN_UNBLOCK);
+		_(UICC_PIN_DISABLE);
+		_(UICC_PIN_ENABLE);
+		_(UICC_PIN_CHANGE);
+		_(UICC_PIN_SUBSTITUTE);
+		_(UICC_PIN_INFO);
+		_(UICC_PIN_PROMPT_VERIFY);
+		_(UICC_APPL_READ_TRANSPARENT);
+		_(UICC_APPL_UPDATE_TRANSPARENT);
+		_(UICC_APPL_READ_LINEAR_FIXED);
+		_(UICC_APPL_UPDATE_LINEAR_FIXED);
+		_(UICC_APPL_FILE_INFO);
+		_(UICC_APPL_APDU_SEND);
+		_(UICC_APPL_CLEAR_CACHE);
+		_(UICC_APPL_SESSION_START);
+		_(UICC_APPL_SESSION_END);
+		_(UICC_APPL_READ_CYCLIC);
+		_(UICC_APPL_UPDATE_CYCLIC);
+		/*_(UICC_APPL_CACHE_UPDATED);*/
+		_(UICC_CONNECT);
+		_(UICC_DISCONNECT);
+		_(UICC_RECONNECT);
+		_(UICC_CAT_ENABLE);
+		_(UICC_CAT_DISABLE);
+		_(UICC_CAT_TERMINAL_PROFILE);
+		_(UICC_CAT_TERMINAL_RESPONSE);
+		_(UICC_CAT_ENVELOPE);
+		_(UICC_CAT_POLLING_SET);
+		_(UICC_CAT_REFRESH);
+		_(UICC_CAT_POLL);
+		_(UICC_APDU_SEND);
+		_(UICC_APDU_ATR_GET);
+		_(UICC_APDU_CONTROL);
+		_(UICC_REFRESH_STATUS);
+		_(UICC_APPL_TERMINATED);
+		_(UICC_APPL_RECOVERED);
+		/*_(UICC_APPL_UNAVAILABLE);*/
+		/*_(UICC_APPL_SHUT_DOWN);*/
+		_(UICC_APPL_ACTIVATED);
+		_(UICC_PIN_VERIFY_NEEDED);
+		_(UICC_PIN_UNBLOCK_NEEDED);
+		_(UICC_PIN_PERMANENTLY_BLOCKED);
+		_(UICC_PIN_VERIFIED);
+		_(UICC_CAT_FETCHED_CMD);
+		_(UICC_CAT_NOT_SUPPORTED);
+		_(UICC_CAT_REG_FAILED);
+		_(UICC_CAT_REG_OK);
+		_(UICC_REFRESH_PERMISSION);
+		_(UICC_REFRESH_STARTING);
+		_(UICC_REFRESH_CANCELLED);
+		_(UICC_REFRESH_NOW);
+		_(UICC_START_UP_COMPLETE);
+		_(UICC_STATUS_GET);
+		_(UICC_READY);
+		/*_(UICC_READY_FOR_ACTIVATION);*/
+		_(UICC_INITIALIZED);
+		_(UICC_SHUTTING_DOWN);
+		/*_(UICC_SHUT_DOWN_CONFIG);*/
+		_(UICC_ERROR);
+		_(UICC_CARD_DISCONNECTED);
+		_(UICC_CARD_REMOVED);
+		_(UICC_CARD_NOT_PRESENT);
+		/*_(UICC_CARD_RESET);*/
+		_(UICC_CARD_READY);
+		_(UICC_CARD_STATUS_GET);
+		_(UICC_CARD_REJECTED);
+		_(UICC_CARD_INFO_GET);
+		_(UICC_SIMLOCK_ACTIVE);
+		_(UICC_APDU_SAP_ACTIVATE);
+		_(UICC_APDU_SAP_DEACTIVATE);
+		_(UICC_APDU_SAP_ATR_GET);
+		_(UICC_APDU_SAP_COLD_RESET);
+		_(UICC_APDU_SAP_WARM_RESET);
+		_(UICC_APDU_SAP_APDU_SEND);
+		_(UICC_APDU_SAP_RECOVERY);
+		_(UICC_APDU_SAP_CONFIG_GET);
+		_(UICC_PWR_CTRL_ENABLE);
+		_(UICC_PWR_CTRL_DISABLE);
+		_(UICC_PWR_CTRL_WAIT);
+		_(UICC_PWR_CTRL_PROCEED);
+		_(UICC_PWR_CTRL_PERMISSION);
+	}
+	return "UICC_SERVICE_<UNKNOWN>";
+}
+
+const char *uicc_details_name(uint8_t value)
+{
+
+	switch (value) {
+		/* Used when status differs from UICC_STATUS_FAIL */
+		_(UICC_NO_DETAILS);
+		/* Request was sent with one or more invalid parameter */
+		_(UICC_INVALID_PARAMETERS);
+		/* The file wasn't found */
+		_(UICC_FILE_NOT_FOUND);
+		/* User does not have the required priviledges for this */
+		_(UICC_SECURITY_CONDITIONS_NOT_SATISFIED);
+		/* Application can not be activated due to already active application */
+		_(UICC_APPL_CONFLICT);
+		/* Card Communication error */
+		_(UICC_CARD_ERROR);
+		/* Operation not supported */
+		_(UICC_SERVICE_NOT_SUPPORTED);
+		/* Session expired  */
+		_(UICC_SESSION_EXPIRED);
+	}
+	return "UICC_STATUS<UNKNOWN>";
+}
+
 const char *uicc_message_id_name(enum uicc_message_id value)
 {
 	switch (value) {




--===============7995279310264637257==--

