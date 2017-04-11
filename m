Content-Type: multipart/mixed; boundary="===============1459203261345998505=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH v2 1/1] gemalto: Improve init process
Date: Tue, 11 Apr 2017 14:30:02 +0200
Message-ID: <1491913802-5600-1-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <1491901451-25109-2-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1459203261345998505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change Airplane mode: keep SIM connected (CFUN=3D4).
Fix enable/disable return value.
Create interfaces only if SIM card is detected.
Listen to URC for SIM status (improve SIM detection robustness).
Add some init commands.
---
Change in v2:
 - Add case in CFUN parsing

 plugins/gemalto.c | 470 +++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 434 insertions(+), 36 deletions(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index ffe6814..014bb4c 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -42,6 +42,7 @@
 #include <ofono/message-waiting.h>
 #include <ofono/netreg.h>
 #include <ofono/phonebook.h>
+#include <ofono/cbs.h>
 #include <ofono/sim.h>
 #include <ofono/sms.h>
 #include <ofono/ussd.h>
@@ -53,10 +54,27 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+static void at_cpin_query_cb(gboolean ok, GAtResult *result,
+		gpointer user_data);
+
+static const char *sind_prefix[] =3D { "^SIND:", NULL };
+static const char *creg_prefix[] =3D { "+CREG:", NULL };
+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
+static const char *sdport_prefix[] =3D { "^SDPORT:", NULL };
+static const char *gcap_prefix[] =3D { "+GCAP:", NULL };
+
+static gboolean sim_iface_created =3D FALSE;
 =

 struct gemalto_data {
 	GAtChat *app;
 	GAtChat *mdm;
+	struct ofono_sim *sim;
+	gboolean pin_required;
+	gboolean need_reboot;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+	gboolean have_gsm;
 };
 =

 static int gemalto_probe(struct ofono_modem *modem)
@@ -67,6 +85,10 @@ static int gemalto_probe(struct ofono_modem *modem)
 	if (data =3D=3D NULL)
 		return -ENOMEM;
 =

+	sim_iface_created =3D FALSE;
+	data->sim =3D NULL;
+	data->have_gsm =3D FALSE;
+
 	ofono_modem_set_data(modem, data);
 =

 	return 0;
@@ -110,6 +132,128 @@ static GAtChat *open_device(const char *device)
 	return chat;
 }
 =

+static void gemalto_cfun_enable_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	DBG("");
+
+	/* Power on the modem */
+	ofono_modem_set_powered(modem, ok);
+}
+
+gboolean gemalto_modem_set_to_online(struct ofono_modem *modem)
+{
+	DBG("");
+	ofono_modem_set_powered(modem, TRUE);
+
+	/* Must return FALSE to stop the g_timeout loop */
+	return FALSE;
+}
+
+static void gemalto_cfun_query_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	gint init_online_state =3D 0;
+
+	DBG("");
+
+	if (!ok) {
+		/* In case of errors, the mode is not powered */
+		ofono_modem_set_powered(modem, FALSE);
+	} else {
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "+CFUN:");
+		g_at_result_iter_next_number(&iter, &init_online_state);
+
+		DBG("online =3D %d", init_online_state);
+		switch (init_online_state) {
+		case 0:
+			/* Keep modem offline but connect USIM */
+			g_at_chat_send(data->app, "AT+CFUN=3D4", NULL,
+					gemalto_cfun_enable_cb, modem, NULL);
+			break;
+		case 1:
+			/* Wait for 300msec otherwise the sim manager has not finished
+			   and it is used in the NetworkManager.
+			   Otherwise, get a seg fault */
+			g_timeout_add(300, (GSourceFunc)gemalto_modem_set_to_online,
+					modem);
+			break;
+		case 4:
+			/* Set modem to powered */
+			ofono_modem_set_powered(modem, TRUE);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void gemalto_sdport_query_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	gint sdport_mode =3D -1;
+
+	DBG("");
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+	g_at_result_iter_next(&iter, "^SDPORT:");
+	g_at_result_iter_next_number(&iter, &sdport_mode);
+
+	/* Already correct mode. */
+	if (sdport_mode =3D=3D 3) {
+		/* Check the modem mode (online/offline) */
+		g_at_chat_send(data->app, "AT+CFUN?", cfun_prefix,
+				gemalto_cfun_query_cb, modem, NULL);
+	}
+}
+
+static void gemalto_smso_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	/* Try hard shutdown */
+	if (!ok) {
+		DBG("Error");
+		return;
+	}
+
+	g_at_chat_cancel_all(data->app);
+	g_at_chat_unregister_all(data->app);
+
+	g_at_chat_unref(data->mdm);
+	data->mdm =3D NULL;
+	g_at_chat_unref(data->app);
+	data->app =3D NULL;
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+void gemalto_shutdown(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	/* Shutdown the modem */
+	g_at_chat_send(data->app, "AT^SMSO", NULL, gemalto_smso_cb,
+			modem, NULL);
+}
+
 static int gemalto_enable(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
@@ -140,7 +284,24 @@ static int gemalto_enable(struct ofono_modem *modem)
 		g_at_chat_set_debug(data->mdm, gemalto_debug, "Mdm");
 	}
 =

