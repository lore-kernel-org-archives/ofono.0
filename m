Content-Type: multipart/mixed; boundary="===============2503907685313179858=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online PATCH 9/9] zte: implement Online property
Date: Tue, 24 Aug 2010 14:32:04 +0300
Message-ID: <1282649524-31353-10-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282649524-31353-9-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2503907685313179858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/zte.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index 7a8c9c7..1e22b47 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -46,6 +46,7 @@
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
 =

 static const char *none_prefix[] =3D { NULL };
 =

@@ -182,7 +183,7 @@ static int zte_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
 						NULL, NULL, NULL);
 =

-	g_at_chat_send(data->aux, "AT+CFUN=3D1", none_prefix,
+	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -226,6 +227,32 @@ static int zte_disable(struct ofono_modem *modem)
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
+static void zte_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct zte_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (data->aux)
+		return;
+
+	g_at_chat_send(data->aux, command, NULL, set_online_cb, cbd, g_free);
+}
+
 static void zte_pre_sim(struct ofono_modem *modem)
 {
 	struct zte_data *data =3D ofono_modem_get_data(modem);
@@ -247,6 +274,15 @@ static void zte_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
+}
+
+static void zte_post_online(struct ofono_modem *modem)
+{
+	struct zte_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
 	ofono_netreg_create(modem, OFONO_VENDOR_ZTE, "atmodem", data->aux);
 =

 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
@@ -255,8 +291,6 @@ static void zte_post_sim(struct ofono_modem *modem)
 					"atmodem", data->aux);
 	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 					"atmodem", data->aux);
-	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
-
 	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->aux);
 =

 	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
@@ -271,8 +305,10 @@ static struct ofono_modem_driver zte_driver =3D {
 	.remove		=3D zte_remove,
 	.enable		=3D zte_enable,
 	.disable	=3D zte_disable,
+	.set_online     =3D zte_set_online,
 	.pre_sim	=3D zte_pre_sim,
 	.post_sim	=3D zte_post_sim,
+	.post_online    =3D zte_post_online,
 };
 =

 static int zte_init(void)
-- =

1.7.0.4


--===============2503907685313179858==--

