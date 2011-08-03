Content-Type: multipart/mixed; boundary="===============1911360678215981808=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 4/5] isimodem: Add functionality to UICC
Date: Wed, 03 Aug 2011 10:43:54 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB24151@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1911360678215981808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/isimodem/uicc.c b/drivers/isimodem/uicc.c
index 2b43793..6c1d95e 100644
--- a/drivers/isimodem/uicc.c
+++ b/drivers/isimodem/uicc.c
@@ -45,10 +45,21 @@
 #include "isiutil.h"
 #include "sim.h"
 #include "uicc.h"
+#include "uicc-util.h"
 #include "debug.h"
 =

-#define USIM_APP_DEDICATED_FILE		0x7FFF
-#define MAX_SIM_APPS			8
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
+#define SIM_EFARR_FILEID		0x6f06
+#define MAX_SIM_APPS			10
 =

 enum uicc_flag {
 	UICC_FLAG_APP_STARTED =3D		1 << 0,
@@ -56,14 +67,6 @@ enum uicc_flag {
 	UICC_FLAG_PASSWD_REQUIRED =3D	1 << 2,
 };
 =

-struct sim_data {
-	GIsiClient *client;
-	unsigned flags;
-	int app_id;
-	int app_type;
-	uint8_t client_id;
-};
-
 static GHashTable *g_modems;
 =

 struct file_info {
@@ -96,6 +99,8 @@ static const struct file_info static_file_info[] =3D {
 	{ SIM_EFIMSI_FILEID, 9, 0, 9, { 0x0e, 0xff, 0xee }, 1 },
 };
 =

+static void uicc_application_list_req(GIsiClient *client, void *opaque);
+
 static gboolean check_resp(const GIsiMessage *msg, uint8_t msgid, uint8_t =
service)
 {
 	uint8_t type;
@@ -125,27 +130,545 @@ static gboolean check_resp(const GIsiMessage *msg, u=
int8_t msgid, uint8_t servic
 	return TRUE;
 }
 =

+struct uicc_file_info_cb_data {
+	void *cb;
+	void *data;
+	void *user;
+	struct ofono_sim* sim;
+};
+
+static void uicc_file_info_resp_cb(const GIsiMessage *msg, void *opaque)
+{
+	uint16_t length =3D 0;
+	uint16_t record_length =3D 0;
+	uint8_t structure =3D -1;
+	uint8_t records =3D 0;
+	uint16_t file_id =3D 0;
+	uint8_t access[3] =3D {0, 0, 0};
+	uint8_t fcp_len =3D 0, read =3D 0, id =3D 0, item_len =3D 0;
+	uint8_t fcp =3D 0, desc =3D 0, coding =3D 0;
+	gboolean everything_ok =3D FALSE;
+
+	uint8_t message_id =3D 0;
+	uint8_t service_type =3D 0;
+	uint8_t status =3D 0;
+	uint8_t details =3D 0;
+	uint8_t num_subblocks =3D 0;
+	uint8_t file_status =3D 1;
+
+	struct uicc_file_info_cb_data *cbd =3D opaque;
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(cbd->sim);
+	struct file_info const *info =3D cbd->user;
+	ofono_sim_file_info_cb_t cb =3D cbd->cb;
+
+	GIsiSubBlockIter iter;
+
+	message_id =3D g_isi_msg_id(msg);
+	DBG("uicc_file_info_resp_cb: msg_id=3D%d, msg len=3D%d", message_id, g_is=
i_msg_data_len(msg));
+	if (message_id !=3D UICC_APPL_CMD_RESP)
+		goto error;
+
+	g_isi_msg_data_get_byte(msg, 0, &service_type);
+	g_isi_msg_data_get_byte(msg, 1, &status);
+	g_isi_msg_data_get_byte(msg, 2, &details);
+	g_isi_msg_data_get_byte(msg, 5, &num_subblocks);
+
+	DBG("%s, service %s, status %s, details %s, nm_sb %d",
+		uicc_message_id_name(message_id),
+		uicc_service_type_name(service_type),
+		uicc_status_name(status), uicc_details_name(details), num_subblocks);
+
+	if (info) {
+		access[0] =3D info->access[0];
+		access[1] =3D info->access[1];
+		access[2] =3D info->access[2];
+		file_status =3D info->file_status;
+	}
+
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, num_subblocks);
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
+				(void) g_isi_sb_iter_get_byte(&iter, &fcp, 8);
+
+				if (fcp =3D=3D FCP_TEMPLATE) {
+					(void) g_isi_sb_iter_get_byte(&iter,
+									&fcp_len, 9);
+
+					while (read < fcp_len) {
+						(void) g_isi_sb_iter_get_byte(
+							&iter, &id, read + 10);
+						(void) g_isi_sb_iter_get_byte(
+							&iter, &item_len,
+							read + 11);
+
+						switch (id) {
+						case FCP_FILE_SIZE:
+
+							if (item_len =3D=3D 2) {
+								g_isi_sb_iter_get_word(
+									&iter,
+									&length,
+									read + 10 + 2);
+							}
+
+							break;
+						case FCP_FILE_ID:
+
+							if (item_len =3D=3D 2) {
+								g_isi_sb_iter_get_word(
+									&iter,
+									&file_id,
+									read + 10 + 2);
+							}
+
+							break;
+						case FCP_FILE_DESC:
+
+							if (item_len >=3D 2) {
+								(void) g_isi_sb_iter_get_byte(
+									&iter,
+									&desc,
+									read + 10 + 2);
+								(void) g_isi_sb_iter_get_byte(
+									&iter,
+									&coding,
+									read + 10 + 3);
+							}
+
+							if (item_len >=3D 4) {
+								g_isi_sb_iter_get_word(
+									&iter,
+									&record_length,
+									read + 10 + 4);
+								(void) g_isi_sb_iter_get_byte(
+									&iter,
+									&records,
+									read + 10 + 6);
+							}
+
+							break;
+						case FCP_FILE_SECURITY_ARR:
+						case FCP_FILE_SECURITY_COMPACT:
+						case FCP_FILE_SECURITY_EXPANDED:
+
+						/* Not implemented, using static
+						 * access rules as these are
+						 * used only for cacheing See
+						 * ETSI TS 102 221, ch
+						 * 11.1.1.4.7 and
+						 * Annexes E,F and G
+						 */
+
+						case FCP_FILE_LIFECYCLE:
+						default:
+							DBG("FCP id %02X not supported",
+								id);
+							break;
+						}
+
+						/*Data length + id size + len size*/
+						read +=3D item_len + 2;
+					}
+				}
+
+				if ((desc & 7) =3D=3D 1)
+					structure =3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT;
+				else if ((desc & 7) =3D=3D 2)
+					structure =3D OFONO_SIM_FILE_STRUCTURE_FIXED;
+				else if ((desc & 7) =3D=3D 6)
+					structure =3D OFONO_SIM_FILE_STRUCTURE_CYCLIC;
+
+				break;
+			case UICC_APPL_TYPE_ICC_SIM:
+				DBG("UICC_APPL_TYPE_ICC_SIM");
+				g_isi_sb_iter_get_word(&iter, &length, 10);
+				g_isi_sb_iter_get_word(&iter, &file_id, 12);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&access[0], 16);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&access[0], 17);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&access[0], 18);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&item_len, 20);
+				(void)g_isi_sb_iter_get_byte(&iter,
+								&structure, 21);
+
+				if (item_len =3D=3D 2)
+					(void)g_isi_sb_iter_get_byte(&iter,
+								(uint8_t *)&record_length, 22);
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
+		DBG("=3D=3D=3D=3DReturning real file info: Fileid=3D%04X, filelen=3D%d, =
"\
+			"records=3D%d, reclen=3D%d, structure=3D%d",
+			file_id, length, records,
+			record_length, structure);
+		CALLBACK_WITH_SUCCESS(
+			cb, length, structure, record_length, access, file_status, cbd->data);
+		goto out;
+	}
+
+error:
+	DBG("Error reading file info");
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0, cbd->data);
+out:
+	g_free(cbd);
+}
+
 static void uicc_read_file_info(struct ofono_sim *sim, int fileid,
 				ofono_sim_file_info_cb_t cb, void *data)
 {
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+	struct uicc_file_info_cb_data *cbd =3D g_try_new0(struct uicc_file_info_c=
b_data, 1);
+
+	/* Prepare for static file info used for access rights */
+	int i;
+	int N =3D sizeof(static_file_info) / sizeof(static_file_info[0]);
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+
+	if (!sd || !cbd)
+		goto error;
+
+	cbd->cb =3D cb;
+	cbd->data =3D data;
+	cbd->sim =3D sim;
+	cbd->user =3D NULL;
+
+	DBG("File info for ID=3D%04X app id %d", fileid, sd->app_id);
+
+	for (i =3D 0; i < N; i++) {
+		if (fileid =3D=3D static_file_info[i].fileid) {
+			cbd->user =3D (void *) &static_file_info[i];
+			continue;
+		}
+	}
+	=

+	if (cbd->user =3D=3D NULL)
+		{
+		DBG("File info for ID=3D%04X NOT FOUND!!!!!!");
+		}
+	=

+	=

+	if (!uicc_get_fileid_path(sd, &mf_path, &df1_path,
+				&df2_path, &df_len, fileid))
+		goto error;
+
+	const unsigned char msg[] =3D {
+		UICC_APPL_CMD_REQ,
+		UICC_APPL_FILE_INFO,      /* Service type */
+		sd->app_id,
+		UICC_SESSION_ID_NOT_USED, /*Session ID*/
+		0, /*Filler*/
+		0, /*Filler*/
+		1, /*number of subblocks*/
+	/* Subblock 1*/
+		UICC_SB_APPL_PATH >> 8,
+		UICC_SB_APPL_PATH & 0xff,
+		0,
+		16, /*Sub block length*/
+		fileid >> 8, /* UICC elementary file ID*/
+		fileid & 0xFF,
+		uicc_get_sfi(fileid), /* Elementary file short file id*/
+		0, /*filler*/
+		df_len, /*DF Path length*/
+		0, /*Filler*/
+		mf_path >> 8,
+		mf_path & 0xff,
+		df1_path >> 8, /*DF Path*/
+		df1_path & 0xFF,
+		df2_path >> 8, /*DF Path*/
+		df2_path & 0xFF,
+	};
+	g_isi_client_send_with_timeout(
+		sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+		uicc_file_info_resp_cb, cbd, NULL);
+	return;
+
+error:
 	DBG("Not implemented");
 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0, data);
