Content-Type: multipart/mixed; boundary="===============8286423027645804142=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 07/13] telit: enable the telit modem after enable SAP
 client
Date: Wed, 28 Sep 2011 18:24:15 -0300
Message-ID: <1317245061-6312-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317245061-6312-6-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8286423027645804142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/telit.c |  271 +++++++++++++++++++++++++++++----------------------=
----
 1 files changed, 141 insertions(+), 130 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index f39a7c4..f15a787 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -213,9 +213,142 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static gboolean sim_inserted_timeout_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->sim_inserted_source =3D 0;
+
+	ofono_sim_inserted_notify(data->sim, TRUE);
+
+	return FALSE;
+}
+
+static void switch_sim_state_status(struct ofono_modem *modem, int status)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	switch (status) {
+	case 0:
+		DBG("SIM not inserted");
+		ofono_sim_inserted_notify(data->sim, FALSE);
+		break;
+	case 1:
+		DBG("SIM inserted");
+		/* We need to sleep a bit */
+		data->sim_inserted_source =3D g_timeout_add_seconds(1,
+							sim_inserted_timeout_cb,
+							modem);
+		break;
+	case 2:
+		DBG("SIM inserted and PIN unlocked");
+		break;
+	case 3:
+		DBG("SIM inserted and ready");
+		break;
+	}
+}
+
+static void telit_qss_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	int status;
+	GAtResultIter iter;
+
+	DBG("%p", modem);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "#QSS:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &status);
+
+	switch_sim_state_status(modem, status);
+}
+
+static void telit_qss_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	int mode;
+	int status;
+	GAtResultIter iter;
+	g_at_result_iter_init(&iter, result);
+
+	DBG("%p", modem);
+
+	if (!g_at_result_iter_next(&iter, "#QSS:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &mode);
+	g_at_result_iter_next_number(&iter, &status);
+
+	switch_sim_state_status(modem, status);
+}
+
+static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_modem *m =3D data->sap_modem ? : modem;
+
+	DBG("%p", modem);
+
+	if (!ok) {
+		g_at_chat_unref(data->chat);
+		data->chat =3D NULL;
+		ofono_modem_set_powered(m, FALSE);
+		sap_close_io(modem);
+		return;
+	}
+
+	ofono_modem_set_powered(m, TRUE);
+
+	/* Enable sim state notification */
+	g_at_chat_send(data->chat, "AT#QSS=3D1", none_prefix, NULL, NULL, NULL);
+
+	/* Follow sim state */
+	g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
+				FALSE, modem, NULL);
+
+	/* Query current sim state */
+	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
+				telit_qss_cb, modem, NULL);
+}
+
+static int telit_enable(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->chat =3D open_device(modem, "Modem", "Modem: ");
+	if (data->chat =3D=3D NULL)
+		return -EINVAL;
+
+	/*
+	 * Disable command echo and
+	 * enable the Extended Error Result Codes
+	 */
+	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
+				NULL, NULL, NULL);
+
+	/* Set phone functionality */
+	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
+				cfun_enable_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
 static void telit_rsen_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
 	int status;
 	GAtResultIter iter;
 =

@@ -227,6 +360,14 @@ static void telit_rsen_notify(GAtResult *result, gpoin=
ter user_data)
 		return;
 =

 	g_at_result_iter_next_number(&iter, &status);
+
+	if (status =3D=3D 0) {
+		ofono_modem_set_powered(data->sap_modem, FALSE);
+		sap_close_io(modem);
+		return;
+	}
+
+	telit_enable(modem);
 }
 =

 static void rsen_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -438,136 +579,6 @@ static void telit_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

-static gboolean sim_inserted_timeout_cb(gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	data->sim_inserted_source =3D 0;
-
-	ofono_sim_inserted_notify(data->sim, TRUE);
-
-	return FALSE;
-}
-
-static void switch_sim_state_status(struct ofono_modem *modem, int status)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	switch (status) {
-	case 0:
-		DBG("SIM not inserted");
-		ofono_sim_inserted_notify(data->sim, FALSE);
-		break;
-	case 1:
-		DBG("SIM inserted");
-		/* We need to sleep a bit */
-		data->sim_inserted_source =3D g_timeout_add_seconds(1,
-							sim_inserted_timeout_cb,
-							modem);
-		break;
-	case 2:
-		DBG("SIM inserted and PIN unlocked");
-		break;
-	case 3:
-		DBG("SIM inserted and ready");
-		break;
-	}
-}
-
-static void telit_qss_notify(GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	int status;
-	GAtResultIter iter;
-
-	DBG("%p", modem);
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "#QSS:"))
-		return;
-
-	g_at_result_iter_next_number(&iter, &status);
-
-	switch_sim_state_status(modem, status);
-}
-
-static void telit_qss_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
-{
-	struct ofono_modem *modem =3D user_data;
-	int mode;
-	int status;
-	GAtResultIter iter;
-	g_at_result_iter_init(&iter, result);
-
-	DBG("%p", modem);
-
-	if (!g_at_result_iter_next(&iter, "#QSS:"))
-		return;
-
-	g_at_result_iter_next_number(&iter, &mode);
-	g_at_result_iter_next_number(&iter, &status);
-
-	switch_sim_state_status(modem, status);
-}
-
-static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	if (!ok) {
-		g_at_chat_unref(data->chat);
-		data->chat =3D NULL;
-		ofono_modem_set_powered(modem, FALSE);
-		return;
-	}
-
-	ofono_modem_set_powered(modem, TRUE);
-
-	/* Enable sim state notification */
-	g_at_chat_send(data->chat, "AT#QSS=3D1", none_prefix, NULL, NULL, NULL);
-
-	/* Follow sim state */
-	g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
-				FALSE, modem, NULL);
-
-	/* Query current sim state */
-	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
-				telit_qss_cb, modem, NULL);
-}
-
-static int telit_enable(struct ofono_modem *modem)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	data->chat =3D open_device(modem, "Modem", "Modem: ");
-	if (data->chat =3D=3D NULL)
-		return -EINVAL;
-
-	/*
-	 * Disable command echo and
-	 * enable the Extended Error Result Codes
-	 */
-	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
-				NULL, NULL, NULL);
-
-	/* Set phone functionality */
-	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
-				cfun_enable_cb, modem, NULL);
-
-	return -EINPROGRESS;
-}
-
 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	struct cb_data *cbd =3D user_data;
-- =

1.7.6.2


--===============8286423027645804142==--

