Content-Type: multipart/mixed; boundary="===============3447689401744860719=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH] huawei: follow sim state change notifications
Date: Tue, 25 May 2010 10:56:37 +0300
Message-ID: <20100525075637.32623.43301.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3447689401744860719==
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

 plugins/huawei.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index e1408bd..7d59a26 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -47,9 +47,18 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+enum huawei_state {
+	HUAWEI_DISABLED,
+	HUAWEI_DISABLE,
+	HUAWEI_ENABLE,
+	HUAWEI_ENABLED,
+};
+
 struct huawei_data {
 	GAtChat *chat;
 	GAtChat *event;
+	gint sim_state;
+	enum huawei_state state;
 };
 =

 static int huawei_probe(struct ofono_modem *modem)
@@ -86,14 +95,80 @@ static void huawei_debug(const char *str, void *user_da=
ta)
 	ofono_info("%s%s", prefix, str);
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	gint srv_status, srv_domain, roam, sys_mode, sim_state;
+	GAtResultIter iter;
 =

-	DBG("");
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
+	data->sim_state =3D sim_state;
+
+	if (data->state =3D=3D HUAWEI_ENABLE && data->sim_state =3D=3D 1) {
+		ofono_modem_set_powered(modem, TRUE);
+		data->state =3D HUAWEI_ENABLED;
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
 =

-	if (ok)
+	data->sim_state =3D state;
+
+	if (data->state =3D=3D HUAWEI_ENABLE && data->sim_state =3D=3D 1) {
 		ofono_modem_set_powered(modem, TRUE);
+		data->state =3D HUAWEI_ENABLED;
+	}
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+	if (!ok) {
+		ofono_modem_set_powered(modem, FALSE);
+		data->state =3D HUAWEI_DISABLED;
+		return;
+	}
+
+	/* check sim state */
+	g_at_chat_send(data->chat, "AT^SYSINFO", NULL, sysinfo_cb, modem, NULL);
 }
 =

 static GAtChat *create_port(const char *device)
@@ -155,12 +230,19 @@ static int huawei_enable(struct ofono_modem *modem)
 		g_at_chat_set_debug(data->event, huawei_debug,
 					"EventChannel: ");
 =

+	data->state =3D HUAWEI_ENABLE;
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
@@ -173,8 +255,11 @@ static void cfun_disable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	g_at_chat_unref(data->chat);
 	data->chat =3D NULL;
 =

-	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
+	if (!ok)
+		return;
+
+	ofono_modem_set_powered(modem, FALSE);
+	data->state =3D HUAWEI_DISABLED;
 }
 =

 static int huawei_disable(struct ofono_modem *modem)
@@ -183,6 +268,8 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	data->state =3D HUAWEI_DISABLE;
+
 	if (data->event) {
 		g_at_chat_cancel_all(data->event);
 		g_at_chat_unregister_all(data->event);


--===============3447689401744860719==--