+	g_free(cbd);
+	return;
+}
+
+static void uicc_read_file_transparent_resp_cb(const GIsiMessage *msg, voi=
d *opaque)
+{
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	GIsiSubBlockIter iter;
+	uint32_t filelen =3D 0;
+	unsigned char filedata[256] =3D { 0xff };
+	gboolean everything_ok =3D FALSE;
+	uint8_t num_sb =3D 0;
+
+	DBG("!");
+
+	if (!check_resp(msg, UICC_APPL_CMD_RESP, UICC_APPL_READ_TRANSPARENT))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 5, &num_sb))
+		goto error;
+
+	for(g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, num_sb);
+	    g_isi_sb_iter_is_valid(&iter);
+	    g_isi_sb_iter_next(&iter)) {
+		int sb_id =3D g_isi_sb_iter_get_id(&iter);
+
+		DBG("Sub-block %s", uicc_subblock_name(sb_id));
+
+		switch (sb_id) {
+		case UICC_SB_FILE_DATA:
+			g_isi_sb_iter_get_dword(&iter, &filelen, 4);
+			memmove(&filedata, iter.start + 8, filelen);
+			everything_ok =3D TRUE;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (everything_ok) {
+		DBG("Transparent EF read: 1st byte %02x, len %d",
+			filedata[0], filelen);
+		CALLBACK_WITH_SUCCESS(cb, filedata, filelen, cbd->data);
+		goto out;
+	}
+
+error:
+	DBG("Error reading transparent EF");
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+out:
+	g_free(cbd);
 }
 =

 static void uicc_read_file_transparent(struct ofono_sim *sim, int fileid,
 					int start, int length,
 					ofono_sim_read_cb_t cb, void *data)
 {
-	DBG("Not implemented");
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+
+	if (!cbd || !sd)
+		goto error;
+
+	DBG("File ID=3D%04X, client %d, AID %d",
+		fileid, sd->client_id, sd->app_id);
+
+	if (!uicc_get_fileid_path(sd, &mf_path, &df1_path,
+			&df2_path, &df_len, fileid))
+		goto error;
+
+	const unsigned char msg[] =3D {
+		UICC_APPL_CMD_REQ,
+		UICC_APPL_READ_TRANSPARENT,
+		sd->app_id,
+		UICC_SESSION_ID_NOT_USED, /*Session ID*/
+		0, /*Filler*/
+		0, /*Filler*/
+		3, /*number of subblocks*/
+	/* Subblock 1 */
+		UICC_SB_CLIENT >> 8,
+		UICC_SB_CLIENT & 0xff,
+		0,
+		8, /*Sub block length*/
+		0, 0, 0, /* Filler */
+		sd->client_id,
+	/* Subblock 2*/
+		UICC_SB_TRANSPARENT >> 8,
+		UICC_SB_TRANSPARENT & 0xff,
+		0, /*Sub block length*/
+		8, /*Sub block length*/
+		0, /*File offset (0=3Dbeginning)*/
+		0, /*File offset (0=3Dbeginning)*/
+		0, /*Data amount (0=3Dall)*/
+		0, /*Data amount (0=3Dall)*/
+	/* Subblock 3 */
+		UICC_SB_APPL_PATH >> 8,
+		UICC_SB_APPL_PATH & 0xff,
+		0,
+		16, /* Sub block length*/
+		fileid >> 8, /* UICC elementary file ID*/
+		fileid & 0xFF,
+		uicc_get_sfi(fileid), /* Elementary file short file id*/
+		0, /*filler*/
+		df_len, /*DF Path length*/
+		0, /*Filler*/
+		mf_path >> 8,
+		mf_path & 0xff,
+		df1_path >> 8, /*DF Path*/
+		df1_path & 0xFF,
+		df2_path >> 8, /*DF Path*/
+		df2_path & 0xFF
+	};
+	g_isi_client_send_with_timeout(sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			  uicc_read_file_transparent_resp_cb, cbd, NULL);
+	return;
+
+error:
+	DBG("Not implemented (fileid =3D %04x)", fileid);
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	g_free(cbd);
+}
+
+static void isi_read_file_linear_resp(const GIsiMessage *msg, void *opaque)
+{
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	uint32_t filelen =3D 0;
+	unsigned char filedata[256] =3D { 0xff };
+	gboolean everything_ok =3D FALSE;
+	GIsiSubBlockIter iter;
+	uint8_t num_sb =3D 0;
+
+	DBG("!");
+
+	if (!check_resp(msg, UICC_APPL_CMD_RESP, UICC_APPL_READ_LINEAR_FIXED))
+		goto error;
+		=

+	everything_ok =3D FALSE;
+	=

+	if (!g_isi_msg_data_get_byte(msg, 5, &num_sb))
+		goto error;
+
+	for(g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, num_sb);
+	    g_isi_sb_iter_is_valid(&iter);
+	    g_isi_sb_iter_next(&iter)) {
+		int sb_id =3D g_isi_sb_iter_get_id(&iter);
+
+		DBG("Sub-block %s", uicc_subblock_name(sb_id));
+
+		switch (sb_id) {
+		case UICC_SB_FILE_DATA:
+			g_isi_sb_iter_get_dword(&iter, &filelen, 4);
+			memmove(&filedata, iter.start + 8, filelen);
+			everything_ok =3D TRUE;
+			break;
+		default:
+			break;
+		}
+
+	}
+
+	if (everything_ok) =

+		{
+		DBG("Linear fixed EF read: 1st byte %02x, len %d",
+			filedata[0], filelen);
+		CALLBACK_WITH_SUCCESS(cb, filedata, filelen, cbd->data);
+		goto out;
+		}
+
+error:
+	DBG("Error reading linear fixed EF");
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+out:
+	g_free(cbd);
 }
 =

