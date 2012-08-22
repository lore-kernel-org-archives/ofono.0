Content-Type: multipart/mixed; boundary="===============7184909563187735264=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] Add SMS initialize retry
Date: Tue, 21 Aug 2012 20:32:45 -0700
Message-ID: <1345606365-4368-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7184909563187735264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

Before SMS fuction is useable, it will do some initialization. Following
AT command will be sent:
  AT+CSMS=3D?
  AT+CSMS=3Dxx
  AT+CSMS?
  AT+CMGF=3D?
  AT+CPMS=3D?
*  AT+CMGF=3Dxx
*  AT+CPMS=3Dxx
  AT+CNMI=3D?
  AT+CNMI=3Dxx

It is possible that the modem will return error. Currently, only two AT
command(AT+CMGF=3Dxx and AT+CPMS=3Dxx) errors are handled. If other AT comm=
and
return error reslut, it will be considered as the modem does not support
SMS. It will cause SMS function unavailable.

Sometimes, if the SIM is busy when receive above AT command, it will return
"(U)SIM busy" error. e.g.

ofonod[274]: Aux: > AT+CMGF=3D?\r
ofonod[274]: Aux: < \r\n+CMGF: (0-1)\r\n\r\nOK\r\n
ofonod[274]: Aux: > AT+CPMS=3D?\r
ofonod[274]: Aux: < \r\n+CMS ERROR: 314\r\n

This patch is to avoid this issue. When (U)SIM busy error occur, it will re=
try
 1 second later.

---
 drivers/atmodem/sms.c |  109 ++++++++++++++++++++++++++++-----------------=
----
 1 files changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index fde90ba..cac184c 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -52,12 +52,11 @@ static const char *cmgs_prefix[] =3D { "+CMGS:", NULL };
 static const char *cmgl_prefix[] =3D { "+CMGL:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

-static gboolean set_cmgf(gpointer user_data);
-static gboolean set_cpms(gpointer user_data);
 static void at_cmgl_set_cpms(struct ofono_sms *sms, int store);
+static gboolean at_sms_start_init(gpointer user_data);
 =

-#define MAX_CMGF_RETRIES 10
-#define MAX_CPMS_RETRIES 10
+#define ERROR_SIM_BUSY 314
+#define MAX_SIM_BUSY_RETRIES 10
 =

 static const char *storages[] =3D {
 	"SM",
@@ -737,6 +736,9 @@ static void at_sms_initialized(struct ofono_sms *sms)
 	else
 		at_cmgl_set_cpms(sms, data->incoming);
 =

+	data->retries =3D 0;
+	data->timeout_source =3D 0;
+
 	ofono_sms_register(sms);
 }
 =

@@ -748,12 +750,38 @@ static void at_sms_not_supported(struct ofono_sms *sm=
s)
 	ofono_sms_remove(sms);
 }
 =

+static void at_sms_init_fail(struct ofono_sms *sms, GAtResult *result,
+					gboolean force)
+{
+	struct ofono_error error;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	/** If SMS init fail due to SIM is busy or force retry,
+		retry 1 sec later */
+	if (error.error =3D=3D ERROR_SIM_BUSY || force =3D=3D TRUE) {
+		data->retries +=3D 1;
+
+		if (data->retries =3D=3D MAX_SIM_BUSY_RETRIES) {
+			DBG("Up to max retry times");
+			return at_sms_not_supported(sms);
+		}
+
+		data->timeout_source =3D
+			g_timeout_add_seconds(1, at_sms_start_init, sms);
+		return;
+	}
+
+	at_sms_not_supported(sms);
+}
+
 static void at_cnmi_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_sms *sms =3D user_data;
 =

 	if (!ok)
-		return at_sms_not_supported(sms);
+		return at_sms_init_fail(sms, result, FALSE);
 =

 	at_sms_initialized(sms);
 }
@@ -945,7 +973,7 @@ static void at_cnmi_query_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 out:
 	if (!supported)
-		return at_sms_not_supported(sms);
+		return at_sms_init_fail(sms, result, FALSE);
 =

 	g_at_chat_send(data->chat, buf, cnmi_prefix,
 			at_cnmi_set_cb, sms, NULL);
@@ -962,22 +990,14 @@ static void at_query_cnmi(struct ofono_sms *sms)
 static void at_cpms_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_sms *sms =3D user_data;
-	struct sms_data *data =3D ofono_sms_get_data(sms);
 =

 	if (ok)
