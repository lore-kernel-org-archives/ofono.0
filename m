Content-Type: multipart/mixed; boundary="===============3861404902700119342=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 1/2] huawei: poll sim state
Date: Mon, 20 Sep 2010 15:40:26 +0300
Message-ID: <20100920124026.12498.53590.stgit@potku.valot.fi>
In-Reply-To: <20100920123957.12498.61806.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3861404902700119342==
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
 plugins/huawei.c |   66 +++++++++++++++++++++++++++++++++++++++++++-------=
----
 1 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index ccb5290..2f605ee 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -76,8 +76,14 @@ struct huawei_data {
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	gboolean voice;
+	guint sim_poll_timeout;
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
-	else
-		ofono_sim_inserted_notify(data->sim, TRUE);
+
+		/* SIM is not ready, try again a bit later */
+		return TRUE;
+	}
+
+	ofono_sim_inserted_notify(data->sim, TRUE);
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
+		data->sim_poll_timeout =3D g_timeout_add_seconds(2,
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
+	data->sim_poll_timeout =3D 0;
+
+	g_at_chat_send(data->pcui, "AT^SYSINFO", sysinfo_prefix,
+			sysinfo_cb, modem, NULL);
+
+	return FALSE;
 }
 =

 static void simst_notify(GAtResult *result, gpointer user_data)
@@ -348,10 +386,6 @@ static void cvoice_query_cb(gboolean ok, GAtResult *re=
sult,
 =

 done:
 	ofono_modem_set_powered(modem, TRUE);
-
-	/* query current sim state */
-        g_at_chat_send(data->pcui, "AT^SYSINFO", sysinfo_prefix,
-						sysinfo_cb, modem, NULL);
 }
 =

 static void cvoice_support_cb(gboolean ok, GAtResult *result,
@@ -377,10 +411,6 @@ static void cvoice_support_cb(gboolean ok, GAtResult *=
result,
 =

 done:
 	ofono_modem_set_powered(modem, TRUE);
-
-	/* query current sim state */
-	g_at_chat_send(data->pcui, "AT^SYSINFO", sysinfo_prefix,
-						sysinfo_cb, modem, NULL);
 }
 =

 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
@@ -523,6 +553,8 @@ static int huawei_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->pcui, "AT+CFUN=3D1;+CFUN=3D5", none_prefix,
 					cfun_enable, modem, NULL);
 =

+	query_sim_state(modem);
+
 	return -EINPROGRESS;
 }
 =

@@ -546,6 +578,11 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->sim_poll_timeout > 0) {
+		g_source_remove(data->sim_poll_timeout);
+		data->sim_poll_timeout =3D 0;
+	}
+
 	if (data->modem) {
 		g_at_chat_cancel_all(data->modem);
 		g_at_chat_unregister_all(data->modem);
@@ -610,6 +647,9 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 	if (data->voice =3D=3D TRUE)
 		ofono_voicecall_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->pcui);
+
+	data->sim_poll_count =3D 0;
+	query_sim_state(modem);
 }
 =

 static void huawei_post_sim(struct ofono_modem *modem)


--===============3861404902700119342==--

