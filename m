Content-Type: multipart/mixed; boundary="===============7995299578623939160=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 16/18] isimodem: sms updated with wgmodem2.5
Date: Wed, 23 Feb 2011 12:43:27 +0100
Message-ID: <7de8fe589465c457fa1fc98ee4bedf6e98db9d4b.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7995299578623939160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/sms.c |  958 +++++++++++++++++++++++++++++++++++++++++---=
----
 1 files changed, 822 insertions(+), 136 deletions(-)

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 957b342..f721684 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2011.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -45,6 +46,7 @@
 #include "isimodem.h"
 #include "isiutil.h"
 #include "sms.h"
+#include "uicc.h"
 #include "debug.h"
 =

 /* This is a straightforward copy of the EF_smsp structure */
@@ -60,6 +62,18 @@ struct sim_efsmsp{
 	uint16_t alpha[17];
 };
 =

+/* USIM structure, 3GPP TS 31.102 */
+struct usim_efsmp {
+	uint8_t alphalen; /* not part of the USIM EF_smsp structure */
+	uint8_t alpha[241];
+	uint8_t indicators; /* parameter indicators */
+	uint8_t tp_dst[12];
+	uint8_t tp_sca[12];
+	uint8_t tp_pid; /* protocol identifier */
+	uint8_t tp_dcs; /* data coding scheme */
+	uint8_t tp_vp; /* validity period */
+};
+
 /* Sub-block used by PN_SMS */
 struct sms_params {
 	uint8_t location;
@@ -99,12 +113,52 @@ struct sms_common {
 	uint8_t *data;
 };
 =

+const unsigned char SMS_STATUS_REPORT =3D 0x02;
+
 struct sms_data {
 	GIsiClient *client;
 	GIsiClient *sim;
-	struct sim_efsmsp params;
+	GIsiVersion version;
+	struct sim_efsmsp sim_params;
+	struct usim_efsmp usim_params;
 };
 =

+static gboolean check_uicc_status(const GIsiMessage *msg, uint8_t msgid,
+					uint8_t service)
+{
+	uint8_t type;
+	uint8_t cause;
+
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
+		return FALSE;
+	}
+
+	if (g_isi_msg_id(msg) !=3D msgid) {
+		DBG("Unexpected msg: %s",
+			uicc_message_id_name(g_isi_msg_id(msg)));
+		return FALSE;
+	}
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &type))
+		return FALSE;
+
+	if (type !=3D service) {
+		DBG("Unexpected service type: 0x%02X", type);
+		return FALSE;
+	}
+
+	if (!g_isi_msg_data_get_byte(msg, 1, &cause))
+		return FALSE;
+
+	if (cause !=3D UICC_STATUS_OK) {
+		DBG("Request failed: %s", uicc_status_name(cause));
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static gboolean check_sim_status(const GIsiMessage *msg, uint8_t msgid,
 					uint8_t service)
 {
@@ -141,7 +195,8 @@ static gboolean check_sim_status(const GIsiMessage *msg=
, uint8_t msgid,
 	return TRUE;
 }
 =

-static gboolean check_sms_status(const GIsiMessage *msg, uint8_t msgid)
+static gboolean check_sms_status_with_cause(const GIsiMessage *msg,
+			uint8_t msgid, uint8_t expected_cause, int cause_pos)
 {
 	uint8_t cause;
 =

@@ -156,12 +211,12 @@ static gboolean check_sms_status(const GIsiMessage *m=
sg, uint8_t msgid)
 		return FALSE;
 	}
 =

-	if (!g_isi_msg_data_get_byte(msg, 0, &cause)) {
+	if (!g_isi_msg_data_get_byte(msg, cause_pos, &cause)) {
 		DBG("Unable to parse cause");
 		return FALSE;
 	}
 =

-	if (cause =3D=3D SMS_OK)
+	if (cause =3D=3D expected_cause)
 		return TRUE;
 =

 	if (cause =3D=3D SMS_ERR_PP_RESERVED) {
@@ -178,6 +233,101 @@ static gboolean check_sms_status(const GIsiMessage *m=
sg, uint8_t msgid)
 	return FALSE;
 }
 =

+static gboolean check_sms_status(const GIsiMessage *msg, uint8_t msgid)
+{
+	return check_sms_status_with_cause(msg, msgid, SMS_OK, 0);
+}
+
+static void sca_query_resp_uicc_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_sms *sms =3D cbd->user;
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	ofono_sms_sca_query_cb_t cb =3D cbd->cb;
+
+	struct ofono_phone_number sca;
+	uint8_t bcd_len;
+	GIsiSubBlockIter iter;
+	int alphalen =3D 0;
+	uint32_t data_len =3D 0;
+	uint8_t sbcount =3D 0;
+
+	int i;
+	DBG("");
+
+	if (!check_uicc_status(msg, UICC_APPL_CMD_RESP,
+					UICC_APPL_READ_LINEAR_FIXED))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 5, &sbcount) || sbcount =3D=3D 0)
+		goto error;
+
+	DBG("starting");
+	for (g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sbcount);
+					g_isi_sb_iter_is_valid(&iter);
+					g_isi_sb_iter_next(&iter)) {
+		if (g_isi_sb_iter_get_id(&iter) !=3D UICC_SB_FILE_DATA)
+			continue;
+		DBG("found UICC_SB_FILE_DATA");
+		g_isi_sb_iter_get_dword(&iter, &data_len, 4);
+
+		DBG("got length %d", data_len);
+		if (data_len < 28)
+			goto error;
+
+		/*y is alpha identifier see 3GPP TS 31.102*/
+		alphalen =3D data_len - 28;
+
+		sd->usim_params.alphalen =3D alphalen;
+		for (i =3D 0; i < alphalen; i++) {
+			uint8_t t_byte;
+			g_isi_sb_iter_get_byte(&iter, &t_byte, 8 + i);
+			sd->usim_params.alpha[i] =3D t_byte;
+		}
+
+		g_isi_sb_iter_get_byte(&iter, &(sd->usim_params.indicators),
+					8 + alphalen);
+
+		for (i =3D 0; i < 12; i++) {
+			uint8_t t_byte;
+			g_isi_sb_iter_get_byte(&iter, &t_byte,
+						8 + alphalen + 1 + i);
+			sd->usim_params.tp_dst[i] =3D t_byte;
+			g_isi_sb_iter_get_byte(&iter, &t_byte,
+						 8 + alphalen + 1 + 12 + i);
+			sd->usim_params.tp_sca[i] =3D t_byte;
+		}
+		g_isi_sb_iter_get_byte(&iter, &(sd->usim_params.tp_pid),
+					alphalen + 1 + 12 + 12);
+		g_isi_sb_iter_get_byte(&iter, &(sd->usim_params.tp_dcs),
+					alphalen + 1 + 12 + 12 + 1);
+		g_isi_sb_iter_get_byte(&iter, &(sd->usim_params.tp_vp),
+					alphalen + 1 + 12 + 12 + 1 + 1);
+
+		DBG("indicators: %d", sd->usim_params.indicators & 0x2);
+		/*if TS-Service Centre Address absent*/
+		if (sd->usim_params.indicators & 0x2)
+			goto error;
+
+		bcd_len =3D sd->usim_params.tp_sca[0];
+
+		DBG("bcd length: %d", bcd_len);
+		if (bcd_len <=3D 1 || bcd_len > 12)
+			goto error;
+
+		extract_bcd_number(sd->usim_params.tp_sca + 2, bcd_len - 1,
+				sca.number);
+		sca.type =3D sd->usim_params.tp_sca[1];
+		DBG("new sca: %04X",
+				(unsigned int) strlen(sca.number));
+		CALLBACK_WITH_SUCCESS(cb, &sca, cbd->data);
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
 static void sca_query_resp_cb(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd =3D data;
@@ -203,16 +353,19 @@ static void sca_query_resp_cb(const GIsiMessage *msg,=
 void *data)
 =

 	info->alpha[info->alphalen - 1] =3D '\0';
 =

-	sd->params.absent =3D info->absent;
-	sd->params.tp_pid =3D info->tp_pid;
-	sd->params.tp_dcs =3D info->tp_dcs;
-	sd->params.tp_vp =3D info->tp_vp;
+	sd->sim_params.absent =3D info->absent;
+	sd->sim_params.tp_pid =3D info->tp_pid;
+	sd->sim_params.tp_dcs =3D info->tp_dcs;
+	sd->sim_params.tp_vp =3D info->tp_vp;
 =

-	memcpy(sd->params.dst, info->dst, sizeof(sd->params.dst));
-	memcpy(sd->params.sca, info->sca, sizeof(sd->params.sca));
+	memmove(sd->sim_params.dst, info->dst,
+		sizeof(sd->sim_params.dst));
+	memmove(sd->sim_params.sca, info->sca,
+		sizeof(sd->sim_params.sca));
 =

-	sd->params.alphalen =3D info->alphalen;
-	memcpy(sd->params.alpha, info->alpha, sizeof(sd->params.alpha));
+	sd->sim_params.alphalen =3D info->alphalen;
+	memmove(sd->sim_params.alpha, info->alpha,
+		sizeof(sd->sim_params.alpha));
 =

 	/*
 	 * Bitmask indicating absence of parameters --
@@ -236,21 +389,86 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+static gboolean sca_query_uicc(struct sms_data *sd, struct isi_cb_data *cb=
d)
+{
+	GIsiModem *modem =3D g_isi_client_modem(sd->sim);
+	int8_t app_id =3D get_app_id(modem);
+	uint8_t client_id =3D get_client_id(modem);
+	int app_type =3D get_app_type(modem);
+	DBG("");
+	if (app_id !=3D -1 && client_id !=3D 0) {
+		int mf_path =3D 0x3F00;
+		int df_path =3D (app_type =3D=3D UICC_APPL_TYPE_UICC_USIM) ? 0x7FFF
+							: 0x7F10;
+		int df_len =3D 4;
+		uint8_t msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_READ_LINEAR_FIXED,
+			app_id,
+			UICC_SESSION_ID_NOT_USED,
+			0, 0, /*fillers*/
+			3, /*nro of sub blocks*/
+
+			UICC_SB_CLIENT >> 8, /*1st subblock*/
+			UICC_SB_CLIENT & 0xFF,
+			0,/*subblock length*/
+			8,/*subblock length*/
+			0, 0, 0,/*fillers*/
+			client_id,
+
+			UICC_SB_APPL_PATH >> 8,/*2nd subblock*/
+			UICC_SB_APPL_PATH & 0xFF,
+			0,/*subblock length*/
+			16,/*subblock length*/
+			0x6F42 >> 8,/*Elementary file ID for EFsmsp*/
+			0x6F42 & 0xFF,
+			UICC_SFI_NOT_PRESENT,
+			0,/*filler*/
+			df_len,/*Path length*/
+			0,/*filler*/
+			mf_path >> 8,/*DF Path MF*/
+			mf_path & 0xFF,
+			df_path >> 8,/*DF Path DFtelecom*/
+			df_path & 0xFF,
+			0, 0,/*fillers 0-3*/
+			UICC_SB_LINEAR_FIXED >> 8,/*3rd subblock*/
+			UICC_SB_LINEAR_FIXED & 0xFF,
+			0,/*subblock length*/
+			8,/*subblock length*/
+			1,/*The record in the file*/
+			0,/*offset 0 =3D=3D beginning of the record*/
+			0,/*data amount 0 =3D=3D until end of record*/
+			0,/*filler*/
+		};
+
+		return g_isi_client_send(sd->sim, msg, sizeof(msg),
+					sca_query_resp_uicc_cb, cbd, g_free);
+	}
+
+	return FALSE;
+}
+
 static void isi_sca_query(struct ofono_sms *sms,
 				ofono_sms_sca_query_cb_t cb, void *data)
 {
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
-
-	const uint8_t msg[] =3D {
+	uint8_t msg[] =3D {
 		SIM_SMS_REQ,
 		READ_PARAMETER,
 		1,	/* Location, default is 1 */
 	};
+	DBG("");
 =

-	if (cbd =3D=3D NULL || sd =3D=3D NULL || sd->sim =3D=3D NULL)
+	if (sd =3D=3D NULL || sd->sim =3D=3D NULL || cbd =3D=3D NULL)
 		goto error;
 =

+	if (PN_UICC =3D=3D g_isi_client_resource(sd->sim)) {
+		if (!sca_query_uicc(sd, cbd))
+			goto error;
+		return;
+	}
+
 	if (g_isi_client_send(sd->sim, msg, sizeof(msg),
 				sca_query_resp_cb, cbd, g_free))
 		return;
@@ -260,6 +478,20 @@ error:
 	g_free(cbd);
 }
 =

+static void sca_set_resp_uicc_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sms_sca_set_cb_t cb =3D cbd->cb;
+
+	if (!check_uicc_status(msg, UICC_APPL_CMD_RESP,
+				UICC_APPL_UPDATE_LINEAR_FIXED)) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
 static void sca_set_resp_cb(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd =3D data;
@@ -273,6 +505,103 @@ static void sca_set_resp_cb(const GIsiMessage *msg, v=
oid *data)
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 =

+static gboolean sca_uicc_set(struct sms_data *sd, struct isi_cb_data *cbd,
+				const struct ofono_phone_number *sca)
+{
+	GIsiModem *modem =3D g_isi_client_modem(sd->sim);
+	int8_t app_id =3D get_app_id(modem);
+	int8_t app_type =3D get_app_type(modem);
+	int8_t client_id =3D get_client_id(modem);
+	int mf_path =3D 0x3F00;
+	int df_path =3D (app_type =3D=3D UICC_APPL_TYPE_UICC_USIM) ? 0x7FFF : 0x7=
F10;
+	int df_len =3D 4;
+	int sca_len =3D 1 + (strlen(sca->number) + 1) / 2;
+	size_t sb_file_data_length =3D 2 + 2 + 4 + sca_len + 1 + 1 + 12;
+	size_t fill_count =3D 4 - (sb_file_data_length % 4);
+	uint8_t bcd[sca_len + 12 + 1 + 1];
+	uint8_t *fill_data =3D g_try_malloc0(fill_count);
+	int i;
+
+	encode_bcd_number(sca->number, bcd + 15);
+	bcd[0] =3D sd->usim_params.indicators & 0xFD;
+
+	for (i =3D 0; i < 12; i++) {
+		if (sd->usim_params.tp_dst[0] =3D=3D '\0')
+			bcd[i + 1] =3D 0xFF;
+		else
+			bcd[i + 1] =3D sd->usim_params.tp_dst[i];
+	}
+
+	bcd[13] =3D sca_len;
+	bcd[14] =3D sca->type;
+
+	if ((app_id !=3D -1) && (client_id !=3D -1)) {
+		uint8_t msg[] =3D {
+			UICC_APPL_CMD_REQ,
+			UICC_APPL_UPDATE_LINEAR_FIXED,
+			app_id,
+			UICC_SESSION_ID_NOT_USED,
+			0, 0, /*fillers*/
+			4, /*nro of sub blocks*/
+			/*1*/
+			UICC_SB_CLIENT >> 8, /*1st subblock*/
+			UICC_SB_CLIENT & 0xFF,
+			0,/*subblock length*/
+			8,/*subblock length*/
+			0, 0, 0,/*fillers*/
+			client_id,
+			/*2*/
+			UICC_SB_LINEAR_FIXED >> 8,/*3rd subblock*/
+			UICC_SB_LINEAR_FIXED & 0xFF,
+			0,/*subblock length*/
+			8,/*subblock length*/
+			1,/*The record in the file*/
+			sd->usim_params.alphalen,
+			/* offset 0 =3D=3D beginning of the record */
+			sca_len + 1 + 12 + 1, /* data amount 0
+						* =3D=3D until end of
+						* record */
+			0,/*filler*/
+			/*3*/
+			UICC_SB_APPL_PATH >> 8,/*2nd subblock*/
+			UICC_SB_APPL_PATH & 0xFF,
+			0,/*subblock length*/
+			16,/*subblock length*/
+			0x6F42 >> 8,/*Elementary file ID for EFsmsp*/
+			0x6F42 & 0xFF,
+			UICC_SFI_NOT_PRESENT,
+			0,/*filler*/
+			df_len,/*Path length*/
+			0,/*filler*/
+			mf_path >> 8,/*DF Path MF*/
+			mf_path & 0xFF,
+			df_path >> 8,/*DF Path DFtelecom*/
+			df_path & 0xFF,
+			0, 0,/*fillers 0-3*/
+			/*4*/
+			UICC_SB_FILE_DATA >> 8,
+			UICC_SB_FILE_DATA & 0xFF,
+			(sb_file_data_length + fill_count) >> 8,
+			(sb_file_data_length + fill_count) & 0xFF,
+			(sca_len + 1 + 12 + 1) >> 24,
+			(sca_len + 1 + 12 + 1) >> 16,
+			(sca_len + 1 + 12 + 1) >> 8,
+			(sca_len + 1 + 12 + 1) & 0xFF,
+		};
+		struct iovec iov[3] =3D {
+				{ msg, sizeof(msg) },
+				{ bcd, sizeof(bcd) },
+				{ fill_data, fill_count },
+		};
+
+		return g_isi_client_vsend(sd->sim, iov, G_N_ELEMENTS(iov),
+					sca_set_resp_uicc_cb, cbd, g_free);
+	}
+	g_free(fill_data);
+	return FALSE;
+
+}
+
 static void isi_sca_set(struct ofono_sms *sms,
 			const struct ofono_phone_number *sca,
 			ofono_sms_sca_set_cb_t cb, void *data)
@@ -280,29 +609,34 @@ static void isi_sca_set(struct ofono_sms *sms,
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
 	uint8_t *bcd;
-
 	uint8_t msg[] =3D {
 		SIM_SMS_REQ,
 		UPDATE_PARAMETER,
 		1,	/* Location, default is 1 */
 	};
-
-	struct iovec iov[2] =3D {
+	struct iovec iov[] =3D {
 		{ msg, sizeof(msg) },
-		{ &sd->params, sizeof(sd->params) },
+		{ &sd->sim_params, sizeof(sd->sim_params) },
 	};
 =

 	if (cbd =3D=3D NULL || sd =3D=3D NULL)
 		goto error;
 =

-	bcd =3D sd->params.sca;
-	sd->params.absent &=3D ~0x02;
+	if (PN_UICC =3D=3D g_isi_client_resource(sd->sim)) {
+		if (!sca_uicc_set(sd, cbd, sca))
+			goto error;
+		return;
+	}
+
+	bcd =3D sd->sim_params.sca;
+	sd->sim_params.absent &=3D ~0x02;
 =

 	encode_bcd_number(sca->number, bcd + 2);
 	bcd[0] =3D 1 + (strlen(sca->number) + 1) / 2;
 	bcd[1] =3D sca->type & 0xFF;
 =

-	if (g_isi_client_vsend(sd->sim, iov, 2, sca_set_resp_cb, cbd, g_free))
+	if (g_isi_client_vsend(sd->sim, iov, G_N_ELEMENTS(iov),
+			sca_set_resp_cb, cbd, g_free))
 		return;
 =

 error:
@@ -310,6 +644,32 @@ error:
 	g_free(cbd);
 }
 =

+static void submit_resp_v2_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sms_submit_cb_t cb =3D cbd->cb;
+	struct sms_report *report;
+	size_t len =3D sizeof(struct sms_report);
+	DBG("");
+
+	if (g_isi_msg_id(msg) !=3D SMS_MESSAGE_SEND_RESP)
+		goto error;
+
+	if (len > g_isi_msg_data_len(msg))
+		goto error;
+
+	if (!g_isi_msg_data_get_struct(msg, 0, (const void **) &report, len))
+		goto error;
+
+	if (report->type =3D=3D SMS_CAUSE_TYPE_COMMON && report->cause =3D=3D SMS=
_OK) {
+		CALLBACK_WITH_SUCCESS(cb, report->ref, cbd->data);
+		return;
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
 static void submit_resp_cb(const GIsiMessage *msg, void *data)
 {
 	struct isi_cb_data *cbd =3D data;
@@ -349,83 +709,244 @@ static void isi_submit(struct ofono_sms *sms, unsign=
ed char *pdu,
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
 =

-	uint8_t use_sca =3D pdu_len - tpdu_len !=3D 1 || pdu[0] =3D=3D 0;
-
-	uint8_t *tpdu =3D pdu + pdu_len - tpdu_len;
-	uint8_t filler_len =3D (-tpdu_len) & 3;
-	uint8_t tpdu_sb_len =3D 4 + tpdu_len + filler_len;
+	if (sd =3D=3D NULL)
+		goto error;
 =

-	uint8_t sca_sb_len =3D use_sca ? 16 : 0;
+	if (sd->version.major =3D=3D 9 && sd->version.minor >=3D 1) {
+
+		uint8_t sca_len =3D pdu_len - tpdu_len;
+		uint8_t *tpdu =3D pdu + sca_len;
+		uint8_t msg[] =3D {
+				SMS_MESSAGE_SEND_REQ,
+				mms,	/* More messages to send*/
+				SMS_ROUTE_DEFAULT,
+				FALSE,	/* Repeated message*/
+				0, 0,	/* fillers*/
+				2,	/* no of subblocks*/
+				SMS_GSM_TPDU_25 >> 8,	/* first subblock*/
+				SMS_GSM_TPDU_25 & 0xFF,
+				(tpdu_len + 6) >> 8,
+				(tpdu_len + 6) & 0xFF,
+				tpdu_len,
+				0x00,
+				/* databytes come here */
+		};
+		uint8_t parameters[] =3D {
+				SMS_GSM_PARAMETERS >> 8,
+				SMS_GSM_PARAMETERS & 0xFF,
+				8 >> 8,	/* subblock length*/
+				8 & 0xFF,
+				/*
+				 * location. We might have to fetch this by
+				 * SMS_SETTINGS_READ_REQ
+				 */
+				1,/*SMS_DEFAULT_PARAMETER_LOCATION =3D 0 else
+				range 1-255*/
+				0x02,	/*SMS_PI_SERVICE_CENTRE_ADDRESS*/
+				0, 0,
+		};
+		struct iovec iov[3] =3D {
+				{ msg, sizeof(msg) },
+				{ tpdu, tpdu_len },
+				{ parameters, sizeof(parameters) },
+		};
+
+		if ((g_isi_client_vsend_with_timeout(sd->client, iov,
+				G_N_ELEMENTS(iov), SMS_TIMEOUT,
+				submit_resp_v2_cb, cbd, g_free)))
+			return;
+	} else {
+		uint8_t use_sca =3D pdu_len - tpdu_len !=3D 1 || pdu[0] =3D=3D 0;
+
+		uint8_t *tpdu =3D pdu + pdu_len - tpdu_len;
+		uint8_t filler_len =3D (-tpdu_len) & 3;
+		uint8_t tpdu_sb_len =3D 4 + tpdu_len + filler_len;
+
+		uint8_t sca_sb_len =3D use_sca ? 16 : 0;
+
+		uint8_t msg[] =3D {
+			SMS_MESSAGE_SEND_REQ,
+			mms,
+			SMS_ROUTE_CS_PREF,
+			0,	/* Is this a re-send? */
+			SMS_SENDER_ANY,
+			SMS_TYPE_TEXT_MESSAGE,
+			1,	/* Sub blocks */
+			SMS_GSM_TPDU,
+			4 + tpdu_sb_len + sca_sb_len,
+			0,	/* Filler */
+			use_sca ? 2 : 1,	/* Sub-sub blocks */
+			SMS_COMMON_DATA,
+			tpdu_sb_len,
+			tpdu_len,
+			0,	/* Packing required? */
+			/* TPDU */
+		};
+
+		static uint8_t filler[4];
+
+		uint8_t sca_sb[16] =3D {
+			SMS_ADDRESS,
+			16,
+			SMS_GSM_0411_ADDRESS,
+			0,
+		};
+
+		struct iovec iov[4] =3D {
+			{ msg, sizeof(msg) },
+			{ tpdu, tpdu_len },
+			{ filler, filler_len },
+			{ sca_sb, sca_sb_len },
+		};
+
+		if (cbd =3D=3D NULL || sd =3D=3D NULL)
+			goto error;
 =

-	uint8_t msg[] =3D {
-		SMS_MESSAGE_SEND_REQ,
-		mms,
-		SMS_ROUTE_CS_PREF,
-		0,	/* Is this a re-send? */
-		SMS_SENDER_ANY,
-		SMS_TYPE_TEXT_MESSAGE,
-		1,	/* Sub blocks */
-		SMS_GSM_TPDU,
-		4 + tpdu_sb_len + sca_sb_len,
-		0,	/* Filler */
-		use_sca ? 2 : 1,	/* Sub-sub blocks */
-		SMS_COMMON_DATA,
-		tpdu_sb_len,
-		tpdu_len,
-		0,	/* Packing required? */
-		/* TPDU */
-	};
+		if (use_sca) {
+			sca_sb[3] =3D pdu_len - tpdu_len;
+			memmove(sca_sb + 4, pdu, sca_sb[3]);
+		}
 =

-	static uint8_t filler[4];
+		/*
+		 * Modem seems to time out SMS_MESSAGE_SEND_REQ in 5 seconds.
+		 * Wait normal timeout plus the modem timeout.
+		 */
+		if (g_isi_client_vsend_with_timeout(sd->client, iov, 4,
+					SMS_TIMEOUT + 5,
+					submit_resp_cb, cbd, g_free))
+			return;
+	}
 =

-	uint8_t sca_sb[16] =3D {
-		SMS_ADDRESS,
-		16,
-		SMS_GSM_0411_ADDRESS,
-		0,
-	};
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+	g_free(cbd);
+}
 =

-	struct iovec iov[4] =3D {
-		{ msg, sizeof(msg) },
-		{ tpdu, tpdu_len },
-		{ filler, filler_len },
-		{ sca_sb, sca_sb_len },
-	};
+static void bearer_query_resp_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sms_bearer_query_cb_t cb =3D cbd->cb;
+	int bearer =3D 0;
+	uint8_t bear_high;
+	uint8_t bear_low;
 =

-	if (cbd =3D=3D NULL || sd =3D=3D NULL)
+	if (!check_sms_status(msg, SMS_SETTINGS_READ_RESP))
 		goto error;
 =

-	if (use_sca) {
-		sca_sb[3] =3D pdu_len - tpdu_len;
-		memcpy(sca_sb + 4, pdu, sca_sb[3]);
-	}
+	g_isi_msg_data_get_byte(msg, 6, &bear_high);
+	g_isi_msg_data_get_byte(msg, 7, &bear_low);
 =

-	/*
-	 * Modem seems to time out SMS_MESSAGE_SEND_REQ in 5 seconds.
-	 * Wait normal timeout plus the modem timeout.
-	 */
-	if (g_isi_client_vsend_with_timeout(sd->client, iov, 4,
-				SMS_TIMEOUT + 5,
-				submit_resp_cb, cbd, g_free))
+	/* check what bearer type was set */
+	if (bear_high =3D=3D 0x00 && bear_low =3D=3D 0x01)
+		bearer =3D 0;
+	else if (bear_high =3D=3D 0x01 && bear_low =3D=3D 0x00)
+		bearer =3D 1;
+	else if (bear_high =3D=3D 0x02 && bear_low =3D=3D 0x01)
+		bearer =3D 2;
+	else if (bear_high =3D=3D 0x01 && bear_low =3D=3D 0x02)
+		bearer =3D 3;
+
+	CALLBACK_WITH_SUCCESS(cb, bearer, cbd->data);
+	return;
+error:
+	CALLBACK_WITH_FAILURE(cb, bearer, cbd->data);
+}
+
+static void set_resp_cb(const GIsiMessage *msg, void *data)
+{
+	struct isi_cb_data *cbd =3D data;
+	ofono_sms_bearer_set_cb_t cb =3D cbd->cb;
+	struct sms_data *sd;
+	int cause_pos =3D 0;
+
+	if (cbd =3D=3D NULL)
 		return;
+	sd =3D ofono_sms_get_data(cbd->user);
+
+	if (sd =3D=3D NULL)
+		goto error;
+
+	if (sd->version.major =3D=3D 9 && sd->version.minor >=3D 1)
+		cause_pos =3D 1;
+
+	if (!check_sms_status_with_cause(msg, SMS_SETTINGS_UPDATE_RESP, SMS_OK,
+			cause_pos))
+		goto error;
 =

+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
 error:
-	CALLBACK_WITH_FAILURE(cb, -1, data);
-	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

 static void isi_bearer_query(struct ofono_sms *sms,
 				ofono_sms_bearer_query_cb_t cb, void *data)
 {
-	DBG("Not implemented");
-	CALLBACK_WITH_FAILURE(cb, -1, data);
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
+	unsigned char msg[] =3D {
+			SMS_SETTINGS_READ_REQ,
+			SMS_SETTING_TYPE_ROUTE,
+			0
+	};
+
+	if (cbd && g_isi_client_send_with_timeout(sd->client, msg, sizeof(msg),
+			SMS_TIMEOUT, bearer_query_resp_cb, cbd, g_free))
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+	g_free(cbd);
 }
 =

 static void isi_bearer_set(struct ofono_sms *sms, int bearer,
 				ofono_sms_bearer_set_cb_t cb, void *data)
 {
-	DBG("Not implemented");
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sms, cb, data);
+	unsigned char bearer_type[2] =3D {SMS_ROUTE_NOT_AVAILABLE,
+			SMS_ROUTE_NOT_AVAILABLE
+	};
+
+	switch (bearer) {
+	case 0:
+		bearer_type[0] =3D SMS_ROUTE_NOT_AVAILABLE;
+		bearer_type[1] =3D SMS_ROUTE_PRIORITY_1;
+		break;
+	case 1:
+		bearer_type[0] =3D SMS_ROUTE_PRIORITY_1;
+		bearer_type[1] =3D SMS_ROUTE_NOT_AVAILABLE;
+		break;
+	case 2:
+		bearer_type[0] =3D SMS_ROUTE_PRIORITY_2;
+		bearer_type[1] =3D SMS_ROUTE_PRIORITY_1;
+		break;
+	case 3:
+		bearer_type[0] =3D SMS_ROUTE_PRIORITY_1;
+		bearer_type[1] =3D SMS_ROUTE_PRIORITY_2;
+		break;
+	}
+
+	if (cbd !=3D NULL && sd !=3D NULL) {
+		unsigned char msg[] =3D {
+			SMS_SETTINGS_UPDATE_REQ,
+			SMS_SETTING_TYPE_ROUTE,
+			1, /* one subblock */
+			SMS_GSM_ROUTE_INFO >> 8,
+			SMS_GSM_ROUTE_INFO & 0xFF,
+			8 >> 8,
+			8 & 0xFF,
+			bearer_type[0], /* cs priority */
+			bearer_type[1], /* ps priority */
+			0, 0
+		};
+
+		if (g_isi_client_send_with_timeout(sd->client, msg, sizeof(msg),
+				SMS_TIMEOUT, set_resp_cb, cbd, g_free))
+			return;
+	}
+
 	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
 }
 =

 static void send_status_ind_cb(const GIsiMessage *msg, void *data)
@@ -456,7 +977,8 @@ static void report_resp_cb(const GIsiMessage *msg, void=
 *data)
 	if (g_isi_msg_error(msg) < 0)
 		return;
 =

-	if (g_isi_msg_id(msg) !=3D SMS_GSM_RECEIVED_PP_REPORT_RESP)
+	if (g_isi_msg_id(msg) !=3D SMS_GSM_RECEIVED_PP_REPORT_RESP &&
+			g_isi_msg_id(msg) !=3D SMS_RECEIVED_MSG_REPORT_RESP)
 		return;
 =

 	if (!g_isi_msg_data_get_byte(msg, 0, &cause))
@@ -465,27 +987,42 @@ static void report_resp_cb(const GIsiMessage *msg, vo=
id *data)
 	DBG("Report resp cause=3D0x%"PRIx8, cause);
 }
 =

-static gboolean send_deliver_report(GIsiClient *client, gboolean success)
+static gboolean send_deliver_report(struct sms_data *sd, gboolean success)
 {
 	uint8_t cause_type =3D !success ? SMS_CAUSE_TYPE_GSM : 0;
 	uint8_t cause =3D !success ? SMS_GSM_ERR_MEMORY_CAPACITY_EXC : 0;
 =

-	uint8_t msg[] =3D {
-		SMS_GSM_RECEIVED_PP_REPORT_REQ,
-		cause_type,	/* Cause type */
-		cause,		/* SMS cause */
-		0, 0, 0,	/* Filler */
-		1,		/* Sub blocks */
-		SMS_GSM_DELIVER_REPORT,
-		8,
-		0,		/* Message parameters */
-		0,		/* Cause type */
-		0, 0, 0,	/* Filler */
-		0,		/* Sub blocks */
-	};
-	size_t len =3D sizeof(msg);
+	if (sd =3D=3D NULL)
+		return FALSE;
 =

-	return g_isi_client_send(client, msg, len, report_resp_cb, NULL, NULL);
+	if (sd->version.major =3D=3D 9 && sd->version.minor >=3D 1) {
+		uint8_t msg[] =3D {
+			SMS_RECEIVED_MSG_REPORT_REQ,
+			cause_type,
+			cause,
+			0, 0, 0,        /* Filler */
+			0,              /* nro of subblocks*/
+		};
+		return g_isi_client_send(sd->client, msg, sizeof(msg),
+				report_resp_cb, NULL, NULL);
+	} else {
+		uint8_t msg[] =3D {
+			SMS_GSM_RECEIVED_PP_REPORT_REQ,
+			cause_type,	/* Cause type */
+			cause,		/* SMS cause */
+			0, 0, 0,	/* Filler */
+			1,		/* Sub blocks */
+			SMS_GSM_DELIVER_REPORT,
+			8,
+			0,		/* Message parameters */
+			0,		/* Cause type */
+			0, 0, 0,	/* Filler */
+			0,		/* Sub blocks */
+		};
+
+		return g_isi_client_send(sd->client, msg, sizeof(msg),
+					report_resp_cb, NULL, NULL);
+	}
 }
 =

 static gboolean parse_sms_address(GIsiSubBlockIter *iter, struct sms_addr =
*add)
@@ -583,8 +1120,8 @@ static void routing_ntf_cb(const GIsiMessage *msg, voi=
d *data)
 			tpdu.len + addr.len > sizeof(pdu))
 		return;
 =

-	memcpy(pdu, addr.data, addr.len);
-	memcpy(pdu + addr.len, tpdu.data, tpdu.len);
+	memmove(pdu, addr.data, addr.len);
+	memmove(pdu + addr.len, tpdu.data, tpdu.len);
 =

 	ofono_sms_deliver_notify(sms, pdu, tpdu.len + addr.len, tpdu.len);
 =

@@ -594,19 +1131,101 @@ static void routing_ntf_cb(const GIsiMessage *msg, =
void *data)
 	 * no such indication from core, so we just blindly trust that
 	 * it did The Right Thing here.
 	 */
-	send_deliver_report(sd->client, TRUE);
+	send_deliver_report(sd, TRUE);
 }
 =

-static void routing_resp_cb(const GIsiMessage *msg, void *data)
+static void received_msg_ind_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_sms *sms =3D data;
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 =

-	if (!check_sms_status(msg, SMS_PP_ROUTING_RESP))
+	GIsiSubBlockIter iter;
+	uint8_t *sca =3D NULL;
+	uint8_t sca_len =3D 0;
+	uint8_t *tpdu =3D NULL;
+	uint8_t tpdu_len =3D 0;
+	unsigned char pdu[176];
+	unsigned char type;
+	uint8_t sbcount;
+	DBG("");
+
+	if (!check_sms_status(msg, SMS_RECEIVED_MSG_IND))
 		return;
 =

-	g_isi_client_ntf_subscribe(sd->client, SMS_PP_ROUTING_NTF,
-					routing_ntf_cb, sms);
+	g_isi_msg_data_get_byte(msg, 1, &sbcount);
+
+	for (g_isi_sb_iter_init_full(&iter, msg, 2, TRUE, sbcount);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		uint8_t type;
+		void *data;
+		uint8_t data_len;
+		case SMS_ADDRESS:
+			if (!g_isi_sb_iter_get_byte(&iter, &type, 4)
+					|| !g_isi_sb_iter_get_byte(&iter,
+							&data_len, 5)
+					|| !g_isi_sb_iter_get_data(&iter,
+							&data, 6)
+					|| type !=3D SMS_SMSC_ADDRESS)
+				break;
+
+			sca =3D data;
+			sca_len =3D data_len;
+			break;
+		case SMS_GSM_TPDU_25:
+			if (!g_isi_sb_iter_get_byte(&iter, &data_len, 4)
+					|| !g_isi_sb_iter_get_data(&iter,
+							&data, 6))
+				break;
+			tpdu =3D data;
+			tpdu_len =3D data_len;
+			break;
+		}
+	}
+
+	if (tpdu =3D=3D NULL || sca =3D=3D NULL || tpdu_len + sca_len > sizeof(pd=
u))
+		return;
+
+	memmove(pdu, sca, sca_len);
+	memmove(pdu + sca_len, tpdu, tpdu_len);
+	/* 23.040 9.2.3.1 */
+	type =3D tpdu[0] & 0x03;
+
+	if (type =3D=3D SMS_STATUS_REPORT) {
+		ofono_sms_status_notify(sms,
+				pdu, tpdu_len + sca_len, tpdu_len);
+	} else {
+		ofono_sms_deliver_notify(sms,
+				pdu, tpdu_len + sca_len, tpdu_len);
+	}
+
+	send_deliver_report(sd, TRUE);
+}
+
+static void receive_msg_resp_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_sms *sms =3D data;
+
+	if (sms =3D=3D NULL)
+		return;
+
+	if (!check_sms_status_with_cause(msg, SMS_RECEIVE_MESSAGE_RESP,
+					SMS_RECEPTION_ACTIVE, 0))
+		return;
+
+	ofono_sms_register(sms);
+}
+
+static void routing_resp_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_sms *sms =3D data;
+
+	if (sms =3D=3D NULL)
+		return;
+
+	if (!check_sms_status(msg, SMS_PP_ROUTING_RESP))
+		return;
 =

 	ofono_sms_register(sms);
 }
