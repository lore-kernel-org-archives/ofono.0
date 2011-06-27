Content-Type: multipart/mixed; boundary="===============0777348094386387573=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH 1/2] linktop: reimplemented with minimum features.
Date: Mon, 27 Jun 2011 11:52:14 +0530
Message-ID: <1309155735-14544-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0777348094386387573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The device supports subset of ST-Ericsson AT command
extensions but nither STE nor the MBM plugin works with
these devices.

Fixes MeeGo bug #14784
---
 plugins/linktop.c |  120 +++++++++++++++++++++++--------------------------=
----
 1 files changed, 52 insertions(+), 68 deletions(-)

diff --git a/plugins/linktop.c b/plugins/linktop.c
index 953f634..2eb1c55 100644
--- a/plugins/linktop.c
+++ b/plugins/linktop.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -34,10 +35,6 @@
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
 #include <ofono/modem.h>
-#include <ofono/call-barring.h>
-#include <ofono/call-forwarding.h>
-#include <ofono/call-meter.h>
-#include <ofono/call-settings.h>
 #include <ofono/devinfo.h>
 #include <ofono/message-waiting.h>
 #include <ofono/netreg.h>
@@ -45,22 +42,20 @@
 #include <ofono/cbs.h>
 #include <ofono/sms.h>
 #include <ofono/ussd.h>
-#include <ofono/call-volume.h>
-#include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/phonebook.h>
 #include <ofono/radio-settings.h>
 #include <ofono/log.h>
 =

-#include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
 =

 static const char *none_prefix[] =3D { NULL };
 =

 struct linktop_data {
 	GAtChat *modem;
-	GAtChat *control;
+	GAtChat *aux;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 };
@@ -89,16 +84,16 @@ static void linktop_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 =

 	g_at_chat_unref(data->modem);
-	g_at_chat_unref(data->control);
+	g_at_chat_unref(data->aux);
 =

 	g_free(data);
 }
 =

 static void linktop_debug(const char *str, void *user_data)
 {
-        const char *prefix =3D user_data;
+	const char *prefix =3D user_data;
 =

-        ofono_info("%s%s", prefix, str);
+	ofono_info("%s%s", prefix, str);
 }
 =

 static GAtChat *open_device(struct ofono_modem *modem,
@@ -138,10 +133,9 @@ static void linktop_disconnect(gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct linktop_data *data =3D ofono_modem_get_data(modem);
 =

-	DBG("");
+	DBG("%p, data->gc %p", modem, data->gc);
 =

-	if (data->gc)
-		ofono_gprs_context_remove(data->gc);
+	ofono_gprs_context_remove(data->gc);
 =

 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
@@ -151,7 +145,7 @@ static void linktop_disconnect(gpointer user_data)
 		return;
 =

 	g_at_chat_set_disconnect_function(data->modem,
-						linktop_disconnect, modem);
+			linktop_disconnect, modem);
 =

 	ofono_info("Reopened GPRS context channel");
 =

@@ -176,31 +170,25 @@ static int linktop_enable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	data->modem =3D open_device(modem, "Modem", "Modem: ");
-	if (data->modem =3D=3D NULL)
-		return -EINVAL;
+	data->aux =3D open_device(modem, "Aux", "Aux: ");
+	if (data->aux =3D=3D NULL)
+		return -EIO;
 =

-	g_at_chat_set_disconnect_function(data->modem,
-						linktop_disconnect, modem);
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL) {
+		g_at_chat_unref(data->aux);
+		data->aux =3D NULL;
 =

-	data->control =3D open_device(modem, "Control", "Control: ");
-	if (data->control =3D=3D NULL) {
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
 		return -EIO;
 	}
 =

-	g_at_chat_send(data->control, "ATE0 +CMEE=3D1", none_prefix,
-						NULL, NULL, NULL);
-
-	g_at_chat_send(data->modem, "AT", none_prefix,
-						NULL, NULL, NULL);
-
-	g_at_chat_send(data->modem, "AT &F", none_prefix,
-						NULL, NULL, NULL);
+	g_at_chat_set_disconnect_function(data->modem,
+						linktop_disconnect, modem);
 =

-	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
-					cfun_enable, modem, NULL);
+	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
+					NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
+				cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
 }
@@ -212,8 +200,11 @@ static void cfun_disable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	DBG("");
 =

-	g_at_chat_unref(data->control);
-	data->control =3D NULL;
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
 =

 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
@@ -232,13 +223,12 @@ static int linktop_disable(struct ofono_modem *modem)
 		data->modem =3D NULL;
 	}
 =

-	if (data->control =3D=3D NULL)
+	if (data->aux =3D=3D NULL)
 		return 0;
 =

-	g_at_chat_cancel_all(data->control);
-	g_at_chat_unregister_all(data->control);
-	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
-					cfun_disable, modem, NULL);
+	g_at_chat_cancel_all(data->aux);
+	g_at_chat_unregister_all(data->aux);
+	g_at_chat_send(data->aux, "AT+CFUN=3D4", NULL, cfun_disable, modem, NULL);
 =

 	return -EINPROGRESS;
 }
@@ -247,22 +237,25 @@ static void set_online_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_modem_online_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
 =

-	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, cbd->data);
+	if (ok)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

 static void linktop_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
 				ofono_modem_online_cb_t cb, void *user_data)
 {
 	struct linktop_data *data =3D ofono_modem_get_data(modem);
-	GAtChat *chat =3D data->control;
+	GAtChat *chat =3D data->aux;
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

+	cbd->user =3D data;
+
 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
 		return;
 =

@@ -278,9 +271,8 @@ static void linktop_pre_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "atmodem", data->control);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->control);
-	ofono_voicecall_create(modem, 0, "stemodem", data->control);
+	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->aux);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
@@ -292,35 +284,27 @@ static void linktop_post_sim(struct ofono_modem *mode=
m)
 =

 	DBG("%p", modem);
 =

-	ofono_radio_settings_create(modem, 0, "stemodem", data->control);
-	ofono_phonebook_create(modem, 0, "atmodem", data->control);
-	ofono_sms_create(modem, 0, "atmodem", data->control);
+	ofono_radio_settings_create(modem, 0, "stemodem", data->aux);
+	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
+	ofono_sms_create(modem, 0, "atmodem", data->aux);
 }
 =

 static void linktop_post_online(struct ofono_modem *modem)
 {
 	struct linktop_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

-	ofono_ussd_create(modem, 0, "atmodem", data->control);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->control);
-	ofono_call_settings_create(modem, 0, "atmodem", data->control);
-	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->control);
-	ofono_call_meter_create(modem, 0, "atmodem", data->control);
-	ofono_call_barring_create(modem, 0, "atmodem", data->control);
-	ofono_call_volume_create(modem, 0, "atmodem", data->control);
-	ofono_cbs_create(modem, 0, "atmodem", data->control);
-
-	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
-					"atmodem", data->control);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
+	ofono_netreg_create(modem, 0, "atmodem", data->aux);
+	ofono_cbs_create(modem, 0, "atmodem", data->aux);
+	ofono_ussd_create(modem, 0, "atmodem", data->aux);
+
+	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->aux);
+	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+
+	if (data->gprs && data->gc)
+		ofono_gprs_add_context(data->gprs, data->gc);
 =

 	mw =3D ofono_message_waiting_create(modem);
 =

-- =

1.7.4.1


--===============0777348094386387573==--

