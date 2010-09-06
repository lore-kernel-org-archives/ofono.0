Content-Type: multipart/mixed; boundary="===============0306566690690310448=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online-impl-v2 PATCH 01/10] atgen: implement Online property
Date: Mon, 06 Sep 2010 21:46:11 +0300
Message-ID: <1283798780-16363-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283798780-16363-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0306566690690310448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/atgen.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/plugins/atgen.c b/plugins/atgen.c
index a6eee60..1ce2467 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -49,6 +49,7 @@
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 =

+#include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/sim-poll.h>
 =

 #include <ofono/gprs.h>
@@ -154,11 +155,45 @@ static int atgen_disable(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

+	g_at_chat_send(chat, "AT+CFUN=3D4", NULL, NULL, NULL, NULL);
+
 	g_at_chat_unref(chat);
 =

 	return 0;
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
+static void atgen_set_online(struct ofono_modem *modem, ofono_bool_t onlin=
e,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
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
 static void atgen_pre_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
@@ -177,6 +212,15 @@ static void atgen_pre_sim(struct ofono_modem *modem)
 static void atgen_post_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", chat);
+}
+
+static void atgen_post_online(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
@@ -191,7 +235,6 @@ static void atgen_post_sim(struct ofono_modem *modem)
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
 	ofono_ssn_create(modem, 0, "atmodem", chat);
 	ofono_sms_create(modem, 0, "atmodem", chat);
-	ofono_phonebook_create(modem, 0, "atmodem", chat);
 	gprs =3D ofono_gprs_create(modem,0, "atmodem", chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);
 	if (gprs && gc)
@@ -208,8 +251,10 @@ static struct ofono_modem_driver atgen_driver =3D {
 	.remove		=3D atgen_remove,
 	.enable		=3D atgen_enable,
 	.disable	=3D atgen_disable,
+	.set_online     =3D atgen_set_online,
 	.pre_sim	=3D atgen_pre_sim,
 	.post_sim	=3D atgen_post_sim,
+	.post_online	=3D atgen_post_online,
 };
 =

 static int atgen_init(void)
-- =

1.7.0.4


--===============0306566690690310448==--

