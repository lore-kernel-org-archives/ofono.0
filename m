Content-Type: multipart/mixed; boundary="===============2882653892953432561=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH 1/2] linktop: reimplemented linktop plugin based on mbm
Date: Wed, 08 Jun 2011 15:16:19 +0530
Message-ID: <1307526380-6285-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2882653892953432561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The AT commands listed with AT+CLAC matches with MBM supported devices.
However, the mbm plugin doesn't work for this devices and the specification=
 is
also quite different.

I have also adopted some fixes from huawei plugin to fix MeeGo bug #14784

Signed-off-by: Amit Mendapara <mendapara.amit@gmail.com>
---
 plugins/linktop.c |  301 ++++++++++++++++++++++++++++++++++++-------------=
---
 1 files changed, 208 insertions(+), 93 deletions(-)

diff --git a/plugins/linktop.c b/plugins/linktop.c
index 953f634..26536d8 100644
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
@@ -42,6 +43,7 @@
 #include <ofono/message-waiting.h>
 #include <ofono/netreg.h>
 #include <ofono/sim.h>
+#include <ofono/stk.h>
 #include <ofono/cbs.h>
 #include <ofono/sms.h>
 #include <ofono/ussd.h>
@@ -53,16 +55,21 @@
 #include <ofono/radio-settings.h>
 #include <ofono/log.h>
 =

-#include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
 =

+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct linktop_data {
-	GAtChat *modem;
-	GAtChat *control;
+	GAtChat *modem_port;
+	GAtChat *data_port;
+	guint cpin_poll_source;
+	guint cpin_poll_count;
+	gboolean have_sim;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	guint reopen_source;
 };
 =

 static int linktop_probe(struct ofono_modem *modem)
@@ -86,35 +93,86 @@ static void linktop_remove(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->reopen_source > 0) {
+		g_source_remove(data->reopen_source);
+		data->reopen_source =3D 0;
+	}
+
 	ofono_modem_set_data(modem, NULL);
 =

-	g_at_chat_unref(data->modem);
-	g_at_chat_unref(data->control);
+	g_at_chat_unref(data->data_port);
+	g_at_chat_unref(data->modem_port);
+
+	if (data->cpin_poll_source > 0)
+		g_source_remove(data->cpin_poll_source);
 =

 	g_free(data);
 }
 =

 static void linktop_debug(const char *str, void *user_data)
 {
-        const char *prefix =3D user_data;
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static gboolean init_simpin_check(gpointer user_data);
+
+static void simpin_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
 =

-        ofono_info("%s%s", prefix, str);
+	DBG("");
+
+	/* Modem returns an error if SIM is not ready. */
+	if (!ok && data->cpin_poll_count++ < 5) {
+		data->cpin_poll_source =3D
+			g_timeout_add_seconds(1, init_simpin_check, modem);
+		return;
+	}
+
+	data->cpin_poll_count =3D 0;
+
+	/* There is probably no SIM if SIM is not ready after 5 seconds. */
+	data->have_sim =3D ok;
+
+	ofono_modem_set_powered(modem, TRUE);
 }
 =

-static GAtChat *open_device(struct ofono_modem *modem,
-				const char *key, char *debug)
+static gboolean init_simpin_check(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+
+	data->cpin_poll_source =3D 0;
+
+	g_at_chat_send(data->modem_port, "AT+CPIN?", cpin_prefix,
+			simpin_check, modem, NULL);
+
+	return FALSE;
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	init_simpin_check(modem);
+}
+
+static GAtChat *create_port(const char *device)
 {
-	const char *device;
 	GAtSyntax *syntax;
 	GIOChannel *channel;
 	GAtChat *chat;
 =

-	device =3D ofono_modem_get_string(modem, key);
-	if (device =3D=3D NULL)
-		return NULL;
-
-	DBG("%s %s", key, device);
-
 	channel =3D g_at_tty_open(device, NULL);
 	if (channel =3D=3D NULL)
 		return NULL;
@@ -127,81 +185,116 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
 	if (chat =3D=3D NULL)
 		return NULL;
 =

-	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(chat, linktop_debug, debug);
-
 	return chat;
 }
 =

