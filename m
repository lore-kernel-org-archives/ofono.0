Content-Type: multipart/mixed; boundary="===============8384001966812212621=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 08/18] isimodem: UICC sim support for wgmodem2.5
Date: Tue, 15 Feb 2011 13:31:02 +0100
Message-ID: <37312896b454b8453698ab6a8f5570a462919763.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8384001966812212621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 Makefile.am              |    4 +-
 drivers/isimodem/debug.c |   84 ++
 drivers/isimodem/debug.h |    1 +
 drivers/isimodem/sim.c   | 2381 ++++++++++++++++++++++++++++++++++++++++++=
++--
 drivers/isimodem/uicc.h  |  268 ++++++
 5 files changed, 2662 insertions(+), 76 deletions(-)
 create mode 100644 drivers/isimodem/uicc.h

diff --git a/Makefile.am b/Makefile.am
index 1b9afe8..7de8d8a 100644
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
diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index bfecbc9..0ef02f3 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2011.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -33,24 +34,216 @@
 =

 #include <gisi/message.h>
 #include <gisi/client.h>
+#include <gisi/iter.h>
 =

 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/sim.h>
-#include "simutil.h"
+#include <ofono/dbus.h>
 =

+#include "simutil.h"
 #include "isimodem.h"
 #include "isiutil.h"
 #include "sim.h"
+#include "uicc.h"
 #include "debug.h"
 =

-#define SIM_MAX_SPN_LENGTH	16
+#define PIN_PROMPT
+#define STATUS_WORD_HANDLING
+
+#define SIM_MAX_SPN_LENGTH		16
+#define CLIENT_ID			1
+
+
+/* File info parameters */
+#define FCP_TEMPLATE			0x62
+#define FCP_FILE_SIZE			0x80
+#define FCP_FILE_DESC			0x82
+#define FCP_FILE_ID			0x83
+#define FCP_FILE_LIFECYCLE		0x8A
+#define FCP_FILE_SECURITY_ARR		0x8B
+#define FCP_FILE_SECURITY_COMPACT	0x8C
+#define FCP_FILE_SECURITY_EXPANDED	0xAB
+#define FCP_PIN_STATUS			0xC6
+#define SIM_EFARR_FILEID		0x6F06
+#define ADF_USIM			0x7FFF
+#define MAX_SIM_APPS			10
+#define NOT_AVAILABLE			-1
+#define NOT_ACTIVATED			-1
 =

 struct sim_data {
 	GIsiClient *client;
+	GIsiClient *primary;
+	GIsiClient *secondary;
+	gboolean iccid;
 	gboolean registered;
+	gboolean uicc_app_started;
+	gboolean pin_state_received;
+	gboolean passwd_required;
+	int app_id;
+	int trying_app_id;
+	int app_type;
+	int trying_app_type;
+	uint8_t client_id;
+	uint8_t current_pin_id;
+	uint8_t pin1_id;
+	uint8_t pin2_id;
+};
+
+struct ofono_sim_local {
+	char *iccid;
+	char *imsi;
+	enum ofono_sim_phase phase;
+	unsigned char mnc_length;
+	GSList *own_numbers;
+	GSList *new_numbers;
+	GSList *service_numbers;
+	gboolean sdn_ready;
+	enum ofono_sim_state state;
+	enum ofono_sim_password_type pin_type;
+	gboolean locked_pins[OFONO_SIM_PASSWORD_INVALID];
+	char **language_prefs;
+	GQueue *simop_q;
+	gint simop_source;
+	unsigned char efmsisdn_length;
+	unsigned char efmsisdn_records;
+	unsigned char *efli;
+	unsigned char efli_length;
+	enum ofono_sim_cphs_phase cphs_phase;
+	unsigned char cphs_service_table[2];
+	struct ofono_watchlist *state_watches;
+	const struct ofono_sim_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+	DBusMessage *pending;
+};
+
+struct sim_passwd_to_pin_id {
+	uint8_t passwd_type;
+	uint8_t pin_id;
+};
+
+static struct sim_passwd_to_pin_id const pin_ids[] =3D {
+	{OFONO_SIM_PASSWORD_NONE, 0},
+	{OFONO_SIM_PASSWORD_SIM_PIN, 1},
+	{OFONO_SIM_PASSWORD_PHSIM_PIN, 0},
+	{OFONO_SIM_PASSWORD_PHFSIM_PIN, 0},
+	{OFONO_SIM_PASSWORD_SIM_PIN2, -1},
+	{OFONO_SIM_PASSWORD_PHNET_PIN, 0x11},
+	{OFONO_SIM_PASSWORD_PHNETSUB_PIN, 0},
+	{OFONO_SIM_PASSWORD_PHSP_PIN, 0},
+	{OFONO_SIM_PASSWORD_PHCORP_PIN, 0},
+	{OFONO_SIM_PASSWORD_SIM_PUK, -1},
+	{OFONO_SIM_PASSWORD_PHFSIM_PUK, 0},
+	{OFONO_SIM_PASSWORD_SIM_PUK2, -1},
+	{OFONO_SIM_PASSWORD_PHNET_PUK, 0},
+	{OFONO_SIM_PASSWORD_PHNETSUB_PUK, 0},
+	{OFONO_SIM_PASSWORD_PHSP_PUK, 0},
+	{OFONO_SIM_PASSWORD_PHCORP_PUK, 0},
+	{OFONO_SIM_PASSWORD_INVALID, 0}
+};
+
+const uint8_t upin_id =3D 0x11;
+
+/* Current SIM */
+static struct ofono_sim *uicc_sim;
+/* UICC client */
+static GIsiClient *pn_uicc_client;
+static int uicc_users;
+
+struct sim_applications {
+	int app_list[MAX_SIM_APPS];
+	int app_type[MAX_SIM_APPS];
+};
+
+struct sim_applications *sim_application_list_p;
+
+struct file_info {
+	int fileid;
+	int length;
+	int structure;
+	int record_length;
+	uint8_t access[3];
+	uint8_t file_status;
+};
+
+static struct file_info const static_file_info[] =3D {
+	{
+		SIM_EFSPN_FILEID, 17, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		0, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EF_ICCID_FILEID, 10, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		10, { 0x0f, 0xff, 0xee }
+	},
+	{
+		SIM_EFPL_FILEID, 1, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		1, { 0x0f, 0xff, 0xff }
+	}, /* not found */
+	{
+		SIM_EFLI_FILEID, 1, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		1, { 0x0f, 0xff, 0xff }
+	}, /* not found */
+	{
+		SIM_EFMSISDN_FILEID, 28, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		28, { 0x01, 0xff, 0xee }
+	},
+	{
+		SIM_EFAD_FILEID, 20, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		20, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EFPHASE_FILEID, 1, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		1, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EFPNN_FILEID, 4 * 18, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		18, { 0x0e, 0xff, 0xee }
+	}, /* 4 records, name 16 bytes */
+	{
+		SIM_EFOPL_FILEID, 4 * 24, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		24, { 0x0e, 0xff, 0xee }
+	}, /* 4 records, name 16 bytes */
+	{
+		SIM_EFMBI_FILEID, 5, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		5, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EFMWIS_FILEID, 6, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		6, { 0x01, 0xff, 0xee }
+	},
+	{
+		SIM_EFSPDI_FILEID, 64, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		64, { 0x0e, 0xff, 0xee }
+	},
+	{
+		SIM_EFECC_FILEID, 5 * 3, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		3, { 0x0e, 0xff, 0xee }
+	}, /* Can be also FIXED in 3G */
+	{
+		SIM_EFCBMIR_FILEID, 8 * 4, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		4, { 0x01, 0xff, 0xee }
+	}, /* 8 records */
+	{
+		SIM_EFCBMI_FILEID, 8 * 2, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		2, { 0x01, 0xff, 0xee }
+	}, /* 8 records */
+	{
+		SIM_EFCBMID_FILEID, 8 * 2, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		2, { 0x01, 0xff, 0x11 }
+	}, /* 8 records */
+	{
+		SIM_EFSMSP_FILEID, 56, OFONO_SIM_FILE_STRUCTURE_FIXED,
+		56, { 0x01, 0xff, 0xee }
+	},
+	{
+		SIM_EFIMSI_FILEID, 9, OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+		9, { 0x0e, 0xff, 0xee }
+	},
 };
 =

