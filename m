Content-Type: multipart/mixed; boundary="===============1596247554687080429=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 13/23] telit: enable the telit modem when SAP is enabled.
Date: Mon, 26 Sep 2011 14:27:06 -0300
Message-ID: <1317058036-32641-13-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317058036-32641-12-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1596247554687080429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/telit.c |  265 ++++++++++++++++++++++++++++-----------------------=
----
 1 files changed, 133 insertions(+), 132 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index a89fce1..856230f 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -110,6 +110,137 @@ static GAtChat *open_device(struct ofono_modem *modem,
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
@@ -131,7 +262,7 @@ static void telit_rsen_notify(GAtResult *result, gpoint=
er user_data)
 		return;
 	}
 =

-	ofono_modem_set_powered(data->sap_modem, TRUE);
+	telit_enable(modem);
 }
 =

 static void rsen_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -204,7 +335,7 @@ static int telit_sap_enable(struct ofono_modem *modem,
 	g_at_chat_register(data->aux, "#RSEN:", telit_rsen_notify,
 				FALSE, modem, NULL);
 =

-	g_at_chat_send(data->aux, "AT#NOPT=3D3", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "AT#NOPT=3D0", NULL, NULL, NULL, NULL);
 =

 	/* Set SAP functionality */
 	g_at_chat_send(data->aux, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
@@ -268,112 +399,6 @@ static void telit_remove(struct ofono_modem *modem)
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
 static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -391,30 +416,6 @@ static void cfun_disable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		ofono_modem_set_powered(modem, FALSE);
 }
 =

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
 static int telit_disable(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
-- =

1.7.6.2


--===============1596247554687080429==--

