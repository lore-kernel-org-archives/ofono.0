Content-Type: multipart/mixed; boundary="===============2946729618890581777=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 02/10] atmodem: export struct netreg
Date: Thu, 18 Jul 2019 12:23:06 +0200
Message-ID: <20190718102314.28094-2-jonas@norrbonn.se>
In-Reply-To: <20190718102314.28094-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2946729618890581777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to do inheritance by composition.
---
 drivers/atmodem/network-registration.c | 94 +++++++++++---------------
 drivers/atmodem/network-registration.h | 14 ++++
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 0f83977b..cc702c2c 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -53,20 +53,6 @@ static const char *smoni_prefix[] =3D { "^SMONI:", NULL =
};
 static const char *zpas_prefix[] =3D { "+ZPAS:", NULL };
 static const char *option_tech_prefix[] =3D { "_OCTI:", "_OUWCTI:", NULL };
 =

-struct netreg_data {
-	GAtChat *chat;
-	char mcc[OFONO_MAX_MCC_LENGTH + 1];
-	char mnc[OFONO_MAX_MNC_LENGTH + 1];
-	int signal_index; /* If strength is reported via CIND */
-	int signal_min; /* min strength reported via CIND */
-	int signal_max; /* max strength reported via CIND */
-	int signal_invalid; /* invalid strength reported via CIND */
-	int tech;
-	struct ofono_network_time time;
-	guint nitz_timeout;
-	unsigned int vendor;
-};
-
 struct tech_query {
 	int status;
 	int lac;
@@ -211,7 +197,7 @@ static void at_creg_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	ofono_netreg_status_cb_t cb =3D cbd->cb;
 	int status, lac, ci, tech;
 	struct ofono_error error;
-	struct netreg_data *nd =3D cbd->user;
+	struct at_netreg_data *nd =3D cbd->user;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 =

@@ -252,7 +238,7 @@ static void zte_tech_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	struct ofono_netreg *netreg =3D cbd->data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

 	if (ok)
 		nd->tech =3D zte_parse_tech(result);
@@ -264,7 +250,7 @@ static void option_tech_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	struct ofono_netreg *netreg =3D cbd->data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

 	if (ok)
 		nd->tech =3D option_parse_tech(result);
@@ -276,7 +262,7 @@ void at_registration_status(struct ofono_netreg *netreg,
 					ofono_netreg_status_cb_t cb,
 					void *data)
 {
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	cbd->user =3D nd;
@@ -339,7 +325,7 @@ void at_registration_status(struct ofono_netreg *netreg,
 static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(cbd->user);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(cbd->user);
 	ofono_netreg_operator_cb_t cb =3D cbd->cb;
 	struct ofono_network_operator op;
 	GAtResultIter iter;
@@ -400,7 +386,7 @@ error:
 static void cops_numeric_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(cbd->user);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(cbd->user);
 	ofono_netreg_operator_cb_t cb =3D cbd->cb;
 	GAtResultIter iter;
 	const char *str;
@@ -455,7 +441,7 @@ error:
 void at_current_operator(struct ofono_netreg *netreg,
 				ofono_netreg_operator_cb_t cb, void *data)
 {
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	gboolean ok;
 =

@@ -594,7 +580,7 @@ static void cops_list_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 void at_list_operators(struct ofono_netreg *netreg,
 				ofono_netreg_operator_list_cb_t cb, void *data)
 {
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (g_at_chat_send(nd->chat, "AT+COPS=3D?", cops_prefix,
@@ -620,7 +606,7 @@ static void register_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 void at_register_auto(struct ofono_netreg *netreg,
 				ofono_netreg_register_cb_t cb, void *data)
 {
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (g_at_chat_send(nd->chat, "AT+COPS=3D0", none_prefix,
@@ -636,7 +622,7 @@ void at_register_manual(struct ofono_netreg *netreg,
 				const char *mcc, const char *mnc,
 				ofono_netreg_register_cb_t cb, void *data)
 {
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[128];
 =

@@ -725,7 +711,7 @@ static void ifx_xhomezr_notify(GAtResult *result, gpoin=
ter user_data)
 static void ifx_xreg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int state;
 	const char *band;
 	GAtResultIter iter;
@@ -824,7 +810,7 @@ static void ifx_xcsq_notify(GAtResult *result, gpointer=
 user_data)
 static void ciev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int strength, ind;
 	GAtResultIter iter;
 =

@@ -853,7 +839,7 @@ static void ciev_notify(GAtResult *result, gpointer use=
r_data)
 static void telit_ciev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	const char *signal_identifier =3D "rssi";
 	const char *ind_str;
 	int strength;
@@ -884,7 +870,7 @@ static void telit_ciev_notify(GAtResult *result, gpoint=
er user_data)
 static void gemalto_ciev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	const char *signal_identifier =3D "rssi";
 	const char *ind_str;
 	int strength;
@@ -917,7 +903,7 @@ static void gemalto_ciev_notify(GAtResult *result, gpoi=
nter user_data)
 static void ctzv_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	const char *tz;
 	GAtResultIter iter;
 =

@@ -939,7 +925,7 @@ static void ctzv_notify(GAtResult *result, gpointer use=
r_data)
 static void tlts_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int year, mon, mday, hour, min, sec;
 	char tz[4];
 	const char *time;
@@ -974,7 +960,7 @@ static void tlts_notify(GAtResult *result, gpointer use=
r_data)
 static gboolean notify_time(gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

 	nd->nitz_timeout =3D 0;
 =

@@ -986,7 +972,7 @@ static gboolean notify_time(gpointer user_data)
 static void ifx_ctzv_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int year, mon, mday, hour, min, sec;
 	const char *tz, *time;
 	GAtResultIter iter;
@@ -1024,7 +1010,7 @@ static void ifx_ctzv_notify(GAtResult *result, gpoint=
er user_data)
 static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int dst;
 	GAtResultIter iter;
 =

@@ -1052,7 +1038,7 @@ static void cind_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_netreg_strength_cb_t cb =3D cbd->cb;
-	struct netreg_data *nd =3D cbd->user;
+	struct at_netreg_data *nd =3D cbd->user;
 	int index;
 	int strength;
 	GAtResultIter iter;
@@ -1106,7 +1092,7 @@ static void huawei_rssi_notify(GAtResult *result, gpo=
inter user_data)
 static void huawei_mode_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 	int mode, submode;
 =

@@ -1134,7 +1120,7 @@ static void huawei_mode_notify(GAtResult *result, gpo=
inter user_data)
 static void huawei_hcsq_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 	const char *mode;
 =

@@ -1155,7 +1141,7 @@ static void huawei_hcsq_notify(GAtResult *result, gpo=
inter user_data)
 static void huawei_nwtime_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int year, mon, mday, hour, min, sec;
 	char tz[4];
 	const char *date, *time, *dst;
@@ -1233,7 +1219,7 @@ static void csq_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 void at_signal_strength(struct ofono_netreg *netreg,
 				ofono_netreg_strength_cb_t cb, void *data)
 {
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	cbd->user =3D nd;
@@ -1260,7 +1246,7 @@ void at_signal_strength(struct ofono_netreg *netreg,
 static void mbm_etzv_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int year, mon, mday, hour, min, sec;
 	const char *tz, *time, *timestamp;
 	GAtResultIter iter;
@@ -1309,7 +1295,7 @@ static void mbm_etzv_notify(GAtResult *result, gpoint=
er user_data)
 static void mbm_erinfo_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 	int mode, gsm, umts;
 =

@@ -1361,7 +1347,7 @@ static void mbm_erinfo_notify(GAtResult *result, gpoi=
nter user_data)
 static void icera_nwstate_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 	const char *mccmnc, *tech, *state;
 	int rssi;
@@ -1429,7 +1415,7 @@ static int cnti_to_tech(const char *cnti)
 static void gobi_cnti_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 	const char *tech;
 	int option;
@@ -1454,7 +1440,7 @@ static void gobi_cnti_notify(GAtResult *result, gpoin=
ter user_data)
 static void nw_cnti_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 	const char *tech;
 	int option;
@@ -1480,7 +1466,7 @@ static void cnti_query_tech_cb(gboolean ok, GAtResult=
 *result,
 						gpointer user_data)
 {
 	struct tech_query *tq =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
 =

 	ofono_netreg_status_notify(tq->netreg,
 			tq->status, tq->lac, tq->ci, nd->tech);
@@ -1520,7 +1506,7 @@ static void creg_notify(GAtResult *result, gpointer u=
ser_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
 	int status, lac, ci, tech;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct tech_query *tq;
 =

 	if (at_util_parse_reg_unsolicited(result, "+CREG:", &status,
@@ -1589,7 +1575,7 @@ static void at_cmer_not_supported(struct ofono_netreg=
 *netreg)
 static void at_cmer_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

 	if (!ok) {
 		at_cmer_not_supported(netreg);
@@ -1648,7 +1634,7 @@ static inline ofono_bool_t append_cmer_element(char *=
buf, int *len, int cap,
 }
 =

 static ofono_bool_t build_cmer_string(char *buf, int *cmer_opts,
-					struct netreg_data *nd)
+					struct at_netreg_data *nd)
 {
 	const char *ind;
 	int len =3D sprintf(buf, "AT+CMER=3D");
@@ -1717,7 +1703,7 @@ static void at_cmer_query_cb(ofono_bool_t ok, GAtResu=
lt *result,
 				gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 	int cmer_opts_cnt =3D 5; /* See 27.007 Section 8.10 */
 	int cmer_opts[cmer_opts_cnt];
@@ -1765,7 +1751,7 @@ error:
 static void cind_support_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 	const char *str;
 	char *signal_identifier =3D "signal";
@@ -1872,7 +1858,7 @@ error:
 static void at_creg_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

 	if (!ok) {
 		ofono_error("Unable to initialize Network Registration");
@@ -2075,7 +2061,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 static void at_creg_test_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	gint range[2];
 	GAtResultIter iter;
 	int creg1 =3D 0;
@@ -2123,9 +2109,9 @@ static int at_netreg_probe(struct ofono_netreg *netre=
g, unsigned int vendor,
 				void *data)
 {
 	GAtChat *chat =3D data;
-	struct netreg_data *nd;
+	struct at_netreg_data *nd;
 =

-	nd =3D g_new0(struct netreg_data, 1);
+	nd =3D g_new0(struct at_netreg_data, 1);
 =

 	nd->chat =3D g_at_chat_clone(chat);
 	nd->vendor =3D vendor;
@@ -2148,7 +2134,7 @@ static int at_netreg_probe(struct ofono_netreg *netre=
g, unsigned int vendor,
 =

 void at_netreg_remove(struct ofono_netreg *netreg)
 {
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

 	if (nd->nitz_timeout)
 		g_source_remove(nd->nitz_timeout);
diff --git a/drivers/atmodem/network-registration.h b/drivers/atmodem/netwo=
rk-registration.h
index 0f622411..8a5401cf 100644
--- a/drivers/atmodem/network-registration.h
+++ b/drivers/atmodem/network-registration.h
@@ -1,5 +1,19 @@
 #pragma once
 =

+struct at_netreg_data {
+	GAtChat *chat;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	int signal_index; /* If strength is reported via CIND */
+	int signal_min; /* min strength reported via CIND */
+	int signal_max; /* max strength reported via CIND */
+	int signal_invalid; /* invalid strength reported via CIND */
+	int tech;
+	struct ofono_network_time time;
+	guint nitz_timeout;
+	unsigned int vendor;
+};
+
 void at_registration_status(struct ofono_netreg *netreg,
 					ofono_netreg_status_cb_t cb,
 					void *data);
-- =

2.20.1


--===============2946729618890581777==--

