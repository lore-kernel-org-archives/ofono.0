Content-Type: multipart/mixed; boundary="===============2478466203993044583=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH] Fix huawei_disconnect function issue
Date: Wed, 09 Mar 2011 13:27:22 +0800
Message-ID: <1299648442-30541-1-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2478466203993044583==
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
 plugins/huawei.c |   50 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 6f05677..5bf02fd 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -470,10 +470,7 @@ static void huawei_disconnect(gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 =

-	DBG("");
-
-	if (data->gc)
-		ofono_gprs_context_remove(data->gc);
+	DBG("data->gc %p", data->gc);
 =

 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
@@ -485,6 +482,12 @@ static void huawei_disconnect(gpointer user_data)
 	g_at_chat_set_disconnect_function(data->modem,
 						huawei_disconnect, modem);
 =

+	/* gprs_context has been destructed and needs not reopen */
+	if (data->gc =3D=3D NULL)
+		return;
+
+	ofono_gprs_context_remove(data->gc);
+
 	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
 			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
 		ofono_info("Reopened GPRS context channel");
@@ -579,15 +582,29 @@ static int huawei_disable(struct ofono_modem *modem)
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
+
+	if (ok) {
+		/* offline mode gprs_context and gprs will be flushed */
+		if (online_cbd->online =3D=3D FALSE) {
+			data->gc =3D NULL;
+			data->gprs =3D NULL;
+		}
 =

-	if (ok)
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		CALLBACK_WITH_SUCCESS(cb, online_cbd->cbd->data);
+	}
 	else
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		CALLBACK_WITH_FAILURE(cb, online_cbd->cbd->data);
 }
 =

 static void huawei_set_online(struct ofono_modem *modem, ofono_bool_t onli=
ne,
@@ -595,21 +612,26 @@ static void huawei_set_online(struct ofono_modem *mod=
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


--===============2478466203993044583==--

