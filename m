Content-Type: multipart/mixed; boundary="===============8038658279900732079=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/8][RFC] STATUS, FETCH and TERMINAL RESPONSE for AT driver.
Date: Mon, 15 Mar 2010 22:21:52 +0100
Message-ID: <1268688112-4026-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8038658279900732079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix ENVELOPE implementation.
---
 drivers/atmodem/sim.c |  286 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 273 insertions(+), 13 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 89ddcc6..d6f08b4 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -44,13 +44,39 @@
 struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	struct ofono_sim *sim;
+};
+
+struct sim_cb_data {
+	struct sim_data *sd;
+	void *cb;
+	void *data;
+	void *user;
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
+static const char *csim_prefix[] =3D { "+CSIM:", NULL };
+
+static inline struct sim_cb_data *sim_cb_data_new(struct sim_data *sd,
+		void *cb, void *data)
+{
+	struct sim_cb_data *ret;
+
+	ret =3D g_try_new0(struct sim_cb_data, 1);
+
+	if (!ret)
+		return ret;
+
+	ret->sd =3D sd;
+	ret->cb =3D cb;
+	ret->data =3D data;
+
+	return ret;
+}
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
-	struct cb_data *cbd =3D user_data;
+	struct sim_cb_data *cbd =3D user_data;
 	GAtResultIter iter;
 	ofono_sim_file_info_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
@@ -93,6 +119,10 @@ static void at_crsm_info_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		goto error;
 =

 	cb(&error, flen, str, rlen, access, cbd->data);
+
+	if (sw1 =3D=3D 0x91)
+		ofono_sim_proactive_command_notify(cbd->sd->sim, sw2);
+
 	return;
 =

 error:
@@ -104,7 +134,7 @@ static void at_sim_read_info(struct ofono_sim *sim, int=
 fileid,
 					void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct sim_cb_data *cbd =3D sim_cb_data_new(sd, cb, data);
 	char buf[64];
 =

 	if (!cbd)
@@ -129,7 +159,7 @@ error:
 static void at_crsm_read_cb(gboolean ok, GAtResult *result,
 		gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
+	struct sim_cb_data *cbd =3D user_data;
 	GAtResultIter iter;
 	ofono_sim_read_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
@@ -163,6 +193,9 @@ static void at_crsm_read_cb(gboolean ok, GAtResult *res=
ult,
 	DBG("crsm_read_cb: %02x, %02x, %d", sw1, sw2, len);
 =

 	cb(&error, response, len, cbd->data);
+
+	if (sw1 =3D=3D 0x91)
+		ofono_sim_proactive_command_notify(cbd->sd->sim, sw2);
 }
 =

 static void at_sim_read_binary(struct ofono_sim *sim, int fileid,
@@ -170,7 +203,7 @@ static void at_sim_read_binary(struct ofono_sim *sim, i=
nt fileid,
 					ofono_sim_read_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct sim_cb_data *cbd =3D sim_cb_data_new(sd, cb, data);
 	char buf[64];
 =

 	if (!cbd)
@@ -195,7 +228,7 @@ static void at_sim_read_record(struct ofono_sim *sim, i=
nt fileid,
 					ofono_sim_read_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct sim_cb_data *cbd =3D sim_cb_data_new(sd, cb, data);
 	char buf[64];
 =

 	if (!cbd)
@@ -218,7 +251,7 @@ error:
 static void at_crsm_update_cb(gboolean ok, GAtResult *result,
 		gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
+	struct sim_cb_data *cbd =3D user_data;
 	GAtResultIter iter;
 	ofono_sim_write_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
@@ -250,6 +283,9 @@ static void at_crsm_update_cb(gboolean ok, GAtResult *r=
esult,
 	DBG("crsm_update_cb: %02x, %02x", sw1, sw2);
 =

 	cb(&error, cbd->data);
+
+	if (sw1 =3D=3D 0x91)
+		ofono_sim_proactive_command_notify(cbd->sd->sim, sw2);
 }
 =

 static void at_sim_update_binary(struct ofono_sim *sim, int fileid,
@@ -258,7 +294,7 @@ static void at_sim_update_binary(struct ofono_sim *sim,=
 int fileid,
 					ofono_sim_write_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct sim_cb_data *cbd =3D sim_cb_data_new(sd, cb, data);
 	char *buf =3D g_try_new(char, 36 + length * 2);
 	int len, ret;
 =

@@ -712,7 +748,7 @@ error:
 static void at_csim_envelope_cb(gboolean ok, GAtResult *result,
 		gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
+	struct sim_cb_data *cbd =3D user_data;
 	GAtResultIter iter;
 	ofono_sim_read_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
@@ -735,13 +771,18 @@ static void at_csim_envelope_cb(gboolean ok, GAtResul=
t *result,
 	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
 		goto error;
 =

-	if (rlen !=3D len * 2 || len < 2 ||
-			response[len - 2] !=3D 0x90 || response[len - 1] !=3D 0)
+	if (rlen !=3D len * 2 || len < 2 || (response[len - 2] !=3D 0x90 &&
+				response[len - 2] !=3D 0x91) ||
+			(response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0))
 		goto error;
 =

 	DBG("csim_envelope_cb: %i", len);
 =

 	cb(&error, response, len - 2, cbd->data);
+
+	if (response[len - 2] =3D=3D 0x91)
+		ofono_sim_proactive_command_notify(cbd->sd->sim,
+				response[len - 1]);
 	return;
 =

 error:
@@ -753,7 +794,7 @@ static void at_sim_envelope(struct ofono_sim *sim, int =
length,
 				ofono_sim_read_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct sim_cb_data *cbd =3D sim_cb_data_new(sd, cb, data);
 	char *buf =3D g_try_new(char, 64 + length * 2);
 	int len, ret;
 =

@@ -761,12 +802,14 @@ static void at_sim_envelope(struct ofono_sim *sim, in=
t length,
 		goto error;
 =

 	len =3D sprintf(buf, "AT+CSIM=3D%i,A0C20000%02hhX",
-			10 + length * 2, length);
+			12 + length * 2, length);
 =

 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *command++);
 =

-	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
+	len +=3D sprintf(buf + len, "FF");
+
+	ret =3D g_at_chat_send(sd->chat, buf, csim_prefix,
 				at_csim_envelope_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -785,6 +828,219 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
 }
 =

+static void at_csim_status_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct sim_cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const guint8 *response;
+	gint rlen, len;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSIM:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &rlen))
+		goto error;
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
+		goto error;
+
+	if (rlen !=3D len * 2 || len < 2 || (response[len - 2] !=3D 0x90 &&
+				response[len - 2] !=3D 0x91) ||
+			(response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0))
+		goto error;
+
+	DBG("csim_status_cb: %i", len);
+
+	cb(&error, cbd->data);
+
+	if (response[len - 2] =3D=3D 0x91)
+		ofono_sim_proactive_command_notify(cbd->sd->sim,
+				response[len - 1]);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void at_sim_status(struct ofono_sim *sim, ofono_sim_cb_t cb, void *=
data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct sim_cb_data *cbd =3D sim_cb_data_new(sd, cb, data);
+	char buf[64];
+
+	if (!cbd)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CSIM=3D%i,A0F200C0", 8);
+
+	if (g_at_chat_send(sd->chat, buf, csim_prefix,
+				at_csim_status_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void at_csim_fetch_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct sim_cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const guint8 *response;
+	gint rlen, len;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSIM:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &rlen))
+		goto error;
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
+		goto error;
+
+	if (rlen !=3D len * 2 || len < 2 || (response[len - 2] !=3D 0x90 &&
+				response[len - 2] !=3D 0x91) ||
+			(response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0))
+		goto error;
+
+	DBG("csim_fetch_cb: %i", len);
+
+	cb(&error, response, len - 2, cbd->data);
+
+	/* Can this happen? */
+	if (response[len - 2] =3D=3D 0x91)
+		ofono_sim_proactive_command_notify(cbd->sd->sim,
+				response[len - 1]);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+}
+
+static void at_sim_fetch(struct ofono_sim *sim, int length,
+		ofono_sim_read_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct sim_cb_data *cbd =3D sim_cb_data_new(sd, cb, data);
+	char buf[64];
+
+	if (!cbd)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CSIM=3D%i,A0120000%02hhX", 10, length);
+
+	if (g_at_chat_send(sd->chat, buf, csim_prefix,
+				at_csim_fetch_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+}
+
+static void at_csim_terminal_response_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct sim_cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_write_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const guint8 *response;
+	gint rlen, len;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSIM:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &rlen))
+		goto error;
+
+	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
+		goto error;
+
+	if (rlen !=3D len * 2 || len < 2 || (response[len - 2] !=3D 0x90 &&
+				response[len - 2] !=3D 0x91) ||
+			(response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0))
+		goto error;
+
+	DBG("csim_terminal_response_cb: %i", len);
+
+	cb(&error, cbd->data);
+
+	if (response[len - 2] =3D=3D 0x91)
+		ofono_sim_proactive_command_notify(cbd->sd->sim,
+				response[len - 1]);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void at_sim_terminal_response(struct ofono_sim *sim, int length,
+		const unsigned char *value, ofono_sim_write_cb_t cb,
+		void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct sim_cb_data *cbd =3D sim_cb_data_new(sd, cb, data);
+	char *buf =3D g_try_new(char, 64 + length * 2);
+	int len, ret;
+
+	if (!cbd || !buf)
+		goto error;
+
+	len =3D sprintf(buf, "AT+CSIM=3D%i,A0140000%02hhX",
+			10 + length * 2, length);
+
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhX", *value++);
+
+	ret =3D g_at_chat_send(sd->chat, buf, csim_prefix,
+				at_csim_terminal_response_cb, cbd, g_free);
+
+	g_free(buf);
+	buf =3D NULL;
+
+	if (ret > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static gboolean at_sim_register(gpointer user)
 {
 	struct ofono_sim *sim =3D user;
@@ -803,6 +1059,7 @@ static int at_sim_probe(struct ofono_sim *sim, unsigne=
d int vendor,
 	sd =3D g_new0(struct sim_data, 1);
 	sd->chat =3D chat;
 	sd->vendor =3D vendor;
+	sd->sim =3D sim;
 =

 	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM)
 		g_at_chat_add_terminator(chat, "+CPIN:", 6, TRUE);
@@ -841,6 +1098,9 @@ static struct ofono_sim_driver driver =3D {
 	.change_passwd		=3D at_change_passwd,
 	.query_locked		=3D at_pin_query_enabled,
 	.envelope		=3D at_sim_envelope,
+	.status			=3D at_sim_status,
+	.fetch			=3D at_sim_fetch,
+	.terminal_response	=3D at_sim_terminal_response,
 };
 =

 void at_sim_init()
-- =

1.6.1


--===============8038658279900732079==--

