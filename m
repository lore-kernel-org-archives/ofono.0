Content-Type: multipart/mixed; boundary="===============6390956575747246945=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 15/24] sap: add set_online handling
Date: Tue, 13 Sep 2011 15:58:23 -0300
Message-ID: <1315940312-1238-15-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-14-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6390956575747246945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    2 +
 plugins/sap.c       |   11 +++++++
 plugins/telit.c     |   83 +++++++++++++++--------------------------------=
----
 3 files changed, 37 insertions(+), 59 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 9850864..b26b4f7 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -47,6 +47,8 @@ struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem);
 	void (*pre_sim) (struct ofono_modem *modem);
+	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data);
 	int (*disable) (struct ofono_modem *modem);
 	int (*open) (struct ofono_modem *modem);
 };
diff --git a/plugins/sap.c b/plugins/sap.c
index 2935552..ef805cc 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -309,6 +309,16 @@ static void sap_post_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 }
 =

+static void sap_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->sap_driver->set_online(data->hw_modem, online, cb, user_data);
+}
+
 static int bluetooth_sap_probe(const char *device, const char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
@@ -414,6 +424,7 @@ static struct ofono_modem_driver sap_driver =3D {
 	.disable	=3D sap_disable,
 	.pre_sim	=3D sap_pre_sim,
 	.post_sim	=3D sap_post_sim,
+	.set_online	=3D sap_set_online,
 };
 =

 static struct bluetooth_profile sap =3D {
diff --git a/plugins/telit.c b/plugins/telit.c
index c116606..1098420 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -373,10 +373,34 @@ static void telit_pre_sim(struct ofono_modem *modem)
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 }
 =

+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void telit_set_online(struct ofono_modem *modem, ofono_bool_t onlin=
e,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	g_at_chat_send(data->chat, command, none_prefix, set_online_cb,
+						cbd, g_free);
+}
+
 static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
 	.pre_sim =3D telit_pre_sim,
+	.set_online =3D telit_set_online,
 	.disable =3D telit_sap_disable,
 	.open =3D telit_sap_open,
 };
@@ -446,65 +470,6 @@ static int telit_disable(struct ofono_modem *modem)
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
-static void telit_set_online(struct ofono_modem *modem, ofono_bool_t onlin=
e,
-				ofono_modem_online_cb_t cb, void *user_data)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
-
-	DBG("modem %p %s", modem, online ? "online" : "offline");
-
-	g_at_chat_send(data->chat, command, none_prefix, set_online_cb,
-						cbd, g_free);
-}
-
-static void telit_post_sim(struct ofono_modem *modem)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_sms_create(modem, 0, "atmodem", data->chat);
-}
-
-static void telit_post_online(struct ofono_modem *modem)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_message_waiting *mw;
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
-
-	DBG("%p", modem);
-
-	ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
-	ofono_ussd_create(modem, 0, "atmodem", data->chat);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
-	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
-	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-
-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
-
-	mw =3D ofono_message_waiting_create(modem);
-	if (mw)
-		ofono_message_waiting_register(mw);
-}
-
 static struct ofono_modem_driver telit_driver =3D {
 	.name		=3D "telit",
 	.probe		=3D telit_probe,
-- =

1.7.6.2


--===============6390956575747246945==--

