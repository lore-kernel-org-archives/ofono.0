Content-Type: multipart/mixed; boundary="===============0740377820383960494=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2] huawei: follow sim state change notifications
Date: Tue, 25 May 2010 11:48:57 +0300
Message-ID: <20100525084857.1105.91785.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0740377820383960494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With Huawei E1552 I got sim busy errors when I plugged in the modem
and ofono was already running:

May 24 17:02:04 tukki ofonod[7619]: > AT+CRC=3D1\r
May 24 17:02:04 tukki ofonod[7619]: < \r\n+CME ERROR: SIM busy\r\n
May 24 17:02:04 tukki ofonod[7619]: > AT+CLIP=3D1\r
May 24 17:02:04 tukki ofonod[7619]: < \r\n+CME ERROR: SIM busy\r\n

Fix this by following sim state changes with ^SIMST notification and
only enable modem after SIM is ready. In case SIM is already ready
and we miss the notification for some reason, also use AT^SYSINFO
to check the state during enable phase.

Also change huawei_enable() to return -EINPROGRESS to make sure that
ofono modem is not powered too early. I believe this was a bug.
---

 plugins/huawei.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index e1408bd..6e45757 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -50,6 +50,7 @@
 struct huawei_data {
 	GAtChat *chat;
 	GAtChat *event;
+	gint sim_state;
 };
 =

 static int huawei_probe(struct ofono_modem *modem)
@@ -86,14 +87,77 @@ static void huawei_debug(const char *str, void *user_da=
ta)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	gint srv_status, srv_domain, roam, sys_mode, sim_state;
+	GAtResultIter iter;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &srv_status))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &srv_domain))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &roam))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &sys_mode))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &sim_state))
+		return;
+
+	if (data->sim_state =3D=3D 0 && sim_state =3D=3D 1) {
+		ofono_modem_set_powered(modem, TRUE);
+		data->sim_state =3D sim_state;
+	}
+}
+
+static void huawei_simst_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int state;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SIMST:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &state))
+		return;
+
+	if (data->sim_state =3D=3D 0 && state =3D=3D 1) {
+		ofono_modem_set_powered(modem, TRUE);
+		data->sim_state =3D state;
+	}
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("");
 =

-	if (ok)
-		ofono_modem_set_powered(modem, TRUE);
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	/* check sim state */
+	g_at_chat_send(data->chat, "AT^SYSINFO", NULL, sysinfo_cb, modem, NULL);
 }
 =

 static GAtChat *create_port(const char *device)
@@ -155,12 +219,18 @@ static int huawei_enable(struct ofono_modem *modem)
 		g_at_chat_set_debug(data->event, huawei_debug,
 					"EventChannel: ");
 =

+	data->sim_state =3D 0;
+
+	/* follow sim state */
+	g_at_chat_register(data->event, "^SIMST:", huawei_simst_notify,
+			FALSE, modem, NULL);
+
 	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL, NULL);
 =

 	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
 					cfun_enable, modem, NULL);
 =

-	return 0;
+	return -EINPROGRESS;
 }
 =

 static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)


--===============0740377820383960494==--

