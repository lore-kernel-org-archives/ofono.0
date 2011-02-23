Content-Type: multipart/mixed; boundary="===============2053838973423940491=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 09/18] isimodem: clip colp clir colr wgmodem2.5
Date: Wed, 23 Feb 2011 12:43:20 +0100
Message-ID: <b85bed728917dbe817cc739f9423881e9fbe78ff.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2053838973423940491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/call-settings.c |  711 ++++++++++++++++++++++++++++++++++=
+++-
 drivers/isimodem/call.h          |    9 +
 drivers/isimodem/debug.c         |    4 +
 drivers/isimodem/ss.h            |   22 ++
 4 files changed, 728 insertions(+), 18 deletions(-)

diff --git a/drivers/isimodem/call-settings.c b/drivers/isimodem/call-setti=
ngs.c
index 89270e9..ed3d11e 100644
--- a/drivers/isimodem/call-settings.c
+++ b/drivers/isimodem/call-settings.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2011.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -45,6 +46,7 @@
 =

 struct settings_data {
 	GIsiClient *client;
+	int clir_status;
 };
 =

 static void update_status_mask(unsigned int *mask, int bsc)
@@ -88,7 +90,6 @@ static void update_status_mask(unsigned int *mask, int bs=
c)
 		break;
 	}
 }
-
 static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgi=
d)
 {
 	if (g_isi_msg_error(msg) < 0) {
@@ -104,6 +105,59 @@ static gboolean check_response_status(const GIsiMessag=
e *msg, uint8_t msgid)
 	return TRUE;
 }
 =

+static void clip_query_cb(const GIsiMessage *msg, void *data)
+{
+	GIsiSubBlockIter iter;
+	struct isi_cb_data *cbd =3D data;
+
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+	uint8_t service;
+	guint32 mask =3D 0;
+
+	if (!check_response_status(msg, SS_SERVICE_COMPLETED_RESP))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &service) ||
+			service !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, 6);
+	     g_isi_sb_iter_is_valid(&iter);
+	     g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (ss_status & SS_GSM_PROVISIONED)
+				mask =3D 1;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("status_mask %d\n", mask);
+	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+	return;
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+}
+
+
 static gboolean decode_gsm_bsc_info(GIsiSubBlockIter *iter, uint32_t *mask)
 {
 	uint8_t num;
@@ -136,23 +190,628 @@ static void query_resp_cb(const GIsiMessage *msg, vo=
id *data)
 		goto error;
 =

 	for (g_isi_sb_iter_init(&iter, msg, 6);
+	     g_isi_sb_iter_is_valid(&iter);
+	     g_isi_sb_iter_next(&iter)) {
+
+		if (g_isi_sb_iter_get_id(&iter) =3D=3D SS_GSM_BSC_INFO) {
+			if (!decode_gsm_bsc_info(&iter, &mask))
+				goto error;
+
+			CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+			return;
+		} else if (g_isi_sb_iter_get_id(&iter) =3D=3D SS_STATUS_RESULT) {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			if (ss_status & SS_GSM_PROVISIONED)
+				mask =3D 1;
+			CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+			return;
+		}
+	}
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+}
+
+static void isi_clip_query(struct ofono_call_settings *cs,
+		ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	unsigned char msg[] =3D {
+			SS_SERVICE_REQ,
+			SS_INTERROGATION,
+			SS_ALL_TELE_AND_BEARER,
+			SS_GSM_CLIP >> 8,       /* Supplementary services */
+			SS_GSM_CLIP & 0xFF,     /* code */
+			SS_SEND_ADDITIONAL_INFO,
+			0                       /* Subblock count */
+	};
+	DBG("");
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_send(sd->client, msg, sizeof(msg),
+				clip_query_cb, cbd, g_free))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+	g_free(cbd);
+}
+
+static void set_clir_status(struct settings_data *sd, const int value)
+{
+	DBG("Setting CLIR status to %i", value);
+	sd->clir_status =3D value;
+}
+
+static int get_clir_status(struct settings_data *sd)
+{
+
+	DBG("Getting CLIR status %i", sd->clir_status);
+
+	switch (sd->clir_status) {
+	case OFONO_CLIR_OPTION_INVOCATION:
+		break;
+	case OFONO_CLIR_OPTION_SUPPRESSION:
+		break;
+	default:
+		sd->clir_status =3D OFONO_CLIR_OPTION_DEFAULT;
+		break;
+	}
+	return sd->clir_status;
+}
+
+static gboolean check_clir_info(const GIsiMessage *msg, GIsiSubBlockIter* =
iter)
+{
+	GIsiMessage info_msg;
+	GIsiSubBlockIter iter_info;
+	guint8 clir_option =3D 0;
+	void *info =3D NULL;
+
+	/*
+	* GIsiMessage function adds 2 to data pointer and
+	* removes 2 from len
+	*/
+
+	info_msg.addr =3D NULL;
+	info_msg.error =3D 0;
+
+	if (!g_isi_sb_iter_get_data(iter, &info, 4))
+				goto error;
+	info_msg.data =3D info - 2;
+	info_msg.len =3D msg->len - 6 + 2;
+
+	for (g_isi_sb_iter_init(&iter_info, &info_msg, 0);
+			g_isi_sb_iter_is_valid(&iter_info);
+			g_isi_sb_iter_next(&iter_info)) {
+		DBG("Sub-block %s",
+		ss_subblock_name(
+			g_isi_sb_iter_get_id(&iter_info)));
+
+		switch (g_isi_sb_iter_get_id(&iter_info)) {
+		case SS_GSM_CLIR_INFO: {
+			if (!g_isi_sb_iter_get_byte(&iter_info,
+							&clir_option, 2))
+				goto error;
+			}
+			break;
+		default:
+		break;
+		}
+		DBG("CLIR_OPTION=3D%d", clir_option);
+	}
+	return TRUE;
+error:
+	return FALSE;
+}
+
+
+static void clir_set_cb(const GIsiMessage *msg, void *data)
+{
+	GIsiSubBlockIter iter;
+	struct isi_cb_data *cbd =3D data;
+	ofono_call_settings_set_cb_t cb =3D cbd->cb;
+	struct settings_data *sd =3D ofono_call_settings_get_data(cbd->user);
+	gint override =3D OFONO_CLIR_OPTION_DEFAULT;
+	gint network =3D CLIR_STATUS_UNKNOWN;
+	uint8_t service;
+
+	if (!check_response_status(msg, SS_SERVICE_COMPLETED_RESP))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &service) ||
+			service !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, 6);
 			g_isi_sb_iter_is_valid(&iter);
 			g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
 =

