Content-Type: multipart/mixed; boundary="===============2531566498785036584=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online PATCH 5/9] nokia: implement Online property
Date: Tue, 24 Aug 2010 14:32:00 +0300
Message-ID: <1282649524-31353-6-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282649524-31353-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2531566498785036584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/nokia.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/plugins/nokia.c b/plugins/nokia.c
index b7db2cc..f185d00 100644
--- a/plugins/nokia.c
+++ b/plugins/nokia.c
@@ -45,6 +45,7 @@
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
 =

 static const char *none_prefix[] =3D { NULL };
 =

@@ -181,7 +182,7 @@ static int nokia_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->control, "ATE0 +CMEE=3D1", none_prefix,
 						NULL, NULL, NULL);
 =

-	g_at_chat_send(data->control, "AT+CFUN=3D1", none_prefix,
+	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -225,6 +226,30 @@ static int nokia_disable(struct ofono_modem *modem)
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
+static void nokia_set_online(struct ofono_modem *modem, ofono_bool_t onlin=
e,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct nokia_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	g_at_chat_send(data->control, command, NULL,
+			set_online_cb, cbd, g_free);
+}
+
 static void nokia_pre_sim(struct ofono_modem *modem)
 {
 	struct nokia_data *data =3D ofono_modem_get_data(modem);
@@ -239,7 +264,7 @@ static void nokia_pre_sim(struct ofono_modem *modem)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-static void nokia_post_sim(struct ofono_modem *modem)
+static void nokia_post_online(struct ofono_modem *modem)
 {
 	struct nokia_data *data =3D ofono_modem_get_data(modem);
 =

@@ -269,8 +294,9 @@ static struct ofono_modem_driver nokia_driver =3D {
 	.remove		=3D nokia_remove,
 	.enable		=3D nokia_enable,
 	.disable	=3D nokia_disable,
+	.set_online     =3D nokia_set_online,
 	.pre_sim	=3D nokia_pre_sim,
-	.post_sim	=3D nokia_post_sim,
+	.post_online	=3D nokia_post_online,
 };
 =

 static int nokia_init(void)
-- =

1.7.0.4


--===============2531566498785036584==--

