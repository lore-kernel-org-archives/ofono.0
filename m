Content-Type: multipart/mixed; boundary="===============7873472118895698547=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] mbm: implement Online property
Date: Mon, 23 Aug 2010 20:49:25 +0300
Message-ID: <1282585765-20277-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7873472118895698547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/mbm.c |   42 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 753a4f1..c9b0ea4 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -47,6 +47,7 @@
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/vendor.h>
+#include <drivers/atmodem/atutil.h>
 =

 static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
@@ -169,8 +170,8 @@ static void cfun_query(gboolean ok, GAtResult *result, =
gpointer user_data)
 =

 	g_at_result_iter_next_number(&iter, &status);
 =

-	if (status =3D=3D 4) {
-		g_at_chat_send(data->modem_port, "AT+CFUN=3D1", none_prefix,
+	if (status !=3D 4) {
+		g_at_chat_send(data->modem_port, "AT+CFUN=3D4", none_prefix,
 				cfun_enable, modem, NULL);
 		return;
 	}
@@ -365,6 +366,30 @@ static int mbm_disable(struct ofono_modem *modem)
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
+static void mbm_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	g_at_chat_send(data->modem_port, command, NULL,
+			set_online_cb, cbd, g_free);
+}
+
 static void mbm_pre_sim(struct ofono_modem *modem)
 {
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
@@ -383,12 +408,19 @@ static void mbm_pre_sim(struct ofono_modem *modem)
 static void mbm_post_sim(struct ofono_modem *modem)
 {
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

 	ofono_stk_create(modem, 0, "mbmmodem", data->modem_port);
+}
+
+static void mbm_post_online(struct ofono_modem *modem)
+{
+	struct mbm_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
 =

 	ofono_netreg_create(modem, OFONO_VENDOR_MBM,
 					"atmodem", data->modem_port);
@@ -412,8 +444,10 @@ static struct ofono_modem_driver mbm_driver =3D {
 	.remove		=3D mbm_remove,
 	.enable		=3D mbm_enable,
 	.disable	=3D mbm_disable,
+	.set_online     =3D mbm_set_online,
 	.pre_sim	=3D mbm_pre_sim,
 	.post_sim	=3D mbm_post_sim,
+	.post_online    =3D mbm_post_online,
 };
 =

 static int mbm_init(void)
-- =

1.7.0.4


--===============7873472118895698547==--

