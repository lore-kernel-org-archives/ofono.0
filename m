Content-Type: multipart/mixed; boundary="===============6267162016461250969=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 2/2] quectel: replace g_at_chat_set_wakeup_command() with
 g_at_chat_retry()
Date: Mon, 12 Aug 2019 22:38:32 +0200
Message-ID: <20190812203832.19096-2-martin@geanix.com>
In-Reply-To: <20190812203832.19096-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6267162016461250969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the modem isn't powered on, the use of g_at_chat_set_wakeup_command()
makes ofono send out AT strings in an endless loop. Avoid this by using
g_at_chat_retry() in a timer instead.
---
 plugins/quectel.c | 64 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index bddf6a17..eef66ced 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -99,6 +99,9 @@ struct quectel_data {
 	int mux_ready_count;
 	int initial_ldisc;
 	struct l_gpio_writer *gpio;
+	struct l_timeout *init_timeout;
+	size_t init_count;
+	guint init_cmd;
 };
 =

 struct dbus_hw {
@@ -186,6 +189,7 @@ static void quectel_remove(struct ofono_modem *modem)
 		g_at_chat_unregister(data->aux, data->cpin_ready);
 =

 	ofono_modem_set_data(modem, NULL);
+	l_timeout_remove(data->init_timeout);
 	l_gpio_writer_free(data->gpio);
 	g_at_chat_unref(data->aux);
 	g_at_chat_unref(data->modem);
@@ -867,6 +871,47 @@ static void ate_cb(int ok, GAtResult *result, void *us=
er_data)
 			cmux_cb, modem, NULL);
 }
 =

+static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const char *rts_cts;
+
+	DBG("%p", modem);
+
+	if (!ok)
+		return;
+
+	rts_cts =3D ofono_modem_get_string(modem, "RtsCts");
+
+	if (strcmp(rts_cts, "on") =3D=3D 0)
+		g_at_chat_send(data->uart, "AT+IFC=3D2,2; E0", none_prefix,
+				ate_cb, modem, NULL);
+	else
+		g_at_chat_send(data->uart, "ATE0", none_prefix, ate_cb, modem,
+				NULL);
+
+	l_timeout_remove(data->init_timeout);
+	data->init_timeout =3D NULL;
+}
+
+static void init_timeout_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (data->init_count++ >=3D 20) {
+		ofono_error("failed to init modem after 20 attempts");
+		close_serial(modem);
+		return;
+	}
+
+	g_at_chat_retry(data->uart, data->init_cmd);
+	l_timeout_modify_ms(timeout, 500);
+}
+
 static int open_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -910,18 +955,15 @@ static int open_serial(struct ofono_modem *modem)
 	 *     a few 'AT' bytes to detect the host UART bitrate, but the RDY is
 	 *     lost.
 	 *
-	 * the wakeup command feature is (mis)used to support all three
-	 * scenarious by sending AT commands until the modem responds with OK,
-	 * at which point the modem is ready.
+	 * Handle all three cases by issuing a plain AT command. The modem
+	 * answers with OK when it is ready. Create a timer to re-issue
+	 * the AT command at regular intervals until the modem answers.
 	 */
-	g_at_chat_set_wakeup_command(data->uart, "AT\r", 500, 10000);
-
-	if (strcmp(rts_cts, "on") =3D=3D 0)
-		g_at_chat_send(data->uart, "AT+IFC=3D2,2; E0", none_prefix,
-				ate_cb, modem, NULL);
-	else
-		g_at_chat_send(data->uart, "ATE0", none_prefix, ate_cb, modem,
-				NULL);
+	data->init_count =3D 0;
+	data->init_cmd =3D g_at_chat_send(data->uart, "AT", none_prefix,
+					init_cmd_cb, modem, NULL);
+	data->init_timeout =3D l_timeout_create_ms(500, init_timeout_cb, modem,
+							NULL);
 =

 	return -EINPROGRESS;
 }
-- =

2.22.0


--===============6267162016461250969==--

