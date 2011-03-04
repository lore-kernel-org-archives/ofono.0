Content-Type: multipart/mixed; boundary="===============6259379736156289356=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH] Fix huawei_disconnect function issue
Date: Fri, 04 Mar 2011 15:44:03 +0800
Message-ID: <1299224643-19026-1-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6259379736156289356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

huawei_disconnect is used to recovery the io and gprs context when
io error happends, see commit 39382730d7758b093ca6271f4e9dea875fa04b3a
However, io error not only happends at PPP disconnect, in theory it
can happends at any situation. I also observed that it happens when modem
go into offline mode at my Huawei EM770W modem. in this case, gprs should
not be reopened.
---
 plugins/huawei.c |   49 +++++++++++++++++++++++++++++++++++--------------
 1 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 6f05677..939509f 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -78,6 +78,7 @@ struct huawei_data {
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	gboolean voice;
+	gboolean online;
 	gboolean ndis;
 	guint sim_poll_timeout;
 	guint sim_poll_count;
@@ -97,6 +98,7 @@ static int huawei_probe(struct ofono_modem *modem)
 	if (data =3D=3D NULL)
 		return -ENOMEM;
 =

+	data->online =3D FALSE;
 	ofono_modem_set_data(modem, data);
 =

 	return 0;
@@ -470,10 +472,7 @@ static void huawei_disconnect(gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 =

-	DBG("");
-
-	if (data->gc)
-		ofono_gprs_context_remove(data->gc);
+	DBG("data->online %d", data->online);
 =

 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
@@ -485,6 +484,13 @@ static void huawei_disconnect(gpointer user_data)
 	g_at_chat_set_disconnect_function(data->modem,
 						huawei_disconnect, modem);
 =

+	/* reopen GPRS context channel only at online state */
+	if (data->online =3D=3D FALSE)
+		return;
+
+	if (data->gc)
+		ofono_gprs_context_remove(data->gc);
+
 	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
 			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
 		ofono_info("Reopened GPRS context channel");
@@ -579,15 +585,25 @@ static int huawei_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+struct huawei_cb_data {
+	struct cb_data *cbd;
+	ofono_bool_t online;
+	struct ofono_modem *modem;
+};
+
 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct huawei_cb_data *online_cbd =3D user_data;
+	ofono_modem_online_cb_t cb =3D online_cbd->cbd->cb;
+	struct huawei_data *data =3D ofono_modem_get_data(online_cbd->modem);
 =

-	if (ok)
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	if (ok) {
+		data->online =3D online_cbd->online;
+
+		CALLBACK_WITH_SUCCESS(cb, online_cbd->cbd->data);
+	}
 	else
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		CALLBACK_WITH_FAILURE(cb, online_cbd->cbd->data);
 }
 =

 static void huawei_set_online(struct ofono_modem *modem, ofono_bool_t onli=
ne,
@@ -595,21 +611,26 @@ static void huawei_set_online(struct ofono_modem *mod=
em, ofono_bool_t online,
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 	GAtChat *chat =3D data->pcui;
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	struct huawei_cb_data *online_cbd;
 	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D5";
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL)
+	online_cbd =3D g_try_new0(struct huawei_cb_data, 1);
+	online_cbd->cbd =3D cb_data_new(cb, user_data);
+	if (online_cbd->cbd =3D=3D NULL)
 		goto error;
+	online_cbd->online =3D online;
+	online_cbd->modem =3D modem;
 =

-	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
+	if (g_at_chat_send(chat, command, NULL, set_online_cb,
+						online_cbd, g_free))
 		return;
 =

 error:
-	g_free(cbd);
+	g_free(online_cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 =

 static void huawei_pre_sim(struct ofono_modem *modem)
-- =

1.6.1.3


--===============6259379736156289356==--

