Content-Type: multipart/mixed; boundary="===============6645238562338327733=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 08/18] isimodem: UICC sim support for wgmodem2.5
Date: Wed, 23 Feb 2011 12:43:19 +0100
Message-ID: <bccb630d3327e6b2d25c418da0834821156b06b5.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6645238562338327733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/sim.c | 2678 ++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 2480 insertions(+), 198 deletions(-)

diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index bfecbc9..117129b 100644
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
@@ -33,22 +34,211 @@
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
+#define	ADF_USIM			0x7FFF
+#define	MAX_SIM_APPS			0x08
+#define	NOT_AVAILABLE			-1
+#define	NOT_ACTIVATED			-1
+
+/* File info parameters */
+enum file_info_params {
+	FCP_TEMPLATE =3D			0x62,
+	FCP_FILE_SIZE =3D			0x80,
+	FCP_FILE_DESC =3D			0x82,
+	FCP_FILE_ID =3D			0x83,
+	FCP_FILE_LIFECYCLE =3D		0x8A,
+	FCP_FILE_SECURITY_ARR =3D		0x8B,
+	FCP_FILE_SECURITY_COMPACT =3D	0x8C,
+	FCP_FILE_SECURITY_EXPANDED =3D	0xAB,
+	FCP_PIN_STATUS =3D		0xC6,
+};
+
+struct sim_applications {
+	int app_list[MAX_SIM_APPS];
+	int app_type[MAX_SIM_APPS];
+};
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
+	struct sim_applications *sim_application_list_p;
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
+	int8_t passwd_type;
+	int8_t pin_id;
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
+struct file_info {
+	int fileid;
+	int length;
+	int structure;
+	int record_length;
+	uint8_t access[3];
+	uint8_t file_status;
+};
+
+struct read_file_data {
+	struct file_info *info;
+	struct sim_data *sim_data;
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

 struct sim_imsi {
@@ -66,14 +256,275 @@ struct sim_spn {
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
+static uint8_t fileid_to_short_fileid(const int fileid)
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
+static int sim_applications_get_next_index(struct sim_applications *sa,
+						int current_app)
+{
+	int i;
+
+	if (current_app >=3D (MAX_SIM_APPS - 1))
+		return NOT_AVAILABLE;
+
+	for (i =3D ++current_app; i < MAX_SIM_APPS; i++) {
+
+		if (sa->app_list[i] && (sa->app_type[i] !=3D
+					UICC_APPL_TYPE_UNKNOWN))
+				return i;
+		}
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
+int get_app_id(GIsiModem *modem)
+{
+	struct ofono_sim *sim;
+
+	if (modem =3D=3D NULL)
+		return -1;
+
+	sim =3D g_isi_modem_get_sim(modem);
+
+	if (sim) {
+		struct sim_data *sd =3D ofono_sim_get_data(sim);
+		return sd->app_id;
+	} else
+		return -1;
+}
+
+int get_app_type(GIsiModem *modem)
+{
+	struct ofono_sim *sim;
+
+	if (modem =3D=3D NULL)
+		return -1;
+
+	sim =3D g_isi_modem_get_sim(modem);
+
+	if (sim) {
+		struct sim_data *sd =3D ofono_sim_get_data(sim);
+		return sd->app_type;
+	} else
+		return -1;
+}
+
+int get_client_id(GIsiModem *modem)
+{
+	struct ofono_sim *sim;
+
+	if (modem =3D=3D NULL)
+		return -1;
+
+	sim =3D g_isi_modem_get_sim(modem);
+
+	if (sim) {
+		struct sim_data *sd =3D ofono_sim_get_data(sim);
+		return sd->client_id;
+	} else
+		return -1;
+}
 =

 /* Returns file info */
 static gboolean fake_file_info(gpointer user)
@@ -89,6 +540,286 @@ static gboolean fake_file_info(gpointer user)
 	return FALSE;
 }
 =

+static gboolean check_response_status_with_cause(const GIsiMessage *msg,
+							uint8_t msgid,
+							uint8_t service,
+							int cause,
+							int pos)
+{
+	uint8_t type;
+	uint8_t msg_cause;
+
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
+		return FALSE;
+	}
+
+	if (g_isi_msg_id(msg) !=3D msgid) {
+		DBG("Unexpected msg: %s",
+			sim_message_id_name(g_isi_msg_id(msg)));
+		return FALSE;
+	}
+
+	if ((!g_isi_msg_data_get_byte(msg, 1, &msg_cause) ||
+						msg_cause !=3D cause)) {
+		return FALSE;
+	}
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &type) || type !=3D service) {
+		DBG("Unexpected service: 0x%02X", type);
+		return FALSE;
+	}
+	return TRUE;
+}
+
+static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgi=
d,
+					uint8_t service)
+{
+	int cause, pos;
+
+	if (g_isi_msg_version_major(msg) =3D=3D 6 &&
+			g_isi_msg_version_minor(msg) >=3D 0) {
+		cause =3D UICC_STATUS_OK;
+		pos =3D 0;
+	} else {
+		cause =3D SIM_SERV_OK;
+		pos =3D 1;
+	}
+
+	return check_response_status_with_cause(msg, msgid, service, cause,
+							pos);
+}
+
+
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
+	if (!g_isi_sb_iter_get_byte(iter, &fcp, 8))
+		return;
+
+	if (fcp !=3D FCP_TEMPLATE)
+		return;
+
+	if (!g_isi_sb_iter_get_byte(iter, &fcp_len, 9))
+		return;
+
+	while (read < fcp_len) {
+		if (!g_isi_sb_iter_get_byte(iter, &id, read + 10))
+			return;
+		if (!g_isi_sb_iter_get_byte(iter, &item_len, read + 11))
+			return;
+
+		switch (id) {
+		case FCP_FILE_SIZE:
+			if (item_len =3D=3D 2) {
+				g_isi_sb_iter_get_word(iter, length,
+								read + 10 + 2);
+			}
+			break;
+		case FCP_FILE_ID:
+			if (item_len =3D=3D 2) {
+				g_isi_sb_iter_get_word(iter, &file_id,
+								read + 10 + 2);
+			}
+			break;
+		case FCP_FILE_DESC:
+			if (item_len >=3D 2) {
+				g_isi_sb_iter_get_byte(iter, &desc,
+								read + 10 + 2);
+				g_isi_sb_iter_get_byte(iter, &coding,
+								read + 10 + 3);
+			}
+
+			if (item_len >=3D 4) {
+				g_isi_sb_iter_get_word(iter, record_length,
+								read + 10 + 4);
+				g_isi_sb_iter_get_byte(iter, records,
+								read + 10 + 6);
+			}
+			break;
+		case FCP_PIN_STATUS:
+			g_isi_sb_iter_get_byte(iter, &pin_do_len,
+							read + 10 + 3);
+			pin_tag_pos =3D read + 10 + 4 + pin_do_len;
+			g_isi_sb_iter_get_byte(iter, &pin_tag, pin_tag_pos);
+
+			while (pin_tag =3D=3D 0x83) {
+
+				g_isi_sb_iter_get_byte(iter, &pin_len,
+							pin_tag_pos + 1);
+				g_isi_sb_iter_get_byte(iter, &pin_id,
+							pin_tag_pos + 2);
+
+				pin_tag_pos +=3D 2 + pin_len;
+				g_isi_sb_iter_get_byte(iter, &pin_tag,
+								pin_tag_pos);
+
+				if ((0x01 <=3D pin_id) &&	(pin_id <=3D 0x08))
+					sd->pin1_id =3D pin_id;
+				else if ((0x81 <=3D pin_id) && (pin_id <=3D 0x88))
+					sd->pin2_id =3D pin_id;
+
+				read +=3D item_len + 2;
+			}
+			break;
+		case FCP_FILE_SECURITY_ARR:
+		case FCP_FILE_SECURITY_COMPACT:
+		case FCP_FILE_SECURITY_EXPANDED:
+
+		/* Not implemented, using
+		 * static access rules as these
+		 * are used only for caching
+		 * See ETSI TS 102 221, ch
+		 * 11.1.1.4.7 and
+		 * Annexes E,F and G
+		 */
+		case FCP_FILE_LIFECYCLE:
+		default:
+			DBG("FCP id %02X not supported", id);
+			break;
+		}
+
+		/*Data length + id size + len size */
+		read +=3D item_len + 2;
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
+	struct read_file_data *fdata =3D cbd->user;
+	struct file_info const *info;
+	GIsiSubBlockIter iter;
+	struct sim_data *sd =3D NULL;
+	uint8_t sbcount =3D 0;
+
+	if (fdata !=3D NULL) {
+		sd =3D fdata->sim_data;
+		info =3D fdata->info;
+		g_free(cbd->user);
+		cbd->user =3D NULL;
+	}
+
+	if (sd =3D=3D NULL)
+		goto error;
+
+	if (!check_response_status(msg,	UICC_APPL_CMD_RESP,
+					UICC_APPL_FILE_INFO))
+		goto error;
+
+
+	if (info !=3D NULL) {
+		access[0] =3D info->access[0];
+		access[1] =3D info->access[1];
+		access[2] =3D info->access[2];
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
 static void isi_read_file_info(struct ofono_sim *sim, int fileid,
 				ofono_sim_file_info_cb_t cb, void *data)
 {
@@ -98,276 +829,1700 @@ static void isi_read_file_info(struct ofono_sim *si=
m, int fileid,
 		{ SIM_EF_ICCID_FILEID, 10, 0, 0, { 0x0f, 0xff, 0xff }, 1 },
 	};
 	int N =3D sizeof(info) / sizeof(info[0]);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct isi_cb_data *cbd;
 =

-	for (i =3D 0; i < N; i++) {
-		if (fileid =3D=3D info[i].fileid) {
-			cbd =3D isi_cb_data_new((void *) &info[i], cb, data);
-			g_idle_add(fake_file_info, cbd);
+	if ((sd !=3D NULL) && g_isi_client_resource(sd->client) =3D=3D PN_UICC) {
+		/* Prepare for static file info used for access rights */
+		int i;
+		int mf_path =3D 0;
+		int df1_path =3D 0;
+		int df2_path =3D 0;
+		unsigned char df_len =3D 0;
+		struct read_file_data *fdata =3D g_try_malloc0(sizeof(
+						struct read_file_data));
+
+		N =3D sizeof(static_file_info) / sizeof(static_file_info[0]);
+		cbd =3D isi_cb_data_new(NULL, cb, data);
+		DBG("File info for ID=3D%04X app id %d", fileid, sd->app_id);
+
+		fdata->sim_data =3D sd;
+
+		for (i =3D 0; i < N; i++) {
+			if (fileid =3D=3D static_file_info[i].fileid &&
+					cbd !=3D NULL) {
+				fdata->info =3D (struct file_info *)
+						&static_file_info[i];
+				continue;
+			}
+		}
+		cbd->user =3D (void *) fdata;
+
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
+				/* Elementary file short id*/
+				fileid_to_short_fileid(fileid),
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
 			return;
 		}
-	}
+	} else {
+		for (i =3D 0; i < N; i++) {
+			if (fileid =3D=3D info[i].fileid) {
+				cbd =3D isi_cb_data_new((void *) &info[i], cb,
+						data);
+				g_idle_add(fake_file_info, cbd);
+				return;
+			}
+		}
 =

+	}
+error:
 	DBG("Fileid %04X not implemented", fileid);
 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0, data);
 }
 =

-static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgi=
d,
-					uint8_t service)
+static void spn_resp_cb(const GIsiMessage *msg, void *data)
 {
-	uint8_t type;
-	uint8_t cause;
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
 =

-	if (g_isi_msg_error(msg) < 0) {
-		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
-		return FALSE;
-	}
+	const struct sim_spn *resp =3D NULL;
+	size_t len =3D sizeof(struct sim_spn);
 =

-	if (g_isi_msg_id(msg) !=3D msgid) {
-		DBG("Unexpected msg: %s",
-			sim_message_id_name(g_isi_msg_id(msg)));
-		return FALSE;
-	}
+	uint8_t spn[SIM_MAX_SPN_LENGTH + 1];
+	int i;
 =

-	if (!g_isi_msg_data_get_byte(msg, 1, &cause) || cause !=3D SIM_SERV_OK) {
-		DBG("Request failed: %s", sim_isi_cause_name(cause));
-		return FALSE;
-	}
+	if (!check_response_status(msg, SIM_SERV_PROV_NAME_RESP,
+					SIM_ST_READ_SERV_PROV_NAME))
+		goto error;
 =

-	if (!g_isi_msg_data_get_byte(msg, 0, &type) || type !=3D service) {
-		DBG("Unexpected service: 0x%02X", type);
-		return FALSE;
+	if (!g_isi_msg_data_get_struct(msg, 2, (const void **) &resp, len))
+		goto error;
+
+	/* Set display condition bits */
+	spn[0] =3D (resp->disp_home & 0x01) | ((resp->disp_roam & 0x01) << 1);
+
+	/* Convert from a NULL-terminated UCS-2 string to ASCII */
+	for (i =3D 0; i < SIM_MAX_SPN_LENGTH; i++) {
+		uint16_t c =3D resp->name[i] >> 8 | resp->name[i] << 8;
+
+		if (c =3D=3D 0)
+			c =3D 0xFF;
+		else if (!g_ascii_isprint(c))
+			c =3D '?';
+
+		spn[i + 1] =3D c;
 	}
-	return TRUE;
+
+	CALLBACK_WITH_SUCCESS(cb, spn, sizeof(spn), cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
 }
 =

-static void spn_resp_cb(const GIsiMessage *msg, void *data)
+static gboolean isi_read_spn(struct ofono_sim *sim, struct isi_cb_data *cb=
d)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	const uint8_t msg[] =3D {
+		SIM_SERV_PROV_NAME_REQ,
+		SIM_ST_READ_SERV_PROV_NAME,
+		0
+	};
+
+	if (sd =3D=3D NULL)
+		return FALSE;
+
+	return g_isi_client_send(sd->client, msg, sizeof(msg),
+					spn_resp_cb, cbd, g_free);
+}
+
+static void read_iccid_resp_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	struct sim_iccid *icc;
+	size_t len =3D sizeof(struct sim_iccid);
+
+	if (!check_response_status(msg, SIM_READ_FIELD_RESP, ICC))
+		goto error;
+
+	if (!g_isi_msg_data_get_struct(msg, 2, (const void **) &icc, len))
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, icc->id, 10, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+}
+
+static gboolean isi_read_iccid(struct ofono_sim *sim, struct isi_cb_data *=
cbd)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	const uint8_t req[] =3D {
+		SIM_READ_FIELD_REQ,
+		ICC,
+	};
+
+	if (sd =3D=3D NULL)
+		return FALSE;
+
+	return g_isi_client_send(sd->client, req, sizeof(req),
+					read_iccid_resp_cb, cbd, g_free);
+}
+
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
+static void isi_read_file_transparent(struct ofono_sim *sim, int fileid,
+					int start, int length,
+					ofono_sim_read_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd;
+	gboolean done;
+
+	cbd =3D isi_cb_data_new(sim, cb, data);
+
+	if (cbd =3D=3D NULL || sd =3D=3D NULL)
+		goto error;
+
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
+				/*Elementary file short id*/
+				fileid_to_short_fileid(fileid),
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
+
+	} else {
+		switch (fileid) {
+		case SIM_EFSPN_FILEID:
+			done =3D isi_read_spn(sim, cbd);
+			break;
+
+		case SIM_EF_ICCID_FILEID:
+			done =3D isi_read_iccid(sim, cbd);
+			break;
+
+		default:
+			done =3D FALSE;
+		}
+
+		if (done)
+			return;
+	}
+
+	DBG("Fileid %04X not implemented", fileid);
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	g_free(cbd);
+}
+
+static void isi_read_file_linear_fixed_resp(const GIsiMessage *msg, void *=
data)
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
+			/* Elementary file short file id*/
+			fileid_to_short_fileid(fileid),
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
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	g_free(cbd);
+}
+
+static void isi_read_file_cyclic(struct ofono_sim *sim, int fileid,
+					int record, int length,
+					ofono_sim_read_cb_t cb, void *data)
+{
+	DBG("Fileid %04X not implemented", fileid);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+}
+
+static void isi_write_file_transparent(struct ofono_sim *sim, int fileid,
+					int start, int length,
+					const unsigned char *value,
+					ofono_sim_write_cb_t cb, void *data)
+{
+	DBG("Fileid %04X not implemented", fileid);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
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
+static void isi_write_file_linear(struct ofono_sim *sim, int fileid,
+					int record, int length,
+					const unsigned char *value,
+					ofono_sim_write_cb_t cb, void *data)
+{
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
+				fileid_to_short_fileid(fileid),
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
+	DBG("Fileid %04X not implemented", fileid);
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void isi_write_file_cyclic(struct ofono_sim *sim, int fileid,
+					int length, const unsigned char *value,
+					ofono_sim_write_cb_t cb, void *data)
+{
+	DBG("Fileid %04X not implemented", fileid);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+static void uicc_read_imsi_resp(const struct ofono_error *error,
+				const unsigned char *data,
+				int len,
+				void *user)
+{
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
+	ofono_sim_imsi_cb_t cb =3D cbd->cb;
+
+	struct sim_imsi *resp;
+	size_t len =3D sizeof(struct sim_imsi);
+
+	char imsi[SIM_MAX_IMSI_LENGTH + 1];
+	size_t i, j;
+
+	if (!g_isi_msg_data_get_struct(msg, 2, (const void **) &resp, len))
+		goto error;
+
+	/* Ignore the low-order semi-octet of the first byte */
+	imsi[0] =3D ((resp->imsi[0] & 0xF0) >> 4) + '0';
+
+	for (i =3D 1, j =3D 1; i < resp->length && j < SIM_MAX_IMSI_LENGTH; i++) {
+		char nibble;
+
+		imsi[j++] =3D (resp->imsi[i] & 0x0F) + '0';
+		nibble =3D (resp->imsi[i] & 0xF0) >> 4;
+		if (nibble !=3D 0x0F)
+			imsi[j++] =3D nibble + '0';
+	}
+
+	imsi[j] =3D '\0';
+	CALLBACK_WITH_SUCCESS(cb, imsi, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static void isi_read_imsi(struct ofono_sim *sim,
+				ofono_sim_imsi_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	size_t len;
+
+	const uint8_t msg[] =3D {
+		SIM_IMSI_REQ_READ_IMSI,
+		READ_IMSI
+	};
+
+	if (cbd =3D=3D NULL || sd =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_resource(sd->client) =3D=3D PN_UICC) {
+		isi_read_file_transparent(sim, SIM_EFIMSI_FILEID, 0, 9,
+				uicc_read_imsi_resp, cbd);
+		return;
+	}
+	len =3D sizeof(msg);
+
+
+	if (g_isi_client_send(sd->client, msg, len, imsi_resp_cb, cbd, g_free))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+	g_free(cbd);
+}
+
+static void uicc_application_activate_req(GIsiClient *client,
+						void *opaque,
+						unsigned char appl_type,
+						unsigned char aid);
+
+
+static void uicc_application_activate_resp(const GIsiMessage *msg, void *d=
ata)
+{
+	struct ofono_sim *sim =3D data;
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
+	uint8_t status;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	if (g_isi_msg_error(msg) < 0)
+		return;
+
+	if (g_isi_msg_id(msg) !=3D UICC_APPLICATION_RESP)
+		return;
+
+	g_isi_msg_data_get_byte(msg, 1, &status);
+
+	if (status =3D=3D UICC_STATUS_OK || status =3D=3D UICC_STATUS_APPL_ACTIVE=
) {
+		if (!sd->uicc_app_started) {
+			sd->app_id =3D sd->trying_app_id;
+			sd->app_type =3D sd->trying_app_type;
+			sd->uicc_app_started =3D TRUE;
+			DBG("UICC application activated");
+			ofono_sim_inserted_notify(sim, TRUE);
+			ofono_sim_register(sim);
+			g_free(sd->sim_application_list_p);
+		}
+	} else {
+		int i =3D sim_applications_get_next_index(
+					sd->sim_application_list_p,
+					sd->trying_app_id);
+
+		if (i =3D=3D NOT_AVAILABLE) {
+			g_free(sd->sim_application_list_p);
+			return;
+		}
+
+		DBG("Activation Error, trying to activate APP with ID:%d", i);
+		uicc_application_activate_req(sd->client, sim,
+				sd->sim_application_list_p->app_type[i],
+				sd->sim_application_list_p->app_list[i]);
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
+	sd->sim_application_list_p =3D g_try_new0(struct sim_applications, 1);
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
+				sd->sim_application_list_p->app_list[appl_id] =3D
+					appl_id;
+				sd->sim_application_list_p->app_type[appl_id] =3D
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
+		index =3D sim_applications_get_next_index(
+						sd->sim_application_list_p,
+						NOT_ACTIVATED);
+
+		if (index !=3D NOT_AVAILABLE) {
+			DBG("Activating APP index:%d", index);
+			sd->trying_app_id =3D
+			  sd->sim_application_list_p->app_list[index];
+			sd->trying_app_type =3D
+			  sd->sim_application_list_p->app_type[index];
+			DBG("Activating APP ID: %d APP type: %d",
+				sd->trying_app_id, sd->trying_app_type);
+			uicc_application_activate_req(sd->client, sim,
+				sd->sim_application_list_p->app_type[index],
+				sd->sim_application_list_p->app_list[index]);
+		} else
+			g_free(sd->sim_application_list_p);
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
+	GIsiSubBlockIter iter;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *) local_sim);
+	uint8_t sbcount =3D 0;
+
+	if (g_isi_msg_error(msg) < 0)
+		goto error;
+
+	if (check_response_status(msg, UICC_PIN_RESP, UICC_PIN_VERIFY)) {
+		sd->passwd_required =3D FALSE;
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		goto out;
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
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
+
+			switch (status) {
+			case UICC_PIN_STATUS_AUTH_BLOCKED:
+			case UICC_PIN_STATUS_AUTH_FAILED:
+				DBG("Authentication method blocked");
+				update_locked_pin(local_sim,
+							UICC_PIN_UNBLOCK_NEEDED,
+							sd->current_pin_id);
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D
+						UICC_PIN_STATUS_AUTH_RETRIES)
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
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+out:
+	g_free(cbd);
+}
+
+static void uicc_pin_enter(struct ofono_sim *sim, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	char pin[8] =3D {0, 0, 0, 0, 0, 0, 0, 0};
+
+	sd->current_pin_id =3D sd->pin1_id; /* No way to enter PIN2 */
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
+			/* Subblock 1 */
+			UICC_SB_PIN >> 8,
+			UICC_SB_PIN & 0xff,
+			0,
+			16, /* Max length */
+			sd->current_pin_id, /* PIN id */
+			UICC_PIN_OLD, /* PIN qualifier */
+			pinlen /* PIN length */
+		};
+		struct iovec iov[2] =3D {
+				{ msg, sizeof(msg) },
+				{ pin, 8 }
+		};
+
+		if ((pinlen < 4) || (pinlen > 8))
+			goto error;
+
+		memmove(pin, passwd, pinlen);
+
+		g_isi_client_vsend_with_timeout(sd->client, iov, 2,
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
+static void uicc_pin_prompt(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				ofono_sim_passwd_cb_t cb,
+				void *data,
+				uint8_t service);
+
+
+static void uicc_pin_prompt_resp(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd =3D data;
-	ofono_sim_read_cb_t cb =3D cbd->cb;
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
+	if (!check_response_status(msg, UICC_PIN_RESP, UICC_PIN_PROMPT_VERIFY)
+			&& !check_response_status(msg, UICC_PIN_RESP,
+							UICC_PIN_INFO)) {
+
+		if (!check_response_status_with_cause(msg, UICC_PIN_RESP,
+						UICC_PIN_PROMPT_VERIFY,
+						UICC_STATUS_PIN_DISABLED, 1))
+			goto error;
+	}
 =

-	const struct sim_spn *resp =3D NULL;
-	size_t len =3D sizeof(struct sim_spn);
+	g_isi_msg_data_get_byte(msg, 1, &status);
+
+	if (check_response_status(msg, UICC_PIN_RESP, UICC_PIN_PROMPT_VERIFY)) {
+		sd->pin_state_received =3D TRUE;
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
 =

-	uint8_t spn[SIM_MAX_SPN_LENGTH + 1];
-	int i;
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
 =

-	if (!check_response_status(msg, SIM_SERV_PROV_NAME_RESP,
-					SIM_ST_READ_SERV_PROV_NAME))
-		goto error;
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
 =

-	if (!g_isi_msg_data_get_struct(msg, 2, (const void **) &resp, len))
-		goto error;
+	if (check_response_status(msg, UICC_PIN_RESP, UICC_PIN_PROMPT_VERIFY)) {
+		uicc_pin_prompt(cbd->user,
+				OFONO_SIM_PASSWORD_SIM_PIN,
+				cb,
+				cbd->data,
+				UICC_PIN_INFO);
+	}
 =

-	/* Set display condition bits */
-	spn[0] =3D (resp->disp_home & 0x01) | ((resp->disp_roam & 0x01) << 1);
+	CALLBACK_WITH_SUCCESS(cb, lock_type, cbd->data);
+	return;
+error:
+	DBG("PIN prompt verify failed");
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
 =

-	/* Convert from a NULL-terminated UCS-2 string to ASCII */
-	for (i =3D 0; i < SIM_MAX_SPN_LENGTH; i++) {
-		uint16_t c =3D resp->name[i] >> 8 | resp->name[i] << 8;
+static void uicc_pin_prompt(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				ofono_sim_passwd_cb_t cb,
+				void *data,
+				uint8_t service)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int8_t index;
+	unsigned char msg[] =3D {
+		UICC_PIN_REQ,
+		service,
+		0, /*app id*/
+		0, /*Filler*/
+		0, /*Filler*/
+		0, /*Filler*/
+		1, /*number of subblocks*/
+		/* Subblock 1 */
+		UICC_SB_PIN_REF >> 8,
+		UICC_SB_PIN_REF & 0xff,
+		0, /*Sub block length.*/
+		8,
+		0, /*PIN ID*/
+		0, /*Filler*/
+		0, /*Filler*/
+		0  /*Filler*/
+	};
 =

-		if (c =3D=3D 0)
-			c =3D 0xFF;
-		else if (!g_ascii_isprint(c))
-			c =3D '?';
+	sd->current_pin_id =3D get_pin_id(sd, passwd_type, &index);
 =

-		spn[i + 1] =3D c;
+	if (cbd =3D=3D NULL || sd =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+		return;
 	}
 =

-	CALLBACK_WITH_SUCCESS(cb, spn, sizeof(spn), cbd->data);
-	return;
+	if (sd->current_pin_id =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+		return;
+	}
 =

-error:
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+	msg[2] =3D sd->app_id;
+	msg[11] =3D sd->current_pin_id;
+
+	g_isi_client_send_with_timeout(sd->client, msg, sizeof(msg),
+					SIM_TIMEOUT, uicc_pin_prompt_resp,
+					cbd, g_free);
 }
 =

-static gboolean isi_read_spn(struct ofono_sim *sim, struct isi_cb_data *cb=
d)
+static void uicc_passwd_state_query(struct ofono_sim *sim,
+					ofono_sim_passwd_cb_t cb,
+					void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct ofono_sim_local *local_sim =3D (struct ofono_sim_local *)sim;
 =

-	const uint8_t msg[] =3D {
-		SIM_SERV_PROV_NAME_REQ,
-		SIM_ST_READ_SERV_PROV_NAME,
-		0
-	};
+	if (sd->pin_state_received) {
+		int lock_type =3D OFONO_SIM_PASSWORD_NONE;
 =

-	if (sd =3D=3D NULL)
-		return FALSE;
+		if (sd->passwd_required) {
+			/* These should be in priority order, highest last */
+			if (local_sim->locked_pins[
+				    OFONO_SIM_PASSWORD_SIM_PIN] =3D=3D TRUE)
+				lock_type =3D OFONO_SIM_PASSWORD_SIM_PIN;
 =

-	return g_isi_client_send(sd->client, msg, sizeof(msg),
-					spn_resp_cb, cbd, g_free);
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
+			uicc_pin_prompt(sim, OFONO_SIM_PASSWORD_SIM_PIN,
+					cb, data, UICC_PIN_PROMPT_VERIFY);
+			return;
+		}
+
+		DBG("No UICC_PIN_IND received");
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+	}
 }
 =

-static void read_iccid_resp_cb(const GIsiMessage *msg, void *data)
+static void uicc_pin_enable_resp(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd =3D data;
-	ofono_sim_read_cb_t cb =3D cbd->cb;
-	struct sim_iccid *icc;
-	size_t len =3D sizeof(struct sim_iccid);
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *) local_sim);
 =

-	if (!check_response_status(msg, SIM_READ_FIELD_RESP, ICC))
-		goto error;
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
 =

-	if (!g_isi_msg_data_get_struct(msg, 2, (const void **) &icc, len))
+	if (g_isi_msg_error(msg) < 0)
 		goto error;
 =

-	CALLBACK_WITH_SUCCESS(cb, icc->id, 10, cbd->data);
-	return;
-
-error:
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
-}
+	if (!check_response_status(msg, UICC_PIN_RESP, UICC_PIN_DISABLE) &&
+			!check_response_status(msg, UICC_PIN_RESP,
+					UICC_PIN_ENABLE))
+		goto cont;
 =

-static gboolean isi_read_iccid(struct ofono_sim *sim, struct isi_cb_data *=
cbd)
-{
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	DBG("PIN lock/unlock succeeded");
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
 =

-	const uint8_t req[] =3D {
-		SIM_READ_FIELD_REQ,
-		ICC,
-	};
+cont:
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
+			case UICC_PIN_STATUS_AUTH_BLOCKED:
+			case UICC_PIN_STATUS_AUTH_FAILED:
+				DBG("Authentication method blocked");
+				update_locked_pin(local_sim,
+						  UICC_PIN_UNBLOCK_NEEDED,
+						  sd->current_pin_id);
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D
+						UICC_PIN_STATUS_AUTH_RETRIES)
+					DBG("Attempts left %d", status & 0xf);
+
+				break;
+			}
+		}
+		default:
+			break;
+		}
 =

-	if (sd =3D=3D NULL)
-		return FALSE;
+		g_isi_sb_iter_next(&iter);
+	}
 =

-	return g_isi_client_send(sd->client, req, sizeof(req),
-					read_iccid_resp_cb, cbd, g_free);
+error:
+	DBG("PIN lock/unlock failed");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

-static void isi_read_file_transparent(struct ofono_sim *sim, int fileid,
-					int start, int length,
-					ofono_sim_read_cb_t cb, void *data)
+static void uicc_pin_enable(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				int enable, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
 {
-	struct isi_cb_data *cbd;
-	gboolean done;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int8_t index;
+	unsigned char service =3D 0;
 =

-	cbd =3D isi_cb_data_new(sim, cb, data);
-	if (cbd =3D=3D NULL)
+	if (cbd =3D=3D NULL || sd =3D=3D NULL)
 		goto error;
 =

-	switch (fileid) {
-	case SIM_EFSPN_FILEID:
-		done =3D isi_read_spn(sim, cbd);
-		break;
-
-	case SIM_EF_ICCID_FILEID:
-		done =3D isi_read_iccid(sim, cbd);
-		break;
+	sd->current_pin_id =3D get_pin_id(sd, passwd_type, &index);
 =

-	default:
-		done =3D FALSE;
-	}
+	if (sd->current_pin_id =3D=3D 0)
+		goto error;
 =

-	if (done)
+	if (enable)
+		service =3D UICC_PIN_ENABLE;
+	else
+		service =3D UICC_PIN_DISABLE;
+
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
 		return;
-
-	DBG("Fileid %04X not implemented", fileid);
+	}
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	CALLBACK_WITH_FAILURE(cb, data);
 	g_free(cbd);
+	return;
 }
 =

-static void isi_read_file_linear(struct ofono_sim *sim, int fileid,
-					int record, int length,
-					ofono_sim_read_cb_t cb, void *data)
+static void uicc_pin_change_resp(const GIsiMessage *msg, void *data)
 {
-	DBG("Fileid %04X not implemented", fileid);
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
-}
+	struct isi_cb_data *cbd =3D data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	struct sim_data *sd =3D
+			ofono_sim_get_data((struct ofono_sim *) local_sim);
 =

-static void isi_read_file_cyclic(struct ofono_sim *sim, int fileid,
-					int record, int length,
-					ofono_sim_read_cb_t cb, void *data)
-{
-	DBG("Fileid %04X not implemented", fileid);
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
-}
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
 =

-static void isi_write_file_transparent(struct ofono_sim *sim, int fileid,
-					int start, int length,
-					const unsigned char *value,
-					ofono_sim_write_cb_t cb, void *data)
-{
-	DBG("Fileid %04X not implemented", fileid);
-	CALLBACK_WITH_FAILURE(cb, data);
-}
+	if (g_isi_msg_error(msg) < 0)
+		goto error;
 =

-static void isi_write_file_linear(struct ofono_sim *sim, int fileid,
-					int record, int length,
-					const unsigned char *value,
-					ofono_sim_write_cb_t cb, void *data)
-{
-	DBG("Fileid %04X not implemented", fileid);
-	CALLBACK_WITH_FAILURE(cb, data);
+	if (!check_response_status(msg, UICC_PIN_RESP, UICC_PIN_CHANGE))
+		goto cont;
+
+	DBG("PIN change succeeded");
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+
+cont:
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
+			case UICC_PIN_STATUS_AUTH_BLOCKED:
+			case UICC_PIN_STATUS_AUTH_FAILED:
+				DBG("Authentication method blocked");
+				update_locked_pin(local_sim,
+					UICC_PIN_UNBLOCK_NEEDED,
+						sd->current_pin_id);
+				break;
+			default:
+
+				if ((status & 0xfff0) =3D=3D
+						UICC_PIN_STATUS_AUTH_RETRIES)
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
+error:
+	DBG("PIN change failed");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

-static void isi_write_file_cyclic(struct ofono_sim *sim, int fileid,
-					int length, const unsigned char *value,
-					ofono_sim_write_cb_t cb, void *data)
+static void uicc_change_pin(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				const char *old,
+				const char *new,
+				ofono_sim_lock_unlock_cb_t cb,
+				void *data)
 {
-	DBG("Fileid %04X not implemented", fileid);
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
 	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+	return;
 }
 =

-static void imsi_resp_cb(const GIsiMessage *msg, void *data)
+static void uicc_pin_send_puk_resp(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd =3D data;
-	ofono_sim_imsi_cb_t cb =3D cbd->cb;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim_local *local_sim =3D
+					(struct ofono_sim_local *) cbd->user;
+	GIsiSubBlockIter iter;
+	uint8_t sbcount =3D 0;
 =

-	struct sim_imsi *resp;
-	size_t len =3D sizeof(struct sim_imsi);
+	if (g_isi_msg_error(msg) < 0)
+		goto error;
+	if (!check_response_status(msg, UICC_PIN_RESP, UICC_PIN_UNBLOCK))
+		goto cont;
+
+	DBG("PIN reset succeeded");
+	/* Only PIN1 can be reseted, turns PIN query on */
+	local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PIN] =3D TRUE;
+	local_sim->locked_pins[OFONO_SIM_PASSWORD_SIM_PUK] =3D FALSE;
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
 =

-	char imsi[SIM_MAX_IMSI_LENGTH + 1];
-	size_t i, j;
+cont:
+	g_isi_msg_data_get_byte(msg, 5, &sbcount);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
 =

-	if (!check_response_status(msg, SIM_IMSI_RESP_READ_IMSI, READ_IMSI))
-		goto error;
+	while (g_isi_sb_iter_is_valid(&iter)) {
+		DBG("Sub-block %s",
+			uicc_subblock_name(g_isi_sb_iter_get_id(&iter)));
 =

-	if (!g_isi_msg_data_get_struct(msg, 2, (const void **) &resp, len))
-		goto error;
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case UICC_SB_STATUS_WORD: {
+			uint16_t status;
+			g_isi_sb_iter_get_word(&iter, &status, 6);
+			DBG("APDU status word =3D %04X", status);
 =

-	/* Ignore the low-order semi-octet of the first byte */
-	imsi[0] =3D ((resp->imsi[0] & 0xF0) >> 4) + '0';
+			switch (status) {
+			case UICC_PIN_STATUS_AUTH_BLOCKED:
+			case UICC_PIN_STATUS_AUTH_FAILED:
+				DBG("Authentication method blocked");
+				break;
+			default:
 =

-	for (i =3D 1, j =3D 1; i < resp->length && j < SIM_MAX_IMSI_LENGTH; i++) {
-		char nibble;
+				if ((status & 0xfff0) =3D=3D
+						UICC_PIN_STATUS_AUTH_RETRIES)
+					DBG("Attempts left %d", status & 0xf);
 =

-		imsi[j++] =3D (resp->imsi[i] & 0x0F) + '0';
-		nibble =3D (resp->imsi[i] & 0xF0) >> 4;
-		if (nibble !=3D 0x0F)
-			imsi[j++] =3D nibble + '0';
-	}
+				break;
+			}
 =

-	imsi[j] =3D '\0';
-	CALLBACK_WITH_SUCCESS(cb, imsi, cbd->data);
-	return;
+			break;
+		}
+		default:
+			break;
+		}
+
+		g_isi_sb_iter_next(&iter);
+	}
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+	DBG("PIN reset failed");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

-static void isi_read_imsi(struct ofono_sim *sim,
-				ofono_sim_imsi_cb_t cb, void *data)
+static void uicc_pin_send_puk(struct ofono_sim *sim,
+				const char *puk,
+				const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb,
+				void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	unsigned char service =3D UICC_PIN_UNBLOCK;
+	unsigned char pinlen =3D strlen(passwd);
+	uint8_t pin[8] =3D { 0, 0, 0, 0, 0, 0, 0, 0 };
+	uint8_t pukcode[10] =3D { 0, 0, 0 , 0, 0, 0, 0, 0, 0, 0 };
+
+	uint8_t msg[] =3D {
+		UICC_PIN_REQ,
+		service,
+		sd->app_id,
+		0, /*Filler*/
+		0, /*Filler*/
+		0, /*Filler*/
+		2, /*number of subblocks*/
+		/* Subblock 1*/
+		UICC_SB_PIN >> 8,
+		UICC_SB_PIN & 0xff,
+		0,
+		16, /*sb length, must be fixed*/
+		sd->current_pin_id, /* PIN id*/
+		UICC_PIN_NEW, /* PIN qualifier*/
+		pinlen /* PIN length*/
+	};
+	uint8_t msg2[] =3D {
+		/* Subblock 2*/
+		UICC_SB_PUK >> 8,
+		UICC_SB_PUK & 0xff,
+		0,
+		16, /*Sub block length*/
+		sd->current_pin_id, /* PIN id*/
+		8, /* PUK length*/
+	};
 =

-	const uint8_t msg[] =3D {
-		SIM_IMSI_REQ_READ_IMSI,
-		READ_IMSI
+	struct iovec iov[4] =3D {
+			{ msg, sizeof(msg) },
+			{ pin, 8 },
+			{ msg2, sizeof(msg2) },
+			{ pukcode, 10 }
 	};
-	size_t len =3D sizeof(msg);
 =

 	if (cbd =3D=3D NULL || sd =3D=3D NULL)
 		goto error;
 =

-	if (g_isi_client_send(sd->client, msg, len, imsi_resp_cb, cbd, g_free))
-		return;
+	if ((pinlen < 4) || (pinlen > 8))
+		goto error;
+
+	if (strlen(puk) !=3D 8)
+		goto error;
+
+	sd->current_pin_id =3D sd->pin1_id; /* No way to reset PIN2 */
+
+	memmove(pin, passwd, pinlen);
+	memmove(pukcode, puk, 8);
+
+	g_isi_client_vsend_with_timeout(sd->client, iov, 4, SIM_TIMEOUT,
+						uicc_pin_send_puk_resp, cbd,
+						g_free);
+	return;
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, data);
 	g_free(cbd);
+	return;
 }
 =

 static void isi_sim_register(struct ofono_sim *sim)
@@ -414,34 +2569,125 @@ static void sim_ind_cb(const GIsiMessage *msg, void=
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
+
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
+	GIsiModem *modem =3D g_isi_client_modem(sd->primary);
 =

-	if (!g_isi_msg_data_get_byte(msg, 0, &status))
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
+	g_isi_modem_set_sim(modem, sim);
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
+	GIsiModem *modem =3D g_isi_client_modem(sd->secondary);
 =

 	if (g_isi_msg_error(msg) < 0)
 		return;
 =

 	ISI_VERSION_DBG(msg);
 =

+	sd->client =3D sd->secondary;
+
+	g_isi_modem_set_sim(modem, sim);
+
 	/* Check if SIM is ready by reading HPLMN */
 	isi_read_hplmn(sim);
+
+	g_isi_client_destroy(sd->primary);
 }
 =

 static int isi_sim_probe(struct ofono_sim *sim, unsigned int vendor,
@@ -454,16 +2700,32 @@ static int isi_sim_probe(struct ofono_sim *sim, unsi=
gned int vendor,
 	if (sd =3D=3D NULL)
 		return -ENOMEM;
 =

-	sd->client =3D g_isi_client_create(modem, PN_SIM);
-	if (sd->client =3D=3D NULL) {
+	sd->primary =3D g_isi_client_create(modem, PN_UICC);
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
@@ -471,13 +2733,23 @@ static int isi_sim_probe(struct ofono_sim *sim, unsi=
gned int vendor,
 static void isi_sim_remove(struct ofono_sim *sim)
 {
 	struct sim_data *data =3D ofono_sim_get_data(sim);
-
-	ofono_sim_set_data(sim, NULL);
+	GIsiModem *modem =3D g_isi_client_modem(data->client);
 =

 	if (data =3D=3D NULL)
 		return;
 =

-	g_isi_client_destroy(data->client);
+	g_isi_modem_set_sim(modem, NULL);
+
+	if (g_isi_client_resource(data->client) =3D=3D PN_UICC) {
+		data->uicc_app_started =3D FALSE;
+		data->pin_state_received =3D FALSE;
+		data->passwd_required =3D TRUE;
+
+		g_isi_client_destroy(data->client);
+	} else
+		g_isi_client_destroy(data->client);
+
+	ofono_sim_set_data(sim, NULL);
 	g_free(data);
 }
 =

@@ -493,8 +2765,18 @@ static struct ofono_sim_driver driver =3D {
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
-- =

1.7.3.5


--===============6645238562338327733==--