@@ -616,28 +1235,36 @@ static void sim_reachable_cb(const GIsiMessage *msg,=
 void *data)
 	struct ofono_sms *sms =3D data;
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 =

-	const uint8_t req[] =3D {
-		SMS_PP_ROUTING_REQ,
-		SMS_ROUTING_SET,
-		0x01,  /* Sub-block count */
-		SMS_GSM_ROUTING,
-		0x08,  /* Sub-block length */
-		SMS_GSM_TPDU_ROUTING,
-		SMS_GSM_MT_ALL_TYPE,
-		0x00, 0x00, 0x00,  /* Filler */
-		0x00  /* Sub-sub-block count */
-	};
-	size_t len =3D sizeof(req);
+	if (sd =3D=3D NULL)
+		return;
 =

 	if (g_isi_msg_error(msg) < 0) {
 		DBG("unable to find SIM resource");
 		g_isi_client_destroy(sd->sim);
 		sd->sim =3D NULL;
 	}
+}
 =

-	g_isi_client_ind_subscribe(sd->client, SMS_MESSAGE_SEND_STATUS_IND,
-					send_status_ind_cb, sms);
-	g_isi_client_send(sd->client, req, len, routing_resp_cb, sms, NULL);
+static void uicc_reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_sms *sms =3D data;
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+
+	if (sd =3D=3D NULL)
+		return;
+
+	if (g_isi_msg_error(msg) < 0) {
+		GIsiModem *modem =3D g_isi_client_modem(sd->sim);
+		g_isi_client_destroy(sd->sim);
+		sd->sim =3D g_isi_client_create(modem, PN_SMS);
+
+		if (sd->sim =3D=3D NULL)
+			return;
+
+		g_isi_client_set_timeout(sd->sim, SIM_TIMEOUT);
+		g_isi_client_verify(sd->sim, sim_reachable_cb, sms, NULL);
+		return;
+	}
 }
 =

 static void sms_reachable_cb(const GIsiMessage *msg, void *data)
