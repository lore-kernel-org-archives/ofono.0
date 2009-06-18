Content-Type: multipart/mixed; boundary="===============6665764807771812571=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Change sim_ops plugin interface to allow acces to linear
 fixed files
Date: Thu, 18 Jun 2009 05:44:44 +0200
Message-ID: <1245296684-15235-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6665764807771812571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

(iow record based files), both read and update access.
Implement writing sim files through AT.

Depends on "[PATCH] Use GET RESPONSE sim command to retrieve EF length."
---
 drivers/atmodem/sim.c |  199 +++++++++++++++++++++++++++++++++++++++++++--=
----
 src/driver.h          |   31 ++++++--
 src/sim.c             |   16 ++--
 3 files changed, 210 insertions(+), 36 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index a2aebb8..66e951e 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -41,20 +41,22 @@
 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 static const char *cnum_prefix[] =3D { "+CNUM:", NULL };
 =

-static void at_crsm_len_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct cb_data *cbd =3D user_data;
 	GAtResultIter iter;
-	ofono_sim_file_len_cb_t cb =3D cbd->cb;
+	ofono_sim_file_info_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 	const guint8 *response;
 	gint sw1, sw2, len;
+	int flen, rlen;
+	enum ofono_simfile_struct str;
 =

-	dump_response("at_crsm_len_cb", ok, result);
+	dump_response("at_crsm_info_cb", ok, result);
 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
-		cb(&error, -1, cbd->data);
+		cb(&error, -1, -1, -1, cbd->data);
 		return;
 	}
 =

@@ -63,29 +65,38 @@ static void at_crsm_len_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	if (!g_at_result_iter_next(&iter, "+CRSM:")) {
 		DECLARE_FAILURE(e);
 =

-		cb(&e, -1, cbd->data);
+		cb(&e, -1, -1, -1, cbd->data);
 		return;
 	}
 =

 	g_at_result_iter_next_number(&iter, &sw1);
-	g_at_result_iter_next_number(&iter, &len);
+	g_at_result_iter_next_number(&iter, &sw2);
 =

 	if (!g_at_result_iter_next_hexstring(&iter, &response, &len) ||
 		(sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92) ||
-		(sw1 =3D=3D 0x90 && sw2 !=3D 0x00) || len < 14) {
+		(sw1 =3D=3D 0x90 && sw2 !=3D 0x00) ||
+		len < 14 || response[6] !=3D 0x04 ||
+		(response[13] =3D=3D 0x01 && len < 15)) {
 		DECLARE_FAILURE(e);
 =

-		cb(&e, -1, cbd->data);
+		cb(&e, -1, -1, -1, cbd->data);
 		return;
 	}
 =

-	ofono_debug("crsm_len_cb: %02x, %02x, %i", sw1, sw2, len);
+	ofono_debug("crsm_info_cb: %02x, %02x, %i", sw1, sw2, len);
+
+	flen =3D (response[2] << 8) | response[3];
+	str =3D response[13];
+	if (str =3D=3D 0x01)
+		rlen =3D response[14];
+	else
+		rlen =3D 0;
 =

-	cb(&error, (response[2] << 8) | response[3], cbd->data);
+	cb(&error, flen, str, rlen, cbd->data);
 }
 =

-static void at_sim_read_file_len(struct ofono_modem *modem, int fileid,
-					ofono_sim_file_len_cb_t cb,
+static void at_sim_read_info(struct ofono_modem *modem, int fileid,
+					ofono_sim_file_info_cb_t cb,
 					void *data)
 {
 	struct at_data *at =3D ofono_modem_userdata(modem);
@@ -97,7 +108,7 @@ static void at_sim_read_file_len(struct ofono_modem *mod=
em, int fileid,
 =

 	snprintf(buf, sizeof(buf), "AT+CRSM=3D192,%i,0,0,15", fileid);
 	if (g_at_chat_send(at->parser, buf, crsm_prefix,
-				at_crsm_len_cb, cbd, g_free) > 0)
+				at_crsm_info_cb, cbd, g_free) > 0)
 		return;
 =

 error:
@@ -106,11 +117,12 @@ error:
 =

 	{
 		DECLARE_FAILURE(error);
-		cb(&error, -1, data);
+		cb(&error, -1, -1, -1, data);
 	}
 }
 =

-static void at_crsm_cb(gboolean ok, GAtResult *result, gpointer user_data)
+static void at_crsm_read_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	GAtResultIter iter;
@@ -119,7 +131,7 @@ static void at_crsm_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	const guint8 *response;
 	gint sw1, sw2, len;
 =

-	dump_response("at_crsm_cb", ok, result);
+	dump_response("at_crsm_read_cb", ok, result);
 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
@@ -147,14 +159,14 @@ static void at_crsm_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		return;
 	}
 =

