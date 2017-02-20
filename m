Content-Type: multipart/mixed; boundary="===============1583985221793952202=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] huawei: reopen modem channel if it disconnects
Date: Mon, 20 Feb 2017 17:33:44 +0100
Message-ID: <20170220163344.16670-1-c.ronco@kerlink.fr>
In-Reply-To: <4a8ffc3a-6f2c-9a04-43ff-a2017fb01f8d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1583985221793952202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On E3372 after a GPRS disconnection, modem AT channel (used by PPP) gets
disconnected (G_IO_HUP and G_IO_ERR are detected in received_data
in gatio.c).
After that all connection attempts fail because we are not able to send
any AT commands on modem channel (it is closed).

With this patch, when this behavior is detected, we close gprs context
driver, reopen AT channel and gprs context driver.
---
 plugins/huawei.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++-----=
--
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 59995b30..fcec7994 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -78,6 +78,8 @@ enum {
 struct huawei_data {
 	GAtChat *modem;
 	GAtChat *pcui;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
 	gboolean have_sim;
 	int sim_state;
 	guint sysinfo_poll_source;
@@ -584,6 +586,45 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static void modem_disconnect(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	ofono_warn("modem channel disconnected");
+
+	/* clean and close modem device */
+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	/* close gprs context driver */
+	ofono_gprs_context_remove(data->gc);
+
+	/* reopen modem channel */
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+
+	if (data->modem =3D=3D NULL) {
+		DBG("Can't reopen device");
+		return;
+	}
+
+	/* configure modem channel */
+	g_at_chat_set_disconnect_function(data->modem, modem_disconnect, modem);
+	g_at_chat_set_slave(data->modem, data->pcui);
+	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
+
+	/* reopen gprs context driver */
+	data->gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
+						"atmodem", data->modem);
+
+	if (data->gprs && data->gc)
+		ofono_gprs_add_context(data->gprs, data->gc);
+}
+
 static int huawei_enable(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
@@ -594,6 +635,8 @@ static int huawei_enable(struct ofono_modem *modem)
 	if (data->modem =3D=3D NULL)
 		return -EINVAL;
 =

+	g_at_chat_set_disconnect_function(data->modem, modem_disconnect, modem);
+
 	data->pcui =3D open_device(modem, "Pcui", "PCUI: ");
 	if (data->pcui =3D=3D NULL) {
 		g_at_chat_unref(data->modem);
@@ -820,9 +863,6 @@ static void huawei_post_sim(struct ofono_modem *modem)
 	}
 =

 	if (data->have_gsm =3D=3D TRUE) {
-		struct ofono_gprs *gprs;
-		struct ofono_gprs_context *gc;
-
 		ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
 		ofono_radio_settings_create(modem, 0,
 						"huaweimodem", data->pcui);
@@ -830,13 +870,13 @@ static void huawei_post_sim(struct ofono_modem *modem)
 		ofono_sms_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->pcui);
 =

-		gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
+		data->gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->pcui);
-		gc =3D ofono_gprs_context_create(modem, 0,
+		data->gc =3D ofono_gprs_context_create(modem, 0,
 						"atmodem", data->modem);
 =

-		if (gprs && gc)
-			ofono_gprs_add_context(gprs, gc);
+		if (data->gprs && data->gc)
+			ofono_gprs_add_context(data->gprs, data->gc);
 	}
 }
 =

-- =

2.11.0


--===============1583985221793952202==--

