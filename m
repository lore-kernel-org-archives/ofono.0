Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79785423160
	for <ofono@lists.linux.dev>; Wed, 13 May 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677200; cv=none; b=KmXA681RlyuuVzJ07yegXt16456MLMQWQTidf15AAAUh9TJIScUhvOOsE8TX0x6UErA9SBllKiw6szUnOTwbiXBRh0wPRekcEKIdfpsv78z7CDumn48xjYSEVpyC0ES3PAUCrts2sWVWfGryc3cISZm7iNqcWKF8vYgI7Tq/qLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677200; c=relaxed/simple;
	bh=Zbw12VmuRJLZSE3+Lf4ZNVCoc7jAh2x5lBmtuT3mgS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYjahgjvZoVj+3eh+ri90BkGwYOMxmBJwUGakwlCfYeLerdotJWUaX7gcPPbjxk42LlIHrbQEJNNG9GaloZrijD/3QRSR6Q2rsJ68byUXP7cRRfWSN//iiLS4khPAS4gcrU9KnPpvF1ti8y5lOf5rRGiX9dhnaUNfjUq+S68BMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=y8fLpQfv; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="y8fLpQfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1778677178; x=1778936378;
	bh=A/mSygPmN9myQFppEzGVLYPoD4kj7y2cgm8QA36xcIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=y8fLpQfv9AllVsKycGH1nQBUdzjCFaSwj5y9wa6sC8bAvpy2OUxhhIIpqYCvxtBS8
	 CIukcbxovmQoGjKLrIeGdgwoZLtwOwDQi38KdYev7xyVRkFB/dPAf9sGa6JK5FgY2M
	 FdZD56PD5rGrG+kcdPAnoNSB0tpvsrKn4k98vl96AQLS88e8pwiPlJwBUzNQU9tcfB
	 f2/Hueh6Q8O8Xo55DUMaCrBIidMMwIqrWr2Fzb5YmIyvwnhQtKtNa4KYsd9LU7xL6c
	 iLoF+qsZqVJHH7u+AIMVr3DHYz7cWIc+OH1yux5dFlbkLzkngG5sWQbcvxbAlPfufL
	 QJXPBAggpAmhg==
X-Pm-Submission-Id: 4gFtpH6C1Fz1DF7Q
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 3/3] sim7100: add dbus under/over voltage warnings
Date: Wed, 13 May 2026 14:59:23 +0200
Message-ID: <20260513125925.2164959-3-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513125925.2164959-1-sean@geanix.com>
References: <20260513125925.2164959-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/sim7100.c | 284 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 281 insertions(+), 3 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 01620e31..ed4f759d 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -16,6 +16,7 @@
 #include <config.h>
 #endif
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
 
@@ -25,6 +26,8 @@
 #include <ell/ell.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono.h>
+#include <ofono/dbus.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
@@ -45,9 +48,12 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 
+#include <gdbus/gdbus.h>
+
 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/atutil.h>
 