+
 static void uicc_read_file_linear(struct ofono_sim *sim, int fileid, int r=
ecord,
 					int rec_length, ofono_sim_read_cb_t cb,
 					void *data)
 {
-	DBG("Not implemented");
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	int mf_path =3D 0;
+	int df1_path =3D 0;
+	int df2_path =3D 0;
+	unsigned char df_len =3D 0;
+	=

+	DBG("File ID=3D%04X, record %d, client %d AID %d", fileid, record, sd->cl=
ient_id, sd->app_id);
+	=

+	if (!uicc_get_fileid_path(sd, &mf_path, &df1_path, &df2_path, &df_len, fi=
leid))
+		goto error;
+	=

+	if (cbd && sd) =

+		{
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
+			uicc_get_sfi(fileid), /* Elementary file short file id*/
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
+		g_isi_client_send_with_timeout(sd->client, msg, sizeof(msg), SIM_TIMEOUT,
+			  isi_read_file_linear_resp, cbd, NULL);
+		return;
+	}
+	=

+error:
+	DBG("Not implemented (fileid =3D %04x)", fileid);
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	g_free(cbd);
 }
 =

 static void uicc_read_file_cyclic(struct ofono_sim *sim, int fileid,
@@ -181,18 +704,133 @@ static void uicc_write_file_cyclic(struct ofono_sim =
*sim, int fileid, int length
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+
+static void uicc_read_imsi_resp(const struct ofono_error *error,
+				const unsigned char *data,
+				int len,
+				void *user)
+{
+#define SIM_MAX_IMSI_LENGTH     15
+	struct isi_cb_data *cbd =3D user;
+	ofono_sim_imsi_cb_t cb =3D cbd->cb;
+	/* For coding see TS 24.008 */
+	char imsi[SIM_MAX_IMSI_LENGTH + 1];
+	int i =3D 1; /*Skip length, the 1st byte*/
+	int j =3D 0;
+	int octets;
+
+	if (!data)
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
 static void uicc_read_imsi(struct ofono_sim *sim,
 				ofono_sim_imsi_cb_t cb, void *data)
 {
-	DBG("Not implemented");
-	CALLBACK_WITH_FAILURE(cb, NULL, data);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	uicc_read_file_transparent(sim, SIM_EFIMSI_FILEID, 0, 9,
+					uicc_read_imsi_resp, cbd);
+}
+
+static void uicc_query_passwd_state_resp(const GIsiMessage *msg, void *opa=
que)
+{
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_passwd_cb_t cb =3D cbd->cb;
+	uint8_t type;
+	uint8_t cause;
+	=

+	DBG("!"); 	=

+	if (g_isi_msg_error(msg) < 0) =

+		{
+		DBG("Error: %s", g_isi_msg_strerror(msg));
+		goto error;
+		}
+
+	if (g_isi_msg_id(msg) !=3D UICC_PIN_RESP) =

+		{
+		DBG("Unexpected msg: %s", sim_message_id_name(g_isi_msg_id(msg)));
+		goto error;
+		}
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &type) || type !=3D UICC_PIN_PROMPT_=
VERIFY) =

+		{
+		DBG("Unexpected service: 0x%02X (0x%02X)", type, UICC_PIN_PROMPT_VERIFY);
+		goto error;
+		}
+
+
+	if (!g_isi_msg_data_get_byte(msg, 1, &cause) ||
+		((cause !=3D UICC_STATUS_OK) && (cause !=3D UICC_STATUS_PIN_DISABLED)))
+		{
+		DBG("Request failed: %s", uicc_status_name(cause));
+		goto error;
+		}
+
+  DBG("Status: %d %s", cause, uicc_status_name(cause));
+	if (cause =3D=3D UICC_STATUS_PIN_DISABLED)
+		{
+		CALLBACK_WITH_SUCCESS(cb, OFONO_SIM_PASSWORD_NONE, cbd->data);
+		goto out;
+		}
+	else
+		{
+		DBG("PASSWORD REQUIRED IMPLEMENT ME!!!!!!");
+		}
+
+		=

+error:		=

+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+out:
+	g_free(cbd);
+	return;
 }
 =

 static void uicc_query_passwd_state(struct ofono_sim *sim,
 					ofono_sim_passwd_cb_t cb, void *data)
 {
-	DBG("Not implemented");
-	CALLBACK_WITH_FAILURE(cb, -1, data);
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	=

+	const uint8_t req[] =3D { UICC_PIN_REQ, UICC_PIN_PROMPT_VERIFY, sd->app_i=
d, =

+											    0, 0, 0, /* Filler */
+											    1, /* Number of subblocks */ =

+											   /* Subblock1 */
+											    UICC_SB_PIN_REF >> 8,
+											    UICC_SB_PIN_REF & 0xFF,
+											    0,
+											    8,  /*Sub block length*/
+											    sd->pin1_id,  /* Pin ID */
+											    0, 0, 0 /* Filler */ };
+
+	DBG("!"); 	=

+	g_isi_client_send_with_timeout(sd->client, req, sizeof(req), SIM_TIMEOUT,
+			  uicc_query_passwd_state_resp, cbd, NULL);
 }
 =

 static void uicc_send_passwd(struct ofono_sim *sim, const char *passwd,
@@ -202,12 +840,81 @@ static void uicc_send_passwd(struct ofono_sim *sim, c=
onst char *passwd,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void uicc_query_pin_retries_resp(const GIsiMessage *msg, void *opaq=
ue)
+{
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	GIsiSubBlockIter iter;
+	uint8_t num_sb =3D 0, pins, pina, puka;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	gboolean everything_ok =3D FALSE;
+	=

+	DBG("!"); 	=

+	if (!check_resp(msg, UICC_PIN_RESP, UICC_PIN_INFO))
+		goto error;
+
+	if (!g_isi_msg_data_get_byte(msg, 5, &num_sb))
+		goto error;
+	DBG("Subblock count %d", num_sb ); 	=

+
+	for(g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, num_sb);
+	    g_isi_sb_iter_is_valid(&iter);
+	    g_isi_sb_iter_next(&iter)) =

+	    {
+			int sb_id =3D g_isi_sb_iter_get_id(&iter);
+
+			DBG("Sub-block %s", uicc_subblock_name(sb_id));
+
+			switch (sb_id) =

+			{
+				case UICC_SB_PIN_INFO:
+					g_isi_sb_iter_get_byte(&iter, &pins, 4);
+					g_isi_sb_iter_get_byte(&iter, &pina, 5);
+					g_isi_sb_iter_get_byte(&iter, &puka, 6);
+					DBG("PIN status %X PIN Attrib %d PUK attrib %d", pins, pina, puka );
+					retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D pina;
+					retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D puka;
+					everything_ok =3D TRUE;
+					break;
+					=

+			default:
+				break;
+			}
+	}
+	if (everything_ok) =

+		{
+		CALLBACK_WITH_SUCCESS(cb, retries, cbd->data);
+		goto out;
+		}
+		=

+error:		=

+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+out:
+	g_free(cbd);
+	return;
+}
+
 static void uicc_query_pin_retries(struct ofono_sim *sim,
 					ofono_sim_pin_retries_cb_t cb,
 					void *data)
 {
-	DBG("Not implemented");
-	CALLBACK_WITH_FAILURE(cb, NULL, data);
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	=

+	const uint8_t req[] =3D { UICC_PIN_REQ, UICC_PIN_INFO, sd->app_id, =

+											    0, 0, 0, /* Filler */
+											    1, /* NUmber of subblocks */ =

+											   /* Subblock1 */
+											    UICC_SB_PIN_REF >> 8,
+											    UICC_SB_PIN_REF & 0xFF,
+											    0,
+											    8,  /*Sub block length*/
+											    sd->pin1_id,  /* Pin ID */
+											    0, 0, 0 /* Filler */ };
+
+	DBG("!"); 	=

+	g_isi_client_send_with_timeout(sd->client, req, sizeof(req), SIM_TIMEOUT,
+			  uicc_query_pin_retries_resp, cbd, NULL);
 }
 =

 static void uicc_reset_passwd(struct ofono_sim *sim, const char *puk,
@@ -248,14 +955,175 @@ static void pin_ind_cb(const GIsiMessage *msg, void =
*data)
 	DBG("%s", uicc_message_id_name(g_isi_msg_id(msg)));
 }
 =

-static void card_ind_cb(const GIsiMessage *msg, void *data)
+static void uicc_card_status_resp(const GIsiMessage *msg, void *data)
 {
-	DBG("%s", uicc_message_id_name(g_isi_msg_id(msg)));
+	struct ofono_sim *sim =3D data;
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+	uint8_t service =3D 0, card_status =3D 0, num_sb =3D 0;
+	gboolean card_ready =3D FALSE;
+	GIsiSubBlockIter iter;
+
+	DBG("!!!");
+
+	if (!sd->server_running)
+		return;
+
+	if (!check_resp(msg, UICC_CARD_RESP, UICC_CARD_STATUS_GET))
+		goto fail;
+
+	if (!g_isi_msg_data_get_byte(msg, 1, &card_status))
+		goto fail;
+
+	/* Get number of sub-blocks */
+	if (!g_isi_msg_data_get_byte(msg, 5, &num_sb))
+		goto fail;
+
+	DBG("sub blocks =3D %d", num_sb);
+
+	/* Iterate through the sub block list */
+	for (g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, num_sb);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+
+		if (g_isi_sb_iter_get_id(&iter) !=3D UICC_SB_CARD_STATUS)
+			continue;
+
+		g_isi_sb_iter_get_byte(&iter, &card_status, 7);
+
+		DBG("card_status =3D 0x%X", card_status);
+
+		if (card_status =3D=3D 0x21)
+			card_ready =3D TRUE;
+		break;
+	}
+
+	if (!card_ready) {
+		DBG("card not ready");
+		ofono_sim_inserted_notify(sim, FALSE);
+	} else {
+		DBG("card is ready");
+		ofono_sim_inserted_notify(sim, TRUE);
+		uicc_application_list_req(sd->client, data);
+	}
+
+	return;
+
+fail:
+	g_isi_client_destroy(sd->client);
+	sd->client =3D NULL;
+
+	ofono_sim_remove(sim);
+}
+
+static void uicc_card_status_req(struct ofono_sim *sim, struct uicc_sim_da=
ta *sd)
+{
+	const uint8_t req[] =3D { UICC_CARD_REQ, UICC_CARD_STATUS_GET, 0 };
+
+	DBG("!!!");
+
+	if (g_isi_client_send(sd->client, req, sizeof(req), uicc_card_status_resp,
+					sim, NULL))
+		return;
+
+fail:
+	g_isi_client_destroy(sd->client);
+	sd->client =3D NULL;
+
+	ofono_sim_remove(sim);
+}
+
+static void uicc_card_ind_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("!!!");
+
+	if (g_isi_msg_id(msg) !=3D UICC_CARD_IND)
+		return;
+
+	/* We're not interested in card indications if server isn't running */
+	if (!sd->server_running)
+		return;
+
+	/* Request card status */
+	uicc_card_status_req(sim, sd);
+}
+
+/*** UICC Status request / response ****/
+
+static void uicc_status_resp(const GIsiMessage *msg, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+	uint8_t status =3D 0, server_status =3D 0;
+	gboolean server_running =3D FALSE;
+
+	if (!check_resp(msg, UICC_RESP, UICC_STATUS_GET))
+		goto fail;
+
+	if (g_isi_msg_error(msg) < 0)
+		goto fail;
+
+	g_isi_msg_data_get_byte(msg, 1, &status);
+	g_isi_msg_data_get_byte(msg, 3, &server_status);
+	DBG("status=3D0x%X, server_status=3D0x%X", status, server_status);
+
+	if (status =3D=3D UICC_STATUS_OK && server_status =3D=3D UICC_STATUS_STAR=
T_UP_COMPLETED) {
+		DBG("server is up!");
+		server_running =3D TRUE;
+	}
+
+
+	if (!server_running) {
+		sd->server_running =3D FALSE;
+
+		/* TODO: Remove SIM etc... */
+		return;
+	}
+
+	if (sd->server_running && server_running) {
+		DBG("Server status didn't change...");
+		return;
+	}
+
+	/* Server is running */
+	sd->server_running =3D TRUE;
+
+	/* Request card status */
+	uicc_card_status_req(sim, sd);
+	return;
+
+fail:
+	g_isi_client_destroy(sd->client);
+	sd->client =3D NULL;
+
+	ofono_sim_remove(sim);
 }
 =

 static void uicc_ind_cb(const GIsiMessage *msg, void *data)
 {
-	DBG("%s", uicc_message_id_name(g_isi_msg_id(msg)));
+	struct ofono_sim *sim =3D data;
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+
+	int msg_id =3D g_isi_msg_id(msg);
+	DBG("%s", uicc_message_id_name(msg_id));
+
+	if (msg_id !=3D UICC_IND)
+		return;
+
+	const uint8_t req[] =3D { UICC_REQ, UICC_STATUS_GET, 0 };
+
+	/* Request status */
+	if (g_isi_client_send(sd->client, req, sizeof(req), uicc_status_resp,
+				data, NULL))
+		return;
+
+	DBG("status request failed!");
+
+	g_isi_client_destroy(sd->client);
+	sd->client =3D NULL;
+	ofono_sim_remove(sim);
 }
 =

 static void app_ind_cb(const GIsiMessage *msg, void *data)
