Content-Type: multipart/mixed; boundary="===============5429029732376404776=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 3/4] quectel: rework sim detection
Date: Thu, 26 Sep 2019 21:27:24 +0200
Message-ID: <20190926192725.227285-3-martin@geanix.com>
In-Reply-To: <20190926192725.227285-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5429029732376404776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Simplify sim handling by querying cpin state directly from
quectel_pre_sim().

The query is conducted by issuing a AT+CPIN?, where only CME errors are
catched by the command response handler. The +CPIN: <state> response is
instead catched by a listener.

The CME handler allows proper handling of the sim-busy and sim-not-
inserted states, which are returned as CME errors by the quectel
modems.

The +CPIN listener allows handling of both sim-locked and sim-ready
states. When the sim is not locked, the listener catches the +CPIN:
READY response from the query in quectel_pre_sim(). If the sim is
locked, the listener catched the +CPIN: READY indication received after
unlocking the sim.
---
 plugins/quectel.c | 401 +++++++++++++++++-----------------------------
 1 file changed, 149 insertions(+), 252 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index a0e435b5..4c94d305 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -59,7 +59,6 @@
 #include <drivers/atmodem/vendor.h>
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
-static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *cbc_prefix[] =3D { "+CBC:", NULL };
 static const char *qinistat_prefix[] =3D { "+QINISTAT:", NULL };
 static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", "Quectel_MC6=
0",
@@ -84,21 +83,12 @@ enum quectel_model {
 	QUECTEL_MC60,
 };
 =

-enum quectel_state {
-	QUECTEL_STATE_INITIALIZING =3D 0,
-	QUECTEL_STATE_POST_SIM,
-	QUECTEL_STATE_READY,
-	QUECTEL_STATE_INITIALIZED,
-};
-
 struct quectel_data {
 	GAtChat *modem;
 	GAtChat *aux;
 	enum ofono_vendor vendor;
 	enum quectel_model model;
-	enum quectel_state state;
 	struct ofono_sim *sim;
-	enum ofono_sim_state sim_state;
 	unsigned int sim_watch;
 =

 	/* used by quectel uart driver */
@@ -531,213 +521,6 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 	ofono_modem_add_interface(modem, dbus_hw_interface);
 }
 =

