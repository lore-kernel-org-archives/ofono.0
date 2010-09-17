Content-Type: multipart/mixed; boundary="===============2942171629801917855=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [RFC PATCH v1 1/2] huawei: poll sim state
Date: Fri, 17 Sep 2010 13:23:52 +0300
Message-ID: <20100917102351.8517.89499.stgit@potku.valot.fi>
In-Reply-To: <20100917101755.8517.58836.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2942171629801917855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On my Huawei E1552 when I plug in the modem (ie. cold start) with PIN locked
SIM, the sim state is 255 (HUAWEI_SIM_STATE_NOT_EXISTENT). As the modem
doesn't send ^SIMST notifications, poll the sim state until it's ready.

In theory it might be possible to do this better, for example follow
^BOOT notifications or something, but it's unknown what parameter we
should check for.
---
 plugins/huawei.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++++-=
--
 1 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index ccb5290..ad1c3ae 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -76,8 +76,14 @@ struct huawei_data {
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	gboolean voice;
+	guint query_sim_state;
+	guint sim_poll_count;
 };
 =

+#define MAX_SIM_POLL_COUNT 5
+
+static gboolean query_sim_state(gpointer user_data);
+
 static int huawei_probe(struct ofono_modem *modem)
 {
 	struct huawei_data *data;
@@ -157,22 +163,32 @@ static void ussdmode_support_cb(gboolean ok, GAtResul=
t *result,
 					ussdmode_query_cb, data, NULL);
 }
 =

-static void notify_sim_state(struct ofono_modem *modem,
+static gboolean notify_sim_state(struct ofono_modem *modem,
 				enum huawei_sim_state sim_state)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 =

-	if (sim_state =3D=3D HUAWEI_SIM_STATE_NOT_EXISTENT)
+	DBG("%d", sim_state);
+
+	if (sim_state =3D=3D HUAWEI_SIM_STATE_NOT_EXISTENT) {
 		ofono_sim_inserted_notify(data->sim, FALSE);
+
+		/* SIM is not ready, try again a bit later */
+		return TRUE;
+	}
 	else
 		ofono_sim_inserted_notify(data->sim, TRUE);
 =

 	data->sim_state =3D sim_state;
+
+	return FALSE;
 }
 =

 static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	gboolean rerun;
 	gint sim_state;
 	GAtResultIter iter;
 =

@@ -199,7 +215,29 @@ static void sysinfo_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	if (!g_at_result_iter_next_number(&iter, &sim_state))
 		return;
 =

-	notify_sim_state(modem, (enum huawei_sim_state) sim_state);
+	rerun =3D notify_sim_state(modem, (enum huawei_sim_state) sim_state);
+
+	if (rerun && data->sim_poll_count < MAX_SIM_POLL_COUNT) {
+		data->sim_poll_count++;
+		data->query_sim_state =3D g_timeout_add_seconds(2,
+								query_sim_state,
+								modem);
+	}
+}
+
+static gboolean query_sim_state(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	data->query_sim_state =3D 0;
+
+	g_at_chat_send(data->pcui, "AT^SYSINFO", sysinfo_prefix,
+			sysinfo_cb, modem, NULL);
+
+	return FALSE;
 }
 =

 static void simst_notify(GAtResult *result, gpointer user_data)
@@ -414,6 +452,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	/* check for voice support */
 	g_at_chat_send(data->pcui, "AT^CVOICE=3D?", cvoice_prefix,
 					cvoice_support_cb, modem, NULL);
+
+	/* query_sim_state(modem); */
 }
 =

 static GAtChat *create_port(const char *device)
@@ -546,6 +586,9 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->query_sim_state)
+		g_source_remove(data->query_sim_state);
+
 	if (data->modem) {
 		g_at_chat_cancel_all(data->modem);
 		g_at_chat_unregister_all(data->modem);
@@ -610,6 +653,9 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 	if (data->voice =3D=3D TRUE)
 		ofono_voicecall_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->pcui);
+
+	data->sim_poll_count =3D 0;
+	query_sim_state(modem);
 }
 =

 static void huawei_post_sim(struct ofono_modem *modem)


--===============2942171629801917855==--

