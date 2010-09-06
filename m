Content-Type: multipart/mixed; boundary="===============8571878337449934646=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online-impl-v2 PATCH 02/10] calypso: implement Online property
Date: Mon, 06 Sep 2010 21:46:12 +0300
Message-ID: <1283798780-16363-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283798780-16363-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8571878337449934646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/calypso.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/plugins/calypso.c b/plugins/calypso.c
index a2d4ec8..0cecc76 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -56,6 +56,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/stk.h>
 =

+#include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

 #define CALYPSO_POWER_PATH "/sys/bus/platform/devices/neo1973-pm-gsm.0/pow=
er_on"
@@ -507,7 +508,7 @@ static void calypso_pre_sim(struct ofono_modem *modem)
 	 * mode 4 -> 1 transitions work and have no side effects.
 	 *
 	 * So in order to switch to Offline mode at startup,
-	 * AT+CFUN=3D1;+CFUN=3D4 would be needed.
+	 * AT+CFUN=3D1;+CFUN=3D4 is be needed.
 	 *
 	 * Additionally AT+CFUN=3D1 response is not checked: on PIN-enabled
 	 * cards, it will in most situations return "+CME ERROR: SIM PIN
@@ -518,14 +519,47 @@ static void calypso_pre_sim(struct ofono_modem *modem)
 	if (data->have_sim && data->sim)
 		ofono_stk_create(modem, 0, "calypsomodem", data->dlcs[AUX_DLC]);
 =

-	g_at_chat_send(data->dlcs[AUX_DLC], "AT+CFUN=3D1",
+	g_at_chat_send(data->dlcs[AUX_DLC], "AT+CFUN=3D1;+CFUN=3D4",
 			none_prefix, NULL, NULL, NULL);
 =

 	if (data->have_sim && data->sim)
 		ofono_sim_inserted_notify(data->sim, TRUE);
 }
 =

-static void calypso_post_sim(struct ofono_modem *modem)
+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+
+	if (ok)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void calypso_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct calypso_data *data =3D ofono_modem_get_data(modem);
+	GAtChat *chat =3D data->dlcs[AUX_DLC];
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (!cbd)
+		goto error;
+
+	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void calypso_post_online(struct ofono_modem *modem)
 {
 	struct calypso_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
@@ -553,8 +587,9 @@ static struct ofono_modem_driver calypso_driver =3D {
 	.remove		=3D calypso_remove,
 	.enable		=3D calypso_enable,
 	.disable	=3D calypso_disable,
+	.set_online     =3D calypso_set_online,
 	.pre_sim	=3D calypso_pre_sim,
-	.post_sim	=3D calypso_post_sim,
+	.post_online	=3D calypso_post_online,
 };
 =

 static int calypso_init(void)
-- =

1.7.0.4


--===============8571878337449934646==--

