Content-Type: multipart/mixed; boundary="===============2659367538366000684=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online PATCH 8/9] ste: implement Online property
Date: Tue, 24 Aug 2010 14:32:03 +0300
Message-ID: <1282649524-31353-9-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282649524-31353-8-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2659367538366000684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/ste.c |   41 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 63c36ce..f5f72a3 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -57,6 +57,8 @@
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
 #include <ofono/stk.h>
+
+#include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

 #include <drivers/stemodem/caif_socket.h>
@@ -237,7 +239,7 @@ static int ste_enable(struct ofono_modem *modem)
 =

 	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
 			NULL, NULL, NULL, NULL);
-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL, cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
 }
@@ -273,6 +275,29 @@ static int ste_disable(struct ofono_modem *modem)
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
+static void ste_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	g_at_chat_send(data->chat, command, NULL, set_online_cb, cbd, g_free);
+}
+
 static void ste_pre_sim(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
@@ -291,13 +316,22 @@ static void ste_pre_sim(struct ofono_modem *modem)
 static void ste_post_sim(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
+	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+}
+
+static void ste_post_online(struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

-	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
 	ofono_radio_settings_create(modem, 0, "stemodem", data->chat);
 	ofono_ussd_create(modem, 0, "atmodem", data->chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
@@ -307,7 +341,6 @@ static void ste_post_sim(struct ofono_modem *modem)
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
 	ofono_ssn_create(modem, 0, "atmodem", data->chat);
 	ofono_sms_create(modem, 0, "atmodem", data->chat);
-	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
 	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
@@ -329,8 +362,10 @@ static struct ofono_modem_driver ste_driver =3D {
 	.remove		=3D ste_remove,
 	.enable		=3D ste_enable,
 	.disable	=3D ste_disable,
+	.set_online     =3D ste_set_online,
 	.pre_sim	=3D ste_pre_sim,
 	.post_sim	=3D ste_post_sim,
+	.post_online    =3D ste_post_online,
 };
 =

 static int ste_init(void)
-- =

1.7.0.4


--===============2659367538366000684==--