-static void linktop_disconnect(gpointer user_data)
+static void linktop_disconnect(gpointer user_data);
+
+static gboolean reopen_callback(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct linktop_data *data =3D ofono_modem_get_data(modem);
+	const char *data_dev;
+
+	data_dev =3D ofono_modem_get_string(modem, "DataDevice");
+	data->data_port =3D create_port(data_dev);
+	/* retry once if failed */
+	if (data->data_port =3D=3D NULL) {
+		if (data->reopen_source > 0)
+			return FALSE;
+
+		data->reopen_source =3D g_timeout_add_seconds(1,
+				reopen_callback, modem);
+		ofono_debug("opening data port failed, retrying...");
+		return FALSE;
+	}
 =

-	DBG("");
-
-	if (data->gc)
-		ofono_gprs_context_remove(data->gc);
-
-	g_at_chat_unref(data->modem);
-	data->modem =3D NULL;
-
-	data->modem =3D open_device(modem, "Modem", "Modem: ");
-	if (data->modem =3D=3D NULL)
-		return;
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->data_port, linktop_debug, "Data: ");
 =

-	g_at_chat_set_disconnect_function(data->modem,
+	g_at_chat_set_disconnect_function(data->data_port,
 						linktop_disconnect, modem);
 =

 	ofono_info("Reopened GPRS context channel");
 =

-	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
-
-	if (data->gprs && data->gc)
+	data->gc =3D ofono_gprs_context_create(modem, 0,
+					"atmodem", data->data_port);
+	if (data->gprs && data->gc) {
 		ofono_gprs_add_context(data->gprs, data->gc);
+	}
+
+	data->reopen_source =3D 0;
+
+	return FALSE;
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+static void linktop_disconnect(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
 =

-	DBG("");
+	DBG("%p, data->gc %p", modem, data->gc);
+
+	/* gprs_context has been destructed and needs not reopen */
+	if (data->gc =3D=3D NULL)
+		return
+	=

+	ofono_gprs_context_remove(data->gc);
 =

-	ofono_modem_set_powered(modem, ok);
+	g_at_chat_unref(data->data_port);
+	data->data_port =3D NULL;
+
+	/* Waiting for the +CGEV: ME DEACT might also work */
+	if (data->reopen_source > 0)
+		g_source_remove(data->reopen_source);
+
+	data->reopen_source =3D g_timeout_add_seconds(1, reopen_callback, modem);
 }
 =

 static int linktop_enable(struct ofono_modem *modem)
 {
 	struct linktop_data *data =3D ofono_modem_get_data(modem);
+	const char *modem_dev;
+	const char *data_dev;
 =

 	DBG("%p", modem);
 =

-	data->modem =3D open_device(modem, "Modem", "Modem: ");
-	if (data->modem =3D=3D NULL)
-		return -EINVAL;
+	modem_dev =3D ofono_modem_get_string(modem, "ModemDevice");
+	data_dev =3D ofono_modem_get_string(modem, "DataDevice");
 =

-	g_at_chat_set_disconnect_function(data->modem,
-						linktop_disconnect, modem);
+	DBG("%s, %s", modem_dev, data_dev);
+
+	if (modem_dev =3D=3D NULL || data_dev =3D=3D NULL)
+		return -EINVAL;
 =

-	data->control =3D open_device(modem, "Control", "Control: ");
-	if (data->control =3D=3D NULL) {
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
+	data->modem_port =3D create_port(modem_dev);
+	if (data->modem_port =3D=3D NULL)
 		return -EIO;
-	}
 =

-	g_at_chat_send(data->control, "ATE0 +CMEE=3D1", none_prefix,
-						NULL, NULL, NULL);
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->modem_port, linktop_debug, "Modem: ");
+
+	data->data_port =3D create_port(data_dev);
+	if (data->data_port =3D=3D NULL) {
+		g_at_chat_unref(data->modem_port);
+		data->modem_port =3D NULL;
 =

-	g_at_chat_send(data->modem, "AT", none_prefix,
-						NULL, NULL, NULL);
+		return -EIO;
+	}
 =

-	g_at_chat_send(data->modem, "AT &F", none_prefix,
-						NULL, NULL, NULL);
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->data_port, linktop_debug, "Data: ");
 =

-	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
-					cfun_enable, modem, NULL);
+	g_at_chat_set_disconnect_function(data->data_port,
+						linktop_disconnect, modem);
 =

