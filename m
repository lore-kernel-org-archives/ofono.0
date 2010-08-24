Content-Type: multipart/mixed; boundary="===============2509021284711964610=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online PATCH 3/9] hso: implement Online property
Date: Tue, 24 Aug 2010 14:31:58 +0300
Message-ID: <1282649524-31353-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282649524-31353-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2509021284711964610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/hso.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/plugins/hso.c b/plugins/hso.c
index 8611e07..7433a7b 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -46,6 +46,7 @@
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
 =

 static const char *none_prefix[] =3D { NULL };
 =

@@ -172,7 +173,7 @@ static int hso_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->control, "ATE0", none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(data->app, "ATE0", none_prefix, NULL, NULL, NULL);
 =

-	g_at_chat_send(data->control, "AT+CFUN=3D1", none_prefix,
+	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -213,6 +214,30 @@ static int hso_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

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
+static void hso_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct hso_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	g_at_chat_send(data->control, command, NULL,
+			set_online_cb, cbd, g_free);
+}
+
 static void hso_pre_sim(struct ofono_modem *modem)
 {
 	struct hso_data *data =3D ofono_modem_get_data(modem);
@@ -228,7 +253,7 @@ static void hso_pre_sim(struct ofono_modem *modem)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-static void hso_post_sim(struct ofono_modem *modem)
+static void hso_post_online(struct ofono_modem *modem)
 {
 	struct hso_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
@@ -260,8 +285,9 @@ static struct ofono_modem_driver hso_driver =3D {
 	.remove		=3D hso_remove,
 	.enable		=3D hso_enable,
 	.disable	=3D hso_disable,
+	.set_online     =3D hso_set_online,
 	.pre_sim	=3D hso_pre_sim,
-	.post_sim	=3D hso_post_sim,
+	.post_online	=3D hso_post_online,
 };
 =

 static int hso_init(void)
-- =

1.7.0.4


--===============2509021284711964610==--

