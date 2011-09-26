Content-Type: multipart/mixed; boundary="===============2337861228959582521=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 17/23] sap: add post_online handling
Date: Mon, 26 Sep 2011 14:27:10 -0300
Message-ID: <1317058036-32641-17-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317058036-32641-16-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2337861228959582521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/sap.c       |   10 ++++++++
 plugins/telit.c     |   58 +++++++++++++++++++++++++++--------------------=
---
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 7e33a4a..6564609 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -50,6 +50,7 @@ struct bluetooth_sap_driver {
 	void (*post_sim) (struct ofono_modem *modem);
 	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
 				ofono_modem_online_cb_t cb, void *user_data);
+	void (*post_online) (struct ofono_modem *modem);
 	int (*disable) (struct ofono_modem *modem);
 	int (*open) (struct ofono_modem *modem);
 };
diff --git a/plugins/sap.c b/plugins/sap.c
index 7aea2af..e19361c 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -324,6 +324,15 @@ static void sap_set_online(struct ofono_modem *modem, =
ofono_bool_t online,
 	data->sap_driver->set_online(data->hw_modem, online, cb, user_data);
 }
 =

+static void sap_post_online(struct ofono_modem *modem)
+{
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->sap_driver->post_online(data->hw_modem);
+}
+
 static int bluetooth_sap_probe(const char *device, const char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
@@ -418,6 +427,7 @@ static struct ofono_modem_driver sap_driver =3D {
 	.pre_sim	=3D sap_pre_sim,
 	.post_sim	=3D sap_post_sim,
 	.set_online	=3D sap_set_online,
+	.post_online	=3D sap_post_online,
 };
 =

 static struct bluetooth_profile sap =3D {
diff --git a/plugins/telit.c b/plugins/telit.c
index 7bdbd8c..5d72b79 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -408,12 +408,43 @@ static void telit_set_online(struct ofono_modem *mode=
m, ofono_bool_t online,
 						cbd, g_free);
 }
 =

+static void telit_post_online(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	if(data->sap_modem)
+		modem =3D data->sap_modem;
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
+	ofono_ussd_create(modem, 0, "atmodem", data->chat);
+	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
+	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
+	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
+	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
+}
+
 static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
 	.pre_sim =3D telit_pre_sim,
 	.post_sim =3D telit_post_sim,
 	.set_online =3D telit_set_online,
+	.post_online =3D telit_post_online,
 	.disable =3D telit_sap_disable,
 	.open =3D telit_sap_open,
 };
@@ -483,33 +514,6 @@ static int telit_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

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


--===============2337861228959582521==--

