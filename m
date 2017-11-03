Content-Type: multipart/mixed; boundary="===============2562815713487005475=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 4/4] atmodem: implement new driver APIs for AID sessions
Date: Fri, 03 Nov 2017 15:34:44 -0700
Message-ID: <1509748484-8773-4-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509748484-8773-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2562815713487005475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implementation for open/close channel, list applications,
and session based file read.
---
 drivers/atmodem/sim.c | 339 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 339 insertions(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 421abfb..6bf5478 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -39,6 +39,7 @@
 #include "gatresult.h"
 #include "simutil.h"
 #include "vendor.h"
+#include "util.h"
 =

 #include "atmodem.h"
 =

@@ -70,6 +71,9 @@ static const char *pct_prefix[] =3D { "#PCT:", NULL };
 static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
 static const char *qpinc_prefix[] =3D { "+QPINC:", NULL };
 static const char *upincnt_prefix[] =3D { "+UPINCNT:", NULL };
+static const char *cuad_prefix[] =3D { "+CUAD:", NULL };
+static const char *ccho_prefix[] =3D { "+CCHO:", NULL };
+static const char *crla_prefix[] =3D { "+CRLA:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void append_file_path(char *buf, const unsigned char *path,
@@ -1604,6 +1608,335 @@ done:
 	ofono_sim_register(sim);
 }
 =

+static void at_discover_apps_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_list_apps_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const unsigned char *dataobj;
+	gint linelen;
+	unsigned char *buffer;
+	int len;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, 0, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	len =3D 0;
+	while (g_at_result_iter_next(&iter, "+CUAD:")) {
+		if (!g_at_result_iter_next_hexstring(&iter, NULL, &linelen))
+			goto error;
+
+		len +=3D linelen;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	buffer =3D g_malloc(len);
+	len =3D 0;
+
+	while (g_at_result_iter_next(&iter, "+CUAD:")) {
+		g_at_result_iter_next_hexstring(&iter, &dataobj, &linelen);
+		memcpy(buffer + len, dataobj, linelen);
+		len +=3D linelen;
+	}
+
+	cb(&error, buffer, len, cbd->data);
+
+	g_free(buffer);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+}
+
+static void at_discover_apps(struct ofono_sim *sim,
+				ofono_sim_list_apps_cb_t cb,
+				void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(sd->chat, "AT+CUAD", cuad_prefix,
+			at_discover_apps_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+}
+
+static void at_open_channel_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_open_channel_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int session_id =3D -1;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CCHO:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &session_id))
+		goto error;
+
+	cb(&error, session_id, cbd->data);
+
+	return;
+
+error:
+	cb(&error, -1, cbd->data);
+}
+
+static void at_open_channel(struct ofono_sim *sim, const unsigned char *ai=
d,
+		ofono_sim_open_channel_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char cmd[43];
+	int ret =3D 0;
+
+	strcpy(cmd, "AT+CCHO=3D\"");
+	ret +=3D 9;
+
+	encode_hex_own_buf(aid, 16, 0, cmd + ret);
+	ret +=3D 32;
+
+	strcpy(cmd + ret, "\"");
+
+	if (g_at_chat_send(sd->chat, cmd, ccho_prefix, at_open_channel_cb,
+			cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void at_close_channel_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_close_channel_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (cb)
+		cb(&error, cbd->data);
+}
+
+static void at_close_channel(struct ofono_sim *sim, int session_id,
+		ofono_sim_close_channel_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char cmd[15];
+
+	sprintf(cmd, "AT+CCHC=3D%d", session_id);
+
+	g_at_chat_send(sd->chat, cmd, NULL, at_close_channel_cb, cbd, g_free);
+}
+
+static void at_crla_read_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const guint8 *response;
+	gint sw1, sw2, len;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, 0, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CRLA:")) {
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_next_number(&iter, &sw1);
+	g_at_result_iter_next_number(&iter, &sw2);
+
+	if ((sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) ||
+			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
+		memset(&error, 0, sizeof(error));
+
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (sw1 << 8) | sw2;
+
+		cb(&error, NULL, 0, cbd->data);
+		return;
+	}
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len)) {
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+		return;
+	}
+
+	DBG("crla_read_cb: %02x, %02x, %d", sw1, sw2, len);
+
+	cb(&error, response, len, cbd->data);
+}
+
+static void at_session_read_binary(struct ofono_sim *sim, int session,
+				int fileid, int start, int length,
+				const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_read_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+	unsigned int len;
+
+	len =3D snprintf(buf, sizeof(buf), "AT+CRLA=3D%i,176,%i,%i,%i,%i,,",
+			session, fileid, start >> 8, start & 0xff, length);
+
+	append_file_path(buf + len, path, path_len);
+
+	if (g_at_chat_send(sd->chat, buf, crla_prefix,
+			at_crla_read_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+}
+
+static void at_session_read_record(struct ofono_sim *sim, int session_id,
+				int fileid, int record, int length,
+				const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_read_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[128];
+	unsigned int len;
+
+	len =3D snprintf(buf, sizeof(buf), "AT+CRLA=3D%i,178,%i,%i,4,%i", session=
_id,
+			fileid, record, length);
+
+	append_file_path(buf + len, path, path_len);
+
+	if (g_at_chat_send(sd->chat, buf, crla_prefix,
+			at_crla_read_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+}
+
+static void at_crla_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_file_info_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const guint8 *response;
+	gint sw1, sw2, len;
+	int flen, rlen;
+	int str;
+	unsigned char access[3];
+	unsigned char file_status;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, -1, -1, NULL, EF_STATUS_INVALIDATED, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CRLA:"))
+		goto error;
+
+	g_at_result_iter_next_number(&iter, &sw1);
+	g_at_result_iter_next_number(&iter, &sw2);
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len) ||
+			(sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92) ||
+			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
+		memset(&error, 0, sizeof(error));
+
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (sw1 << 8) | sw2;
+
+		cb(&error, -1, -1, -1, NULL, EF_STATUS_INVALIDATED, cbd->data);
+		return;
+	}
+
+	DBG("crla_info_cb: %02x, %02x, %i", sw1, sw2, len);
+
+	if (response[0] =3D=3D 0x62) {
+		ok =3D sim_parse_3g_get_response(response, len, &flen, &rlen,
+						&str, access, NULL);
+
+		file_status =3D EF_STATUS_VALID;
+	}
+
+	if (!ok)
+		goto error;
+
+	cb(&error, flen, str, rlen, access, file_status, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL,
+				EF_STATUS_INVALIDATED, cbd->data);
+}
+
+static void at_session_read_info(struct ofono_sim *sim, int session_id,
+				int fileid, const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_file_info_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[128];
+	unsigned int len;
+
+	len =3D snprintf(buf, sizeof(buf), "AT+CRLA=3D%i,192,%i", session_id,
+			fileid);
+
+	append_file_path(buf + len, path, path_len);
+
+	if (g_at_chat_send(sd->chat, buf, crla_prefix,
+			at_crla_info_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL,
+				EF_STATUS_INVALIDATED, data);
+}
+
 static int at_sim_probe(struct ofono_sim *sim, unsigned int vendor,
 				void *data)
 {
@@ -1663,6 +1996,12 @@ static struct ofono_sim_driver driver =3D {
 	.lock			=3D at_pin_enable,
 	.change_passwd		=3D at_change_passwd,
 	.query_facility_lock	=3D at_query_clck,
+	.list_apps		=3D at_discover_apps,
+	.open_channel		=3D at_open_channel,
+	.close_channel		=3D at_close_channel,
+	.session_read_binary	=3D at_session_read_binary,
+	.session_read_record	=3D at_session_read_record,
+	.session_read_info	=3D at_session_read_info,
 };
 =

 static struct ofono_sim_driver driver_noef =3D {
-- =

2.7.4


--===============2562815713487005475==--