@@ -650,9 +1277,41 @@ static void sms_reachable_cb(const GIsiMessage *msg, =
void *data)
 		return;
 	}
 =

+	if (sd =3D=3D NULL)
+		return;
+
 	ISI_VERSION_DBG(msg);
+	sd->version.major =3D g_isi_msg_version_major(msg);
+	sd->version.minor =3D g_isi_msg_version_minor(msg);
+
+	if (sd->version.major =3D=3D 9 && sd->version.minor >=3D 1) {
+		uint8_t req[] =3D {
+				SMS_RECEIVE_MESSAGE_REQ,
+				SMS_RECEPTION_ACTIVATE,
+				0,
+		};
+		size_t len =3D sizeof(req);
+		g_isi_client_send(sd->client, req, len,
+					receive_msg_resp_cb, sms, NULL);
+
+	} else {
+		uint8_t req[] =3D {
+				SMS_PP_ROUTING_REQ,
+				SMS_ROUTING_SET,
+				0x01,  /* Sub-block count */
+				SMS_GSM_ROUTING,
+				0x08,  /* Sub-block length */
+				SMS_GSM_TPDU_ROUTING,
+				SMS_GSM_MT_ALL_TYPE,
+				0x00, 0x00, 0x00,  /* Filler */
+				0x00  /* Sub-sub-block count */
+		};
+		size_t len =3D sizeof(req);
+		g_isi_client_send(sd->client, req, len,
+					routing_resp_cb, sms, NULL);
+	}
 =

