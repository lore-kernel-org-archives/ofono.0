Content-Type: multipart/mixed; boundary="===============6042136582389950588=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] Work around Palm Pre SIM file reading quirk.
Date: Tue, 10 Nov 2009 07:30:10 +0100
Message-ID: <1257834610-22409-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6042136582389950588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm not sure if MSM is not a too generic name but it seems the G1's
Qualcomm MSM suffers from similar problems.
---
 drivers/atmodem/sim.c    |   72 ++++++++++++++++++++++++++++--------------=
---
 drivers/atmodem/vendor.h |    1 +
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index b14ddda..f28f663 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -37,9 +37,15 @@
 #include "gatchat.h"
 #include "gatresult.h"
 #include "simutil.h"
+#include "vendor.h"
 =

 #include "atmodem.h"
 =

+struct sim_data {
+	GAtChat *chat;
+	unsigned int vendor;
+};
+
 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -98,7 +104,7 @@ static void at_sim_read_info(struct ofono_sim *sim, int =
fileid,
 					ofono_sim_file_info_cb_t cb,
 					void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

@@ -107,7 +113,10 @@ static void at_sim_read_info(struct ofono_sim *sim, in=
t fileid,
 =

 	snprintf(buf, sizeof(buf), "AT+CRSM=3D192,%i", fileid);
 =

-	if (g_at_chat_send(chat, buf, crsm_prefix,
+	if (sd->vendor =3D=3D OFONO_VENDOR_MSM)
+		strcat(buf, ",0,0,255"); /* Maximum possible length */
+
+	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_info_cb, cbd, g_free) > 0)
 		return;
 =

@@ -162,7 +171,7 @@ static void at_sim_read_binary(struct ofono_sim *sim, i=
nt fileid,
 					int start, int length,
 					ofono_sim_read_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

@@ -172,7 +181,7 @@ static void at_sim_read_binary(struct ofono_sim *sim, i=
nt fileid,
 	snprintf(buf, sizeof(buf), "AT+CRSM=3D176,%i,%i,%i,%i", fileid,
 			start >> 8, start & 0xff, length);
 =

-	if (g_at_chat_send(chat, buf, crsm_prefix,
+	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_read_cb, cbd, g_free) > 0)
 		return;
 =

@@ -187,7 +196,7 @@ static void at_sim_read_record(struct ofono_sim *sim, i=
nt fileid,
 					int record, int length,
 					ofono_sim_read_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

@@ -197,7 +206,7 @@ static void at_sim_read_record(struct ofono_sim *sim, i=
nt fileid,
 	snprintf(buf, sizeof(buf), "AT+CRSM=3D178,%i,%i,4,%i", fileid,
 			record, length);
 =

-	if (g_at_chat_send(chat, buf, crsm_prefix,
+	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_read_cb, cbd, g_free) > 0)
 		return;
 =

@@ -251,7 +260,7 @@ static void at_sim_update_binary(struct ofono_sim *sim,=
 int fileid,
 					const unsigned char *value,
 					ofono_sim_write_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char *buf =3D g_try_new(char, 36 + length * 2);
 	int len, ret;
@@ -265,7 +274,7 @@ static void at_sim_update_binary(struct ofono_sim *sim,=
 int fileid,
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhx", *value++);
 =

-	ret =3D g_at_chat_send(chat, buf, crsm_prefix,
+	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_update_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -285,7 +294,7 @@ static void at_sim_update_record(struct ofono_sim *sim,=
 int fileid,
 					const unsigned char *value,
 					ofono_sim_write_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char *buf =3D g_try_new(char, 36 + length * 2);
 	int len, ret;
@@ -299,7 +308,7 @@ static void at_sim_update_record(struct ofono_sim *sim,=
 int fileid,
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhx", *value++);
 =

-	ret =3D g_at_chat_send(chat, buf, crsm_prefix,
+	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_update_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -318,7 +327,7 @@ static void at_sim_update_cyclic(struct ofono_sim *sim,=
 int fileid,
 					int length, const unsigned char *value,
 					ofono_sim_write_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char *buf =3D g_try_new(char, 36 + length * 2);
 	int len, ret;
@@ -331,7 +340,7 @@ static void at_sim_update_cyclic(struct ofono_sim *sim,=
 int fileid,
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhx", *value++);
 =

-	ret =3D g_at_chat_send(chat, buf, crsm_prefix,
+	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_update_cb, cbd, g_free);
 =

 	g_free(buf);
@@ -378,13 +387,13 @@ static void at_cimi_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 static void at_read_imsi(struct ofono_sim *sim, ofono_sim_imsi_cb_t cb,
 			void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(chat, "AT+CIMI", NULL,
+	if (g_at_chat_send(sd->chat, "AT+CIMI", NULL,
 				at_cimi_cb, cbd, g_free) > 0)
 		return;
 =

@@ -466,13 +475,13 @@ static void at_cpin_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 static void at_pin_query(struct ofono_sim *sim, ofono_sim_passwd_cb_t cb,
 			void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (!cbd)
 		goto error;
 =

-	if (g_at_chat_send(chat, "AT+CPIN?", NULL,
+	if (g_at_chat_send(sd->chat, "AT+CPIN?", NULL,
 				at_cpin_cb, cbd, g_free) > 0)
 		return;
 =

@@ -499,7 +508,7 @@ static void at_lock_unlock_cb(gboolean ok, GAtResult *r=
esult,
 static void at_pin_send(struct ofono_sim *sim, const char *passwd,
 			ofono_sim_lock_unlock_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 	int ret;
@@ -509,7 +518,8 @@ static void at_pin_send(struct ofono_sim *sim, const ch=
ar *passwd,
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
 =

-	ret =3D g_at_chat_send(chat, buf, NULL, at_lock_unlock_cb, cbd, g_free);
+	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -527,7 +537,7 @@ static void at_pin_send_puk(struct ofono_sim *sim, cons=
t char *puk,
 				const char *passwd,
 				ofono_sim_lock_unlock_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 	int ret;
@@ -537,7 +547,8 @@ static void at_pin_send_puk(struct ofono_sim *sim, cons=
t char *puk,
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

-	ret =3D g_at_chat_send(chat, buf, NULL, at_lock_unlock_cb, cbd, g_free);
+	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -567,7 +578,7 @@ static void at_pin_enable(struct ofono_sim *sim,
 				int enable, const char *passwd,
 				ofono_sim_lock_unlock_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 	int ret;
@@ -582,7 +593,8 @@ static void at_pin_enable(struct ofono_sim *sim,
 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",%i,\"%s\"",
 			at_clck_cpwd_fac[passwd_type], enable ? 1 : 0, passwd);
 =

-	ret =3D g_at_chat_send(chat, buf, NULL, at_lock_unlock_cb, cbd, g_free);
+	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -601,7 +613,7 @@ static void at_change_passwd(struct ofono_sim *sim,
 			const char *old, const char *new,
 			ofono_sim_lock_unlock_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 	int ret;
@@ -617,7 +629,8 @@ static void at_change_passwd(struct ofono_sim *sim,
 	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
 			at_clck_cpwd_fac[passwd_type], old, new);
 =

-	ret =3D g_at_chat_send(chat, buf, NULL, at_lock_unlock_cb, cbd, g_free);
+	ret =3D g_at_chat_send(sd->chat, buf, NULL,
+				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -666,7 +679,7 @@ static void at_pin_query_enabled(struct ofono_sim *sim,
 				enum ofono_sim_password_type passwd_type,
 				ofono_sim_locked_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_sim_get_data(sim);
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fac);
@@ -680,7 +693,7 @@ static void at_pin_query_enabled(struct ofono_sim *sim,
 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2",
 			at_clck_cpwd_fac[passwd_type]);
 =

-	if (g_at_chat_send(chat, buf, NULL,
+	if (g_at_chat_send(sd->chat, buf, NULL,
 				at_lock_status_cb, cbd, g_free) > 0)
 		return;
 =

@@ -704,8 +717,13 @@ static int at_sim_probe(struct ofono_sim *sim, unsigne=
d int vendor,
 				void *data)
 {
 	GAtChat *chat =3D data;
+	struct sim_data *sd;
+
+	sd =3D g_new0(struct sim_data, 1);
+	sd->chat =3D chat;
+	sd->vendor =3D vendor;
 =

-	ofono_sim_set_data(sim, chat);
+	ofono_sim_set_data(sim, sd);
 	g_idle_add(at_sim_register, sim);
 =

 	return 0;
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index d88444f..5c2613c 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -23,4 +23,5 @@ enum ofono_vendor {
 	OFONO_VENDOR_GENERIC =3D 0,
 	OFONO_VENDOR_HTC_G1,
 	OFONO_VENDOR_CALYPSO,
+	OFONO_VENDOR_MSM,
 };
-- =

1.6.1


--===============6042136582389950588==--