-	return 0;
+	g_at_chat_send(data->app, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(data->app, "AT^SQPORT?", NULL, NULL, NULL, NULL);
+
+	/* TEMPORARY : Add this command to get data reconnection working */
+	g_at_chat_send(data->mdm, "AT&C0", NULL, NULL, NULL, NULL);
+
+	/* Configure the modem to be in profil 1 */
+	g_at_chat_send(data->app, "AT^SCFG=3D\"Radio/Mtpl\",1,1",
+			NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(data->app, "AT^SDPORT?", sdport_prefix,
+			gemalto_sdport_query_cb, modem, NULL);
+
+	/* Add the Time Zone URC */
+	g_at_chat_send(data->app, "AT+CTZU=3D1", NULL, NULL, NULL, NULL);
+
+	return -EINPROGRESS;
 }
 =

 static int gemalto_disable(struct ofono_modem *modem)
@@ -149,55 +310,272 @@ static int gemalto_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_send(data->app, "AT^SMSO", NULL, NULL, NULL, NULL);
+	if (data->app =3D=3D NULL)
+		return 0;
 =

-	ofono_modem_set_data(modem, NULL);
+	gemalto_shutdown(modem);
 =

-	return 0;
+	return -EINPROGRESS;
 }
 =

-static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+static void gemalto_cfun_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_modem_online_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
-
-	decode_at_error(&error, g_at_result_final_response(result));
 =

-	cb(&error, cbd->data);
+	if (ok)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