-	ofono_debug("crsm_cb: %02x, %02x, %d", sw1, sw2, len);
+	ofono_debug("crsm_read_cb: %02x, %02x, %d", sw1, sw2, len);
 =

 	cb(&error, response, len, cbd->data);
 }
 =

-static void at_sim_read_file(struct ofono_modem *modem, int fileid, int st=
art,
-					int length, ofono_sim_read_cb_t cb,
-					void *data)
+static void at_sim_read_binary(struct ofono_modem *modem, int fileid,
+					int start, int length,
+					ofono_sim_read_cb_t cb, void *data)
 {
 	struct at_data *at =3D ofono_modem_userdata(modem);
 	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
@@ -166,7 +178,34 @@ static void at_sim_read_file(struct ofono_modem *modem=
, int fileid, int start,
 	snprintf(buf, sizeof(buf), "AT+CRSM=3D176,%i,%i,%i,%i", fileid,
 			start >> 8, start & 0xff, length);
 	if (g_at_chat_send(at->parser, buf, crsm_prefix,
-				at_crsm_cb, cbd, g_free) > 0)
+				at_crsm_read_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, NULL, 0, data);
+	}
+}
+
+static void at_sim_read_record(struct ofono_modem *modem, int fileid,
+					int record, int length,
+					ofono_sim_read_cb_t cb, void *data)
+{
+	struct at_data *at =3D ofono_modem_userdata(modem);
+	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
+	char buf[64];
+
+	if (!cbd)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CRSM=3D178,%i,%i,4,%i", fileid,
+			record + 1, length);
+	if (g_at_chat_send(at->parser, buf, crsm_prefix,
+				at_crsm_read_cb, cbd, g_free) > 0)
 		return;
 =

 error:
@@ -179,6 +218,117 @@ error:
 	}
 }
 =

+static void at_crsm_update_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_generic_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	gint sw1, sw2;
+
+	dump_response("at_crsm_update_cb", ok, result);
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CRSM:")) {
+		DECLARE_FAILURE(e);
+
+		cb(&e, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_next_number(&iter, &sw1);
+	g_at_result_iter_next_number(&iter, &sw2);
+	if ((sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) ||
+		(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
+		DECLARE_FAILURE(e);
+
+		cb(&e, cbd->data);
+		return;
+	}
+
+	ofono_debug("crsm_update_cb: %02x, %02x", sw1, sw2);
+
+	cb(&error, cbd->data);
+}
+
+static void at_sim_update_binary(struct ofono_modem *modem, int fileid,
+					int start, int length,
+					const unsigned char *value,
+					ofono_generic_cb_t cb, void *data)
+{
+	struct at_data *at =3D ofono_modem_userdata(modem);
+	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
+	char *buf =3D g_try_new(char, 36 + length * 2);
+	int len, ret;
+
+	if (!cbd || !buf)
+		goto error;
+
+	len =3D sprintf(buf, "AT+CRSM=3D214,%i,%i,%i,%i,", fileid,
+			start >> 8, start & 0xff, length);
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhx", *value++);
+	ret =3D g_at_chat_send(at->parser, buf, crsm_prefix,
+				at_crsm_update_cb, cbd, g_free);
+
+	g_free(buf);
+
+	if (ret > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, data);
+	}
+}
+
+static void at_sim_update_record(struct ofono_modem *modem, int fileid,
+					int record, int length,
+					const unsigned char *value,
+					ofono_generic_cb_t cb, void *data)
+{
+	struct at_data *at =3D ofono_modem_userdata(modem);
+	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
+	char *buf =3D g_try_new(char, 36 + length * 2);
+	int len, ret;
+
+	if (!cbd || !buf)
+		goto error;
+
+	len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid,
+			record + 1, length);
+	for (; length; length--)
+		len +=3D sprintf(buf + len, "%02hhx", *value++);
+	ret =3D g_at_chat_send(at->parser, buf, crsm_prefix,
+				at_crsm_update_cb, cbd, g_free);
+
+	g_free(buf);
+
+	if (ret > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	{
+		DECLARE_FAILURE(error);
+		cb(&error, data);
+	}
+}
+
 static void at_cimi_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -317,8 +467,11 @@ error:
 }
 =

 static struct ofono_sim_ops ops =3D {
-	.read_file_len 		=3D at_sim_read_file_len,
-	.read_file 		=3D at_sim_read_file,
+	.read_file_info		=3D at_sim_read_info,
+	.read_file_transparent	=3D at_sim_read_binary,
+	.read_file_linear	=3D at_sim_read_record,
+	.write_file_transparent	=3D at_sim_update_binary,
+	.write_file_linear	=3D at_sim_update_record,
 	.read_imsi		=3D at_read_imsi,
 	.read_own_numbers	=3D at_read_msisdn,
 };
