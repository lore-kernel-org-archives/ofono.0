Content-Type: multipart/mixed; boundary="===============8588737056702780324=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: [PATCH 1/2] linktop: reimplemented linktop plugin with minimum
 features.
Date: Mon, 20 Jun 2011 13:05:58 +0530
Message-ID: <1308555359-22857-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8588737056702780324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The device supports subset of ST-Ericsson AT command extensions but nither
STE nor the MBM plugin works with these devices.

- Supports voice call and has builtin soundcard but unable to hear any soun=
d.
- Supports sim toolkit commands but I am unable to test this feature.

Fixes MeeGo bug #14784
---
 plugins/linktop.c |  234 +++++++++++++++++++++++++------------------------=
----
 1 files changed, 112 insertions(+), 122 deletions(-)

diff --git a/plugins/linktop.c b/plugins/linktop.c
index 953f634..bd8aa3e 100644
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
@@ -34,33 +35,30 @@
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
 #include <ofono/sim.h>
-#include <ofono/cbs.h>
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
 };
@@ -88,25 +86,79 @@ static void linktop_remove(struct ofono_modem *modem)
 =

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
+
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
+}
+
+static gboolean init_simpin_check(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct linktop_data *data =3D ofono_modem_get_data(modem);
+
+	data->cpin_poll_source =3D 0;
 =

-        ofono_info("%s%s", prefix, str);
+	g_at_chat_send(data->modem_port, "AT+CPIN?", cpin_prefix,
+			simpin_check, modem, NULL);
+
+	return FALSE;
+}
+
+static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
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
 }
 =

 static GAtChat *open_device(struct ofono_modem *modem,
 				const char *key, char *debug)
 {
-	const char *device;
 	GAtSyntax *syntax;
 	GIOChannel *channel;
+	const char *device;
 	GAtChat *chat;
 =

 	device =3D ofono_modem_get_string(modem, key);
@@ -126,94 +178,53 @@ static GAtChat *open_device(struct ofono_modem *modem,
 =

 	if (chat =3D=3D NULL)
 		return NULL;
-
+		=

 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(chat, linktop_debug, debug);
 =

 	return chat;
 }
 =

-static void linktop_disconnect(gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct linktop_data *data =3D ofono_modem_get_data(modem);
-
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
-
-	g_at_chat_set_disconnect_function(data->modem,
-						linktop_disconnect, modem);
-
-	ofono_info("Reopened GPRS context channel");
-
-	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
-
-	if (data->gprs && data->gc)
-		ofono_gprs_add_context(data->gprs, data->gc);
-}
-
-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-
-	DBG("");
-
-	ofono_modem_set_powered(modem, ok);
-}
-
 static int linktop_enable(struct ofono_modem *modem)
 {
 	struct linktop_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p", modem);
 =

-	data->modem =3D open_device(modem, "Modem", "Modem: ");
-	if (data->modem =3D=3D NULL)
+	data->modem_port =3D open_device(modem, "ModemDevice", "Modem: ");
+	if (data->modem_port =3D=3D NULL)
 		return -EINVAL;
 =

-	g_at_chat_set_disconnect_function(data->modem,
-						linktop_disconnect, modem);
+	data->data_port =3D open_device(modem, "DataDevice", "Data: ");
+	if (data->data_port =3D=3D NULL) {
+		g_at_chat_unref(data->modem_port);
+		data->modem_port =3D NULL;
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
-
-	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
-					cfun_enable, modem, NULL);
-
+	g_at_chat_send(data->modem_port, "AT&F E0 V1 X4 &C1 +CMEE=3D1", none_pref=
ix,
+				cfun_enable_cb, modem, NULL);
+	g_at_chat_send(data->data_port, "AT&F E0 V1 X4 &C1 +CMEE=3D1", none_prefi=
x,
+				cfun_enable_cb, modem, NULL);
+	g_at_chat_send(data->modem_port, "AT+CFUN=3D4", none_prefix,
+				cfun_enable_cb, modem, NULL);
+	=

 	return -EINPROGRESS;
 }
 =

-static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct linktop_data *data =3D ofono_modem_get_data(modem);
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
@@ -225,20 +236,14 @@ static int linktop_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	if (data->modem) {
-		g_at_chat_cancel_all(data->modem);
-		g_at_chat_unregister_all(data->modem);
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
-	}
-
-	if (data->control =3D=3D NULL)
+	if (data->modem_port =3D=3D NULL)
 		return 0;
 =

-	g_at_chat_cancel_all(data->control);
-	g_at_chat_unregister_all(data->control);
-	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
-					cfun_disable, modem, NULL);
+	g_at_chat_cancel_all(data->modem_port);
+	g_at_chat_unregister_all(data->modem_port);
+
+	g_at_chat_send(data->modem_port, "AT+CFUN=3D4", NULL,
+					cfun_disable_cb, modem, NULL);
 =

 	return -EINPROGRESS;
 }
@@ -257,12 +262,14 @@ static void linktop_set_online(struct ofono_modem *mo=
dem, ofono_bool_t online,
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

+	cbd->user =3D data;
+
 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
 		return;
 =

@@ -278,49 +285,33 @@ static void linktop_pre_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "atmodem", data->control);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->control);
-	ofono_voicecall_create(modem, 0, "stemodem", data->control);
+	ofono_devinfo_create(modem, 0, "atmodem", data->modem_port);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem_port);
 =

-	if (sim)
+	if (data->have_sim && sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void linktop_post_sim(struct ofono_modem *modem)
 {
 	struct linktop_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_radio_settings_create(modem, 0, "stemodem", data->control);
-	ofono_phonebook_create(modem, 0, "atmodem", data->control);
-	ofono_sms_create(modem, 0, "atmodem", data->control);
-}
-
-static void linktop_post_online(struct ofono_modem *modem)
-{
-	struct linktop_data *data =3D ofono_modem_get_data(modem);
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
+	ofono_radio_settings_create(modem, 0, "stemodem", data->modem_port);
+	ofono_phonebook_create(modem, 0, "atmodem", data->modem_port);
+	ofono_sms_create(modem, 0, "atmodem", data->modem_port);
+	ofono_ussd_create(modem, 0, "atmodem", data->modem_port);
+	ofono_netreg_create(modem, 0, "atmodem", data->modem_port);
+	=

+	data->gprs =3D ofono_gprs_create(modem, 0,
+					"atmodem", data->modem_port);
+	data->gc =3D ofono_gprs_context_create(modem, 0,
+					"atmodem", data->data_port);
 =

-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
+	if (data->gprs && data->gc)
+		ofono_gprs_add_context(data->gprs, data->gc);
 =

 	mw =3D ofono_message_waiting_create(modem);
 =

@@ -336,8 +327,7 @@ static struct ofono_modem_driver linktop_driver =3D {
 	.disable	=3D linktop_disable,
 	.set_online	=3D linktop_set_online,
 	.pre_sim	=3D linktop_pre_sim,
-	.post_sim	=3D linktop_post_sim,
-	.post_online	=3D linktop_post_online,
+	.post_sim	=3D linktop_post_sim
 };
 =

 static int linktop_init(void)
-- =

1.7.4.1


--===============8588737056702780324==--