+static uint8_t get_sfi(const int fileid);
+
 struct sim_imsi {
 	uint8_t length;
 	uint8_t imsi[8];
@@ -66,14 +259,283 @@ struct sim_spn {
 	uint8_t disp_roam;
 };
 =

-struct file_info {
-	int fileid;
-	int length;
-	int structure;
-	int record_length;
-	uint8_t access[3];
-	uint8_t file_status;
-};
+static void handle_app_uicc_usim(GIsiSubBlockIter *iter,
+					struct sim_data *sd,
+					uint16_t *length,
+					uint16_t *record_length,
+					uint8_t *records,
+					uint8_t *structure);
+
+static void uicc_pin_prompt(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				ofono_sim_passwd_cb_t cb,
+				void *data,
+				uint8_t service);
+
+static void uicc_application_activate_req(GIsiClient *client,
+						void *opaque,
+						unsigned char appl_type,
+						unsigned char aid);
+
+static int sim_applications_get_next_index(struct sim_applications *sa,
+						int current_app)
+{
+	if (current_app < (MAX_SIM_APPS - 1)) {
+		int i;
+
+		for (i =3D ++current_app; i < MAX_SIM_APPS; i++) {
+			if (sa->app_list[i] &&
+				(sa->app_type[i] !=3D UICC_APPL_TYPE_UNKNOWN))
+				return i;
+		}
+	}
+
+	return NOT_AVAILABLE;
+}
+
+static uint8_t get_pin_id(struct sim_data *sd,
+				uint8_t passwd_type,
+				int8_t *index)
+{
+	const uint16_t MAX_INDEX =3D (sizeof(pin_ids)/sizeof(
+			struct sim_passwd_to_pin_id));
+	uint8_t i, pin_id;
+	*index =3D -1;
+
+	for (i =3D 0; i <  MAX_INDEX; i++) {
+		if (pin_ids[i].passwd_type =3D=3D passwd_type)
+			*index =3D i;
+	}
+
+	switch (passwd_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+	case OFONO_SIM_PASSWORD_SIM_PUK:
+		return sd->pin1_id;
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
+	case OFONO_SIM_PASSWORD_SIM_PUK2:
+		return sd->pin2_id;
+	default:
+
+		if (*index =3D=3D -1)
+			pin_id =3D 0;
+		else
+			pin_id =3D pin_ids[*index].pin_id;
+
+		return pin_id;
+	}
+}
+
+static void update_locked_pin(struct ofono_sim_local *local_sim,
+				uint8_t lock_type, uint8_t pinID)
+{
+	struct sim_data *sd =3D ofono_sim_get_data((struct ofono_sim *)local_sim);
+
+	switch (lock_type) {
+	case UICC_PIN_VERIFY_NEEDED:
+
+		if (pinID <=3D sd->pin1_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_SIM_PIN;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_SIM_PIN] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		} else if (pinID =3D=3D sd->pin2_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_SIM_PIN2;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_SIM_PIN2] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		} else if (pinID =3D=3D upin_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_PHNET_PIN;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_PHNET_PIN] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		}
+
+		break;
+	case UICC_PIN_UNBLOCK_NEEDED:
+
+		if (pinID =3D=3D sd->pin1_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_SIM_PUK;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_SIM_PUK] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		} else if (pinID =3D=3D sd->pin2_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_SIM_PUK2;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_SIM_PUK2] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		} else if (pinID =3D=3D upin_id) {
+			local_sim->pin_type =3D
+				OFONO_SIM_PASSWORD_PHNET_PUK;
+			local_sim->locked_pins[
+				OFONO_SIM_PASSWORD_PHNET_PUK] =3D TRUE;
+			sd->passwd_required =3D TRUE;
+		}
+
+		break;
+	default:
+		break;
+	}
+}
+
+static gboolean get_fileid_path(struct ofono_sim *sim,
+				int *mf_path,
+				int *df1_path,
+				int *df2_path,
+				unsigned char *df_len,
+				int fileid)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	switch (fileid) {
+	case SIM_EFPL_FILEID:
+	case SIM_EF_ICCID_FILEID:
+		*mf_path =3D SIM_MF_FILEID;
+		*df1_path =3D 0x0000;
+		*df2_path =3D 0x0000;
+		*df_len =3D 2;
+		break;
+	case SIM_EFSMSP_FILEID:
+	case SIM_EFSDN_FILEID:
+	case SIM_EFMSISDN_FILEID:
+		*mf_path =3D SIM_MF_FILEID;
+
+		if (UICC_APPL_TYPE_ICC_SIM =3D=3D sd->app_type)
+			*df1_path =3D SIM_DFTELECOM_FILEID;
+		else
+			*df1_path =3D ADF_USIM;
+
+		*df2_path =3D 0x0000;
+		*df_len =3D 4;
+		break;
+	case SIM_EFLI_FILEID:
+	case SIM_EFSPN_FILEID:
+	case SIM_EFAD_FILEID:
+	case SIM_EFPNN_FILEID:
+	case SIM_EFOPL_FILEID:
+	case SIM_EFMBDN_FILEID:
+	case SIM_EFMBI_FILEID:
+	case SIM_EFMWIS_FILEID:
+	case SIM_EFSPDI_FILEID:
+	case SIM_EFECC_FILEID:
+	case SIM_EFCBMI_FILEID:
+	case SIM_EFCBMIR_FILEID:
+	case SIM_EFCBMID_FILEID:
+	case SIM_EFIMSI_FILEID:
+	case SIM_EFPHASE_FILEID: /* 3GPP TS 11.11 */
+	case SIM_EFARR_FILEID:
+	case SIM_EF_CPHS_INFORMATION_FILEID:
+		*mf_path =3D SIM_MF_FILEID;
+
+		if (UICC_APPL_TYPE_ICC_SIM =3D=3D sd->app_type)
+			*df1_path =3D SIM_DFGSM_FILEID;
+		else
+			*df1_path =3D ADF_USIM;
+
+		*df2_path =3D 0x0000;
+		*df_len =3D 4;
+		break;
+		/* No info */
+	case SIM_EF_CPHS_MBDN_FILEID:
+	case SIM_EF_CPHS_MWIS_FILEID:
+		DBG("=3D=3D=3D=3D=3D=3D=3D=3D No path info for %04X", fileid);
+		return FALSE;
+	case SIM_EFADN_FILEID: /* Only for SIM */
+	case SIM_EFEXT1_FILEID: /* Only for SIM */
+		*mf_path =3D SIM_MF_FILEID;
+		*df1_path =3D SIM_DFTELECOM_FILEID;
+		*df2_path =3D 0x0000;
+		*df_len =3D 4;
+		break;
+	default:
+		*mf_path =3D SIM_MF_FILEID;
+		*df1_path =3D SIM_DFTELECOM_FILEID;
+		*df2_path =3D SIM_DFPHONEBOOK_FILEID;
+		*df_len =3D 6;
+		break;
+	}
+
+	return TRUE;
+}
+
+static uint8_t get_sfi(const int fileid)
+{
+	uint8_t ret;
+
+	/* SFI list from 3GPP TS 31.102 Annex H */
+	switch (fileid) {
+	case SIM_EFECC_FILEID:
+		ret =3D 01;
+		break;
+	case SIM_EFLI_FILEID:
+		ret =3D 02;
+		break;
+	case SIM_EFAD_FILEID:
+		ret =3D 03;
+		break;
+	case SIM_EFIMSI_FILEID:
+		ret =3D 07;
+		break;
+	case SIM_EFCBMID_FILEID:
+		ret =3D 0x0E;
+		break;
+	case SIM_EFPNN_FILEID:
+		ret =3D 0x19;
+		break;
+	case SIM_EFOPL_FILEID:
+		ret =3D 0x1A;
+		break;
+	default:
+		ret =3D UICC_SFI_NOT_PRESENT;
+		break;
+	}
+
+	return ret;
+}
+
+int get_app_id(void)
+{
+	if (uicc_sim) {
+		struct sim_data *sd =3D ofono_sim_get_data(uicc_sim);
+		DBG("app_id %d", sd->app_id);
+		return sd->app_id;
+	} else
+		return -1;
+}
+
+int get_app_type(void)
+{
+	if (uicc_sim) {
+		struct sim_data *sd =3D ofono_sim_get_data(uicc_sim);
+		DBG("app_type %d", sd->app_type);
+		return sd->app_type;
+	} else
+		return -1;
+}
+
+int get_client_id(void)
+{
+	if (uicc_sim) {
+		struct sim_data *sd =3D ofono_sim_get_data(uicc_sim);
+		DBG("client_id %d", sd->client_id);
+		return sd->client_id;
+	} else
+		return -1;
+}
+
+GIsiClient *read_pn_uicc_client(void)
+{
+	return pn_uicc_client;
+}
+
+struct ofono_sim *get_sim(void)
+{
+	return uicc_sim;
+}
 =

 /* Returns file info */
 static gboolean fake_file_info(gpointer user)
@@ -89,29 +551,6 @@ static gboolean fake_file_info(gpointer user)
 	return FALSE;
 }
 =

-static void isi_read_file_info(struct ofono_sim *sim, int fileid,
-				ofono_sim_file_info_cb_t cb, void *data)
-{
-	int i;
-	static struct file_info const info[] =3D {
-		{ SIM_EFSPN_FILEID, 17, 0, 0, { 0x0f, 0xff, 0xff }, 1 },
-		{ SIM_EF_ICCID_FILEID, 10, 0, 0, { 0x0f, 0xff, 0xff }, 1 },
-	};
-	int N =3D sizeof(info) / sizeof(info[0]);
-	struct isi_cb_data *cbd;
-
-	for (i =3D 0; i < N; i++) {
-		if (fileid =3D=3D info[i].fileid) {
-			cbd =3D isi_cb_data_new((void *) &info[i], cb, data);
-			g_idle_add(fake_file_info, cbd);
-			return;
-		}
-	}
-
-	DBG("Fileid %04X not implemented", fileid);
-	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0, data);
-}
-
 static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgi=