-static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	GAtResultIter iter;
-	int ready =3D 0;
-	int status;
-
-	DBG("%p", modem);
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+QINISTAT:"))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &status))
-		return;
-
-	DBG("qinistat: %d", status);
-
-	switch (data->model) {
-	case QUECTEL_UC15:
-		/* UC15 uses a bitmap of 1 + 2 + 4 =3D 7 */
-		ready =3D 7;
-		break;
-	case QUECTEL_M95:
-	case QUECTEL_MC60:
-		/* M95 and MC60 uses a counter to 3 */
-		ready =3D 3;
-		break;
-	case QUECTEL_UNKNOWN:
-		ready =3D 0;
-		break;
-	}
-
-	if (status !=3D ready) {
-		l_timeout_modify_ms(data->init_timeout, 500);
-		return;
-	}
-
-	l_timeout_remove(data->init_timeout);
-	data->init_timeout =3D NULL;
-
-	if (data->sim_state =3D=3D OFONO_SIM_STATE_READY) {
-		/*
-		 * when initializing with a non-locked sim card, the sim atom
-		 * isn't created until now to avoid accessing it before the
-		 * modem is ready.
-		 *
-		 * call ofono_modem_set_powered() to make ofono call
-		 * quectel_pre_sim() where the sim atom is created.
-		 */
-		ofono_modem_set_powered(modem, true);
-	} else {
-		/*
-		 * When initialized with a locked sim card, the modem is already
-		 * powered up, and the inserted signal has been sent to allow
-		 * the pin to be entered. So simply update the state, and notify
-		 * about the finished initialization below.
-		 */
-		data->sim_state =3D OFONO_SIM_STATE_READY;
-	}
-
-	ofono_sim_initialized_notify(data->sim);
-
-	/*
-	 * If quectel_post_sim() has not yet been called, then postpone atom
-	 * creation until it is called. Otherwise create the atoms now.
-	 */
-	if (data->state !=3D QUECTEL_STATE_POST_SIM) {
-		data->state =3D QUECTEL_STATE_READY;
-		return;
-	}
-
-	ofono_sms_create(modem, data->vendor, "atmodem", data->aux);
-	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
-	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
-	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
-	data->state =3D QUECTEL_STATE_INITIALIZED;
-}
-
-static void init_timer_cb(struct l_timeout *timeout, void *user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct quectel_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	g_at_chat_send(data->aux, "AT+QINISTAT", qinistat_prefix, qinistat_cb,
-			modem, NULL);
-}
-
-static void sim_watch_cb(GAtResult *result, void *user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct quectel_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	g_at_chat_unregister(data->aux, data->sim_watch);
-	data->sim_watch =3D 0;
-
-	data->init_timeout =3D l_timeout_create_ms(500, init_timer_cb, modem, NUL=
L);
-	if (!data->init_timeout) {
-		close_serial(modem);
-		return;
-	}
-}
-
-static enum ofono_sim_state cme_parse(GAtResult *result)
-{
-	struct ofono_error error;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-
-	if (error.type !=3D OFONO_ERROR_TYPE_CME)
-		return OFONO_SIM_STATE_RESETTING;
-
-	switch (error.error) {
-	case 5:
-	case 6:
-	case 7:
-	case 11:
-	case 12:
-	case 17:
-	case 18:
-		return OFONO_SIM_STATE_LOCKED_OUT;
-	case 10:
-		return OFONO_SIM_STATE_NOT_PRESENT;
-	case 13:
-	case 14:
-	case 15:
-		return OFONO_SIM_STATE_RESETTING;
-	default:
-		ofono_error("unknown cpin error: %i", error.error);
-		return OFONO_SIM_STATE_RESETTING;
-	}
-}
-
-static enum ofono_sim_state cpin_parse(GAtResult *result)
-{
-	GAtResultIter iter;
-	const char *cpin;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+CPIN:"))
-		return OFONO_SIM_STATE_RESETTING;
-
-	g_at_result_iter_next_unquoted_string(&iter, &cpin);
-
-	if (g_strcmp0(cpin, "NOT INSERTED") =3D=3D 0)
-		return OFONO_SIM_STATE_NOT_PRESENT;
-
-	if (g_strcmp0(cpin, "READY") =3D=3D 0)
-		return OFONO_SIM_STATE_READY;
-
-	return OFONO_SIM_STATE_LOCKED_OUT;
-}
-
-static void cpin_query(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct quectel_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p ok %i", modem, ok);
-
-	if (ok)
-		data->sim_state =3D cpin_parse(result);
-	else
-		data->sim_state =3D cme_parse(result);
-
-	/* Turn off the radio. */
-	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, NULL, NULL, NULL);
-
-	switch (data->sim_state) {
-	case OFONO_SIM_STATE_LOCKED_OUT:
-		ofono_modem_set_powered(modem, true);
-		data->sim_watch =3D g_at_chat_register(data->aux, "+CPIN: READY",
-							sim_watch_cb, FALSE,
-							modem, NULL);
-		if (!data->sim_watch) {
-			ofono_error("failed to create sim watch");
-			close_serial(modem);
-			return;
-		}
-		break;
-	case OFONO_SIM_STATE_READY:
-		data->init_timeout =3D l_timeout_create_ms(500, init_timer_cb,
-							modem, NULL);
-		if (!data->init_timeout) {
-			ofono_error("failed to create qinitstat timer");
-			close_serial(modem);
-			return;
-		}
-		break;
-	case OFONO_SIM_STATE_RESETTING:
-	case OFONO_SIM_STATE_INSERTED:
-		g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query,
-				modem, NULL);
-		break;
-	case OFONO_SIM_STATE_NOT_PRESENT:
-		ofono_warn("%s: sim not present", ofono_modem_get_path(modem));
-		ofono_modem_set_powered(modem, true);
-	}
-}
-
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -751,9 +534,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	}
 =

 	dbus_hw_enable(modem);
-
-	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query, modem,
-			NULL);
+	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, NULL, NULL, NULL);
+	ofono_modem_set_powered(modem, true);
 }
 =

 static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
@@ -1108,8 +890,6 @@ static int quectel_disable(struct ofono_modem *modem)
 	g_at_chat_send(data->aux, "AT+CFUN=3D0", cfun_prefix, cfun_disable, modem,
 			NULL);
 =

-	data->state =3D QUECTEL_STATE_INITIALIZING;
-
 	return -EINPROGRESS;
 }
 =

@@ -1143,27 +923,166 @@ static void quectel_set_online(struct ofono_modem *=
modem, ofono_bool_t online,
 	g_free(cbd);
 }
 =