-static void gemalto_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+static void gemalto_set_online(struct ofono_modem *modem, gboolean online,
 		ofono_modem_online_cb_t cb, void *user_data)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D0";
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (g_at_chat_send(data->app, command, NULL, set_online_cb, cbd, g_free))
+	if (data->app =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+	}
+
+	g_at_chat_send(data->app, command, cfun_prefix, gemalto_cfun_cb, cbd,
+			g_free);
+}
+
+static void gemalto_create_sim(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!sim_iface_created) {
+		sim_iface_created =3D TRUE;
+		/* Create the sim */
+		data->sim =3D ofono_sim_create(modem, 0, "atmodem",
+				data->app);
+		if (data->sim)
+			ofono_sim_inserted_notify(data->sim, TRUE);
+	}
+}
+
+static void gemalto_set_network(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	ofono_devinfo_create(modem, 0, "atmodem", data->app);
+
+	if (data->have_gsm =3D=3D TRUE) {
+		ofono_sms_create(modem, 0, "atmodem", data->app);
+
+		ofono_cbs_create(modem, 0, "atmodem", data->app);
+
+		data->gprs =3D ofono_gprs_create(modem, 0,
+				"atmodem", data->app);
+
+		data->gc =3D ofono_gprs_context_create(modem, 0,
+				"atmodem", data->mdm);
+
+		if (data->gprs && data->gc)
+			ofono_gprs_add_context(data->gprs, data->gc);
+	}
+}
+
+static void gemalto_sind_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int value =3D 0;
+
+	DBG("");
+
+	if (ok) {
+		g_at_result_iter_init(&iter, result);
+		if (!g_at_result_iter_next(&iter, "^SIND:"))
+			return;
+		if (!g_at_result_iter_skip_next(&iter))
+			return;
+		if (!g_at_result_iter_skip_next(&iter))
+			return;
+		if (!g_at_result_iter_next_number(&iter, &value))
+			return;
+
+		if (value =3D=3D 5) { /* SIM data ready */
+			/* If no pin required, we create the SIM interface */
+			if (!data->pin_required) {
+				/* Deactivate the SIND URC*/
+				g_at_chat_send(data->app, "AT^SIND=3D\"simstatus\",0",
+						sind_prefix, NULL, NULL, NULL);
+				gemalto_create_sim(modem);
+			}
+		}
+
+		g_at_result_iter_close_list(&iter);
+	}
+}
+
+static void gemalto_sind_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	char *signal_identifier =3D "simstatus";
+	const char *str;
+	int value =3D 0;
+
+	DBG("");
+
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, "+CIEV:"))
+		return;
+	if (!g_at_result_iter_next_unquoted_string(&iter, &str))
+		return;
+	if (g_str_equal(signal_identifier, str) =3D=3D FALSE)
 		return;
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+	if (value =3D=3D 5) { /* SIM data ready */
+		/* If no pin required, we create the SIM interface */
+		if (!data->pin_required)
+			gemalto_create_sim(modem);
+	}
+	g_at_result_iter_close_list(&iter);
+}
+
+static void gemalto_creg_query_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int value =3D 0;
+
+	DBG("");
+
+	if (ok) {
+		g_at_result_iter_init(&iter, result);
+		if (!g_at_result_iter_next(&iter, "+CREG:"))
+			return;
+		/* Skip the URC mode */
+		if (!g_at_result_iter_skip_next(&iter))
+			return;
+		if (!g_at_result_iter_next_number(&iter, &value))
+			return;
+		if (value =3D=3D 5) {
+			/* Deactivate the CREG URC */
+			g_at_chat_send(data->app, "AT+CREG=3D0", NULL, NULL, NULL, NULL);
+
+			gemalto_set_network(modem);
+		}
+		g_at_result_iter_close_list(&iter);
+	}
+}
 =

-	CALLBACK_WITH_FAILURE(cb, cbd->data);
+static void gemalto_creg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int value =3D 0;
+
+	DBG("");
 =