d,
 					uint8_t service)
 {
@@ -129,7 +568,10 @@ static gboolean check_response_status(const GIsiMessag=
e *msg, uint8_t msgid,
 		return FALSE;
 	}
 =

-	if (!g_isi_msg_data_get_byte(msg, 1, &cause) || cause !=3D SIM_SERV_OK) {
+	if ((!g_isi_msg_data_get_byte(msg, 1, &cause) ||
+			cause !=3D SIM_SERV_OK) &&
+			(!g_isi_msg_data_get_byte(msg, 2, &cause) ||
+					cause !=3D UICC_STATUS_OK)) {
 		DBG("Request failed: %s", sim_isi_cause_name(cause));
 		return FALSE;
 	}
@@ -141,6 +583,303 @@ static gboolean check_response_status(const GIsiMessa=
ge *msg, uint8_t msgid,
 	return TRUE;
 }
 =

+static void handle_app_uicc_usim(GIsiSubBlockIter *iter,
+					struct sim_data *sd,
+					uint16_t *length,
+					uint16_t *record_length,
+					uint8_t *records, uint8_t *structure)
+{
+	uint8_t fcp;
+	uint8_t fcp_len;
+	uint8_t read =3D 0;
+	uint8_t id;
+	uint8_t item_len;
+	uint16_t file_id;
+	uint8_t desc;
+	uint8_t coding;
+	uint8_t pin_do_len;
+	uint8_t pin_len;
+	uint8_t pin_tag;
+	uint8_t pin_id;
+	uint8_t pin_tag_pos;
+
+
+	(void)g_isi_sb_iter_get_byte(iter, &fcp, 8);
+	if (fcp =3D=3D FCP_TEMPLATE) {
+		(void) g_isi_sb_iter_get_byte(iter, &fcp_len, 9);
+		while (read < fcp_len) {
+			(void) g_isi_sb_iter_get_byte(iter, &id, read + 10);
+			(void) g_isi_sb_iter_get_byte(iter, &item_len,
+					read + 11);
+
+			switch (id) {
+			case FCP_FILE_SIZE:
+				if (item_len =3D=3D 2) {
+					g_isi_sb_iter_get_word(iter, length,
+								read + 10 + 2);
+				}
+				break;
+			case FCP_FILE_ID:
+
+				if (item_len =3D=3D 2) {
+					g_isi_sb_iter_get_word(iter, &file_id,
+								read + 10 + 2);
+				}
+				break;
+			case FCP_FILE_DESC:
+				if (item_len >=3D 2) {
+					g_isi_sb_iter_get_byte(iter, &desc,
+								read + 10 + 2);
+					g_isi_sb_iter_get_byte(iter, &coding,
+								read + 10 + 3);
+				}
+
+				if (item_len >=3D 4) {
+					g_isi_sb_iter_get_word(iter,
+								record_length,
+								read + 10 + 4);
+					g_isi_sb_iter_get_byte(iter, records,
+								read + 10 + 6);
+				}
+				break;
+			case FCP_PIN_STATUS:
+				g_isi_sb_iter_get_byte(iter, &pin_do_len,
+							read + 10 + 3);
+				pin_tag_pos =3D read + 10 + 4 + pin_do_len;
+				g_isi_sb_iter_get_byte(iter, &pin_tag,
+							pin_tag_pos);
+
+				while (pin_tag =3D=3D 0x83) {
+
+					g_isi_sb_iter_get_byte(iter, &pin_len,
+							pin_tag_pos + 1);
+					g_isi_sb_iter_get_byte(iter, &pin_id,
+							pin_tag_pos + 2);
+
+					pin_tag_pos +=3D 2 + pin_len;
+					g_isi_sb_iter_get_byte(iter, &pin_tag,
+								pin_tag_pos);
+
+					if ((0x01 <=3D pin_id) &&
+							(pin_id <=3D 0x08))
+						sd->pin1_id =3D pin_id;
+					else if ((0x81 <=3D pin_id) &&
+							(pin_id <=3D 0x88))
+						sd->pin2_id =3D pin_id;
+					read +=3D item_len + 2;
+				}
+				break;
+			case FCP_FILE_SECURITY_ARR:
+			case FCP_FILE_SECURITY_COMPACT:
+			case FCP_FILE_SECURITY_EXPANDED:
+
+			/* Not implemented, using
+			 * static access rules as these
+			 * are used only for caching
+			 * See ETSI TS 102 221, ch
+			 * 11.1.1.4.7 and
+			 * Annexes E,F and G
+			 */
+			case FCP_FILE_LIFECYCLE:
+			default:
+				DBG("FCP id %02X not supported", id);
+				break;
+			}
+
+			/*Data length + id size + len size */
+			read +=3D item_len + 2;
+		}
+	}
+	if ((desc & 7) =3D=3D 1)
+		*structure =3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT;
+	else if ((desc & 7) =3D=3D 2)
+		*structure =3D OFONO_SIM_FILE_STRUCTURE_FIXED;
+	else if ((desc & 7) =3D=3D 6)
+		*structure =3D OFONO_SIM_FILE_STRUCTURE_CYCLIC;
+}
+
+static void isi_file_info_resp(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_file_info_cb_t cb =3D cbd->cb;
+	uint16_t length =3D 0;
+	uint16_t record_length =3D 0;
+	uint8_t structure =3D -1;
+	uint8_t records =3D 0;
+	uint16_t file_id =3D 0;
+	uint8_t access[3] =3D {0, 0, 0};
+	uint8_t item_len =3D 0;
+	gboolean everything_ok =3D FALSE;
+	/*Access is read from static file info*/
+	struct file_info const *info =3D cbd->user;
+	GIsiSubBlockIter iter;
+	struct sim_data *sd =3D ofono_sim_get_data(uicc_sim);
+	uint8_t sbcount =3D 0;
+
+	if (!check_response_status(msg,	UICC_APPL_CMD_RESP,
+					UICC_APPL_FILE_INFO))
+		goto error;
+
+	if (info !=3D NULL) {
+		access[0] =3D info->access[0];
+		access[1] =3D info->access[1];
+		access[2] =3D info->access[2];
+	}
+	g_isi_msg_data_get_byte(msg, 5, &sbcount);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_FCI:
+			DBG("UICC_SB_FCI");
+			everything_ok =3D TRUE;
+
+			switch (sd->app_type) {
+			case UICC_APPL_TYPE_UICC_USIM:
+				DBG("UICC_APPL_TYPE_UICC_USIM");
+				handle_app_uicc_usim(&iter, sd,
+						&length, &record_length,
+						&records, &structure);
+
+				break;
+			case UICC_APPL_TYPE_ICC_SIM:
+				DBG("UICC_APPL_TYPE_ICC_SIM");
+				g_isi_sb_iter_get_word(&iter, &length, 10);
+				g_isi_sb_iter_get_word(&iter, &file_id, 12);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&access[0],
+								16);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&access[0],
+								17);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&access[0],
+								18);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&item_len, 20);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&structure,
+								21);
+
+				if (item_len =3D=3D 2)
+					(void)g_isi_sb_iter_get_byte(&iter,
+						(uint8_t *)&record_length,
+						22);
+
+				break;
+			default:
+				DBG("UICC application type %d not supported",
+					sd->app_type);
+				break;
+			}
+
+			break;
+		default:
+			DBG("Skipping SB");
+			break;
+		}
+
+		if (g_isi_sb_iter_next(&iter) =3D=3D FALSE)
+			goto error;
+	}
+
+	if (everything_ok) {
+		CALLBACK_WITH_SUCCESS(cb, length, structure, record_length,
+				      access, '\n', cbd->data);
+		return;
+	}
+
+error:
+	DBG("Error reading file info");
+	CALLBACK_WITH_FAILURE(cb, 0, 0, 0, access, '\n', cbd->data);
+}
+
+static void isi_read_file_info(struct ofono_sim *sim, int fileid,
+				ofono_sim_file_info_cb_t cb, void *data)
+{
+	int i;
+	static struct file_info const info[] =3D {
+		{ SIM_EFSPN_FILEID, 17, 0, 0, { 0x0f, 0xff, 0xff }, 1 },
+		{ SIM_EF_ICCID_FILEID, 10, 0, 0, { 0x0f, 0xff, 0xff }, 1 },
+	};
+	int N =3D sizeof(info) / sizeof(info[0]);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd;
+
+	if ((sd !=3D NULL) && g_isi_client_resource(sd->client) =3D=3D PN_UICC) {
+		/* Prepare for static file info used for access rights */
+		int i;
+		int mf_path =3D 0;
+		int df1_path =3D 0;
+		int df2_path =3D 0;
+		unsigned char df_len =3D 0;
+
+		N =3D sizeof(static_file_info) / sizeof(static_file_info[0]);
+		cbd =3D isi_cb_data_new(NULL, cb, data);
+		DBG("File info for ID=3D%04X app id %d", fileid, sd->app_id);
+
+		for (i =3D 0; i < N; i++) {
+			if (fileid =3D=3D static_file_info[i].fileid &&
+					cbd !=3D NULL) {
+				cbd->user =3D (void *) &static_file_info[i];
+				continue;
+			}
+		}
+		if (!get_fileid_path(sim, &mf_path, &df1_path,
+					&df2_path, &df_len, fileid)) {
+			g_free(cbd);
+			goto error;
+		}
+		if (cbd) {
+			const unsigned char msg[] =3D {
+				UICC_APPL_CMD_REQ,
+				UICC_APPL_FILE_INFO,
+				sd->app_id,
+				UICC_SESSION_ID_NOT_USED, /*Session ID*/
+				0, /*Filler*/
+				0, /*Filler*/
+				1, /*number of subblocks*/
+			/* Subblock 1*/
+				UICC_SB_APPL_PATH >> 8,
+				UICC_SB_APPL_PATH & 0xff,
+				0,
+				16, /*Sub block length*/
+				fileid >> 8, /* UICC elementary file ID*/
+				fileid & 0xFF,
+				get_sfi(fileid), /* Elementary file short id*/
+				0, /*filler*/
+				df_len, /*DF Path length*/
+				0, /*Filler*/
+				mf_path >> 8,
+				mf_path & 0xff,
+				df1_path >> 8, /*DF Path*/
+				df1_path & 0xFF,
+				df2_path >> 8, /*DF Path*/
+				df2_path & 0xFF,
+			};
+			g_isi_client_send(sd->client, msg, sizeof(msg),
+				isi_file_info_resp, cbd, g_free);
+			return;
+		}
+	} else {
+		for (i =3D 0; i < N; i++) {
+			if (fileid =3D=3D info[i].fileid) {
+				cbd =3D isi_cb_data_new((void *) &info[i], cb,
+						data);
+				g_idle_add(fake_file_info, cbd);
+				return;
+			}
+		}
+
+	}
+error:
+	DBG("Fileid %04X not implemented", fileid);
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0, data);
+}
+
 static void spn_resp_cb(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd =3D data;
@@ -234,32 +973,142 @@ static gboolean isi_read_iccid(struct ofono_sim *sim=
, struct isi_cb_data *cbd)
 					read_iccid_resp_cb, cbd, g_free);
 }
 =

