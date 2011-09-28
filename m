Content-Type: multipart/mixed; boundary="===============1848492242051442751=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 11/13] telit: add post_online to SAP Client
Date: Wed, 28 Sep 2011 18:24:19 -0300
Message-ID: <1317245061-6312-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317245061-6312-10-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1848492242051442751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/telit.c     |   58 +++++++++++++++++++++++++++--------------------=
---
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 89733a1..ad78921 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -51,6 +51,7 @@ struct bluetooth_sap_driver {
 	void (*post_sim) (struct ofono_modem *modem);
 	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
 				ofono_modem_online_cb_t cb, void *user_data);
+	void (*post_online) (struct ofono_modem *modem);
 	int (*disable) (struct ofono_modem *modem);
 };
 =

diff --git a/plugins/telit.c b/plugins/telit.c
index dc6850f..8a2f6af 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -589,12 +589,43 @@ static void telit_set_online(struct ofono_modem *mode=
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
 };
 =

@@ -631,33 +662,6 @@ static void telit_remove(struct ofono_modem *modem)
 	g_free(data);
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


--===============1848492242051442751==--