-		if (g_isi_sb_iter_get_id(&iter) !=3D SS_GSM_BSC_INFO)
-			continue;
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (!(ss_status & SS_GSM_PROVISIONED))
+				network =3D CLIR_STATUS_NOT_PROVISIONED;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_GENERIC_SERVICE_INFO: {
+			guint8 ss_status =3D 0;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			if (!(ss_status & SS_GSM_PROVISIONED))
+				network =3D CLIR_STATUS_NOT_PROVISIONED;
+
+			if (!check_clir_info(msg, &iter))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+				goto error;
 =

-		if (!decode_gsm_bsc_info(&iter, &mask))
+			if (network !=3D CLIR_STATUS_NOT_PROVISIONED) {
+				DBG("CLIR set successfully.");
+				set_clir_status(sd,
+						OFONO_CLIR_OPTION_INVOCATION);
+
+			} else {
+				DBG("CLIR option not supported by network "
+						"provider.");
+			}
+		}
+		break;
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("override=3D%d, network=3D%d\n", override, network);
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void isi_clir_set(struct ofono_call_settings *cs,
+				int mode,
+				ofono_call_settings_set_cb_t cb,
+				void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	int result =3D 0;
+	/*
+	 * CLIR cannot be activated in Network, but we can override it
+	 * using local settings - 3GPP TS 24.081 Chapter 2.5
+	 */
+
+	switch (mode) {
+	case(OFONO_CLIR_OPTION_DEFAULT):
+		set_clir_status(sd, OFONO_CLIR_OPTION_DEFAULT);
+		break;
+	/* CLIR enabled (number not shown) */
+	case(OFONO_CLIR_OPTION_INVOCATION): {
+		/*
+		 * We send interrogation request to check if Network
+		 * has CLIR option provisioned.
+		 */
+		unsigned char msg[] =3D {
+				SS_SERVICE_REQ,
+				SS_INTERROGATION,
+				SS_ALL_TELE_AND_BEARER,
+				SS_GSM_CLIR >> 8, /* Supplementary services */
+				SS_GSM_CLIR & 0xFF, /* code */
+				SS_SEND_ADDITIONAL_INFO,
+				0 /* Subblock count */
+		};
+
+		DBG("Attempting to set the CLIR - checking Network Settings");
+
+		if (cbd =3D=3D NULL)
+			goto error;
+
+		if (g_isi_client_send(sd->client, msg, sizeof(msg),
+				clir_set_cb, cbd, g_free))
+
+			return;
+		else
 			goto error;
+	}
+	break;
+	case(OFONO_CLIR_OPTION_SUPPRESSION): /* CLIR disabled (number shown) */
+		set_clir_status(sd, OFONO_CLIR_OPTION_SUPPRESSION);
+	break;
+	default:
+		DBG("CLIR mode not supported %d", mode);
+		break;
+	}
+
+	if (result =3D=3D EXIT_FAILURE)
+		goto error;
+
+	DBG("CLIR set to mode: %d", mode);
+	CALLBACK_WITH_SUCCESS(cb, data);
+	goto out;
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+out:
+	g_free(cbd);
+	return;
+}
+
+static void clir_query_cb(const GIsiMessage *msg, void *data)
+{
+	GIsiSubBlockIter iter, iter_info;
+	struct isi_cb_data *cbd =3D data;
+	ofono_call_settings_clir_cb_t cb =3D cbd->cb;
+	struct settings_data *sd =3D ofono_call_settings_get_data(cbd->user);
+	uint8_t service;
+	gint override =3D OFONO_CLIR_OPTION_DEFAULT;
+	gint network =3D CLIR_STATUS_UNKNOWN;
 =

-		CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+
+	if (!check_response_status(msg, SS_SERVICE_COMPLETED_RESP))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &service) ||
+			service !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, 6);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (!(ss_status & SS_GSM_PROVISIONED))
+				network =3D CLIR_STATUS_NOT_PROVISIONED;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_GENERIC_SERVICE_INFO: {
+			guint8 ss_status =3D 0;
+			guint8 clir_option =3D 0;
+			void *info =3D NULL;
+			GIsiMessage info_msg;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			if (!(ss_status & SS_GSM_PROVISIONED))
+				network =3D CLIR_STATUS_NOT_PROVISIONED;
+
+			if (!g_isi_sb_iter_get_data(&iter, &info, 4))
+				goto error;
+
+			info_msg.addr =3D NULL;
+			info_msg.error =3D 0;
+			/* GIsiMessage function adds 2 to data pointer and
+			 * removes 2 from len */
+			info_msg.data =3D info - 2;
+			info_msg.len =3D msg->len - 6 + 2;
+
+			for (g_isi_sb_iter_init(&iter_info, &info_msg, 0);
+					g_isi_sb_iter_is_valid(&iter_info);
+					g_isi_sb_iter_next(&iter_info)) {
+				uint8_t id =3D g_isi_sb_iter_get_id(&iter_info);
+				DBG("Sub-sub-block %d", id);
+
+				switch (id) {
+				case SS_GSM_CLIR_INFO: {
+					if (!g_isi_sb_iter_get_byte(&iter_info,
+							&clir_option, 2))
+						goto error;
+					break;
+				}
+				default:
+					break;
+				}
+
+				DBG("SS_STATUS_RESULT=3D%d, CLIR_OPTION=3D%d",
+						ss_status, clir_option);
+			}
+
+			if (network !=3D CLIR_STATUS_NOT_PROVISIONED) {
+				switch (clir_option) {
+				case SS_GSM_CLI_PERMANENT:
+					network =3D
+					CLIR_STATUS_PROVISIONED_PERMANENT;
+					break;
+				case SS_GSM_DEFAULT_RESTRICTED:
+					break;
+				case SS_GSM_CLI_DEFAULT_ALLOWED:
+					network =3D
+						CLIR_STATUS_TEMPORARY_ALLOWED;
+					break;
+				case SS_GSM_OVERRIDE_ENABLED:
+					override =3D
+						OFONO_CLIR_OPTION_SUPPRESSION;
+					break;
+				case SS_GSM_OVERRIDE_DISABLED:
+					override =3D
+						OFONO_CLIR_OPTION_INVOCATION;
+					break;
+				default:
+					break;
+				}
+			}
+		}
+		break;
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+	/*
+	 * CLIR cannot be activated,registrated in Network, but we can override
+	 * it using local settings - 33GPP TS 24.081 Chapter 2.5
+	 * we have to read status and pass override parameter to Ofono
+	 */
+
+	if (network !=3D CLIR_STATUS_NOT_PROVISIONED) {
+		override =3D get_clir_status(sd);
+		DBG("CLIR mode queried %d\n", override);
+	}
+
+	DBG("override=3D%d, network=3D%d\n", override, network);
+	CALLBACK_WITH_SUCCESS(cb, override, network, cbd->data);
+	return;
+error:
+	CALLBACK_WITH_FAILURE(cb, override, network, cbd->data);
+}
+
+static void isi_clir_query(struct ofono_call_settings *cs,
+		ofono_call_settings_clir_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	int override =3D 0, network =3D 2;
+	unsigned char msg[] =3D {
+			SS_SERVICE_REQ,
+			SS_INTERROGATION,
+			SS_ALL_TELE_AND_BEARER,
+			SS_GSM_CLIR >> 8,       /* Supplementary services */
+			SS_GSM_CLIR & 0xFF,     /* code */
+			SS_SEND_ADDITIONAL_INFO,
+			0                       /* Subblock count */
+	};
+	DBG("");
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_send(sd->client, msg, sizeof(msg),
+				clir_query_cb, cbd, g_free))
 		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, override, network, data);