-		return at_query_cnmi(sms);
-
-	data->retries +=3D 1;
-
-	if (data->retries =3D=3D MAX_CPMS_RETRIES) {
-		ofono_error("Unable to set preferred storage");
-		return at_sms_not_supported(sms);
-	}
-
-	data->timeout_source =3D g_timeout_add_seconds(1, set_cpms, sms);
+		at_query_cnmi(sms);
+	else
+		at_sms_init_fail(sms, result, TRUE);
 }
 =

-static gboolean set_cpms(gpointer user_data)
+static void set_cpms(gpointer user_data)
 {
 	struct ofono_sms *sms =3D user_data;
 	struct sms_data *data =3D ofono_sms_get_data(sms);
@@ -993,44 +1013,25 @@ static gboolean set_cpms(gpointer user_data)
 =

 	g_at_chat_send(data->chat, buf, cpms_prefix,
 			at_cpms_set_cb, sms, NULL);
-
-	data->timeout_source =3D 0;
-
-	return FALSE;
 }
 =

 static void at_cmgf_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_sms *sms =3D user_data;
-	struct sms_data *data =3D ofono_sms_get_data(sms);
 =

-	if (ok) {
-		data->retries =3D 0;
+	if (ok)
 		set_cpms(sms);
-		return;
-	}
-
-	data->retries +=3D 1;
-
-	if (data->retries =3D=3D MAX_CMGF_RETRIES) {
-		DBG("Unable to enter PDU mode");
-		return at_sms_not_supported(sms);
-	}
-
-	data->timeout_source =3D g_timeout_add_seconds(1, set_cmgf, sms);
+	else
+		at_sms_init_fail(sms, result, TRUE);
 }
 =

-static gboolean set_cmgf(gpointer user_data)
+static void set_cmgf(gpointer user_data)
 {
 	struct ofono_sms *sms =3D user_data;
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 =

 	g_at_chat_send(data->chat, "AT+CMGF=3D0", cmgf_prefix,
 			at_cmgf_set_cb, sms, NULL);
-
-	data->timeout_source =3D 0;
-
-	return FALSE;
 }
 =

 static void at_cpms_query_cb(gboolean ok, GAtResult *result,
@@ -1117,7 +1118,7 @@ static void at_cpms_query_cb(gboolean ok, GAtResult *=
result,
 	}
 out:
 	if (!supported)
-		return at_sms_not_supported(sms);
+		return at_sms_init_fail(sms, result, FALSE);
 =

 	set_cmgf(sms);
 }
@@ -1149,7 +1150,7 @@ static void at_cmgf_query_cb(gboolean ok, GAtResult *=
result,
 =

 out:
 	if (!supported)
-		return at_sms_not_supported(sms);
+		return at_sms_init_fail(sms, result, FALSE);
 =

 	g_at_chat_send(data->chat, "AT+CPMS=3D?", cpms_prefix,
 			at_cpms_query_cb, sms, NULL);
@@ -1201,7 +1202,7 @@ static void at_csms_status_cb(gboolean ok, GAtResult =
*result,
 =

 out:
 	if (!supported)
-		return at_sms_not_supported(sms);
+		return at_sms_init_fail(sms, result, FALSE);
 =

 	/* Now query supported text format */
 	g_at_chat_send(data->chat, "AT+CMGF=3D?", cmgf_prefix,
@@ -1229,7 +1230,7 @@ static void at_csms_query_cb(gboolean ok, GAtResult *=
result,
 	char buf[128];
 =

 	if (!ok)
-		return at_sms_not_supported(sms);
+		return at_sms_init_fail(sms, result, FALSE);
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -1251,6 +1252,18 @@ out:
 			at_csms_set_cb, sms, NULL);
 }
 =

+/** start init modem sms relative setting */
+static gboolean at_sms_start_init(gpointer user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	g_at_chat_send(data->chat, "AT+CSMS=3D?", csms_prefix,
+			at_csms_query_cb, sms, NULL);
+
+	return FALSE;
+}
+
 static int at_sms_probe(struct ofono_sms *sms, unsigned int vendor,
 				void *user)
 {
@@ -1263,8 +1276,10 @@ static int at_sms_probe(struct ofono_sms *sms, unsig=
ned int vendor,
 =

 	ofono_sms_set_data(sms, data);
 =

-	g_at_chat_send(data->chat, "AT+CSMS=3D?", csms_prefix,
-			at_csms_query_cb, sms, NULL);
+	data->retries =3D 0;
+	data->timeout_source =3D 0;
+
+	at_sms_start_init(sms);
 =

 	return 0;
 }
-- =

1.7.0.4


--===============7184909563187735264==--

