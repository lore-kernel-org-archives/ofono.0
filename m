Content-Type: multipart/mixed; boundary="===============0211260565319497261=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 09/10] call-meter: Unregister AT notifiers when removing
Date: Tue, 10 Aug 2010 22:43:48 +0800
Message-ID: <1281451429-17257-10-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0211260565319497261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unregister AT notifiers when removing call-meter at modem driver.
---
 drivers/atmodem/call-meter.c |   55 ++++++++++++++++++++++++++++----------=
---
 1 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index 38774d4..f36ff3c 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -45,6 +45,12 @@ static const char *cacm_prefix[] =3D { "+CACM:", NULL };
 static const char *camm_prefix[] =3D { "+CAMM:", NULL };
 static const char *cpuc_prefix[] =3D { "+CPUC:", NULL };
 =

+struct cm_data {
+	GAtChat *chat;
+	guint cccm_id;
+	guint ccwv_id;
+};
+
 static void caoc_cacm_camm_query_cb(gboolean ok,
 		GAtResult *result, gpointer user_data)
 {
@@ -113,14 +119,14 @@ static void at_caoc_query(struct ofono_call_meter *cm,
 				ofono_call_meter_query_cb_t cb,
 				void *data)
 {
-	GAtChat *chat =3D ofono_call_meter_get_data(cm);
+	struct cm_data *cd =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (!cbd)
 		goto error;
 =

 	cbd->user =3D "+CAOC:";
-	if (g_at_chat_send(chat, "AT+CAOC=3D0", caoc_prefix,
+	if (g_at_chat_send(cd->chat, "AT+CAOC=3D0", caoc_prefix,
 				caoc_cacm_camm_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -135,14 +141,14 @@ static void at_cacm_query(struct ofono_call_meter *cm,
 				ofono_call_meter_query_cb_t cb,
 				void *data)
 {
-	GAtChat *chat =3D ofono_call_meter_get_data(cm);
+	struct cm_data *cd =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (!cbd)
 		goto error;
 =

 	cbd->user =3D "+CACM:";
-	if (g_at_chat_send(chat, "AT+CACM?", cacm_prefix,
+	if (g_at_chat_send(cd->chat, "AT+CACM?", cacm_prefix,
 				caoc_cacm_camm_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -167,7 +173,7 @@ static void generic_set_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 static void at_cacm_set(struct ofono_call_meter *cm, const char *passwd,
 			ofono_call_meter_set_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_call_meter_get_data(cm);
+	struct cm_data *cd =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

@@ -176,7 +182,7 @@ static void at_cacm_set(struct ofono_call_meter *cm, co=
nst char *passwd,
 =

 	snprintf(buf, sizeof(buf), "AT+CACM=3D\"%s\"", passwd);
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send(cd->chat, buf, none_prefix,
 				generic_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -191,14 +197,14 @@ static void at_camm_query(struct ofono_call_meter *cm,
 				ofono_call_meter_query_cb_t cb,
 				void *data)
 {
-	GAtChat *chat =3D ofono_call_meter_get_data(cm);
+	struct cm_data *cd =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (!cbd)
 		goto error;
 =

 	cbd->user =3D "+CAMM:";
-	if (g_at_chat_send(chat, "AT+CAMM?", camm_prefix,
+	if (g_at_chat_send(cd->chat, "AT+CAMM?", camm_prefix,
 				caoc_cacm_camm_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -213,7 +219,7 @@ static void at_camm_set(struct ofono_call_meter *cm,
 			int accmax, const char *passwd,
 			ofono_call_meter_set_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_call_meter_get_data(cm);
+	struct cm_data *cd =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

@@ -222,7 +228,7 @@ static void at_camm_set(struct ofono_call_meter *cm,
 =

 	snprintf(buf, sizeof(buf), "AT+CAMM=3D\"%06X\",\"%s\"", accmax, passwd);
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send(cd->chat, buf, none_prefix,
 				generic_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -276,14 +282,14 @@ error:
 static void at_cpuc_query(struct ofono_call_meter *cm,
 				ofono_call_meter_puct_query_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_call_meter_get_data(cm);
+	struct cm_data *cd =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (!cbd)
 		goto error;
 =

 	cbd->user =3D "+CPUC:";
-	if (g_at_chat_send(chat, "AT+CPUC?", cpuc_prefix,
+	if (g_at_chat_send(cd->chat, "AT+CPUC?", cpuc_prefix,
 				cpuc_query_cb, cbd, g_free) > 0)
 		return;
 =

@@ -298,7 +304,7 @@ static void at_cpuc_set(struct ofono_call_meter *cm, co=
nst char *currency,
 			double ppu, const char *passwd,
 			ofono_call_meter_set_cb_t cb, void *data)
 {
-	GAtChat *chat =3D ofono_call_meter_get_data(cm);
+	struct cm_data *cd =3D ofono_call_meter_get_data(cm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 =

@@ -308,7 +314,7 @@ static void at_cpuc_set(struct ofono_call_meter *cm, co=
nst char *currency,
 	snprintf(buf, sizeof(buf), "AT+CPUC=3D\"%s\",\"%f\",\"%s\"",
 			currency, ppu, passwd);
 =

-	if (g_at_chat_send(chat, buf, none_prefix,
+	if (g_at_chat_send(cd->chat, buf, none_prefix,
 				generic_set_cb, cbd, g_free) > 0)
 		return;
 =

@@ -335,10 +341,12 @@ static void at_call_meter_initialized(gboolean ok, GA=
tResult *result,
 					gpointer user_data)
 {
 	struct ofono_call_meter *cm =3D user_data;
-	GAtChat *chat =3D ofono_call_meter_get_data(cm);
+	struct cm_data *cd =3D ofono_call_meter_get_data(cm);
 =

-	g_at_chat_register(chat, "+CCCM:", cccm_notify, FALSE, cm, NULL);
-	g_at_chat_register(chat, "+CCWV", ccwv_notify, FALSE, cm, NULL);
+	cd->cccm_id =3D g_at_chat_register(cd->chat, "+CCCM:", cccm_notify, FALSE,
+						cm, NULL);
+	cd->ccwv_id =3D g_at_chat_register(cd->chat, "+CCWV", ccwv_notify, FALSE,
+						cm, NULL);
 =

 	ofono_call_meter_register(cm);
 }
@@ -347,8 +355,13 @@ static int at_caoc_probe(struct ofono_call_meter *cm, =
unsigned int vendor,
 				void *data)
 {
 	GAtChat *chat =3D data;
+	struct cm_data *cd;
+
+	cd =3D g_new0(struct cm_data, 1);
 =

-	ofono_call_meter_set_data(cm, chat);
+	cd->chat =3D chat;
+
+	ofono_call_meter_set_data(cm, cd);
 =

 	g_at_chat_send(chat, "AT+CAOC=3D2", NULL, NULL, NULL, NULL);
 	g_at_chat_send(chat, "AT+CCWE=3D1", NULL,
@@ -359,6 +372,12 @@ static int at_caoc_probe(struct ofono_call_meter *cm, =
unsigned int vendor,
 =

 static void at_caoc_remove(struct ofono_call_meter *cm)
 {
+	struct cm_data *cd =3D ofono_call_meter_get_data(cm);
+
+	g_at_chat_unregister(cd->chat, cd->cccm_id);
+	g_at_chat_unregister(cd->chat, cd->ccwv_id);
+
+	g_free(cd);
 }
 =

 static struct ofono_call_meter_driver driver =3D {
-- =

1.7.0.4


--===============0211260565319497261==--

