Content-Type: multipart/mixed; boundary="===============0043032704595923768=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 10/21] sap: add set_online handling
Date: Tue, 27 Sep 2011 18:04:09 -0300
Message-ID: <1317157460-17012-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-9-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0043032704595923768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    2 +
 plugins/sap.c       |   11 ++++++++++
 plugins/telit.c     |   56 +++++++++++++++++++++--------------------------=
---
 3 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 740ecce..257f092 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -47,6 +47,8 @@ struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem);
 	void (*pre_sim) (struct ofono_modem *modem);
+	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data);
 	int (*disable) (struct ofono_modem *modem);
 };
 =

diff --git a/plugins/sap.c b/plugins/sap.c
index 2a8b618..1713d4c 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -304,6 +304,16 @@ static void sap_post_sim(struct ofono_modem *modem)
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
@@ -395,6 +405,7 @@ static struct ofono_modem_driver sap_driver =3D {
 	.disable	=3D sap_disable,
 	.pre_sim	=3D sap_pre_sim,
 	.post_sim	=3D sap_post_sim,
+	.set_online	=3D sap_set_online,
 };
 =

 static struct bluetooth_profile sap =3D {
diff --git a/plugins/telit.c b/plugins/telit.c
index 6791c6e..da89b1c 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -378,10 +378,34 @@ static void telit_pre_sim(struct ofono_modem *modem)
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
 };
 =

@@ -450,38 +474,6 @@ static int telit_disable(struct ofono_modem *modem)
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
 static void telit_post_online(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
-- =

1.7.6.2


--===============0043032704595923768==--