+static void isi_read_file_transparent_resp(const GIsiMessage *msg, void *d=
ata)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	uint32_t filelen =3D 0;
+	unsigned char filedata[256] =3D { 0xff };
+	gboolean everything_ok =3D FALSE;
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
+
+	if (!check_response_status(msg, UICC_APPL_CMD_RESP,
+			UICC_APPL_READ_TRANSPARENT))
+		goto error;
+
+	g_isi_msg_data_get_byte(msg, 5, &sbcount);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_FILE_DATA:
+			g_isi_sb_iter_get_dword(&iter, &filelen, 4);
+			memmove(&filedata, iter.start + 8, filelen);
+			everything_ok =3D TRUE;
+			break;
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	if (everything_ok) {
+		DBG("Transparent EF read: 1st byte %02x, len %d",
+			filedata[0], filelen);
+		CALLBACK_WITH_SUCCESS(cb, filedata, filelen, cbd->data);
+		return;
+	}
+
+error:
+	DBG("Error reading transparent EF");
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+}
+
 static void isi_read_file_transparent(struct ofono_sim *sim, int fileid,
 					int start, int length,
 					ofono_sim_read_cb_t cb, void *data)
 {
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct isi_cb_data *cbd;
 	gboolean done;
 =

 	cbd =3D isi_cb_data_new(sim, cb, data);
-	if (cbd =3D=3D NULL)
+
+	if (cbd =3D=3D NULL || sd =3D=3D NULL)
 		goto error;
 =

-	switch (fileid) {
-	case SIM_EFSPN_FILEID:
-		done =3D isi_read_spn(sim, cbd);
-		break;
+	if (g_isi_client_resource(sd->client) =3D=3D PN_UICC) {
+		int mf_path =3D 0;
+		int df1_path =3D 0;
+		int df2_path =3D 0;
+		unsigned char df_len =3D 0;
+
+		DBG("File ID=3D%04X, client %d, AID %d",
+			fileid, sd->client_id, sd->app_id);
+
+		if (get_fileid_path(sim, &mf_path, &df1_path,
+				&df2_path, &df_len, fileid)) {
+			const unsigned char msg[] =3D {
+				UICC_APPL_CMD_REQ,
+				UICC_APPL_READ_TRANSPARENT,
+				sd->app_id,
+				UICC_SESSION_ID_NOT_USED, /*Session ID*/
+				0, /*Filler*/
+				0, /*Filler*/
+				3, /*number of subblocks*/
+				/* Subblock 1 */
+				UICC_SB_CLIENT >> 8,
+				UICC_SB_CLIENT & 0xff,
+				0,
+				8, /*Sub block length*/
+				0, 0, 0, /* Filler */
+				sd->client_id,
+				/* Subblock 2*/
+				UICC_SB_TRANSPARENT >> 8,
+				UICC_SB_TRANSPARENT & 0xff,
+				0, /*Sub block length*/
+				8, /*Sub block length*/
+				0, /*File offset (0=3Dbeginning)*/
+				0, /*File offset (0=3Dbeginning)*/
+				0, /*Data amount (0=3Dall)*/
+				0, /*Data amount (0=3Dall)*/
+				/* Subblock 3 */
+				UICC_SB_APPL_PATH >> 8,
+				UICC_SB_APPL_PATH & 0xff,
+				0,
+				16, /* Sub block length*/
+				fileid >> 8, /* UICC elementary file ID*/
+				fileid & 0xFF,
+				get_sfi(fileid),/*Elementary file short id*/
+				0, /*filler*/
+				df_len, /*DF Path length*/
+				0, /*Filler*/
+				mf_path >> 8,
+				mf_path & 0xff,
+				df1_path >> 8, /*DF Path*/
+				df1_path & 0xFF,
+				df2_path >> 8, /*DF Path*/
+				df2_path & 0xFF
+			};
+			g_isi_client_send_with_timeout(
+				sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+				isi_read_file_transparent_resp, cbd, g_free);
+			return;
+		}
+		goto error;
 =

-	case SIM_EF_ICCID_FILEID:
-		done =3D isi_read_iccid(sim, cbd);
-		break;
+	} else {
+		switch (fileid) {
+		case SIM_EFSPN_FILEID:
+			done =3D isi_read_spn(sim, cbd);
+			break;
 =

-	default:
-		done =3D FALSE;
-	}
+		case SIM_EF_ICCID_FILEID:
+			done =3D isi_read_iccid(sim, cbd);
+			break;
 =

-	if (done)
-		return;
+		default:
+			done =3D FALSE;
+		}
+
+		if (done)
+			return;
+	}
 =

 	DBG("Fileid %04X not implemented", fileid);
 =

@@ -268,12 +1117,125 @@ error:
 	g_free(cbd);
 }
 =

