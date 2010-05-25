Content-Type: multipart/mixed; boundary="===============8597938986191915595=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 2/4] huawei: properly notify sim state to ofono
Date: Tue, 25 May 2010 17:23:19 +0300
Message-ID: <20100525142319.10449.65642.stgit@potku.valot.fi>
In-Reply-To: <20100525142205.10449.64616.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8597938986191915595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of using ofono_modem_set_powered(), use ofono_sim_inserted_notify()
which is the proper way to notify about sim state changes.

Now the problem is that voicecall commands fail with my Huawei E1552:

ofonod[12395]: > AT+CRC=3D1\r
ofonod[12395]: src/sim.c:ofono_sim_add_state_watch() 0x1bf8e50
ofonod[12395]: src/sim.c:ofono_sim_add_state_watch() 0x1bf8e50
ofonod[12395]: < \r\n+CME ERROR: SIM busy\r\n
ofonod[12395]: > AT+CLIP=3D1\r
ofonod[12395]: < \r\n+CME ERROR: SIM busy\r\n
ofonod[12395]: > AT+COLP=3D1\r
ofonod[12395]: < \r\n+CME ERROR: SIM busy\r\n
ofonod[12395]: > AT+CCWA=3D1\r
ofonod[12395]: < \r\n+CME ERROR: SIM busy\r\n
ofonod[12395]: drivers/atmodem/voicecall.c:at_voicecall_initialized()
  voicecall_init: registering to notifications
ofonod[12395]: src/sim.c:ofono_sim_add_state_watch() 0x1bf8e50
ofonod[12395]: > AT^SYSINFO\r
ofonod[12395]: < \r\n^SYSINFO:0,0,0,0,255,,0\r\n\r\nOK\r\n
ofonod[12395]: > AT+CGMI\r
ofonod[12395]: < \r\nhuawei\r\n\r\nOK\r\n
ofonod[12395]: EventChannel: < \r\n^STIN:0,0,0\r\n
ofonod[12395]: > AT+CLCC\r
ofonod[12395]: < \r\n+CME ERROR: SIM busy\r\n

But as I can't make voice calls with this modem anyway, I don't worry
about them right now.
---

 plugins/huawei.c |   44 +++++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 1c44be1..962895a 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -50,6 +50,7 @@
 struct huawei_data {
 	GAtChat *chat;
 	GAtChat *event;
+	struct ofono_sim *sim;
 	gint sim_state;
 };
 =

@@ -87,6 +88,17 @@ static void huawei_debug(const char *str, void *user_dat=
a)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static void notify_sim_state(struct huawei_data *data, gint sim_state)
+{
+	if (data->sim_state =3D=3D 0 && sim_state =3D=3D 1) {
+		ofono_sim_inserted_notify(data->sim, TRUE);
+		data->sim_state =3D sim_state;
+	} else if (data->sim_state =3D=3D 1 && sim_state =3D=3D 0) {
+		ofono_sim_inserted_notify(data->sim, FALSE);
+		data->sim_state =3D sim_state;
+	}
+}
+
 static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -117,10 +129,7 @@ static void sysinfo_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	if (!g_at_result_iter_next_number(&iter, &sim_state))
 		return;
 =

-	if (data->sim_state =3D=3D 0 && sim_state =3D=3D 1) {
-		ofono_modem_set_powered(modem, TRUE);
-		data->sim_state =3D sim_state;
-	}
+	notify_sim_state(data, sim_state);
 }
 =

 static void simst_notify(GAtResult *result, gpointer user_data)
@@ -138,10 +147,7 @@ static void simst_notify(GAtResult *result, gpointer u=
ser_data)
 	if (!g_at_result_iter_next_number(&iter, &state))
 		return;
 =

-	if (data->sim_state =3D=3D 0 && state =3D=3D 1) {
-		ofono_modem_set_powered(modem, TRUE);
-		data->sim_state =3D state;
-	}
+	notify_sim_state(data, state);
 }
 =

 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
@@ -151,12 +157,16 @@ static void cfun_enable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	DBG("");
 =

-	if (!ok) {
-		ofono_modem_set_powered(modem, FALSE);
+	ofono_modem_set_powered(modem, ok);
+
+	if (!ok)
 		return;
-	}
 =

-	/* check sim state */
+	/* follow sim state */
+	g_at_chat_register(data->event, "^SIMST:", simst_notify,
+							FALSE, modem, NULL);
+
+	/* query current sim state */
 	g_at_chat_send(data->chat, "AT^SYSINFO", NULL, sysinfo_cb, modem, NULL);
 }
 =

@@ -221,10 +231,6 @@ static int huawei_enable(struct ofono_modem *modem)
 =

 	data->sim_state =3D 0;
 =

-	/* follow sim state */
-	g_at_chat_register(data->event, "^SIMST:", simst_notify,
-							FALSE, modem, NULL);
-
 	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL, NULL);
 =

 	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
@@ -274,16 +280,12 @@ static int huawei_disable(struct ofono_modem *modem)
 static void huawei_pre_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
+	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
-
-	if (sim)
-		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void cgreg_notify(GAtResult *result, gpointer user_data)


--===============8597938986191915595==--

