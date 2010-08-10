Content-Type: multipart/mixed; boundary="===============8485169115755344096=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 1/2] huawei: poll sim state
Date: Tue, 10 Aug 2010 12:57:35 +0300
Message-ID: <20100810095735.18457.31162.stgit@potku.valot.fi>
In-Reply-To: <20100810095612.18457.66344.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8485169115755344096==
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
 plugins/huawei.c |   34 ++++++++++++++++++++++++++++++----
 1 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index f8ada24..ba66513 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -73,8 +73,11 @@ struct huawei_data {
 	enum huawei_sim_state sim_state;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	guint query_sim_state;
 };
 =

+static gboolean query_sim_state(gpointer user_data);
+
 static int huawei_probe(struct ofono_modem *modem)
 {
 	struct huawei_data *data;
@@ -114,8 +117,15 @@ static void notify_sim_state(struct ofono_modem *modem,
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
+		data->query_sim_state =3D
+			g_timeout_add_seconds(2, query_sim_state, modem);
+	}
 	else
 		ofono_sim_inserted_notify(data->sim, TRUE);
 =

@@ -154,6 +164,21 @@ static void sysinfo_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	notify_sim_state(modem, (enum huawei_sim_state) sim_state);
 }
 =

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
+}
+
 static void simst_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -187,9 +212,7 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	g_at_chat_register(data->pcui, "^SIMST:", simst_notify,
 							FALSE, modem, NULL);
 =

-	/* query current sim state */
-	g_at_chat_send(data->pcui, "AT^SYSINFO", sysinfo_prefix,
-					sysinfo_cb, modem, NULL);
+	query_sim_state(modem);
 }
 =

 static GAtChat *create_port(const char *device)
@@ -319,6 +342,9 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->query_sim_state)
+		g_source_remove(data->query_sim_state);
+
 	if (data->modem) {
 		g_at_chat_cancel_all(data->modem);
 		g_at_chat_unregister_all(data->modem);


--===============8485169115755344096==--