-	g_free(cbd);
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, "+CREG:"))
+		return;
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	if (value =3D=3D 5 && !data->have_gsm) {
+		data->have_gsm =3D TRUE;
+		gemalto_set_network(modem);
+	}
+	g_at_result_iter_close_list(&iter);
+}
+
+static gboolean at_pin_query(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	/* Invert FALSE =3D stop, TRUE =3D re-do to be used in g_timeout_add_seco=
nds */
+	gboolean ret =3D FALSE;
+
+	if (g_at_chat_send(data->mdm, "AT+CPIN?", cpin_prefix,
+				at_cpin_query_cb, modem, NULL) <=3D 0) {
+		DBG("Error while querying the PIN.");
+		ret =3D TRUE;
+	}
+	return ret;
+}
+
+static void at_cpin_query_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	struct ofono_error error;
+	const char *pin_type_str;
+
+	if (ok) {
+		g_at_result_iter_init(&iter, result);
+
+		if (g_at_result_iter_next(&iter, "+CPIN:")) {
+			g_at_result_iter_next_unquoted_string(&iter, &pin_type_str);
+			/* No PIN required or there is an error */
+			if (g_strcmp0(pin_type_str, "READY") =3D=3D 0) {
+				data->pin_required =3D FALSE;
+			} else { /* PIN is required */
+				data->pin_required =3D TRUE;
+				/* Create the SIM manager to enter PIN */
+				gemalto_create_sim(modem);
+			}
+		}
+	} else {
+		decode_at_error(&error, g_at_result_final_response(result));
+		/* If the error is CME busy */
+		if (error.type =3D=3D OFONO_ERROR_TYPE_CME && error.error =3D=3D 14) {
+			DBG("Invalid password =3D> retry the command");
+			/* We re-try the command */
+			g_timeout_add_seconds(1, (GSourceFunc)at_pin_query, modem);
+			/* If the SIM is not inserted */
+		} else if (error.type =3D=3D OFONO_ERROR_TYPE_CME && error.error =3D=3D =
11) {
+
+			DBG("PIN not entered, please enter PIN");
+			g_timeout_add_seconds(1, (GSourceFunc)at_pin_query, modem);
+
+		}
+	}
 }
 =

 static void gemalto_pre_sim(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
-	ofono_voicecall_create(modem, 0, "atmodem", data->app);
 	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
 =

-	if (sim)
-		ofono_sim_inserted_notify(sim, TRUE);
+	/* Listen to simstatus SIND URC */
+	g_at_chat_register(data->app, "+CIEV:",
+			gemalto_sind_notify, FALSE, modem, NULL);
+	/* Listen to CREG URC */
+	g_at_chat_register(data->app, "+CREG:",
+			gemalto_creg_notify, FALSE, modem, NULL);
+
+	/* Check the SIM status and enable simstatus SIND URC */
+	g_at_chat_send(data->mdm, "AT^SIND=3D\"simstatus\",1", sind_prefix,
+			gemalto_sind_cb, modem, NULL);
+
+	/* Query the PIN command to create SIM Manager (or not) */
+	at_pin_query(modem);
 }
 =

 static void gemalto_post_sim(struct ofono_modem *modem)
@@ -207,35 +585,55 @@ static void gemalto_post_sim(struct ofono_modem *mode=
m)
 	DBG("%p", modem);
 =

 	ofono_phonebook_create(modem, 0, "atmodem", data->app);
+}
+
+static void gcap_support(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	const char *gcap;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+GCAP:"))
+		return;
 =

-	ofono_sms_create(modem, 0, "atmodem", data->app);
+	while (g_at_result_iter_next_unquoted_string(&iter, &gcap)) {
+		if (*gcap =3D=3D '\0')
+			break;
+
+		if (!g_strcmp0(gcap, "+CGSM"))
+			data->have_gsm =3D TRUE;
+	}
+
+	if (data->have_gsm)
+		gemalto_set_network(modem);
 }
 =

 static void gemalto_post_online(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_message_waiting *mw;
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

-	ofono_ussd_create(modem, 0, "atmodem", data->app);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
-	ofono_call_settings_create(modem, 0, "atmodem", data->app);
-	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);
-	ofono_call_meter_create(modem, 0, "atmodem", data->app);
-	ofono_call_barring_create(modem, 0, "atmodem", data->app);
+	/* Enable CREG URC and check CREG status */
+	g_at_chat_send(data->app, "AT+CREG=3D1", creg_prefix, NULL, modem, NULL);
+	g_at_chat_send(data->app, "AT+CREG?", creg_prefix,
+			gemalto_creg_query_cb, modem, NULL);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
+	ofono_voicecall_create(modem, 0, "atmodem", data->app);
+	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);
 =

-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
+	g_at_chat_send(data->mdm, "AT&C0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->mdm, "AT&D2", NULL, NULL, NULL, NULL);
 =

-	mw =3D ofono_message_waiting_create(modem);
-	if (mw)
-		ofono_message_waiting_register(mw);
+	/* Check for GSM capabilities */
+	g_at_chat_send(data->app, "AT+GCAP", gcap_prefix, gcap_support, modem,
+			NULL);
 }
 =

 static struct ofono_modem_driver gemalto_driver =3D {
-- =

1.9.1


--===============1459203261345998505==--

