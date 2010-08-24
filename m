Content-Type: multipart/mixed; boundary="===============4086642546534491374=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online PATCH 7/9] palmpre: implement Online property
Date: Tue, 24 Aug 2010 14:32:02 +0300
Message-ID: <1282649524-31353-8-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282649524-31353-7-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4086642546534491374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/palmpre.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/plugins/palmpre.c b/plugins/palmpre.c
index 7d2aeb4..0963cb1 100644
--- a/plugins/palmpre.c
+++ b/plugins/palmpre.c
@@ -45,6 +45,7 @@
 #include <ofono/sms.h>
 =

 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
 =

 struct palmpre_data {
 	GAtChat *chat;
@@ -132,7 +133,7 @@ static int palmpre_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->chat, "ATZ E0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 =

 	/* Power modem up */
-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
+	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL,
 			cfun_set_on_cb, modem, NULL);
 =

 	return 0;
@@ -167,6 +168,30 @@ static int palmpre_disable(struct ofono_modem *modem)
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
+static void palmpre_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct palmpre_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	g_at_chat_send(data->chat, command, NULL,
+			set_online_cb, cbd, g_free);
+}
+
 static void palmpre_pre_sim(struct ofono_modem *modem)
 {
 	struct palmpre_data *data =3D ofono_modem_get_data(modem);
@@ -186,6 +211,14 @@ static void palmpre_pre_sim(struct ofono_modem *modem)
 static void palmpre_post_sim(struct ofono_modem *modem)
 {
 	struct palmpre_data *data =3D ofono_modem_get_data(modem);
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+}
+
+static void palmpre_post_online(struct ofono_modem *modem)
+{
+	struct palmpre_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
@@ -195,7 +228,6 @@ static void palmpre_post_sim(struct ofono_modem *modem)
 	ofono_netreg_create(modem, 0, "atmodem", data->chat);
 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
 				data->chat);
-	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
@@ -214,8 +246,10 @@ static struct ofono_modem_driver palmpre_driver =3D {
 	.remove		=3D palmpre_remove,
 	.enable		=3D palmpre_enable,
 	.disable	=3D palmpre_disable,
+	.set_online     =3D palmpre_set_online,
 	.pre_sim	=3D palmpre_pre_sim,
-	.post_sim	=3D palmpre_post_sim
+	.post_sim	=3D palmpre_post_sim,
+	.post_online	=3D palmpre_post_online,
 };
 =

 static int palmpre_init(void)
-- =

1.7.0.4


--===============4086642546534491374==--