+	g_free(cbd);
+}
+
+static void colp_query_cb(const GIsiMessage *msg, void *data)
+{
+	GIsiSubBlockIter iter;
+	struct isi_cb_data *cbd =3D data;
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+	uint8_t service;
+	guint32 mask =3D 0;
+
+	if (!check_response_status(msg, SS_SERVICE_COMPLETED_RESP))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &service) ||
+			service !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, 6);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (ss_status & SS_GSM_PROVISIONED)
+				mask =3D 1;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_BSC_INFO: {
+			guint8 bsc;
+			guint8 count;
+			guint8 i;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &count, 2))
+				goto error;
+
+			for (i =3D 0; i < count; i++) {
+				if (!g_isi_sb_iter_get_byte(&iter, &bsc, 3 + i))
+					goto error;
+
+				update_status_mask(&mask, bsc);
+			}
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
 	}
 =

+	DBG("status_mask %d\n", mask);
+	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+	return;
 error:
 	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
 }
 =

+static void isi_colp_query(struct ofono_call_settings *cs,
+		ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	unsigned char msg[] =3D {
+			SS_SERVICE_REQ,
+			SS_INTERROGATION,
+			SS_ALL_TELE_AND_BEARER,
+			SS_GSM_COLP >> 8,       /* Supplementary services */
+			SS_GSM_COLP & 0xFF,     /* code */
+			SS_SEND_ADDITIONAL_INFO,
+			0                       /* Subblock count */
+	};
+	DBG("");
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_send(sd->client, msg, sizeof(msg),
+				colp_query_cb, cbd, g_free))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+	g_free(cbd);
+}
+
+static void colr_query_cb(const GIsiMessage *msg, void *data)
+{
+	GIsiSubBlockIter iter;
+	struct isi_cb_data *cbd =3D data;
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+	uint8_t service;
+	guint32 mask =3D 0;
+
+	if (!check_response_status(msg, SS_SERVICE_COMPLETED_RESP))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &service) ||
+			service !=3D SS_INTERROGATION)
+		goto error;
+
+	for (g_isi_sb_iter_init(&iter, msg, 6);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+		DBG("Sub-block %s",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)));
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case SS_STATUS_RESULT: {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+			DBG("SS_STATUS_RESULT=3D%d", ss_status);
+
+			if (ss_status & SS_GSM_PROVISIONED)
+				mask =3D 1;
+		}
+		break;
+		case SS_GSM_ADDITIONAL_INFO:
+			break;
+		case SS_GSM_BSC_INFO: {
+			guint8 bsc;
+			guint8 count;
+			guint8 i;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &count, 2))
+				goto error;
+			for (i =3D 0; i < count; i++) {
+				if (!g_isi_sb_iter_get_byte(&iter, &bsc,
+						3 + i))
+					goto error;
+
+				update_status_mask(&mask, bsc);
+			}
+
+			break;
+		}
+		default:
+			DBG("Skipping sub-block: %s (%zd bytes)",
+				ss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+				g_isi_sb_iter_get_len(&iter));
+			break;
+		}
+	}
+
+	DBG("status_mask %d\n", mask);
+	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
+	return;
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+}
+
+static void isi_colr_query(struct ofono_call_settings *cs,
+		ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(cs, cb, data);
+	unsigned char msg[] =3D {
+			SS_SERVICE_REQ,
+			SS_INTERROGATION,
+			SS_ALL_TELE_AND_BEARER,
+			SS_GSM_COLR >> 8,       /* Supplementary services */
+			SS_GSM_COLR & 0xFF,     /* code */
+			SS_SEND_ADDITIONAL_INFO,
+			0                       /* Subblock count */
+	};
+	DBG("");
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_send(sd->client, msg, sizeof(msg),
+				colr_query_cb, cbd, g_free))
+
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+	g_free(cbd);
+}
+
 static void isi_cw_query(struct ofono_call_settings *cs, int cls,
 			ofono_call_settings_status_cb_t cb, void *data)
 {
@@ -205,17 +864,31 @@ static void set_resp_cb(const GIsiMessage *msg, void =
*data)
 		if (g_isi_sb_iter_get_id(&iter) !=3D SS_GSM_DATA)
 			continue;
 =

-		if (!g_isi_sb_iter_get_byte(&iter, &status, 2))
-			goto error;
+		if (g_isi_sb_iter_get_id(&iter) =3D=3D SS_GSM_DATA) {
+			if (!g_isi_sb_iter_get_byte(&iter, &status, 2))
+				goto error;
 =

-		if ((status & SS_GSM_ACTIVE) && (service =3D=3D SS_DEACTIVATION))
-			goto error;
+			if ((status & SS_GSM_ACTIVE) &&
+					(service =3D=3D SS_DEACTIVATION))
+				goto error;
 =

-		if (!(status & SS_GSM_ACTIVE) && (service =3D=3D SS_ACTIVATION))
-			goto error;
+			if (!(status & SS_GSM_ACTIVE) &&
+					(service =3D=3D SS_ACTIVATION))
+				goto error;
 =

-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
-		return;
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+			return;
+		} else if (g_isi_sb_iter_get_id(&iter) =3D=3D SS_GSM_DATA) {
+			guint8 ss_status;
+
+			if (!g_isi_sb_iter_get_byte(&iter, &ss_status, 2))
+				goto error;
+
+
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+			return;
+
+		}
 	}
 =

 error:
