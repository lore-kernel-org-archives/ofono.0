Content-Type: multipart/mixed; boundary="===============7498951147134929950=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [online PATCH 4/9] huawei: implement Online property
Date: Tue, 24 Aug 2010 14:31:59 +0300
Message-ID: <1282649524-31353-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282649524-31353-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7498951147134929950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/huawei.c |   44 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index fc331ff..4869294 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -351,7 +351,7 @@ static int huawei_enable(struct ofono_modem *modem)
 =

 	g_at_chat_send(data->pcui, "ATE0", none_prefix, NULL, NULL, NULL);
 =

-	g_at_chat_send(data->pcui, "AT+CFUN=3D1", none_prefix,
+	g_at_chat_send(data->pcui, "AT+CFUN=3D4", none_prefix,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -395,6 +395,30 @@ static int huawei_disable(struct ofono_modem *modem)
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
+static void huawei_set_online(struct ofono_modem *modem, ofono_bool_t onli=
ne,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	g_at_chat_send(data->pcui, command, NULL,
+			set_online_cb, cbd, g_free);
+}
+
 static void huawei_pre_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
@@ -414,15 +438,20 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 static void huawei_post_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_netreg *netreg;
-	struct ofono_message_waiting *mw;
 =

 	DBG("%p", modem);
 =

-	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS_AND_CS) {
-		ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
+	ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
+}
+
+static void huawei_post_online(struct ofono_modem *modem)
+{
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_netreg *netreg;
+	struct ofono_message_waiting *mw;
+
+	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS_AND_CS)
 		return;
-	}
 =

 	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
 								data->pcui);
@@ -432,7 +461,6 @@ static void huawei_post_sim(struct ofono_modem *modem)
 						"atmodem", data->pcui);
 	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 						"atmodem", data->pcui);
-	ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
 =

 	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
 			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
@@ -464,8 +492,10 @@ static struct ofono_modem_driver huawei_driver =3D {
 	.remove		=3D huawei_remove,
 	.enable		=3D huawei_enable,
 	.disable	=3D huawei_disable,
+	.set_online     =3D huawei_set_online,
 	.pre_sim	=3D huawei_pre_sim,
 	.post_sim	=3D huawei_post_sim,
+	.post_online    =3D huawei_post_online,
 };
 =

 static int huawei_init(void)
-- =

1.7.0.4


--===============7498951147134929950==--