+static const char *cbc_prefix[] = { "+CBC:", NULL };
 static const char *cfun_prefix[] = { "+CFUN:", NULL };
 
 enum sim7x00_model {
@@ -66,6 +72,21 @@ struct sim7100_data {
 	guint init_cmd;
 };
 
+struct dbus_hw {
+	DBusMessage *msg;
+	struct ofono_modem *modem;
+	int32_t voltage;
+};
+
+enum sim7100_power_event {
+	LOW_POWER_DOWN = -2,
+	LOW_POWER_WARNING = -1,
+	HIGH_POWER_WARNING = 1,
+	HIGH_POWER_DOWN = 2,
+};
+
+static const char dbus_hw_interface[] = OFONO_SERVICE ".sim7100.Hardware";
+
 static void sim7100_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -109,6 +130,217 @@ static void sim7100_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 
+static void dbus_hw_reply_properties(struct dbus_hw *hw)
+{
+	struct sim7100_data *data = ofono_modem_get_data(hw->modem);
+	DBusMessage *reply;
+	DBusMessageIter dbus_iter;
+	DBusMessageIter dbus_dict;
+
+	DBG("%p", hw->modem);
+
+	reply = dbus_message_new_method_return(hw->msg);
+	dbus_message_iter_init_append(reply, &dbus_iter);
+	dbus_message_iter_open_container(&dbus_iter, DBUS_TYPE_ARRAY,
+					 OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					 &dbus_dict);
+
+	ofono_dbus_dict_append(&dbus_dict, "Voltage", DBUS_TYPE_INT32,
+			       &hw->voltage);
+
+	dbus_message_iter_close_container(&dbus_iter, &dbus_dict);
+
+	__ofono_dbus_pending_reply(&hw->msg, reply);
+}
+
+static void cbc_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct dbus_hw *hw = user_data;
+	GAtResultIter iter;
+	const char *voltage;
+	double volts = 0.0;
+
+	DBG("%p", hw->modem);
+
+	if (!hw->msg)
+		return;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CBC:"))
+		goto error;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &voltage))
+		goto error;
+
+	if (sscanf(voltage, "%lfV", &volts) == 1) {
+		hw->voltage = (int)(volts * 1000);
+		DBG("%s = %d mV\n", voltage, hw->voltage);
+	} else {
+		DBG("Failed to parse voltage\n");
+		goto error;
+	}
+
+	dbus_hw_reply_properties(hw);
+
+	return;
+
+ error:
+	__ofono_dbus_pending_reply(&hw->msg, __ofono_error_failed(hw->msg));
+}
+
+static DBusMessage *dbus_hw_get_properties(DBusConnection *conn,
+					   DBusMessage *msg, void *user_data)
+{
+	struct dbus_hw *hw = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(hw->modem);
+
+	DBG("%p", hw->modem);
+
+	if (hw->msg != NULL)
+		return __ofono_error_busy(msg);
+
+	if (!g_at_chat_send(data->at, "AT+CBC", cbc_prefix, cbc_cb, hw, NULL))
+		return __ofono_error_failed(msg);
+
+	hw->msg = dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static void voltage_handle(struct ofono_modem *modem,
+			   enum sim7100_power_event event)
+{
+	DBusConnection *conn = ofono_dbus_get_connection();
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	const char *path = ofono_modem_get_path(modem);
+	const char *name;
+	const char *reason;
+
+	DBG("%p", modem);
+
+	switch (event) {
+	case LOW_POWER_DOWN:
+		name = "PowerDown";
+		reason = "voltagelow";
+		break;
+	case LOW_POWER_WARNING:
+		name = "PowerWarning";
+		reason = "voltagelow";
+		break;
+	case HIGH_POWER_WARNING:
+		name = "PowerWarning";
+		reason = "voltagehigh";
+		break;
+	case HIGH_POWER_DOWN:
+		name = "PowerDown";
+		reason = "voltagehigh";
+		break;
+	default:
+		return;
+	}
+
+	signal = dbus_message_new_signal(path, dbus_hw_interface, name);
+	if (!signal)
+		return;
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
+					&reason);
+	g_dbus_send_message(conn, signal);
+}
+
+static void power_notify(GAtResult *result, void *user_data)
+{
+	struct dbus_hw *hw = user_data;
+	GAtResultIter iter;
+	const char *event;
+
+	DBG("%p", hw->modem);
+
+	g_at_result_iter_init(&iter, result);
+	g_at_result_iter_next(&iter, NULL);
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	DBG("event: %s", event);
+
+	if (g_strcmp0(event, "UNDER-VOLTAGE WARNNING POWER DOWN") == 0)
+		voltage_handle(hw->modem, LOW_POWER_DOWN);
+	else if (g_strcmp0(event, "UNDER-VOLTAGE WARNNING") == 0)
+		voltage_handle(hw->modem, LOW_POWER_WARNING);
+	else if (g_strcmp0(event, "OVER-VOLTAGE WARNNING") == 0)
+		voltage_handle(hw->modem, HIGH_POWER_WARNING);
+	else if (g_strcmp0(event, "OVER-VOLTAGE WARNNING POWER DOWN") == 0)
+		voltage_handle(hw->modem, HIGH_POWER_DOWN);
+}
+
+static const GDBusMethodTable dbus_hw_methods[] = {
+	{GDBUS_ASYNC_METHOD("GetProperties",
+				NULL, GDBUS_ARGS({"properties", "a{sv}"}),
+				dbus_hw_get_properties)},
+	{}
+};
+
+static const GDBusSignalTable dbus_hw_signals[] = {
+	{GDBUS_SIGNAL("PowerWarning",
+			GDBUS_ARGS({"reason", "s"}))},
+	{GDBUS_SIGNAL("PowerDown",
+			GDBUS_ARGS({"reason", "s"}))},
+	{}
+};
+
+static void dbus_hw_cleanup(void *data)
+{
+	struct dbus_hw *hw = data;
+
+	DBG("%p", hw->modem);
+
+	if (hw->msg)
+		__ofono_dbus_pending_reply(&hw->msg,
+					__ofono_error_canceled(hw->msg));
+
+	l_free(hw);
+}
+
+static void dbus_hw_enable(struct ofono_modem *modem)
+{
+	DBusConnection *conn = ofono_dbus_get_connection();
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+	const char *path = ofono_modem_get_path(modem);
+	struct dbus_hw *hw;
+
+	DBG("%p", modem);
+
+	hw = l_new(struct dbus_hw, 1);
+	hw->modem = modem;
+
+	if (!g_dbus_register_interface(conn, path, dbus_hw_interface,
+				       dbus_hw_methods, dbus_hw_signals, NULL,
+				       hw, dbus_hw_cleanup)) {
+		ofono_error("Could not register %s interface under %s",
+			    dbus_hw_interface, path);
+		l_free(hw);
+		return;
+	}
+
+	g_at_chat_register(data->at, "UNDER-VOLTAGE WARNNING POWER DOWN",
+			   power_notify, FALSE, hw, NULL);
+	g_at_chat_register(data->at, "UNDER-VOLTAGE WARNNING",
+			   power_notify, FALSE, hw, NULL);
+	g_at_chat_register(data->at, "OVER-VOLTAGE WARNNING",
+			   power_notify, FALSE, hw, NULL);
+	g_at_chat_register(data->at, "OVER-VOLTAGE WARNNING POWER DOWN",
+			   power_notify, FALSE, hw, NULL);
+
+	ofono_modem_add_interface(modem, dbus_hw_interface);
+}
+
 static void ppptim_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