diff --git a/src/driver.h b/src/driver.h
index 61504dd..36b9a08 100644
--- a/src/driver.h
+++ b/src/driver.h
@@ -98,6 +98,13 @@ struct ofono_own_number {
 	int itc;
 };
 =

+/* 51.011 Section 9.3 */
+enum ofono_simfile_struct {
+	OFONO_SIM_FILE_TRANSPARENT =3D 0,
+	OFONO_SIM_FILE_FIXED =3D 1,
+	OFONO_SIM_FILE_CYCLIC =3D 3
+};
+
 /* Notification functions, the integer values here should map to
  * values obtained from the modem.  The enumerations are the same
  * as the values for the fields found in 3GPP TS 27.007
@@ -156,8 +163,10 @@ typedef void (*ofono_call_meter_puct_query_cb_t)(const=
 struct ofono_error *error
 typedef void (*ofono_call_barring_cb_t)(const struct ofono_error *error,
 					int status, void *data);
 =

-typedef void (*ofono_sim_file_len_cb_t)(const struct ofono_error *error,
-					int length, void *data);
+typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
+					int filelength,
+					enum ofono_simfile_struct structure,
+					int recordlength, void *data);
 =

 typedef void (*ofono_sim_read_cb_t)(const struct ofono_error *error,
 					const unsigned char *sdata, int length,
@@ -363,10 +372,20 @@ int ofono_call_barring_register(struct ofono_modem *m=
odem,
 void ofono_call_barring_unregister(struct ofono_modem *modem);
 =

 struct ofono_sim_ops {
-	void (*read_file_len)(struct ofono_modem *modem, int fileid,
-			ofono_sim_file_len_cb_t cb, void *data);
-	void (*read_file)(struct ofono_modem *modem, int fileid, int start,
-			int length, ofono_sim_read_cb_t cb, void *data);
+	void (*read_file_info)(struct ofono_modem *modem, int fileid,
+			ofono_sim_file_info_cb_t cb, void *data);
+	void (*read_file_transparent)(struct ofono_modem *modem, int fileid,
+			int start, int length,
+			ofono_sim_read_cb_t cb, void *data);
+	void (*read_file_linear)(struct ofono_modem *modem, int fileid,
+			int record, int length,
+			ofono_sim_read_cb_t cb, void *data);
+	void (*write_file_transparent)(struct ofono_modem *modem, int fileid,
+			int start, int length, const unsigned char *value,
+			ofono_generic_cb_t cb, void *data);
+	void (*write_file_linear)(struct ofono_modem *modem, int fileid,
+			int record, int length, const unsigned char *value,
+			ofono_generic_cb_t cb, void *data);
 	void (*read_imsi)(struct ofono_modem *modem,
 			ofono_imsi_cb_t cb, void *data);
 	void (*read_own_numbers)(struct ofono_modem *modem,
diff --git a/src/sim.c b/src/sim.c
index acec7bb..9c85292 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -237,16 +237,18 @@ static void sim_spn_read_cb(const struct ofono_error =
*error,
 		sim_spn_notify(modem, l->data);
 }
 =

-static void sim_spn_len_cb(const struct ofono_error *error,
-		int length, void *data)
+static void sim_spn_info_cb(const struct ofono_error *error,
+		int length, enum ofono_simfile_struct structure, int dummy,
+		void *data)
 {
 	struct ofono_modem *modem =3D data;
 	struct sim_manager_data *sim =3D modem->sim_manager;
 =

-	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || length <=3D 1)
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || length <=3D 1 ||
+			structure !=3D OFONO_SIM_FILE_TRANSPARENT)
 		return;
 =

-	sim->ops->read_file(modem, SIM_EFSPN_FILEID, 0, length,
+	sim->ops->read_file_transparent(modem, SIM_EFSPN_FILEID, 0, length,
 			sim_spn_read_cb, modem);
 }
 =

@@ -255,8 +257,8 @@ static gboolean sim_retrieve_spn(void *user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct sim_manager_data *sim =3D modem->sim_manager;
 =

-	sim->ops->read_file_len(modem, SIM_EFSPN_FILEID,
-			sim_spn_len_cb, modem);
+	sim->ops->read_file_info(modem, SIM_EFSPN_FILEID,
+			sim_spn_info_cb, modem);
 =

 	return FALSE;
 }
@@ -341,7 +343,7 @@ static void initialize_sim_manager(struct ofono_modem *=
modem)
 =

 	modem_add_interface(modem, SIM_MANAGER_INTERFACE);
 =

-	if (modem->sim_manager->ops->read_file)
+	if (modem->sim_manager->ops->read_file_transparent)
 		g_timeout_add(0, sim_retrieve_spn, modem);
 =

 	if (modem->sim_manager->ops->read_imsi)
-- =

1.6.0


--===============6665764807771812571==--