-static void isi_read_file_linear(struct ofono_sim *sim, int fileid,
-					int record, int length,
-					ofono_sim_read_cb_t cb, void *data)
+static void isi_read_file_linear_fixed_resp(const GIsiMessage *msg, void *=
data)
 {
-	DBG("Fileid %04X not implemented", fileid);
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	uint32_t filelen =3D 0;
+	unsigned char filedata[256] =3D { 0xff };
+	gboolean everything_ok =3D FALSE;
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
+
+	if (!check_response_status(msg, UICC_APPL_CMD_RESP,
+			UICC_APPL_READ_LINEAR_FIXED))
+		goto error;
+
+	everything_ok =3D FALSE;
+	g_isi_msg_data_get_byte(msg, 5, &sbcount);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_FILE_DATA:
+			g_isi_sb_iter_get_dword(&iter, &filelen, 4);
+			memmove(&filedata, iter.start + 8, filelen);
+			everything_ok =3D TRUE;
+			break;
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	if (everything_ok) {
+		DBG("Linear fixed EF read: 1st byte %02x, len %d",
+			filedata[0], filelen);
+		CALLBACK_WITH_SUCCESS(cb, filedata, filelen, cbd->data);
+		return;
+	}
+
+error:
+	DBG("Error reading linear fixed EF");
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+}
+
+static void isi_read_file_linear(struct ofono_sim *sim,
+					int fileid,
+					int record,
+					int rec_length,
+					ofono_sim_read_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+	DBG("File ID=3D%04X, record %d, client %d AID %d",
+		fileid, record, sd->client_id, sd->app_id);
+	if (!get_fileid_path(sim, &mf_path,
+			&df1_path, &df2_path, &df_len, fileid))
+		goto error;
+	if ((cbd !=3D NULL) && (sd !=3D NULL)) {
+
+		const unsigned char msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_READ_LINEAR_FIXED,
+			sd->app_id,
+			UICC_SESSION_ID_NOT_USED, /*Session ID*/
+			0, /*Filler*/
+			0, /*Filler*/
+			3, /*number of subblocks*/
+		/* Subblock 1*/
+			UICC_SB_CLIENT >> 8,
+			UICC_SB_CLIENT & 0xff,
+			0,
+			8, /*Sub block length */
+			0, 0, 0, /* Filler */
+			sd->client_id,
+		/* Subblock 2 */
+			UICC_SB_LINEAR_FIXED >> 8,
+			UICC_SB_LINEAR_FIXED & 0xff,
+			0, /*Sub block length*/
+			8, /*Sub block length*/
+			record, /*Record*/
+			0, /*Record offset (0=3Dbeginning)*/
+			rec_length & 0xff, /*Data amount (0=3Dall)*/
+			0, /*Filler*/
+		/* Subblock 3*/
+			UICC_SB_APPL_PATH >> 8,
+			UICC_SB_APPL_PATH & 0xff,
+			0,
+			16, /*Sub block length*/
+			fileid >> 8, /* UICC elementary file ID*/
+			fileid & 0xFF,
+			get_sfi(fileid), /* Elementary file short file id*/
+			0, /*filler*/
+			df_len, /*DF Path length*/
+			0, /*Filler*/
+			mf_path >> 8,
+			mf_path & 0xff,
+			df1_path >> 8, /*DF Path*/
+			df1_path & 0xFF,
+			df2_path >> 8, /*DF Path*/
+			df2_path & 0xFF
+		};
+		g_isi_client_send_with_timeout(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			isi_read_file_linear_fixed_resp, cbd, g_free);
+		return;
+	}
+
+error:
+	DBG("Not implemented (fileid =3D %04x)", fileid);
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	g_free(cbd);
 }
 =

 static void isi_read_file_cyclic(struct ofono_sim *sim, int fileid,
@@ -293,13 +1255,123 @@ static void isi_write_file_transparent(struct ofono=
_sim *sim, int fileid,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void write_file_linear_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_write_cb_t cb =3D cbd->cb;
+	DBG("");
+
+	if (check_response_status(msg, UICC_APPL_CMD_RESP,
+			UICC_APPL_UPDATE_LINEAR_FIXED))
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+}
+
 static void isi_write_file_linear(struct ofono_sim *sim, int fileid,
 					int record, int length,
 					const unsigned char *value,
 					ofono_sim_write_cb_t cb, void *data)
 {
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+
+	if (g_isi_client_resource(sd->client) =3D=3D PN_UICC) {
+		int mf_path =3D 0;
+		int df1_path =3D 0;
+		int df2_path =3D 0;
+		unsigned char df_len =3D 0;
+		size_t i =3D 0;
+		size_t sb_file_data_legth =3D (2 + 2 + 4 + length + 3) & ~3;
+		size_t fill_count =3D sb_file_data_legth - (2 + 2 + 4 + length);
+		uint8_t *fill_data =3D g_try_malloc0(fill_count);
+
+		DBG("");
+
+		if (!fill_data && fill_count > 0) {
+			g_free(fill_data);
+			goto error;
+		}
+		for (i =3D 0; i < fill_count; i++)
+			fill_data[i] =3D 0x00;
+
+		if (!sd->app_id || !sd->client_id || !sd || !sd->client ||
+				!cbd) {
+			DBG("Parameter error");
+			g_free(fill_data);
+			goto error;
+		}
+
+		if (get_fileid_path(sim, &mf_path, &df1_path,
+				&df2_path, &df_len, fileid)) {
+			uint8_t msg[] =3D {
+				UICC_APPL_CMD_REQ,
+				UICC_APPL_UPDATE_LINEAR_FIXED,
+				sd->app_id,
+				UICC_SESSION_ID_NOT_USED,
+				0x00, 0x00, /* fillers */
+				0x04, /* nro of sub blocks */
+				/* 1st subblock */
+				UICC_SB_CLIENT >> 8,
+				UICC_SB_CLIENT & 0xFF,
+				0x00, 0x08, /* subblock length */
+				0x00, 0x00, 0x00, /* fillers */
+				sd->client_id,
+				/* 2nd subblock */
+				UICC_SB_LINEAR_FIXED >> 8,
+				UICC_SB_LINEAR_FIXED & 0xFF,
+				0x00, 0x08, /* subblock length */
+				record, /* the record in the file*/
+				0x00, /* record offset (0 =3D=3D beginning) */
+				0x00, /* data amount, used only for reading */
+				0x00, /* filler */
+				/* 3th subblock */
+				UICC_SB_APPL_PATH >> 8,
+				UICC_SB_APPL_PATH & 0xFF,
+				0x00, 0x10, /* subblock length */
+				fileid >> 8, /* elementary file id */
+				fileid & 0xFF,
+				get_sfi(fileid),
+				0x00, /* filler */
+				df_len, /* path length */
+				0x00, /* filler */
+				mf_path >> 8, /* DF Path MF */
+				mf_path & 0xFF,
+				df1_path >> 8, /* DF Path */
+				df1_path & 0xFF,
+				df2_path >> 8, /* DF Path */
+				df2_path & 0xFF,
+				/* 4nd subblock */
+				UICC_SB_FILE_DATA >> 8,
+				UICC_SB_FILE_DATA & 0xFF,
+				sb_file_data_legth >> 8, /* subblock length */
+				sb_file_data_legth & 0xFF,
+				length >> 24, /* data length */
+				length >> 16, /* need to be shifted */
+				length >> 8,
+				length & 0xFF,
+			};
+
+			struct iovec iov[3] =3D {
+				{ msg, sizeof(msg) },
+				{ (uint8_t *)value, length },
+				{ fill_data, fill_count },
+			};
+
+			if (!g_isi_client_vsend_with_timeout(sd->client, iov,
+					3, SIM_TIMEOUT, write_file_linear_cb,
+					cbd, g_free)) {
+				g_free(fill_data);
+				goto error;
+			}
+
+			g_free(fill_data);
+			return;
+		}
+	}
 	DBG("Fileid %04X not implemented", fileid);
+error:
 	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
 }
 =

 static void isi_write_file_cyclic(struct ofono_sim *sim, int fileid,
@@ -309,10 +1381,53 @@ static void isi_write_file_cyclic(struct ofono_sim *=
sim, int fileid,
 	DBG("Fileid %04X not implemented", fileid);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
-
-static void imsi_resp_cb(const GIsiMessage *msg, void *data)
+static void uicc_read_imsi_resp(const struct ofono_error *error,
+				const unsigned char *data,
+				int len,
+				void *user)
 {
-	struct isi_cb_data *cbd =3D data;
+	struct isi_cb_data *cbd =3D user;
+	ofono_sim_imsi_cb_t cb =3D cbd->cb;
+	/* For coding see TS 24.008 */
+	char imsi[SIM_MAX_IMSI_LENGTH + 1];
+	int i =3D 1; /*Skip length, the 1st byte*/
+	int j =3D 0;
+	int octets;
+
+	if (data =3D=3D NULL)
+		goto error;
+
+	octets =3D data[0];
+
+	if (octets !=3D 8 || octets > len)
+		goto error;
+
+	/* Ignore the low-order semi-octet of the first byte */
+	imsi[j] =3D ((data[i] & 0xF0) >> 4) + '0';
+
+	for (i++, j++; i - 1 < octets && j < SIM_MAX_IMSI_LENGTH; i++) {
+		char nibble;
+		imsi[j++] =3D (data[i] & 0x0F) + '0';
+		nibble =3D (data[i] & 0xF0) >> 4;
+
+		if (nibble !=3D 0x0F)
+			imsi[j++] =3D nibble + '0';
+	}
+
+	imsi[j] =3D '\0';
+	DBG("IMSI %s", imsi);
+	CALLBACK_WITH_SUCCESS(cb, imsi, cbd->data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+out:
+	g_free(cbd);
+	return;
+}
+
+static void imsi_resp_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
 	ofono_sim_imsi_cb_t cb =3D cbd->cb;
 =

 	struct sim_imsi *resp;
@@ -321,9 +1436,6 @@ static void imsi_resp_cb(const GIsiMessage *msg, void =
*data)
 	char imsi[SIM_MAX_IMSI_LENGTH + 1];
 	size_t i, j;
 =

-	if (!check_response_status(msg, SIM_IMSI_RESP_READ_IMSI, READ_IMSI))
-		goto error;
-
 	if (!g_isi_msg_data_get_struct(msg, 2, (const void **) &resp, len))
 		goto error;
 =

@@ -352,16 +1464,24 @@ static void isi_read_imsi(struct ofono_sim *sim,
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	size_t len;
 =

 	const uint8_t msg[] =3D {
 		SIM_IMSI_REQ_READ_IMSI,
 		READ_IMSI
 	};
-	size_t len =3D sizeof(msg);
 =

 	if (cbd =3D=3D NULL || sd =3D=3D NULL)
 		goto error;
 =

+	if (g_isi_client_resource(sd->client) =3D=3D PN_UICC) {
+		isi_read_file_transparent(sim, SIM_EFIMSI_FILEID, 0, 9,
+				uicc_read_imsi_resp, cbd);
+		return;
+	}
+	len =3D sizeof(msg);
+
+
 	if (g_isi_client_send(sd->client, msg, len, imsi_resp_cb, cbd, g_free))
 		return;
 =

@@ -370,6 +1490,976 @@ error:
 	g_free(cbd);
 }
 =

+static void uicc_application_activate_resp(const GIsiMessage *msg, void *d=
ata)
+{
+	struct ofono_sim *sim =3D data;
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	uint8_t *msg_data =3D (uint8_t *)g_isi_msg_data(msg);
+
+	if (!check_response_status(msg, UICC_APPLICATION_RESP,
+			UICC_APPL_HOST_ACTIVATE))
+		return;
+
+	if ((msg_data[2] =3D=3D UICC_STATUS_OK) ||
+			(msg_data[2] =3D=3D UICC_STATUS_APPL_ACTIVE)) {
+		if (!sd->uicc_app_started) {
+			sd->app_id =3D sd->trying_app_id;
+			sd->app_type =3D sd->trying_app_type;
+			sd->uicc_app_started =3D TRUE;
+			DBG("UICC application activated");
+			ofono_sim_inserted_notify(sim, TRUE);
+			ofono_sim_register(sim);
+			g_free(sim_application_list_p);
+		}
+	} else {
+		int i =3D sim_applications_get_next_index(
+				sim_application_list_p, sd->trying_app_id);
+
+		if (i =3D=3D NOT_AVAILABLE) {
+			g_free(sim_application_list_p);
+			return;
+		}
+
+		DBG("Activation Error, trying to activate APP with ID:%d", i);
+		uicc_application_activate_req(sd->client, sim,
+					sim_application_list_p->app_type[i],
+					sim_application_list_p->app_list[i]);
+		return;
+	}
+
+	g_isi_msg_data_get_byte(msg, 5, &sbcount);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_CLIENT: {
+			guint8 client =3D 0;
+			g_isi_sb_iter_get_byte(&iter, &client, 7);
+			DBG("Client id %d", client);
+			sd->client_id =3D client;
+			break;
+		}
+		case UICC_SB_FCI:
+			DBG("UICC_SB_FCI");
+
+			if (sd->app_type =3D=3D UICC_APPL_TYPE_UICC_USIM) {
+				uint16_t length, record_length;
+				uint8_t records, structure;
+				handle_app_uicc_usim(&iter, sd, &length,
+						&record_length, &records,
+						&structure);
+			}
+
+			break;
+		case UICC_SB_CHV:
+			DBG("UICC_SB_CHV");
+
+			if (sd->app_type =3D=3D UICC_APPL_TYPE_ICC_SIM) {
+				uint8_t chv_id =3D 0, pin_id =3D 0;
+				(void) g_isi_sb_iter_get_byte(&iter,
+							      &chv_id, 4);
+				(void) g_isi_sb_iter_get_byte(&iter,
+							      &pin_id, 5);
+				DBG("UICC_APPL_TYPE_UICC_SIM");
+
+				if (chv_id =3D=3D 1)
+					sd->pin1_id =3D pin_id;
+				else if (chv_id =3D=3D 2)
+					sd->pin2_id =3D pin_id;
+			}
+
+			break;
+		default:
+			DBG("Skipping sub-block: %s (%zu bytes)",
+				uicc_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+
+		(void)g_isi_sb_iter_next(&iter);
+	}
+}
+
+static void uicc_application_activate_req(GIsiClient *client,
+						void *opaque,
+						unsigned char appl_type,
+						unsigned char aid)
+{
+	const unsigned char msg[] =3D {
+		UICC_APPLICATION_REQ,
+		UICC_APPL_HOST_ACTIVATE,
+		2, /* number of subblocks*/
+	/* Subblock 1 */
+		UICC_SB_APPLICATION >> 8,
+		UICC_SB_APPLICATION & 0xff,
+		0, /*subblock length*/
+		8, /*subblock length*/
+		0, /*filler*/
+		0, /*filler*/
+		appl_type,
+		aid,
+	/* Subblock 2 */
+		UICC_SB_APPL_INFO >> 8,
+		UICC_SB_APPL_INFO & 0xff,
+		0, /*subblock length*/
+		8, /*subblock length*/
+		0, /*filler*/
+		0, /*filler*/
+		0, /*filler*/
+		/* whether the application initialization procedure
+		*  will follow the activation or not */
+		UICC_APPL_START_UP_INIT_PROC
+	};
+
+	DBG("Appl type %d, AID %d", appl_type, aid);
+
+	g_isi_client_send_with_timeout(
+		client, msg, sizeof(msg), SIM_TIMEOUT,
+		uicc_application_activate_resp, opaque, NULL);
+}
+
+static void uicc_application_list_resp(const GIsiMessage *msg, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	gboolean everything_ok =3D TRUE;
+	int index =3D NOT_AVAILABLE;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	if (!check_response_status(msg, UICC_APPLICATION_RESP,
+			UICC_APPL_LIST)) {
+		uint8_t status =3D 0;
+
+		g_isi_msg_data_get_byte(msg, 2, &status);
+		if (status !=3D UICC_STATUS_FAIL)
+			return;
+		everything_ok =3D FALSE;
+	}
+
+	sim_application_list_p =3D g_try_new0(struct sim_applications, 1);
+
+	if (everything_ok) {
+		GIsiSubBlockIter iter;
+		uint8_t sbcount =3D 0;
+		g_isi_msg_data_get_byte(msg, 5, &sbcount);
+		g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+		while (g_isi_sb_iter_is_valid(&iter)) {
+			DBG("Sub-block %s",
+				uicc_subblock_name(
+					g_isi_sb_iter_get_id(&iter)));
+
+			switch (g_isi_sb_iter_get_id(&iter)) {
+			case UICC_SB_APPL_DATA_OBJECT: {
+				guint8 appl_id =3D -1;
+				guint8 appl_type =3D -1;
+				guint8 status =3D -1;
+				gboolean ret;
+				ret =3D g_isi_sb_iter_get_byte(
+					      &iter, &appl_type, 6);
+				ret =3D g_isi_sb_iter_get_byte(
+					      &iter, &appl_id, 7);
+				(void) g_isi_sb_iter_get_byte(
+					&iter, &status, 8);
+				DBG("Appl type=3D%d, Appl id=3D%d, Appl status=3D%d",
+					appl_type, appl_id, status);
+
+				sim_application_list_p->app_list[appl_id] =3D
+					appl_id;
+				sim_application_list_p->app_type[appl_id] =3D
+					appl_type;
+				break;
+			}
+			default:
+				DBG("Skipping sub-block: %s (%zu bytes)",
+					uicc_subblock_name(
+						g_isi_sb_iter_get_id(&iter)),
+					g_isi_sb_iter_get_len(&iter));
+				break;
+			}
+
+			g_isi_sb_iter_next(&iter);
+		}
+	}
+
+	if (!sd->uicc_app_started) {
+		index =3D sim_applications_get_next_index(sim_application_list_p,
+						NOT_ACTIVATED);
+
+		if (index !=3D NOT_AVAILABLE) {
+			DBG("Activating APP index:%d", index);
+			sd->trying_app_id =3D
+			  sim_application_list_p->app_list[index];
+			sd->trying_app_type =3D
+			  sim_application_list_p->app_type[index];
+			DBG("Activating APP ID: %d APP type: %d",
+				sd->trying_app_id, sd->trying_app_type);
+			uicc_application_activate_req(sd->client, sim,
+				sim_application_list_p->app_type[index],
+				sim_application_list_p->app_list[index]);
+		} else
+			g_free(sim_application_list_p);
+	}
+}
+
+static void uicc_application_list_req(GIsiClient *client,
+					void *opaque)
+{
+	const unsigned char msg[] =3D {
+		UICC_APPLICATION_REQ,
+		UICC_APPL_LIST,
+		0 /* number of subblocks*/
+	};
+	DBG("");
+
+	g_isi_client_send_with_timeout(
+		client, msg, sizeof(msg), SIM_TIMEOUT,
+		uicc_application_list_resp, opaque, NULL);
+}
+
+static void uicc_pin_enter_resp(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct ofono_error error;
+	GIsiSubBlockIter iter;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *) local_sim);
+	uint8_t status =3D 0, sbcount =3D 0;
+
+	if (msg =3D=3D NULL)
+		goto error;
+
+	g_isi_msg_data_get_byte(msg, 2, &status);
+	if (status =3D=3D UICC_STATUS_OK) {
+		sd->passwd_required =3D FALSE;
+		error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		error.error =3D 0;
+		goto out;
+	}
+
+error:
+	g_isi_msg_data_get_byte(msg, 5, &sbcount);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
+
+			switch (status) {
+			case 0x6983:
+			case 0x9840:
+				DBG("Authentication method blocked");
+				update_locked_pin(local_sim,
+							UICC_PIN_UNBLOCK_NEEDED,
+							sd->current_pin_id);
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D 0x63c0)
+					DBG("Attempts left %d", status & 0xf);
+
+				break;
+			}
+
+			break;
+		}
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	error.type =3D OFONO_ERROR_TYPE_FAILURE;
+	error.error =3D 1;
+out:
+	cb(&error, cbd->data);
+}
+
+static void uicc_pin_enter(struct ofono_sim *sim, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	sd->current_pin_id =3D sd->pin1_id; /* No way to enter PIN2 */
+	DBG("PIN=3D%s PINID=3D%02x", passwd, sd->current_pin_id);
+
+	if (cbd && sd) {
+		unsigned char pinlen =3D strlen(passwd);
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			UICC_PIN_VERIFY,
+			sd->app_id,
+			0, /* Filler */
+			0, /* Filler */
+			0, /* Filler */
+			1, /* number of subblocks */
+		/* Subblock 1 */
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			16, /* Max length */
+			sd->current_pin_id, /* PIN id */
+			UICC_PIN_OLD, /* PIN qualifier */
+			pinlen, /* PIN length */
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0
+		};
+
+		if ((pinlen < 4) || (pinlen > 8))
+			goto error;
+
+		memmove(&msg[14], passwd, pinlen);
+
+		g_isi_client_send_with_timeout(sd->client, msg, sizeof(msg),
+					SIM_TIMEOUT, uicc_pin_enter_resp, cbd,
+					g_free);
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+enum ofono_sim_password_type passwd_type_for_query =3D
+	OFONO_SIM_PASSWORD_SIM_PIN;
+
+static void uicc_pin_prompt_resp(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_passwd_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *)local_sim);
+
+	unsigned char lock_type =3D -1;
+	GIsiSubBlockIter iter;
+	uint8_t status =3D UICC_STATUS_UNKNOWN;
+	uint8_t pin_attempts =3D -1;
+	uint8_t puk_attempts =3D -1;
+
+	if (!check_response_status(msg, UICC_PIN_RESP,
+			UICC_PIN_PROMPT_VERIFY) && !check_response_status(msg,
+					UICC_PIN_RESP, UICC_PIN_INFO))
+		goto error;
+
+	if (check_response_status(msg, UICC_PIN_RESP, UICC_PIN_PROMPT_VERIFY)) {
+		sd->pin_state_received =3D TRUE;
+		g_isi_msg_data_get_byte(msg, 2, &status);
+	} else if (check_response_status(msg, UICC_PIN_RESP, UICC_PIN_INFO)) {
+		uint8_t sbcount =3D 0;
+
+		sd->pin_state_received =3D TRUE;
+		g_isi_msg_data_get_byte(msg, 5, &sbcount);
+		g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+		while (g_isi_sb_iter_is_valid(&iter)) {
+			DBG("Sub-block %s",
+				uicc_subblock_name(g_isi_sb_iter_get_id(
+							&iter)));
+
+			switch (g_isi_sb_iter_get_id(&iter)) {
+			case UICC_SB_PIN_INFO:
+				g_isi_sb_iter_get_byte(&iter, &status, 4);
+				g_isi_sb_iter_get_byte(&iter,
+							&pin_attempts, 5);
+				g_isi_sb_iter_get_byte(&iter,
+							&puk_attempts, 6);
+				DBG("Status=3D%s, PIN attempts=3D%d, \
+					PUK attempts=3D%d",
+					uicc_status_name(status),
+					pin_attempts, puk_attempts);
+				break;
+			default:
+				break;
+			}
+
+			g_isi_sb_iter_next(&iter);
+		}
+	}
+
+	if ((status =3D=3D UICC_STATUS_OK) ||
+		(status =3D=3D UICC_STATUS_PIN_ENABLED)) {
+		/* PIN query on, indication should tell
+		 * if it is verified or not
+		 */
+		if (pin_attempts =3D=3D 0) {
+			DBG("PIN blocked");
+			update_locked_pin(local_sim,
+					  UICC_PIN_UNBLOCK_NEEDED,
+						sd->current_pin_id);
+		} else {
+			DBG("PIN query enabled");
+			update_locked_pin(local_sim,
+					  UICC_PIN_VERIFY_NEEDED,
+						sd->current_pin_id);
+		}
+
+		lock_type =3D local_sim->pin_type;
+	} else if (status =3D=3D UICC_STATUS_PIN_DISABLED) {
+		if (pin_attempts =3D=3D 0) {
+			DBG("PIN blocked");
+			update_locked_pin(local_sim,
+					  UICC_PIN_UNBLOCK_NEEDED,
+						sd->current_pin_id);
+			lock_type =3D local_sim->pin_type;
+		} else {
+			DBG("PIN query disabled");
+			local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PIN] =3D
+				FALSE;
+			local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PIN2] =3D
+				FALSE;
+			lock_type =3D OFONO_SIM_PASSWORD_NONE;
+		}
+	}
+
+	if (check_response_status(msg, UICC_PIN_RESP, UICC_PIN_PROMPT_VERIFY)) {
+		uicc_pin_prompt(cbd->user,
+				passwd_type_for_query,
+				cb,
+				cbd->data,
+				UICC_PIN_INFO);
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, lock_type, cbd->data);
+	return;
+error:
+	DBG("PIN prompt verify failed");
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void uicc_pin_prompt(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				ofono_sim_passwd_cb_t cb,
+				void *data,
+				uint8_t service)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int8_t index;
+	sd->current_pin_id =3D get_pin_id(sd, passwd_type, &index);
+	DBG("PINID =3D %02x", sd->current_pin_id);
+
+	if ((cbd) && (sd) && (sd->current_pin_id)) {
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			service,
+			sd->app_id,
+			0, /*Filler*/
+			0, /*Filler*/
+			0, /*Filler*/
+			1, /*number of subblocks*/
+		/* Subblock 1 */
+			UICC_SB_PIN_REF >> 8,
+			UICC_SB_PIN_REF & 0xff,
+			0, /*Sub block length.*/
+			8,
+			sd->current_pin_id, /*PIN ID*/
+			0, /*Filler*/
+			0, /*Filler*/
+			0  /*Filler*/
+		};
+		g_isi_client_send_with_timeout(sd->client, msg, sizeof(msg),
+				   SIM_TIMEOUT, uicc_pin_prompt_resp, cbd,
+				   g_free);
+	} else {
+		DBG("PIN info query failed");
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
+}
+
+static void uicc_passwd_state_query(struct ofono_sim *sim,
+					ofono_sim_passwd_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct ofono_sim_local *local_sim =3D (struct ofono_sim_local *)sim;
+
+	if (sd->pin_state_received) {
+		int lock_type =3D OFONO_SIM_PASSWORD_NONE;
+
+		if (sd->passwd_required) {
+			/* These should be in priority order, highest last */
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_SIM_PIN] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_SIM_PIN;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_SIM_PIN2] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_SIM_PIN2;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_PHNET_PIN] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_PHNET_PIN;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_SIM_PUK] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_SIM_PUK;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_SIM_PUK2] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_SIM_PUK2;
+
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_PHNET_PUK] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_PHNET_PUK;
+		}
+
+		DBG("UICC lock type=3D%d", lock_type);
+		CALLBACK_WITH_SUCCESS(cb, lock_type, data);
+	} else {
+		if (sd->uicc_app_started) {
+			/* No indication received but UICC app is
+			 * started, let's query the state
+			 */
+			DBG("Querying PIN info");
+			uicc_pin_prompt(sim, passwd_type_for_query,
+					cb, data, UICC_PIN_PROMPT_VERIFY);
+			return;
+		}
+
+		DBG("No UICC_PIN_IND received");
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+	}
+}
+
+static void uicc_pin_enable_resp(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *) local_sim);
+
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
+
+	if (!check_response_status(msg, UICC_PIN_RESP, UICC_PIN_DISABLE) &&
+			!check_response_status(msg, UICC_PIN_RESP,
+					UICC_PIN_ENABLE))
+		goto error;
+
+	DBG("PIN lock/unlock succeeded");
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+
+error:
+	g_isi_msg_data_get_byte(msg, 5, &sbcount);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+		    uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
+
+			switch (status) {
+			case 0x6983:
+			case 0x9840:
+				DBG("Authentication method blocked");
+				update_locked_pin(local_sim,
+						  UICC_PIN_UNBLOCK_NEEDED,
+						  sd->current_pin_id);
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D 0x63c0)
+					DBG("Attempts left %d", status & 0xf);
+
+				break;
+			}
+		}
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	DBG("PIN lock/unlock failed");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void uicc_pin_enable(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				int enable, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int8_t index;
+	unsigned char service =3D 0;
+	sd->current_pin_id =3D get_pin_id(sd, passwd_type, &index);
+
+	DBG("Lock=3D%d, PIN code=3D%s, PIN ID =3D%d",
+	enable, passwd, sd->current_pin_id);
+	if (enable) {
+		DBG("Enabling PIN");
+		service =3D UICC_PIN_ENABLE;
+	} else {
+		DBG("Disabling PIN");
+		service =3D UICC_PIN_DISABLE;
+	}
+	if ((cbd) && (sd) && (sd->current_pin_id)) {
+
+		unsigned char pinlen =3D strlen(passwd);
+
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			service,
+			sd->app_id,
+			0, /*Filler*/
+			0, /*Filler*/
+			0, /*Filler*/
+			1, /*number of subblocks*/
+		/* Subblock 1 */
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			16, /*Max length*/
+			sd->current_pin_id, /* PIN id */
+			UICC_PIN_OLD, /* PIN qualifier */
+			pinlen, /* PIN length */
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0
+		};
+
+		if ((pinlen < 4) || (pinlen > 8))
+			goto error;
+		memmove(&msg[14], passwd, pinlen);
+		g_isi_client_send_with_timeout(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			uicc_pin_enable_resp, cbd, g_free);
+		return;
+	}
+
+error:
+	DBG("Error");
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+	return;
+}
+
+static void uicc_pin_change_resp(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *) local_sim);
+
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
+
+	if (!check_response_status(msg, UICC_PIN_RESP, UICC_PIN_CHANGE))
+		goto error;
+
+	DBG("PIN change succeeded");
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+
+error:
+	g_isi_msg_data_get_byte(msg, 5, &sbcount);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
+
+			switch (status) {
+			case 0x6983:
+			case 0x9840:
+				DBG("Authentication method blocked");
+				update_locked_pin(local_sim,
+					UICC_PIN_UNBLOCK_NEEDED,
+						sd->current_pin_id);
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D 0x63c0)
+					DBG("Attempts left %d", status & 0xf);
+
+				break;
+			}
+
+			break;
+		}
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	DBG("PIN change failed");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void uicc_change_pin(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				const char *old,
+				const char *new,
+				ofono_sim_lock_unlock_cb_t cb,
+				void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int8_t index;
+	sd->current_pin_id =3D get_pin_id(sd, passwd_type, &index);
+	DBG("old=3D%s, new=3D%s, PINID=3D%02x",
+		old, new, sd->current_pin_id);
+
+	if ((cbd) && (sd) && (sd->current_pin_id)) {
+		unsigned char service =3D UICC_PIN_CHANGE;
+		unsigned char oldlen =3D strlen(old);
+		unsigned char newlen =3D strlen(new);
+
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			service,
+			sd->app_id,
+			0, /*Filler*/
+			0, /*Filler*/
+			0, /*Filler*/
+			2, /*number of subblocks*/
+		/* Subblock 1 */
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			16, /* Must be fixed */
+			sd->current_pin_id, /* PIN id */
+			UICC_PIN_OLD, /* PIN qualifier */
+			oldlen, /* PIN length */
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+		/* Subblock 2 */
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			/* Sub block length:
+			*  "header" size + 1 (=3Dtrailing filler) + PIN length */
+			16,
+			sd->current_pin_id, /* PIN id */
+			UICC_PIN_NEW, /* PIN qualifier */
+			newlen, /* PIN length */
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0
+		};
+
+		if ((oldlen < 4) || (oldlen > 8))
+			goto error;
+
+		if ((newlen < 4) || (newlen > 8))
+			goto error;
+
+		memmove(&msg[14], old, oldlen);
+		memmove(&msg[30], new, newlen);
+		g_isi_client_send_with_timeout(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			uicc_pin_change_resp, cbd, g_free);
+		return;
+	}
+
+error:
+	DBG("Error");
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+	return;
+}
+
+static void uicc_pin_send_puk_resp(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
+
+	if (!check_response_status(msg, UICC_PIN_RESP, UICC_PIN_UNBLOCK))
+		goto error;
+
+	DBG("PIN reset succeeded");
+	/* Only PIN1 can be reseted, turns PIN query on */
+	local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PIN] =3D TRUE;
+	local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PUK] =3D FALSE;
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+
+error:
+	g_isi_msg_data_get_byte(msg, 5, &sbcount);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
+
+			switch (status) {
+			case 0x6983:
+			case 0x9840:
+				DBG("Authentication method blocked");
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D 0x63c0)
+					DBG("Attempts left %d", status & 0xf);
+
+				break;
+			}
+
+			break;
+		}
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
+
+	DBG("PIN reset failed");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void uicc_pin_send_puk(struct ofono_sim *sim,
+				const char *puk,
+				const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb,
+				void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	sd->current_pin_id =3D sd->pin1_id; /* No way to reset PIN2 */
+	DBG("PUK=3D%s, PIN=3D%s, PINID=3D%02x", puk, passwd, sd->current_pin_id);
+
+	if (cbd && sd) {
+		unsigned char service =3D UICC_PIN_UNBLOCK;
+		unsigned char pinlen =3D strlen(passwd);
+
+		unsigned char msg[] =3D {
+			UICC_PIN_REQ,
+			service,
+			sd->app_id,
+			0, /*Filler*/
+			0, /*Filler*/
+			0, /*Filler*/
+			2, /*number of subblocks*/
+		/* Subblock 1*/
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			16, /*Must be fixed*/
+			sd->current_pin_id, /* PIN id*/
+			UICC_PIN_NEW, /* PIN qualifier*/
+			pinlen, /* PIN length*/
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+			0,
+		/* Subblock 2*/
+			UICC_SB_PUK >> 8,
+			UICC_SB_PUK & 0xff,
+			0,
+			16, /*Sub block length*/
+			sd->current_pin_id, /* PIN id*/
+			8, /* PUK length*/
+			puk[0],
+			puk[1],
+			puk[2],
+			puk[3],
+			puk[4],
+			puk[5],
+			puk[6],
+			puk[7],
+			0,
+			0
+		};
+
+		if ((pinlen < 4) || (pinlen > 8))
+			goto error;
+
+		if (strlen(puk) !=3D 8)
+			goto error;
+		memmove(&msg[14], passwd, pinlen);
+		g_isi_client_send_with_timeout(
+			sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			uicc_pin_send_puk_resp, cbd, g_free);
+		return;
+	}
+
+error:
+	DBG("PIN reset error");
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+	return;
+}
+
 static void isi_sim_register(struct ofono_sim *sim)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