@@ -273,10 +946,12 @@ static int isi_call_settings_probe(struct ofono_call_=
settings *cs,
 		return -ENOMEM;
 =

 	sd->client =3D g_isi_client_create(modem, PN_SS);
+
 	if (sd->client =3D=3D NULL) {
 		g_free(sd);
 		return -ENOMEM;
 	}
+	sd->clir_status =3D OFONO_CLIR_OPTION_DEFAULT;
 =

 	ofono_call_settings_set_data(cs, sd);
 =

@@ -302,11 +977,11 @@ static struct ofono_call_settings_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_call_settings_probe,
 	.remove			=3D isi_call_settings_remove,
-	.clip_query		=3D NULL,
-	.colp_query		=3D NULL,
-	.clir_query		=3D NULL,
-	.colr_query		=3D NULL,
-	.clir_set		=3D NULL,
+	.clip_query		=3D isi_clip_query,
+	.colp_query		=3D isi_colp_query,
+	.clir_query		=3D isi_clir_query,
+	.colr_query		=3D isi_colr_query,
+	.clir_set		=3D isi_clir_set,
 	.cw_query		=3D isi_cw_query,
 	.cw_set			=3D isi_cw_set
 };
diff --git a/drivers/isimodem/call.h b/drivers/isimodem/call.h
index 05f05a5..84f4e04 100644
--- a/drivers/isimodem/call.h
+++ b/drivers/isimodem/call.h
@@ -402,6 +402,15 @@ enum {
 	CALL_DTMF_DISABLE_TONE_IND_SEND =3D	0x02,
 };
 =