@@ -169,6 +401,39 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 		ofono_modem_set_powered(modem, TRUE);
 }
 
+static void cvalarm_set_on_cb(gboolean ok, GAtResult *result,
+			      gpointer user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!ok)
+		return;
+
+	dbus_hw_enable(modem);
+
+	/* power up modem */
+	g_at_chat_send(data->at, "AT+CFUN=4", NULL, cfun_set_on_cb, modem,
+		       NULL);
+}
+
+static void cpmvt_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (!ok)
+		return;
+
+	/* enable under/over voltage warning */
+	g_at_chat_send(data->at, "AT+CVALARM=1", NULL, cvalarm_set_on_cb, modem,
+		       NULL);
+}
+
 static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
@@ -205,14 +470,17 @@ static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
 		/* ignore NO CARRIER on the AT channel when disconnecting PPP */
 		g_at_chat_blacklist_terminator(data->at,
 					G_AT_CHAT_TERMINATOR_NO_CARRIER);
+		/* enable under/over voltage warning + powerdown */
+		g_at_chat_send(data->at, "AT+CPMVT=1", NULL, cpmvt_set_on_cb,
+				modem, NULL);
 		break;
 	default:
+		/* power up modem */
+		g_at_chat_send(data->at, "AT+CFUN=4", NULL, cfun_set_on_cb, modem,
+				NULL);
 		break;
 	}
 
-	/* power up modem */
-	g_at_chat_send(data->at, "AT+CFUN=4", NULL, cfun_set_on_cb, modem,
-									NULL);
 }
 
 static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
@@ -317,6 +585,8 @@ static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
 static int sim7100_disable(struct ofono_modem *modem)
 {
 	struct sim7100_data *data = ofono_modem_get_data(modem);
+	DBusConnection *conn = ofono_dbus_get_connection();
+	const char *path = ofono_modem_get_path(modem);
 
 	DBG("");
 
@@ -325,6 +595,14 @@ static int sim7100_disable(struct ofono_modem *modem)
 	g_at_chat_cancel_all(data->at);
 	g_at_chat_unregister_all(data->ppp);
 	g_at_chat_unregister_all(data->at);
+
+	switch (data->model) {
+	case SIMCOM_A7671:
+	case SIMCOM_A7672:
+		if (g_dbus_unregister_interface(conn, path, dbus_hw_interface))
+			ofono_modem_remove_interface(modem, dbus_hw_interface);
+	}
+
 	g_at_chat_send(data->at, "AT+CFUN=0", NULL, cfun_set_off_cb,
 								modem, NULL);
 
-- 
2.52.0

