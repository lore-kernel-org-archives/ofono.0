Content-Type: multipart/mixed; boundary="===============5111678855070614647=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [RFC PATCH v1 2/2] huawei: fix online logic
Date: Fri, 17 Sep 2010 13:23:58 +0300
Message-ID: <20100917102358.8517.8873.stgit@potku.valot.fi>
In-Reply-To: <20100917101755.8517.58836.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5111678855070614647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


---
 plugins/huawei.c |   79 ++++++++++++++++++++++++++++++++++++++------------=
----
 1 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index ad1c3ae..0b4e65e 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -78,6 +78,7 @@ struct huawei_data {
 	gboolean voice;
 	guint query_sim_state;
 	guint sim_poll_count;
+	struct cb_data *online_cbd;
 };
 =

 #define MAX_SIM_POLL_COUNT 5
@@ -167,19 +168,51 @@ static gboolean notify_sim_state(struct ofono_modem *=
modem,
 				enum huawei_sim_state sim_state)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	ofono_modem_online_cb_t cb;
 =

 	DBG("%d", sim_state);
 =

-	if (sim_state =3D=3D HUAWEI_SIM_STATE_NOT_EXISTENT) {
-		ofono_sim_inserted_notify(data->sim, FALSE);
+	/*
+	 * this needs to be set before calling the online callback, other
+	 * post_online() will use the wrong value
+	 */
+	data->sim_state =3D sim_state;
 =

+	switch (sim_state) {
+	case HUAWEI_SIM_STATE_NOT_EXISTENT:
 		/* SIM is not ready, try again a bit later */
 		return TRUE;
+	case HUAWEI_SIM_STATE_INVALID_OR_LOCKED:
+		ofono_modem_set_powered(modem, TRUE);
+
+		if (data->sim)
+			ofono_sim_inserted_notify(data->sim, TRUE);
+		break;
+	case HUAWEI_SIM_STATE_VALID:
+	case HUAWEI_SIM_STATE_INVALID_CS:
+	case HUAWEI_SIM_STATE_INVALID_PS:
+	case HUAWEI_SIM_STATE_INVALID_PS_AND_CS:
+		/*
+		 * In the "warm start" case the modem skips
+		 * HUAWEI_SIM_STATE_INVALID_OR_LOCKED altogether, so need
+		 * to set power and sim state also here
+		 */
+		ofono_modem_set_powered(modem, TRUE);
+
+		if (data->sim)
+			ofono_sim_inserted_notify(data->sim, TRUE);
+
+		if (data->online_cbd) {
+			cb =3D data->online_cbd->cb;
+			CALLBACK_WITH_SUCCESS(cb, data->online_cbd->data);
+
+			/* FIXME: how to handle failure? */
+			/* CALLBACK_WITH_FAILURE(cb, cbd->data); */
+
+			data->online_cbd =3D NULL;
+		}
+		break;
 	}
-	else
-		ofono_sim_inserted_notify(data->sim, TRUE);
-
-	data->sim_state =3D sim_state;
 =

 	return FALSE;
 }
@@ -385,8 +418,6 @@ static void cvoice_query_cb(gboolean ok, GAtResult *res=
ult,
 						NULL, NULL, NULL);
 =

 done:
-	ofono_modem_set_powered(modem, TRUE);
-
 	/* query current sim state */
         g_at_chat_send(data->pcui, "AT^SYSINFO", sysinfo_prefix,
 						sysinfo_cb, modem, NULL);
@@ -414,8 +445,6 @@ static void cvoice_support_cb(gboolean ok, GAtResult *r=
esult,
 	return;
 =

 done:
-	ofono_modem_set_powered(modem, TRUE);
-
 	/* query current sim state */
 	g_at_chat_send(data->pcui, "AT^SYSINFO", sysinfo_prefix,
 						sysinfo_cb, modem, NULL);
@@ -452,8 +481,6 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	/* check for voice support */
 	g_at_chat_send(data->pcui, "AT^CVOICE=3D?", cvoice_prefix,
 					cvoice_support_cb, modem, NULL);
-
-	/* query_sim_state(modem); */
 }
 =

 static GAtChat *create_port(const char *device)
@@ -557,6 +584,7 @@ static int huawei_enable(struct ofono_modem *modem)
 		data->voice =3D TRUE;
 =

 	data->sim_state =3D 0;
+	data->online_cbd =3D NULL;
 =

 	g_at_chat_send(data->pcui, "ATE0", none_prefix, NULL, NULL, NULL);
 =

@@ -609,13 +637,9 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_modem_online_cb_t cb =3D cbd->cb;
+	struct ofono_modem *modem =3D user_data;
 =

-	if (ok)
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	else
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	query_sim_state(modem);
 }
 =

 static void huawei_set_online(struct ofono_modem *modem, ofono_bool_t onli=
ne,
@@ -623,21 +647,23 @@ static void huawei_set_online(struct ofono_modem *mod=
em, ofono_bool_t online,
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 	GAtChat *chat =3D data->pcui;
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D5";
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (!cbd)
+	data->online_cbd =3D cb_data_new(cb, user_data);
+
+	if (!data->online_cbd)
 		goto error;
 =

-	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
+	if (g_at_chat_send(chat, command, NULL, set_online_cb, modem, NULL))
 		return;
 =

 error:
-	g_free(cbd);
+	g_free(data->online_cbd);
+	data->online_cbd =3D NULL;
 =

-	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 =

 static void huawei_pre_sim(struct ofono_modem *modem)
@@ -673,8 +699,13 @@ static void huawei_post_online(struct ofono_modem *mod=
em)
 	struct ofono_netreg *netreg;
 	struct ofono_message_waiting *mw;
 =

-	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS_AND_CS)
+	if (data->sim_state !=3D HUAWEI_SIM_STATE_VALID &&
+	    data->sim_state !=3D HUAWEI_SIM_STATE_INVALID_CS &&
+	    data->sim_state !=3D HUAWEI_SIM_STATE_INVALID_PS) {
+		ofono_info("huawei: invalid sim state in post online (%d)",
+				data->sim_state);
 		return;
+	}
 =

 	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
 								data->pcui);


--===============5111678855070614647==--

