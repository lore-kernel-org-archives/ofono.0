Content-Type: multipart/mixed; boundary="===============8042109880444622161=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online PATCH 2/9] g1: implement Online property
Date: Tue, 24 Aug 2010 14:31:57 +0300
Message-ID: <1282649524-31353-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282649524-31353-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8042109880444622161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/g1.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/plugins/g1.c b/plugins/g1.c
index fa96eb1..8c04117 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -49,6 +49,7 @@
 #include <ofono/voicecall.h>
 =

 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
 =

 static void g1_debug(const char *str, void *data)
 {
@@ -120,7 +121,7 @@ static int g1_enable(struct ofono_modem *modem)
 	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
 =

 	/* power up modem */
-	g_at_chat_send(chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem, NULL);
+	g_at_chat_send(chat, "AT+CFUN=3D4", NULL, cfun_set_on_cb, modem, NULL);
 =

 	return 0;
 }
@@ -168,7 +169,30 @@ static void g1_pre_sim(struct ofono_modem *modem)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-static void g1_post_sim(struct ofono_modem *modem)
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
+static void g1_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free);
+}
+
+static void g1_post_online(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
@@ -196,8 +220,9 @@ static struct ofono_modem_driver g1_driver =3D {
 	.remove		=3D g1_remove,
 	.enable		=3D g1_enable,
 	.disable	=3D g1_disable,
+	.set_online     =3D g1_set_online,
 	.pre_sim	=3D g1_pre_sim,
-	.post_sim	=3D g1_post_sim,
+	.post_online	=3D g1_post_online,
 };
 =

 static int g1_init(void)
-- =

1.7.0.4


--===============8042109880444622161==--