@@ -414,34 +2504,121 @@ static void sim_ind_cb(const GIsiMessage *msg, void=
 *data)
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	uint8_t status;
 =

-	if (sd =3D=3D NULL || g_isi_msg_id(msg) !=3D SIM_IND || sd->registered)
-		return;
+	if (g_isi_client_resource(sd->client) =3D=3D PN_UICC) {
+		uint8_t service_type;
+		uint8_t pin_id;
+
+		g_isi_msg_data_get_byte(msg, 0, &service_type);
+		g_isi_msg_data_get_byte(msg, 1, &pin_id);
+
+		switch (g_isi_msg_id(msg)) {
+
+		case UICC_CARD_IND:
+			ofono_sim_inserted_notify(sim, TRUE);
+
+			if ((service_type =3D=3D UICC_CARD_READY) &&
+					(!sd->uicc_app_started)) {
+				DBG("UICC_CARD_IND activation");
+				uicc_application_list_req(sd->client, sim);
+			}
+			break;
+		case UICC_PIN_IND:
+			sd->pin_state_received =3D TRUE;
+			sd->passwd_required =3D FALSE;
+
+			switch (service_type) {
+			case UICC_PIN_VERIFY_NEEDED:
+				update_locked_pin((
+						struct ofono_sim_local *)sim,
+						UICC_PIN_VERIFY_NEEDED,
+						pin_id);
+				break;
+			case UICC_PIN_UNBLOCK_NEEDED:
+				update_locked_pin((
+						struct ofono_sim_local *)sim,
+						UICC_PIN_UNBLOCK_NEEDED,
+						pin_id);
+				break;
+			case UICC_PIN_PERMANENTLY_BLOCKED:
+			case UICC_PIN_VERIFIED:
+			default:
+				break;
+			}
+
+			break;
+		case UICC_IND:
+			DBG("UICC IND RECEIVED");
+
+			if (service_type =3D=3D UICC_START_UP_COMPLETE)
+				sd->passwd_required =3D FALSE;
+
+			break;
+		default:
+			break;
+		}
+	} else {
+		if (sd =3D=3D NULL || g_isi_msg_id(msg) !=3D SIM_IND ||
+				sd->registered)
+			return;
+
+		if (!g_isi_msg_data_get_byte(msg, 0, &status))
+			return;
+
+		switch (status) {
+		case SIM_ST_PIN:
+			isi_sim_register(sim);
+			break;
 =

-	if (!g_isi_msg_data_get_byte(msg, 0, &status))
+		case SIM_ST_INFO:
+			isi_read_hplmn(sim);
+			break;
+		}
+	}
+}
+
+static void uicc_reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	if (g_isi_msg_error(msg) < 0)
 		return;
 =

