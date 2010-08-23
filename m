Content-Type: multipart/mixed; boundary="===============0976980885422340953=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] calypso: implement Online property
Date: Mon, 23 Aug 2010 21:01:42 +0300
Message-ID: <1282586502-21076-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0976980885422340953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/calypso.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/plugins/calypso.c b/plugins/calypso.c
index a2d4ec8..e47cf19 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -57,6 +57,7 @@
 #include <ofono/stk.h>
 =

 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
 =

 #define CALYPSO_POWER_PATH "/sys/bus/platform/devices/neo1973-pm-gsm.0/pow=
er_on"
 #define CALYPSO_RESET_PATH "/sys/bus/platform/devices/neo1973-pm-gsm.0/res=
et"
@@ -518,14 +519,38 @@ static void calypso_pre_sim(struct ofono_modem *modem)
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
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	g_at_chat_send(data->dlcs[AUX_DLC], command, NULL,
+			set_online_cb, cbd, g_free);
+}
+
+static void calypso_post_online(struct ofono_modem *modem)
 {
 	struct calypso_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
@@ -553,8 +578,9 @@ static struct ofono_modem_driver calypso_driver =3D {
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


--===============0976980885422340953==--

