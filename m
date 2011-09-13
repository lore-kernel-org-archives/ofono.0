Content-Type: multipart/mixed; boundary="===============7205589340257139010=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 16/24] sap: add post_sim handling
Date: Tue, 13 Sep 2011 15:58:24 -0300
Message-ID: <1315940312-1238-16-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-15-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7205589340257139010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/sap.c       |    4 ++++
 plugins/telit.c     |   40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index b26b4f7..2f02c39 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -47,6 +47,7 @@ struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem);
 	void (*pre_sim) (struct ofono_modem *modem);
+	void (*post_sim) (struct ofono_modem *modem);
 	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
 				ofono_modem_online_cb_t cb, void *user_data);
 	int (*disable) (struct ofono_modem *modem);
diff --git a/plugins/sap.c b/plugins/sap.c
index ef805cc..43218c7 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -306,7 +306,11 @@ static void sap_pre_sim(struct ofono_modem *modem)
 =

 static void sap_post_sim(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
+
+	data->sap_driver->post_sim(data->hw_modem);
 }
 =

 static void sap_set_online(struct ofono_modem *modem, ofono_bool_t online,
diff --git a/plugins/telit.c b/plugins/telit.c
index 1098420..7bdbd8c 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -373,6 +373,18 @@ static void telit_pre_sim(struct ofono_modem *modem)
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 }
 =

+static void telit_post_sim(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	if (data->sap_modem)
+		modem =3D data->sap_modem;
+
+	DBG("%p", modem);
+
+	ofono_sms_create(modem, 0, "atmodem", data->chat);
+}
+
 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	struct cb_data *cbd =3D user_data;
@@ -400,6 +412,7 @@ static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
 	.pre_sim =3D telit_pre_sim,
+	.post_sim =3D telit_post_sim,
 	.set_online =3D telit_set_online,
 	.disable =3D telit_sap_disable,
 	.open =3D telit_sap_open,
@@ -470,6 +483,33 @@ static int telit_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+static void telit_post_online(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
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
 static struct ofono_modem_driver telit_driver =3D {
 	.name		=3D "telit",
 	.probe		=3D telit_probe,
-- =

1.7.6.2


--===============7205589340257139010==--

