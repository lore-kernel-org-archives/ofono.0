Content-Type: multipart/mixed; boundary="===============4811624495369157855=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 10/13] telit: add set_online to SAP Client
Date: Wed, 28 Sep 2011 18:24:18 -0300
Message-ID: <1317245061-6312-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317245061-6312-9-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4811624495369157855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    2 ++
 plugins/telit.c     |   47 ++++++++++++++++++++++++-----------------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index a9d3683..89733a1 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -49,6 +49,8 @@ struct bluetooth_sap_driver {
 								int bt_fd);
 	void (*pre_sim) (struct ofono_modem *modem);
 	void (*post_sim) (struct ofono_modem *modem);
+	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data);
 	int (*disable) (struct ofono_modem *modem);
 };
 =

diff --git a/plugins/telit.c b/plugins/telit.c
index 8fe421f..dc6850f 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -566,11 +566,35 @@ static void telit_post_sim(struct ofono_modem *modem)
 	ofono_sms_create(modem, 0, "atmodem", data->chat);
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
 	.post_sim =3D telit_post_sim,
+	.set_online =3D telit_set_online,
 	.disable =3D telit_sap_disable,
 };
 =

@@ -607,29 +631,6 @@ static void telit_remove(struct ofono_modem *modem)
 	g_free(data);
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
 static void telit_post_online(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
-- =

1.7.6.2


--===============4811624495369157855==--

