Content-Type: multipart/mixed; boundary="===============9029045070326856825=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv2 1/2] quectel: rework sim detection
Date: Mon, 30 Sep 2019 21:54:38 +0200
Message-ID: <20190930195439.1442573-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9029045070326856825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use at_util_sim_state_query_new() to query the sim inserted state. Once
that returns, the locked state is queried by issuing a AT+CPIN? command.

If not locked, a timer is started to query the quectel init status of
the sim. Once the init status is ready, the sim atom is created, and the
modem is set to powered, and the sim is signaled both inserted, and
initialized.

If locked, the modem is set to powered, and the sim atom is created.
This allows users to enter the pin to unlock the sim. Once the sim is
unlocked, a +CPIN: READY indication is caught to query the quectel
init status. Once the init status is ready, the sim is signaled
initialized.

All the above is needed, because the modem indicated +CPIN: READY before
the sim is really ready. The only way to be certain, is to wait for the
quectel init status to be ready. Even signaling the sim inserted
prematurely can cause to modem to hang during the initial AT+CRSM
commands.
---

Changes since v1:
 * use at_util_sim_state_query_new() during .enable()
 * query CPIN? locked/unlocked after sim_state_query()
 * avoid sending at commands in .pre_sim()

 plugins/quectel.c | 255 +++++++++++++++++-----------------------------
 1 file changed, 94 insertions(+), 161 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index a0e435b5..f19065b2 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -84,22 +84,15 @@ enum quectel_model {
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
-	struct ofono_sim *sim;
-	enum ofono_sim_state sim_state;
+	struct at_util_sim_state_query *sim_state_query;
 	unsigned int sim_watch;
+	bool sim_locked;
+	bool sim_ready;
 =

 	/* used by quectel uart driver */
 	GAtChat *uart;
@@ -195,6 +188,7 @@ static void quectel_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 	l_timeout_remove(data->init_timeout);
 	l_gpio_writer_free(data->gpio);
+	at_util_sim_state_query_free(data->sim_state_query);
 	g_at_chat_unref(data->aux);
 	g_at_chat_unref(data->modem);
 	g_at_chat_unref(data->uart);
@@ -238,6 +232,9 @@ static void close_serial(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	at_util_sim_state_query_free(data->sim_state_query);
+	data->sim_state_query =3D NULL;
+
 	g_at_chat_unref(data->aux);
 	data->aux =3D NULL;
 =

@@ -534,6 +531,7 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct ofono_sim *sim =3D ofono_modem_get_sim(modem);
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 	GAtResultIter iter;
 	int ready =3D 0;
@@ -574,42 +572,13 @@ static void qinistat_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	l_timeout_remove(data->init_timeout);
 	data->init_timeout =3D NULL;
 =

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
+	if (data->sim_locked) {
+		ofono_sim_initialized_notify(sim);
 		return;
 	}
 =

-	ofono_sms_create(modem, data->vendor, "atmodem", data->aux);
-	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
-	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
-	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
-	data->state =3D QUECTEL_STATE_INITIALIZED;
+	data->sim_ready =3D true;
+	ofono_modem_set_powered(modem, TRUE);
 }
 =

 static void init_timer_cb(struct l_timeout *timeout, void *user_data)
@@ -627,118 +596,94 @@ static void sim_watch_cb(GAtResult *result, void *us=
er_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	const char *cpin;
 =

 	DBG("%p", modem);
 =

-	g_at_chat_unregister(data->aux, data->sim_watch);
-	data->sim_watch =3D 0;
+	g_at_result_iter_init(&iter, result);
 =

-	data->init_timeout =3D l_timeout_create_ms(500, init_timer_cb, modem, NUL=
L);
-	if (!data->init_timeout) {
-		close_serial(modem);
+	if (!g_at_result_iter_next(&iter, "+CPIN:"))
 		return;
-	}
-}
 =

-static enum ofono_sim_state cme_parse(GAtResult *result)
-{
-	struct ofono_error error;
+	g_at_result_iter_next_unquoted_string(&iter, &cpin);
 =

-	decode_at_error(&error, g_at_result_final_response(result));
+	if (g_strcmp0(cpin, "READY") !=3D 0)
+		return;
 =

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
+	g_at_chat_unregister(data->aux, data->sim_watch);
+	data->sim_watch =3D 0;
+
+	data->init_timeout =3D l_timeout_create_ms(500, init_timer_cb, modem, NUL=
L);
 }
 =

-static enum ofono_sim_state cpin_parse(GAtResult *result)
+static void cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const char *path =3D ofono_modem_get_path(modem);
 	GAtResultIter iter;
 	const char *cpin;
 =

+	DBG("%p", modem);
+
+	if (!ok) {
+		close_serial(modem);
+		return;
+	}
+
 	g_at_result_iter_init(&iter, result);
 =

-	if (!g_at_result_iter_next(&iter, "+CPIN:"))
-		return OFONO_SIM_STATE_RESETTING;
+	if (!g_at_result_iter_next(&iter, "+CPIN:")) {
+		close_serial(modem);
+		return;
+	}
 =

 	g_at_result_iter_next_unquoted_string(&iter, &cpin);
 =

-	if (g_strcmp0(cpin, "NOT INSERTED") =3D=3D 0)
-		return OFONO_SIM_STATE_NOT_PRESENT;
+	if (g_strcmp0(cpin, "READY") =3D=3D 0) {
+		data->init_timeout =3D l_timeout_create_ms(500, init_timer_cb,
+								modem, NULL);
+		return;
+	}
 =

-	if (g_strcmp0(cpin, "READY") =3D=3D 0)
-		return OFONO_SIM_STATE_READY;
+	if (g_strcmp0(cpin, "SIM PIN") !=3D 0) {
+		close_serial(modem);
+		return;
+	}
 =

-	return OFONO_SIM_STATE_LOCKED_OUT;
+	ofono_info("%s: sim locked", path);
+	data->sim_locked =3D true;
+	data->sim_watch =3D g_at_chat_register(data->aux, "+CPIN:",
+						sim_watch_cb, FALSE,
+						modem, NULL);
+	ofono_modem_set_powered(modem, TRUE);
 }
 =