-static void quectel_pre_sim(struct ofono_modem *modem)
+static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
+	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int ready =3D 0;
+	int status;
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
-	data->sim =3D ofono_sim_create(modem, data->vendor, "atmodem", data->aux);
-	if (!data->sim)
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+QINISTAT:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	DBG("qinistat: %d", status);
+
+	switch (data->model) {
+	case QUECTEL_UC15:
+		/* UC15 uses a bitmap of 1 + 2 + 4 =3D 7 */
+		ready =3D 7;
+		break;
+	case QUECTEL_M95:
+	case QUECTEL_MC60:
+		/* M95 and MC60 uses a counter to 3 */
+		ready =3D 3;
+		break;
+	case QUECTEL_UNKNOWN:
+		ready =3D 0;
+		break;
+	}
+
+	if (status !=3D ready) {
+		l_timeout_modify_ms(data->init_timeout, 500);
+		return;
+	}
+
+	l_timeout_remove(data->init_timeout);
+	data->init_timeout =3D NULL;
+
+	if (ofono_sim_get_state(data->sim) =3D=3D OFONO_SIM_STATE_INSERTED)
+		ofono_sim_initialized_notify(data->sim);
+	else
+		ofono_sim_inserted_notify(data->sim, true);
+}
+
+static void init_timer_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_send(data->aux, "AT+QINISTAT", qinistat_prefix, qinistat_cb,
+			modem, NULL);
+}
+
+static void sim_watch_cb(GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	enum ofono_sim_state state =3D ofono_sim_get_state(data->sim);
+	const char *path =3D ofono_modem_get_path(modem);
+	GAtResultIter iter;
+	const char *cpin;
+
+	DBG("%p", modem);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CPIN:"))
 		return;
 =

-	switch (data->sim_state) {
-	case OFONO_SIM_STATE_LOCKED_OUT:
-	case OFONO_SIM_STATE_READY:
+	g_at_result_iter_next_unquoted_string(&iter, &cpin);
+
+	if (g_strcmp0(cpin, "NOT INSERTED") =3D=3D 0) {
+		ofono_warn("%s: sim not present", path);
+		return;
+	}
+
+	if (g_strcmp0(cpin, "READY") !=3D 0) {
+		if (state !=3D OFONO_SIM_STATE_INSERTED) {
+			ofono_info("%s: sim locked", path);
+			ofono_sim_inserted_notify(data->sim, true);
+		}
+
+		return;
+	}
+
+	g_at_chat_unregister(data->aux, data->sim_watch);
+	data->sim_watch =3D 0;
+
+	data->init_timeout =3D l_timeout_create_ms(500, init_timer_cb, modem, NUL=
L);
+	if (!data->init_timeout) {
+		close_serial(modem);
+		return;
+	}
+}
+
+static void cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_error error;
+
+	if (ok)
+		return;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (error.type !=3D OFONO_ERROR_TYPE_CME)
+		return;
+
+	switch (error.error) {
+	case 5:
+	case 6:
+	case 7:
+	case 11:
+	case 12:
+	case 17:
+	case 18:
 		ofono_sim_inserted_notify(data->sim, true);
 		break;
-	default:
+	case 10:
+		ofono_warn("%s: sim not present", ofono_modem_get_path(modem));
+		break;
+	case 13:
+	case 14:
+	case 15:
+		/* wait for +CPIN: indication */
 		break;
+	default:
+		ofono_error("unknown cpin error: %i", error.error);
 	}
 }
 =

+static void quectel_pre_sim(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
+	data->sim =3D ofono_sim_create(modem, data->vendor, "atmodem", data->aux);
+	data->sim_watch =3D g_at_chat_register(data->aux, "+CPIN:", sim_watch_cb,
+						FALSE, modem, NULL);
+
+	/*
+	 * unsolicited indications about a missing or locked sim can occur before
+	 * the auto-baud dance in open_serial(), so issue a CPIN query here
+	 *
+	 * the callback is only called for CME errors to catch those. The +CPIN
+	 * response is catched by the watch registered above
+	 */
+	g_at_chat_send(data->aux, "AT+CPIN?", none_prefix, cpin_cb, modem, NULL);
+}
+
 static void quectel_post_sim(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -1179,31 +1098,9 @@ static void quectel_post_sim(struct ofono_modem *mod=
em)
 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
 =

-	/*
-	 * the sim related atoms must not be created until the modem is really
-	 * ready, so check the state here
-	 */
-	switch (data->state) {
-	case QUECTEL_STATE_INITIALIZING:
-		/*
-		 * the modem is still initializing, so postpone the atom
-		 * creation until qinistat_cb() determines the modem is
-		 * ready
-		 */
-		data->state =3D QUECTEL_STATE_POST_SIM;
-		return;
-	case QUECTEL_STATE_READY:
-		/* the modem is ready, so create atoms below */
-		break;
-	default:
-		return;
-	}
-
 	ofono_sms_create(modem, data->vendor, "atmodem", data->aux);
 	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
-	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
 	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
-	data->state =3D QUECTEL_STATE_INITIALIZED;
 }
 =

 static void quectel_post_online(struct ofono_modem *modem)
-- =

2.23.0


--===============5429029732376404776==--