@@ -279,44 +1147,307 @@ struct data_object {
 	uint8_t len;
 };
 =

-static void uicc_app_list_resp(const GIsiMessage *msg, void *data)
+static void uicc_application_activate_resp(const GIsiMessage* msg, void *o=
paque)
+{
+	struct ofono_sim *sim =3D opaque;
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
+	GIsiSubBlockIter iter;
+	uint8_t cause, num_sb;
+
+	DBG("");
+
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", g_isi_msg_strerror(msg));
+		goto error;
+	}
+
+	if (g_isi_msg_id(msg) !=3D UICC_APPLICATION_RESP) {
+		DBG("Unexpected msg: %s",
+			sim_message_id_name(g_isi_msg_id(msg)));
+		goto error;
+	}
+
+	if (!g_isi_msg_data_get_byte(msg, 1, &cause))
+		goto error;
+
+
+	if ((cause =3D=3D UICC_STATUS_OK) ||
+	    (cause =3D=3D UICC_STATUS_APPL_ACTIVE)) {
+		if (!sd->uicc_app_started) {
+			sd->app_id =3D sd->trying_app_id;
+			sd->app_type =3D sd->trying_app_type;
+			sd->uicc_app_started =3D TRUE;
+			DBG("UICC application activated");
+			ofono_sim_inserted_notify(sim, TRUE);
+			ofono_sim_register(sim);
+			g_hash_table_remove_all(sd->app_table);
+		}
+	} else {
+		/*int i =3D sim_applications_get_next_index(
+				sim_application_list_p, sd->trying_app_id);
+
+		if (i =3D=3D NOT_AVAILABLE) {
+			g_free(sim_application_list_p);
+			goto error;
+		}
+
+		DBG("Activation Error, trying to activate APP with ID:%d", i);
+		uicc_application_activate_req(client, sim,
+						sim_application_list_p->app_type[i],
+						sim_application_list_p->app_list[i]);*/
+		goto error;
+	}
+
+	g_isi_msg_data_get_byte(msg, 5, &num_sb);
+	g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, num_sb);
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
+				uint8_t fcp =3D 0, fcp_len =3D 0, read =3D 0,
+					id =3D 0, item_len =3D 0;
+				(void) g_isi_sb_iter_get_byte(&iter, &fcp, 8);
+				DBG("UICC_APPL_TYPE_UICC_USIM");
+
+				if (fcp =3D=3D FCP_TEMPLATE) {
+					(void) g_isi_sb_iter_get_byte(
+						&iter, &fcp_len, 9);
+					DBG("FCP_TEMPLATE");
+
+					while (read < fcp_len) {
+						(void) g_isi_sb_iter_get_byte(
+							&iter, &id, read + 10);
+						(void) g_isi_sb_iter_get_byte(
+							&iter, &item_len,
+							read + 11);
+
+						/* See TS 102 221,
+						*  PIN status template DO */
+						switch (id) {
+							uint8_t pin_do_len, pin_len,
+								pin_tag, pin_id,
+								pin_tag_pos;
+
+						case FCP_PIN_STATUS:
+
+							DBG("PIN status");
+							g_isi_sb_iter_get_byte(&iter,
+										&pin_do_len,
+										read + 10 + 3);
+							pin_tag_pos =3D
+								read + 10 + 4 + pin_do_len;
+							g_isi_sb_iter_get_byte(&iter,
+										&pin_tag,
+										pin_tag_pos);
+
+							while (pin_tag =3D=3D 0x83) {
+								g_isi_sb_iter_get_byte(
+									&iter,
+									&pin_len,
+									pin_tag_pos + 1);
+								g_isi_sb_iter_get_byte(
+									&iter,
+									&pin_id,
+									pin_tag_pos + 2);
+								pin_tag_pos +=3D 2 + pin_len;
+								g_isi_sb_iter_get_byte(
+									&iter, &pin_tag,
+									pin_tag_pos);
+								DBG("PIN_len %d, PIN id %02x, \
+									PIN tag %02x", pin_len,
+									pin_id, pin_tag);
+
+								if ((0x01 <=3D pin_id) &&
+										(pin_id <=3D 0x08))
+									sd->pin1_id =3D pin_id;
+								else if ((0x81 <=3D pin_id) &&
+										(pin_id <=3D 0x88))
+									sd->pin2_id =3D pin_id;
+							}
+
+							DBG("PIN1 %02x,\
+								PIN2 %02x",
+								sd->pin1_id,
+								sd->pin2_id);
+							break;
+						default:
+							DBG("Skipping tag %02x", id);
+							break;
+						}
+
+						/*Data length + id size + len size*/
+						read +=3D item_len + 2;
+					}
+				}
+			}
+
+			break;
+		case UICC_SB_CHV:
+			DBG("UICC_SB_CHV");
+
+			if (sd->app_type =3D=3D UICC_APPL_TYPE_ICC_SIM) {
+				uint8_t chv_id =3D 0, pin_id =3D 0;
+				(void) g_isi_sb_iter_get_byte(&iter, &chv_id, 4);
+				(void) g_isi_sb_iter_get_byte(&iter, &pin_id, 5);
+				DBG("UICC_APPL_TYPE_ICC_SIM");
+
+				if (chv_id =3D=3D 1)
+					sd->pin1_id =3D pin_id;
+				else if (chv_id =3D=3D 2)
+					sd->pin2_id =3D pin_id;
+
+				DBG("CHV=3D%d, pin_id=3D%2x, PIN1 %02x, PIN2 %02x",
+					chv_id, pin_id, sd->pin1_id, sd->pin2_id);
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
+
+error:
+	return;
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
 {
 	struct ofono_sim *sim =3D data;
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
 	GIsiSubBlockIter iter;
-	uint8_t sb;
-	struct data_object *app;
-	size_t len =3D sizeof(struct data_object);
-	uint8_t *obj;
+	uint8_t num_sb;
+
+	/* Throw away old app table */
+	g_hash_table_remove_all(sd->app_table);
 =

 	if (!check_resp(msg, UICC_APPLICATION_RESP, UICC_APPL_LIST))
 		goto fail;
 =

-	if (!g_isi_msg_data_get_byte(msg, 5, &sb))
+	/* Get number of sub-blocks */
+	if (!g_isi_msg_data_get_byte(msg, 5, &num_sb))
 		goto fail;
 =

-	for (g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, sb);
+	/* Iterate through the application list */
+	for (g_isi_sb_iter_init_full(&iter, msg, 6, TRUE, num_sb);
 			g_isi_sb_iter_is_valid(&iter);
 			g_isi_sb_iter_next(&iter)) {
+		uint8_t app_type, app_id, app_status, app_len;
 =

 		if (g_isi_sb_iter_get_id(&iter) !=3D UICC_SB_APPL_DATA_OBJECT)
 			continue;
 =

-		if (!g_isi_sb_iter_get_struct(&iter, (void **) &app, len, 4))
+		if (!g_isi_sb_iter_get_byte(&iter, &app_type, 6))
+			goto fail;
+		if (!g_isi_sb_iter_get_byte(&iter, &app_id, 7))
+			goto fail;
+		if (!g_isi_sb_iter_get_byte(&iter, &app_status, 8))
+			goto fail;
+		if (!g_isi_sb_iter_get_byte(&iter, &app_len, 9))
+			goto fail;
+
+		if (app_type !=3D UICC_APPL_TYPE_ICC_SIM && app_type !=3D UICC_APPL_TYPE=
_UICC_USIM)
+			continue;
+
+		/*if (!g_isi_sb_iter_get_struct(&iter, (void **) &app, len, 4))
 			goto fail;
 =

 		if (!g_isi_sb_iter_get_struct(&iter, (void **) &obj, app->len,
 				4 + len))
+			goto fail;*/
+
+		/*decode_data_object(obj, app->len);*/
+
+		/* Insert the app in the table */
+		struct uicc_sim_application* sim_app =3D g_try_new0(struct uicc_sim_appl=
ication, 1);
+		if (!sim_app) {
+			DBG("out of memory!");
 			goto fail;
+		}
+
+		sim_app->type =3D app_type;
+		sim_app->id =3D app_id;
+		sim_app->status =3D app_status;
+		sim_app->length =3D app_len;
+		sim_app->sim =3D sd;
+
+		DBG("Insert in hash table!");
+		g_hash_table_replace(sd->app_table, &sim_app->id, sim_app);
+	}
+
+	if (!sd->uicc_app_started) {
+		/* Take next from hash table for activation*/
+		GHashTableIter iter;
+		gpointer key, value;
+
+		g_hash_table_iter_init (&iter, sd->app_table);
+		if (g_hash_table_iter_next (&iter, &key, &value)) {
+			struct uicc_sim_application *app =3D value;
+
+			sd->trying_app_id =3D app->id;
+			sd->trying_app_type =3D app->type;
 =

-		DBG("type=3D0x%02X id=3D0x%02X status=3D0x%02X length=3D%u bytes",
-			app->type, app->id, app->status, app->len);
+			g_hash_table_remove(sd->app_table, &app->id);
 =

-		decode_data_object(obj, app->len);
+			uicc_application_activate_req(sd->client, data, sd->trying_app_type, sd=
->trying_app_id);
+		}
 	}
 =

-	ofono_sim_register(sim);
-	ofono_sim_inserted_notify(sim, TRUE);
 	return;
 =

 fail:
@@ -328,43 +1459,28 @@ fail:
 	ofono_sim_remove(sim);
 }
 =

-static void uicc_status_resp(const GIsiMessage *msg, void *data)
+static void uicc_application_list_req(GIsiClient *client, void *opaque)
 {
-	struct ofono_sim *sim =3D data;
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
-
-	const uint8_t req[] =3D {
+	const unsigned char msg[] =3D {
 		UICC_APPLICATION_REQ,
 		UICC_APPL_LIST,
-		0,	/* Number of subblocks */
+		0 /* number of subblocks*/
 	};
+	DBG("!!!");
 =

-	if (!check_resp(msg, UICC_RESP, UICC_STATUS_GET))
-		goto fail;
-
-	DBG("");
-
-	if (g_isi_msg_error(msg) < 0)
-		goto fail;
-
-	if (g_isi_client_send(sd->client, req, sizeof(req), uicc_app_list_resp,
-				data, NULL))
-		return;
-
-fail:
-	g_isi_client_destroy(sd->client);
-	sd->client =3D NULL;
-
-	ofono_sim_remove(sim);
+	g_isi_client_send_with_timeout(
+		client, msg, sizeof(msg), SIM_TIMEOUT,
+		uicc_application_list_resp, opaque, NULL);
 }
 =

 static void uicc_reachable_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_sim *sim =3D data;
-	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct uicc_sim_data *sd =3D ofono_sim_get_data(sim);
 =

 	const uint8_t req[] =3D {
 		UICC_REQ, UICC_STATUS_GET,
+		0 /* Number of Sub Blocks (only from version 4.0) */
 	};
 =

 	ISI_RESOURCE_DBG(msg);
@@ -372,7 +1488,16 @@ static void uicc_reachable_cb(const GIsiMessage *msg,=
 void *data)
 	if (g_isi_msg_error(msg) < 0)
 		goto fail;
 =

-	if (g_isi_client_send(sd->client, req, sizeof(req), uicc_status_resp,
+    sd->version.major =3D g_isi_msg_version_major(msg);
+    sd->version.minor =3D g_isi_msg_version_minor(msg);
+
+	/* UICC server is reachable: request indications */
+	g_isi_client_ind_subscribe(sd->client, UICC_IND, uicc_ind_cb, sim);
+	g_isi_client_ind_subscribe(sd->client, UICC_CARD_IND, uicc_card_ind_cb,
+					sim);
+
+	/* Update status */
+    if (g_isi_client_send(sd->client, req, sizeof(req) - ((sd->version.maj=
or < 4) ? 1 : 0), uicc_status_resp,
 				data, NULL))
 		return;
 =

@@ -383,34 +1508,52 @@ fail:
 	ofono_sim_remove(sim);
 }
 =

+void sim_app_destroy(gpointer p)
+{
+	struct uicc_sim_application* app =3D p;
+	if (!app)
+		return;
+
+	g_free(app);
+}
+
 static int uicc_sim_probe(struct ofono_sim *sim, unsigned int vendor,
 				void *user)
 {
 	GIsiModem *modem =3D user;
-	struct sim_data *sd;
+	struct uicc_sim_data *sd;
 =

-	sd =3D g_try_new0(struct sim_data, 1);
+	sd =3D g_try_new0(struct uicc_sim_data, 1);
 	if (sd =3D=3D NULL)
 		return -ENOMEM;
 =

+	/* Create hash table for the UICC applications */
+	sd->app_table =3D g_hash_table_new_full(g_int_hash, g_int_equal, NULL, si=
m_app_destroy);
+	if (sd->app_table =3D=3D NULL) {
+		g_free(sd);
+		return -ENOMEM;
+	}
+
 	sd->client =3D g_isi_client_create(modem, PN_UICC);
 	if (sd->client =3D=3D NULL) {
+		g_hash_table_destroy(sd->app_table);
 		g_free(sd);
 		return -ENOMEM;
 	}
 =

 	g_hash_table_insert(g_modems, g_isi_client_modem(sd->client), sim);
 =

+	sd->server_running =3D FALSE;
+	sd->uicc_app_started =3D FALSE;
+	sd->pin_state_received =3D FALSE;
+	sd->passwd_required =3D TRUE;
 	ofono_sim_set_data(sim, sd);
 =

-	g_isi_client_ind_subscribe(sd->client, UICC_IND, uicc_ind_cb, sim);
-	g_isi_client_ind_subscribe(sd->client, UICC_CARD_IND, card_ind_cb,
-					sim);
-	g_isi_client_ind_subscribe(sd->client, UICC_CARD_READER_IND,
+	/*g_isi_client_ind_subscribe(sd->client, UICC_CARD_READER_IND,
 					card_ind_cb, sim);
 	g_isi_client_ind_subscribe(sd->client, UICC_PIN_IND, pin_ind_cb, sim);
 	g_isi_client_ind_subscribe(sd->client, UICC_APPLICATION_IND,
-					app_ind_cb, sim);
+					app_ind_cb, sim);*/
 =

 	g_isi_client_verify(sd->client, uicc_reachable_cb, sim, NULL);
 =

@@ -419,7 +1562,7 @@ static int uicc_sim_probe(struct ofono_sim *sim, unsig=
ned int vendor,
 =

 static void uicc_sim_remove(struct ofono_sim *sim)
 {
-	struct sim_data *data =3D ofono_sim_get_data(sim);
+	struct uicc_sim_data *data =3D ofono_sim_get_data(sim);
 =

 	ofono_sim_set_data(sim, NULL);
 =

@@ -428,6 +1571,7 @@ static void uicc_sim_remove(struct ofono_sim *sim)
 =

 	g_hash_table_remove(g_modems, g_isi_client_modem(data->client));
 =

+	g_hash_table_destroy(data->app_table);
 	g_isi_client_destroy(data->client);
 	g_free(data);
 }
@@ -469,7 +1613,7 @@ gboolean isi_uicc_properties(GIsiModem *modem, int *ap=
p_id, int *app_type,
 				int *client_id)
 {
 	struct ofono_sim *sim;
-	struct sim_data *sd;
+	struct uicc_sim_data *sd;
 =

 	sim =3D g_hash_table_lookup(g_modems, modem);
 	if (sim =3D=3D NULL)








--===============1911360678215981808==--