-	g_isi_client_verify(sd->sim, sim_reachable_cb, sms, NULL);
+	g_isi_client_verify(sd->sim, uicc_reachable_cb, sms, NULL);
 }
 =

 static int isi_sms_probe(struct ofono_sms *sms, unsigned int vendor,
@@ -664,28 +1323,44 @@ static int isi_sms_probe(struct ofono_sms *sms, unsi=
gned int vendor,
 	if (sd =3D=3D NULL)
 		return -ENOMEM;
 =

-	sd->params.absent =3D 0xFF;
-	sd->params.alphalen =3D 1; /* Includes final UCS2-coded NUL */
+	sd->sim_params.absent =3D 0xFF;
+	sd->sim_params.alphalen =3D 1; /* Includes final UCS2-coded NUL */
+
+	sd->usim_params.indicators =3D 0xFF;
+	sd->usim_params.alphalen =3D 0; /* Includes final UCS2-coded NUL */
+
 =

 	sd->client =3D g_isi_client_create(modem, PN_SMS);
 	if (sd->client =3D=3D NULL)
 		goto nomem;
 =

-	sd->sim =3D g_isi_client_create(modem, PN_SIM);
+	sd->sim =3D g_isi_client_create(modem, PN_UICC);
+
 	if (sd->sim =3D=3D NULL)
 		goto nomem;
 =

-	g_isi_client_set_timeout(sd->client, SMS_TIMEOUT);
-	g_isi_client_set_timeout(sd->sim, SIM_TIMEOUT);
 =

 	ofono_sms_set_data(sms, sd);
 =

+	g_isi_client_ind_subscribe(sd->client, SMS_MESSAGE_SEND_STATUS_IND,
+					send_status_ind_cb, sms);
+
+	g_isi_client_ind_subscribe(sd->client, SMS_RECEIVED_MSG_IND,
+					received_msg_ind_cb, sms);
+
+	g_isi_client_ntf_subscribe(sd->client, SMS_PP_ROUTING_NTF,
+					routing_ntf_cb, sms);
+
 	g_isi_client_verify(sd->client, sms_reachable_cb, sms, NULL);
 =

+	g_isi_client_set_timeout(sd->client, SMS_TIMEOUT);
+	g_isi_client_set_timeout(sd->sim, SIM_TIMEOUT);
+
 	return 0;
 =

 nomem:
 	g_isi_client_destroy(sd->client);
+	g_isi_client_destroy(sd->sim);
 	g_free(sd);
 	return -ENOMEM;
 }
@@ -694,28 +1369,39 @@ static void isi_sms_remove(struct ofono_sms *sms)
 {
 	struct sms_data *sd =3D ofono_sms_get_data(sms);
 =

-	const uint8_t msg[] =3D {
-		SMS_PP_ROUTING_REQ,
-		SMS_ROUTING_RELEASE,
-		0x01,  /* Sub-block count */
-		SMS_GSM_ROUTING,
-		0x08,  /* Sub-block length */
-		SMS_GSM_TPDU_ROUTING,
-		SMS_GSM_MT_ALL_TYPE,
-		0x00, 0x00, 0x00,  /* Filler */
-		0x00  /* Sub-sub-block count */
-	};
-
-	ofono_sms_set_data(sms, NULL);
-
 	if (sd =3D=3D NULL)
 		return;
 =

+	ofono_sms_set_data(sms, NULL);
+
 	/*
 	 * Send a promiscuous routing release, so as not to
 	 * hog resources unnecessarily after being removed
 	 */
-	g_isi_client_send(sd->client, msg, sizeof(msg), NULL, NULL, NULL);
+	if (sd->version.major =3D=3D 9 && sd->version.minor >=3D 1) {
+		uint8_t msg[] =3D {
+			SMS_RECEIVE_MESSAGE_REQ,
+			SMS_RECEPTION_DEACTIVATE,
+			0x0,
+		};
+		g_isi_client_send(sd->client, msg, sizeof(msg),
+					NULL, NULL, NULL);
+	} else {
+		uint8_t msg[] =3D {
+			SMS_PP_ROUTING_REQ,
+			SMS_ROUTING_RELEASE,
+			0x01,  /* Sub-block count */
+			SMS_GSM_ROUTING,
+			0x08,  /* Sub-block length */
+			SMS_GSM_TPDU_ROUTING,
+			SMS_GSM_MT_ALL_TYPE,
+			0x00, 0x00, 0x00,  /* Filler */
+			0x00  /* Sub-sub-block count */
+		};
+		g_isi_client_send(sd->client, msg, sizeof(msg),
+					NULL, NULL, NULL);
+	}
+
 	g_isi_client_destroy(sd->client);
 	g_isi_client_destroy(sd->sim);
 	g_free(sd);
-- =

1.7.3.5


--===============7995299578623939160==--