+/* 27.007 Section 7.7 */
+enum clir_status {
+	CLIR_STATUS_NOT_PROVISIONED =3D 0,
+	CLIR_STATUS_PROVISIONED_PERMANENT,
+	CLIR_STATUS_UNKNOWN,
+	CLIR_STATUS_TEMPORARY_RESTRICTED,
+	CLIR_STATUS_TEMPORARY_ALLOWED
+};
+
 #ifdef __cplusplus
 };
 #endif
diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 89e4573..33e4dcb 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -95,10 +95,14 @@ const char *ss_subblock_name(enum ss_subblock value)
 		_(SS_GSM_FORWARDING_FEATURE);
 		_(SS_GSM_DATA);
 		_(SS_GSM_BSC_INFO);
+		_(SS_GSM_GENERIC_SERVICE_INFO);
+		_(SS_GSM_CLIR_INFO);
 		_(SS_GSM_PASSWORD_INFO);
 		_(SS_GSM_INDICATE_PASSWORD_ERROR);
 		_(SS_GSM_INDICATE_ERROR);
 		_(SS_GSM_ADDITIONAL_INFO);
+		_(SS_GSM_BARRING_INFO);
+		_(SS_GSM_BARRING_FEATURE);
 		_(SS_GSM_USSD_STRING);
 	}
 	return "SS_<UNKNOWN>";
