Content-Type: multipart/mixed; boundary="===============5330286072192913249=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 1/2] speedup: remove online/offline mechanism.
Date: Thu, 28 Jul 2011 16:16:09 +0200
Message-ID: <1311862570-29780-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1311862570-29780-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5330286072192913249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedup.c |   55 +++++++------------------------------------------=
---
 1 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index a7aa43c..f959e12 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -47,8 +47,6 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

-static const char *none_prefix[] =3D { NULL };
-
 struct speedup_data {
 	GAtChat *modem;
 	GAtChat *aux;
@@ -177,7 +175,7 @@ static int speedup_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 =

-	g_at_chat_send(data->aux, "AT+CFUN=3D4", NULL,
+	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -218,34 +216,6 @@ static int speedup_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

-static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
-{
-	struct cb_data *cbd =3D user_data;
-	ofono_modem_online_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, cbd->data);
-}
-
-static void speedup_set_online(struct ofono_modem *modem, ofono_bool_t onl=
ine,
-				ofono_modem_online_cb_t cb, void *user_data)
-{
-	struct speedup_data *data =3D ofono_modem_get_data(modem);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
-
-	DBG("modem %p %s", modem, online ? "online" : "offline");
-
-	if (g_at_chat_send(data->aux, command, none_prefix,
-					set_online_cb, cbd, g_free) > 0)
-		return;
-
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-	g_free(cbd);
-}
-
 static void speedup_pre_sim(struct ofono_modem *modem)
 {
 	struct speedup_data *data =3D ofono_modem_get_data(modem);
@@ -269,6 +239,13 @@ static void speedup_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	ofono_netreg_create(modem, 0, "atmodem", data->aux);
+
+	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+					"atmodem", data->aux);
+	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+					"atmodem", data->aux);
+
 	ofono_phonebook_create(modem, 0, "atmodem", data->aux);
 =

 	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
@@ -281,30 +258,14 @@ static void speedup_post_sim(struct ofono_modem *mode=
m)
 		ofono_gprs_add_context(gprs, gc);
 }
 =

-static void speedup_post_online(struct ofono_modem *modem)
-{
-	struct speedup_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_netreg_create(modem, 0, "atmodem", data->aux);
-
-	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
-					"atmodem", data->aux);
-	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
-					"atmodem", data->aux);
-}
-
 static struct ofono_modem_driver speedup_driver =3D {
 	.name		=3D "speedup",
 	.probe		=3D speedup_probe,
 	.remove		=3D speedup_remove,
 	.enable		=3D speedup_enable,
 	.disable	=3D speedup_disable,
-	.set_online     =3D speedup_set_online,
 	.pre_sim	=3D speedup_pre_sim,
 	.post_sim	=3D speedup_post_sim,
-	.post_online    =3D speedup_post_online,
 };
 =

 static int speedup_init(void)
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5330286072192913249==--

