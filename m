Content-Type: multipart/mixed; boundary="===============5133559382406609437=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] quectel: detect missing sim-cards
Date: Mon, 12 Aug 2019 22:50:10 +0200
Message-ID: <20190812205010.21575-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5133559382406609437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The unsolicited +CPIN: NOT INSERTED is lost on the M95 and MC60 modems
during CMUX setup, and the CPIN? query responds with an unhandled
CME ERROR: 10.

Use at_util_sim_state_query_new() to detect SIM presence/pin-state
during power-on. (M95 / MC60 don't support hotplug of sim card).
---

Philip: This patch removes the CFUN? query that is apparently needed for
UC15 modems, but I don't have such a modem to test on. Are you still
working with this and can you test this?

 plugins/quectel.c | 90 ++++++-----------------------------------------
 1 file changed, 11 insertions(+), 79 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index bddf6a17..741aced6 100644
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
@@ -87,12 +86,12 @@ enum quectel_model {
 struct quectel_data {
 	GAtChat *modem;
 	GAtChat *aux;
-	guint cpin_ready;
 	guint call_ready;
 	bool have_sim;
 	enum ofono_vendor vendor;
 	enum quectel_model model;
 	struct l_timeout *sms_ready_timer;
+	struct at_util_sim_state_query *sim_state_query;
 =

 	/* used by quectel uart driver */
 	GAtChat *uart;
@@ -182,9 +181,6 @@ static void quectel_remove(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	if (data->cpin_ready !=3D 0)
-		g_at_chat_unregister(data->aux, data->cpin_ready);
-
 	ofono_modem_set_data(modem, NULL);
 	l_gpio_writer_free(data->gpio);
 	g_at_chat_unref(data->aux);
@@ -523,68 +519,25 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 	ofono_modem_add_interface(modem, dbus_hw_interface);
 }
 =

-static void cpin_notify(GAtResult *result, gpointer user_data)
+static void sim_state_cb(gboolean present, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	const char *sim_inserted;
-	GAtResultIter iter;
 =

 	DBG("%p", modem);
 =

-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+CPIN:"))
-		return;
-
-	g_at_result_iter_next_unquoted_string(&iter, &sim_inserted);
-
-	if (g_strcmp0(sim_inserted, "NOT INSERTED") !=3D 0)
-		data->have_sim =3D true;
-
-	ofono_modem_set_powered(modem, TRUE);
-
-	/* Turn off the radio. */
-	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, NULL, NULL, NULL);
-
-	g_at_chat_unregister(data->aux, data->cpin_ready);
-	data->cpin_ready =3D 0;
+	if (!present)
+		ofono_warn("%s sim not present", ofono_modem_get_path(modem));
 =

+	data->have_sim =3D present;
 	dbus_hw_enable(modem);
+	ofono_modem_set_powered(modem, TRUE);
 }
 =

-static void cpin_query(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	DBG("%p ok %d", user_data, ok);
-
-	if (ok)
-		cpin_notify(result, user_data);
-}
-
-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct quectel_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p ok %d", modem, ok);
-
-	if (!ok) {
-		close_serial(modem);
-		return;
-	}
-
-	data->cpin_ready =3D g_at_chat_register(data->aux, "+CPIN", cpin_notify,
-						FALSE, modem, NULL);
-	g_at_chat_send(data->aux, "AT+CPIN?", cpin_prefix, cpin_query, modem,
-			NULL);
-}
-
-static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
+static void cfun_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	GAtResultIter iter;
-	int cfun;
 =

 	DBG("%p ok %d", modem, ok);
 =

@@ -593,30 +546,9 @@ static void cfun_query(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		return;
 	}
 =

-	g_at_result_iter_init(&iter, result);
-
-	if (g_at_result_iter_next(&iter, "+CFUN:") =3D=3D FALSE) {
-		close_serial(modem);
-		return;
-	}
-
-	g_at_result_iter_next_number(&iter, &cfun);
-
-	/*
-	 * The modem firmware powers up in CFUN=3D1 but will respond to AT+CFUN=
=3D4
-	 * with ERROR until some amount of time (which varies with temperature)
-	 * passes.  Empirical evidence suggests that the firmware will report an
-	 * unsolicited +CPIN: notification when it is ready to be useful.
-	 *
-	 * Work around this feature by only transitioning to CFUN=3D4 if the
-	 * modem is not in CFUN=3D1 or until after we've received an unsolicited
-	 * +CPIN: notification.
-	 */
-	if (cfun !=3D 1)
-		g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, cfun_enable,
-				modem, NULL);
-	else
-		cfun_enable(TRUE, NULL, modem);
+	data->sim_state_query =3D at_util_sim_state_query_new(data->aux, 2, 20,
+								sim_state_cb,
+								modem, NULL);
 }
 =

 static void cgmm_cb(int ok, GAtResult *result, void *user_data)
@@ -651,7 +583,7 @@ static void cgmm_cb(int ok, GAtResult *result, void *us=
er_data)
 		data->model =3D QUECTEL_UNKNOWN;
 	}
 =

-	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix, cfun_query, modem,
+	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, cfun_cb, modem,
 			NULL);
 }
 =

-- =

2.22.0


--===============5133559382406609437==--