diff --git a/drivers/isimodem/ss.h b/drivers/isimodem/ss.h
index 5cd86e9..8a2942e 100644
--- a/drivers/isimodem/ss.h
+++ b/drivers/isimodem/ss.h
@@ -94,6 +94,12 @@ enum ss_codes {
 	SS_GSM_BARR_OUT_INTER =3D			331,
 	SS_GSM_BARR_OUT_INTER_EXC_HOME =3D	332,
 	SS_GSM_BARR_ALL_IN_ROAM =3D		351,
+	SS_GSM_CLIP =3D                           0x001E,
+	SS_GSM_CLIR =3D                           0x001F,
+	SS_GSM_COLP =3D                           0x004C,
+	SS_GSM_COLR =3D                           0x004D,
+	SS_GSM_CNAP =3D                           0x012C,
+	SS_GSM_ECT =3D                            0x0060
 };
 =

 enum ss_response_data {
@@ -106,9 +112,13 @@ enum ss_subblock {
 	SS_GSM_PASSWORD =3D			0x03,
 	SS_GSM_FORWARDING_INFO =3D		0x04,
 	SS_GSM_FORWARDING_FEATURE =3D		0x05,
+	SS_GSM_BARRING_INFO =3D			0x06,
+	SS_GSM_BARRING_FEATURE =3D		0x07,
 	SS_GSM_DATA =3D				0x08,
 	SS_GSM_BSC_INFO =3D			0x09,
+	SS_GSM_GENERIC_SERVICE_INFO =3D		0x0A,
 	SS_GSM_PASSWORD_INFO =3D			0x0B,
+	SS_GSM_CLIR_INFO =3D			0x0C,
 	SS_GSM_INDICATE_PASSWORD_ERROR =3D	0x0D,
 	SS_GSM_INDICATE_ERROR =3D			0x0E,
 	SS_GSM_ADDITIONAL_INFO =3D		0x2F,
@@ -122,4 +132,16 @@ enum ss_isi_cause {
 	SS_GSM_QUIESCENT =3D			0x08,
 };
 =

+enum ss_gsm_cli_restriction_option {
+	SS_GSM_CLI_PERMANENT =3D			0x00,
+	SS_GSM_DEFAULT_RESTRICTED =3D		0x01,
+	SS_GSM_CLI_DEFAULT_ALLOWED =3D		0x02,
+	SS_GSM_OVERRIDE_ENABLED =3D		0x03,
+	SS_GSM_OVERRIDE_DISABLED =3D		0x04
+};
+
+enum ss_constants {
+	SS_UNDEFINED_TIME =3D			0x00,
+};
+
 #endif /* __ISIMODEM_SS_H */
-- =

1.7.3.5


--===============2053838973423940491==--