-	switch (status) {
-	case SIM_ST_PIN:
-		isi_sim_register(sim);
-		break;
+	ISI_VERSION_DBG(msg);
 =

-	case SIM_ST_INFO:
-		isi_read_hplmn(sim);
-		break;
+	sd->client =3D sd->primary;
+	sd->uicc_app_started =3D FALSE;
+	sd->pin_state_received =3D FALSE;
+	sd->passwd_required =3D TRUE;
+	sd->current_pin_id =3D 0x01;
+	sd->pin1_id =3D 0x01;
+	sd->pin2_id =3D 0x81;
+
+	uicc_sim =3D sim;
+
+	if (!sd->uicc_app_started) {
+		DBG("Let's check if we have UICC applications");
+		uicc_application_list_req(sd->client, sim);
 	}
+	g_isi_client_destroy(sd->secondary);
 }
 =

 static void sim_reachable_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_sim *sim =3D data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

 	if (g_isi_msg_error(msg) < 0)
 		return;
 =

 	ISI_VERSION_DBG(msg);
 =

+	sd->client =3D sd->secondary;
+
 	/* Check if SIM is ready by reading HPLMN */
 	isi_read_hplmn(sim);
+
+	g_isi_client_destroy(sd->primary);
 }
 =

 static int isi_sim_probe(struct ofono_sim *sim, unsigned int vendor,
@@ -454,16 +2631,32 @@ static int isi_sim_probe(struct ofono_sim *sim, unsi=
gned int vendor,
 	if (sd =3D=3D NULL)
 		return -ENOMEM;
 =

-	sd->client =3D g_isi_client_create(modem, PN_SIM);
-	if (sd->client =3D=3D NULL) {
+	sd->primary =3D get_pn_uicc_client(modem, PN_UICC);
+
+	if (sd->primary =3D=3D NULL) {
+		g_free(sd);
+		return -ENOMEM;
+	}
+
+	sd->secondary =3D g_isi_client_create(modem, PN_SIM);
+
+	if (sd->secondary =3D=3D NULL) {
 		g_free(sd);
 		return -ENOMEM;
 	}
 =

 	ofono_sim_set_data(sim, sd);
 =

-	g_isi_client_ind_subscribe(sd->client, SIM_IND, sim_ind_cb, sim);
-	g_isi_client_verify(sd->client, sim_reachable_cb, sim, NULL);
+	g_isi_client_ind_subscribe(sd->secondary, SIM_IND, sim_ind_cb, sim);
+
+	g_isi_client_ind_subscribe(sd->primary, UICC_IND, sim_ind_cb, sim);
+	g_isi_client_ind_subscribe(sd->primary, UICC_CARD_IND, sim_ind_cb, sim);
+	g_isi_client_ind_subscribe(sd->primary, UICC_PIN_IND, sim_ind_cb, sim);
+	g_isi_client_ind_subscribe(sd->primary, UICC_APPLICATION_IND,
+					sim_ind_cb, sim);
+
+	g_isi_client_verify(sd->primary, uicc_reachable_cb, sim, NULL);
+	g_isi_client_verify(sd->secondary, sim_reachable_cb, sim, NULL);
 =

 	return 0;
 }
@@ -472,12 +2665,19 @@ static void isi_sim_remove(struct ofono_sim *sim)
 {
 	struct sim_data *data =3D ofono_sim_get_data(sim);
 =

-	ofono_sim_set_data(sim, NULL);
-
 	if (data =3D=3D NULL)
 		return;
 =

-	g_isi_client_destroy(data->client);
+	if (g_isi_client_resource(data->client) =3D=3D PN_UICC) {
+		data->uicc_app_started =3D FALSE;
+		data->pin_state_received =3D FALSE;
+		data->passwd_required =3D TRUE;
+
+		pn_uicc_client_destroy(data->client);
+	} else
+		g_isi_client_destroy(data->client);
+
+	ofono_sim_set_data(sim, NULL);
 	g_free(data);
 }
 =

@@ -493,8 +2693,18 @@ static struct ofono_sim_driver driver =3D {
 	.write_file_linear	=3D isi_write_file_linear,
 	.write_file_cyclic	=3D isi_write_file_cyclic,
 	.read_imsi		=3D isi_read_imsi,
+	.query_passwd_state	=3D uicc_passwd_state_query,
+	.send_passwd		=3D uicc_pin_enter,
+	.reset_passwd		=3D uicc_pin_send_puk,
+	.change_passwd		=3D uicc_change_pin,
+	.lock			=3D uicc_pin_enable,
 };
 =

+struct ofono_sim_driver *get_sim_driver_func(void)
+{
+	return &driver;
+}
+
 void isi_sim_init(void)
 {
 	ofono_sim_driver_register(&driver);
@@ -504,3 +2714,24 @@ void isi_sim_exit(void)
 {
 	ofono_sim_driver_unregister(&driver);
 }
+
+GIsiClient *get_pn_uicc_client(GIsiModem *modem, uint8_t resource)
+{
+	if (pn_uicc_client =3D=3D NULL)
+		pn_uicc_client =3D g_isi_client_create(modem, resource);
+
+	uicc_users++;
+	return pn_uicc_client;
+}
+
+void pn_uicc_client_destroy(GIsiClient *client)
+{
+	if (uicc_users > 0)
+		uicc_users--;
+	if (!uicc_users) {
+		if (pn_uicc_client) {
+			g_isi_client_destroy(client);
+			pn_uicc_client =3D NULL;
+		}
+	}
+}
diff --git a/drivers/isimodem/uicc.h b/drivers/isimodem/uicc.h
new file mode 100644
index 0000000..4be4d01
--- /dev/null
+++ b/drivers/isimodem/uicc.h
@@ -0,0 +1,268 @@
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
+int get_app_id(void);
+int get_app_type(void);
+int get_client_id(void);
+
+GIsiClient *read_pn_uicc_client(void); /* Only returns the exisisting clie=
nt */
+
+GIsiClient *get_pn_uicc_client(GIsiModem *modem, uint8_t resource);
+
+void pn_uicc_client_destroy(GIsiClient *client);
+
+struct ofono_sim_driver *get_sim_driver_func(void);
+
+struct ofono_sim *get_sim(void);
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* __ISIMODEM25_UICC_H */
-- =

1.7.3.5


--===============8384001966812212621==--

