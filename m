Content-Type: multipart/mixed; boundary="===============1789763735844717385=="
MIME-Version: 1.0
From: Mingli Wu <mingli@southpole.se>
Subject: [PATCH 3/3] Delay 10 seconds between CFUN=4 and CFUN=1
Date: Mon, 17 Dec 2012 17:22:18 +0100
Message-ID: <1355761338-9081-4-git-send-email-mingli@southpole.se>
In-Reply-To: <1355761338-9081-1-git-send-email-mingli@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1789763735844717385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According Telit software user guide:
Note: the protocol implementation of the module requires a
delay between consecutive activation of CFUN=3D1 and CFUN=3D4
(or vice versa) modes. It is suggested to use a delay of
10 sec.
---
 plugins/telit.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 77 insertions(+)

diff --git a/plugins/telit.c b/plugins/telit.c
index aaf2a9d..8938425 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -31,6 +31,7 @@
 #include <termios.h>
 #include <string.h>
 #include <sys/socket.h>
+#include <time.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -75,6 +76,10 @@ struct telit_data {
 	GIOChannel *hw_io;
 	guint bt_watch;
 	guint hw_watch;
+	int cfun_cmd;
+	time_t cfun_time;
+	struct cb_data *cbd;
+	ofono_bool_t online;
 };
 =

 static void telit_debug(const char *str, void *user_data)
@@ -408,6 +413,10 @@ static int telit_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
 				cfun_enable_cb, modem, NULL);
 =

+	data->cfun_time =3D time(NULL);
+	data->cfun_cmd =3D 1;
+	data->online =3D FALSE;
+
 	return -EINPROGRESS;
 }
 =

@@ -614,6 +623,20 @@ static void telit_pre_sim(struct ofono_modem *modem)
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 }
 =

+static gboolean post_sim_offline_timeout_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	if (!ofono_modem_get_online(modem)){
+		g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
+				NULL, NULL, NULL);
+		data->cfun_time =3D time(NULL);		=

+		data->cfun_cmd =3D 4;
+		data->online =3D FALSE;
+	}
+}
+
 static void telit_post_sim(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
@@ -632,9 +655,13 @@ static void telit_post_sim(struct ofono_modem *modem)
 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
 =

+	/* Wait for 10 secs, and then check whether it should be online */
+	g_timeout_add_seconds(10, post_sim_offline_timeout_cb, modem);
+#if 0
 	if (!ofono_modem_get_online(modem))
 		g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
 				NULL, NULL, NULL);
+#endif
 }
 =

 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
@@ -647,17 +674,67 @@ static void set_online_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	cb(&error, cbd->data);
 }
 =

+static gboolean set_online_timeout_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+	int cfun_cmd =3D data->online ? 1 : 4;
+
+	char const *command =3D data->online ? "AT+CFUN=3D1,0" : "AT+CFUN=3D4,0";
+
+	/* Before timeout, online status might already be changed */
+	if(data->cfun_cmd =3D=3D cfun_cmd){
+		return;
+	}
+
+	g_at_chat_send(data->chat, command, none_prefix, set_online_cb,
+				data->cbd, g_free);
+
+	data->cfun_time =3D time(NULL);
+	data->cfun_cmd =3D cfun_cmd;
+
+	if (data->online) {
+		/* =

+		 * Query current sim state in case it changed while we
+		 * were offline and ignoring the QSS: 0 reports.
+		 */
+		g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
+		telit_qss_cb, modem, NULL);
+	}
+}
+
 static void telit_set_online(struct ofono_modem *modem, ofono_bool_t onlin=
e,
 				ofono_modem_online_cb_t cb, void *user_data)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 	char const *command =3D online ? "AT+CFUN=3D1,0" : "AT+CFUN=3D4,0";
+	int cfun_cmd =3D online ? 1 : 4;
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
+	=

+	data->online =3D online;
+	if(data->cfun_cmd !=3D cfun_cmd){
+		time_t val =3D abs(time(NULL) - data->cfun_time);
+
+		/*
+		 * According Telit software user guide:
+		 * the protocol implementation of the module
+		 * requires a delay between consecutive activation =

+		 * of CFUN=3D1 and CFUN=3D4 (or vice versa) modes. =

+		 * It is suggested to use a delay of 10 sec.
+		 */
+		if(val < 10){
+			data->cbd =3D cbd;
+			g_timeout_add_seconds(10 - val, set_online_timeout_cb, modem);
+			return;
+		}
+	}
 =

 	g_at_chat_send(data->chat, command, none_prefix, set_online_cb,
 						cbd, g_free);
+	data->cfun_time =3D time(NULL);
+	data->cfun_cmd =3D cfun_cmd;
 =

 	if (online) {
 		/* Query current sim state in case it changed while we
-- =

1.7.9.5


--===============1789763735844717385==--