+	g_at_chat_send(data->modem_port, "AT&F E0 V1 X4 &C1 +CMEE=3D1", NULL,
+					NULL, NULL, NULL);
+	g_at_chat_send(data->data_port, "AT&F E0 V1 X4 &C1 +CMEE=3D1", NULL,
+					NULL, NULL, NULL);
+	g_at_chat_send(data->modem_port, "AT+CFUN=3D4", none_prefix,
+				cfun_enable, modem, NULL);
+	=

 	return -EINPROGRESS;
 }
 =

@@ -212,8 +305,11 @@ static void cfun_disable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	DBG("");
 =

-	g_at_chat_unref(data->control);
-	data->control =3D NULL;
+	g_at_chat_unref(data->modem_port);
+	data->modem_port =3D NULL;
+
+	g_at_chat_unref(data->data_port);
+	data->data_port =3D NULL;
 =

 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
@@ -225,19 +321,17 @@ static int linktop_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	if (data->modem) {
-		g_at_chat_cancel_all(data->modem);
-		g_at_chat_unregister_all(data->modem);
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
+	if (data->reopen_source > 0) {
+		g_source_remove(data->reopen_source);
+		data->reopen_source =3D 0;
 	}
 =

-	if (data->control =3D=3D NULL)
+	if (data->modem_port =3D=3D NULL)
 		return 0;
 =

-	g_at_chat_cancel_all(data->control);
-	g_at_chat_unregister_all(data->control);
-	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
+	g_at_chat_cancel_all(data->modem_port);
+	g_at_chat_unregister_all(data->modem_port);
+	g_at_chat_send(data->modem_port, "AT+CFUN=3D4", NULL,
 					cfun_disable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -253,17 +347,37 @@ static void set_online_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	cb(&error, cbd->data);
 }
 =

+static void set_offline_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	if (ok) {
+		struct linktop_data *data =3D cbd->user;
+
+		data->gc =3D NULL;
+		data->gprs =3D NULL;
+	}
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
 static void linktop_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
 				ofono_modem_online_cb_t cb, void *user_data)
 {
 	struct linktop_data *data =3D ofono_modem_get_data(modem);
-	GAtChat *chat =3D data->control;
+	GAtChat *chat =3D data->modem_port;
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
+	cbd->user =3D data;
+
+	if (g_at_chat_send(chat, command, NULL,
+				online ? set_online_cb : set_offline_cb, cbd, g_free))
 		return;
 =

 	g_free(cbd);
@@ -278,11 +392,11 @@ static void linktop_pre_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "atmodem", data->control);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->control);
-	ofono_voicecall_create(modem, 0, "stemodem", data->control);
+	ofono_devinfo_create(modem, 0, "atmodem", data->modem_port);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem_port);
+	ofono_voicecall_create(modem, 0, "stemodem", data->modem_port);
 =

-	if (sim)
+	if (data->have_sim && sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

@@ -292,35 +406,36 @@ static void linktop_post_sim(struct ofono_modem *mode=
m)
 =

 	DBG("%p", modem);
 =

-	ofono_radio_settings_create(modem, 0, "stemodem", data->control);
-	ofono_phonebook_create(modem, 0, "atmodem", data->control);
-	ofono_sms_create(modem, 0, "atmodem", data->control);
+	ofono_stk_create(modem, 0, "mbmmodem", data->modem_port);
+	ofono_radio_settings_create(modem, 0, "stemodem", data->modem_port);
+	ofono_phonebook_create(modem, 0, "atmodem", data->modem_port);
+	ofono_sms_create(modem, 0, "atmodem", data->modem_port);
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
+	ofono_netreg_create(modem, 0, "atmodem", data->modem_port);
+	ofono_cbs_create(modem, 0, "atmodem", data->modem_port);
+	ofono_ussd_create(modem, 0, "atmodem", data->modem_port);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->modem_port);
+	ofono_call_settings_create(modem, 0, "atmodem", data->modem_port);
+	ofono_call_meter_create(modem, 0, "atmodem", data->modem_port);
+	ofono_call_barring_create(modem, 0, "atmodem", data->modem_port);
+	ofono_call_volume_create(modem, 0, "atmodem", data->modem_port);
+
+	data->gprs =3D ofono_gprs_create(modem, 0,
+					"atmodem", data->modem_port);
+	data->gc =3D ofono_gprs_context_create(modem, 0,
+					"atmodem", data->data_port);
+
+	if (data->gprs && data->gc) {
+		ofono_gprs_add_context(data->gprs, data->gc);
+	}
 =

 	mw =3D ofono_message_waiting_create(modem);
 =

-- =

1.7.4.1


--===============2882653892953432561==--