-static void cpin_query(gboolean ok, GAtResult *result, gpointer user_data)
+static void sim_state_cb(gboolean present, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const char *path =3D ofono_modem_get_path(modem);
 =

-	DBG("%p ok %i", modem, ok);
+	DBG("%p present %d", modem, present);
 =

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
+	at_util_sim_state_query_free(data->sim_state_query);
+	data->sim_state_query =3D NULL;
+	data->sim_locked =3D false;
+	data->sim_ready =3D false;
+
+	if (!present) {
+		ofono_modem_set_powered(modem, TRUE);
+		ofono_warn("%s: sim not present", path);
+		return;
 	}
+
+	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_cb, modem,
+			NULL);
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+static void cfun_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -751,8 +696,24 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	}
 =

 	dbus_hw_enable(modem);
+	data->sim_state_query =3D at_util_sim_state_query_new(data->aux,
+						2, 20, sim_state_cb, modem,
+						NULL);
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
 =

-	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query, modem,
+	DBG("%p ok %d", modem, ok);
+
+	if (!ok) {
+		close_serial(modem);
+		return;
+	}
+
+	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, cfun_cb, modem,
 			NULL);
 }
 =

@@ -1108,8 +1069,6 @@ static int quectel_disable(struct ofono_modem *modem)
 	g_at_chat_send(data->aux, "AT+CFUN=3D0", cfun_prefix, cfun_disable, modem,
 			NULL);
 =

-	data->state =3D QUECTEL_STATE_INITIALIZING;
-
 	return -EINPROGRESS;
 }
 =

@@ -1146,22 +1105,18 @@ static void quectel_set_online(struct ofono_modem *=
modem, ofono_bool_t online,
 static void quectel_pre_sim(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
-	data->sim =3D ofono_sim_create(modem, data->vendor, "atmodem", data->aux);
-	if (!data->sim)
-		return;
+	ofono_voicecall_create(modem, data->vendor, "atmodem", data->aux);
+	sim =3D ofono_sim_create(modem, data->vendor, "atmodem", data->aux);
 =

-	switch (data->sim_state) {
-	case OFONO_SIM_STATE_LOCKED_OUT:
-	case OFONO_SIM_STATE_READY:
-		ofono_sim_inserted_notify(data->sim, true);
-		break;
-	default:
-		break;
-	}
+	if (data->sim_locked || data->sim_ready)
+		ofono_sim_inserted_notify(sim, true);
+
+	if (data->sim_ready)
+		ofono_sim_initialized_notify(sim);
 }
 =

 static void quectel_post_sim(struct ofono_modem *modem)
@@ -1179,31 +1134,9 @@ static void quectel_post_sim(struct ofono_modem *mod=
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

--===============9029045070326856825==--

