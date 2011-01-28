Content-Type: multipart/mixed; boundary="===============8776737105465559294=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: [PATCH] plugins:ste:preparation for hotswap
Date: Fri, 28 Jan 2011 16:49:11 +0200
Message-ID: <1296226151-3432-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8776737105465559294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
Hi, =


This patch enables ste modem to handle hotswap situation. =


Br, =

Jussi

 plugins/ste.c |  109 +++++++++++++++++++++++++++++++++++++++++------------=
---
 1 files changed, 80 insertions(+), 29 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 85d2d51..e183073 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -66,15 +66,23 @@
 =

 #define NUM_CHAT	1
 =

-static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
-
 static char *chat_prefixes[NUM_CHAT] =3D { "Default: " };
 =

 struct ste_data {
 	GAtChat *chat;
-	guint cpin_poll_source;
-	guint cpin_poll_count;
 	gboolean have_sim;
+	struct ofono_sim *sim;
+};
+
+enum ste_sim_state {
+	SIM_STATE_NULL =3D 0,
+	SIM_STATE_AWAITING_APP,
+	SIM_STATE_BLOCKED,
+	SIM_STATE_BLOCKED_FOREVER,
+	SIM_STATE_WAIT_FOR_PIN,
+	SIM_STATE_ACTIVE,
+	SIM_STATE_TERMINATING,
+	SIM_STATE_POWER_OFF
 };
 =

 static int ste_probe(struct ofono_modem *modem)
@@ -102,9 +110,6 @@ static void ste_remove(struct ofono_modem *modem)
 =

 	g_at_chat_unref(data->chat);
 =

-	if (data->cpin_poll_source > 0)
-		g_source_remove(data->cpin_poll_source);
-
 	g_free(data);
 }
 =

@@ -115,28 +120,58 @@ static void ste_debug(const char *str, void *user_dat=
a)
 	ofono_info("%s%s", prefix, str);
 }
 =

-static gboolean init_simpin_check(gpointer user_data);
+static void handle_sim_status(int status, struct ofono_modem *modem)
+{
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	DBG("SIM status:%d\n", status);
+
+	switch (status) {
+	case SIM_STATE_WAIT_FOR_PIN:
+	case SIM_STATE_ACTIVE:
+
+		if (data->sim)
+			ofono_sim_inserted_notify(data->sim, TRUE);
+
+		data->have_sim =3D TRUE;
+		break;
+	case SIM_STATE_POWER_OFF:
+		if (data->sim)
+			ofono_sim_inserted_notify(data->sim, FALSE);
+		break;
+	case SIM_STATE_NULL:
+	case SIM_STATE_AWAITING_APP:
+	case SIM_STATE_BLOCKED:
+	case SIM_STATE_BLOCKED_FOREVER:
+	case SIM_STATE_TERMINATING:
+		break;
+	}
+}
 =

 static void simpin_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_modem *modem =3D user_data;
-	struct ste_data *data =3D ofono_modem_get_data(modem);
+	int simnr, status;
+	GAtResultIter iter;
 =

-	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
-	if (!ok && result->final_or_pdu &&
-			!strcmp(result->final_or_pdu, "+CME ERROR: 10") &&
-			data->cpin_poll_count++ < 5) {
-		data->cpin_poll_source =3D
-			g_timeout_add_seconds(1, init_simpin_check, modem);
-		return;
-	}
+	DBG("ok:%d", ok);
 =

-	data->cpin_poll_count =3D 0;
+	if (!ok)
+		return;
 =

-	/* Modem returns ERROR if there is no SIM in slot. */
-	data->have_sim =3D ok;
+	g_at_result_iter_init(&iter, result);
 =

 	ofono_modem_set_powered(modem, TRUE);
+
+	if (!g_at_result_iter_next(&iter, "*ESIMSR:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &simnr))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	handle_sim_status(status, modem);
 }
 =

 static gboolean init_simpin_check(gpointer user_data)
@@ -144,10 +179,9 @@ static gboolean init_simpin_check(gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct ste_data *data =3D ofono_modem_get_data(modem);
 =

-	data->cpin_poll_source =3D 0;
-
-	g_at_chat_send(data->chat, "AT+CPIN?", cpin_prefix,
-			simpin_check, modem, NULL);
+	g_at_chat_send(data->chat, "AT*ESIMSR=3D1;*ESIMSR?", NULL,
+			simpin_check,
+			modem, NULL);
 =

 	return FALSE;
 }
@@ -234,6 +268,23 @@ static GIOChannel *ste_create_channel(struct ofono_mod=
em *modem)
 	return channel;
 }
 =

+static void esimsr_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	int status;
+	GAtResultIter iter;
+	DBG("");
+
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, "*ESIMSR:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	handle_sim_status(status, modem);
+}
+
 static int ste_enable(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
@@ -265,6 +316,9 @@ static int ste_enable(struct ofono_modem *modem)
 =

 	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL, cfun_enable, modem, NULL);
 =

+	g_at_chat_register(data->chat, "*ESIMSR:", esimsr_notify,
+			FALSE, modem, NULL);
+
 	return -EINPROGRESS;
 }
 =

@@ -335,16 +389,13 @@ error:
 static void ste_pre_sim(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	sim =3D ofono_sim_create(modem, OFONO_VENDOR_MBM, "atmodem", data->chat);
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_MBM, "atmodem",
+			data->chat);
 	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
-
-	if (sim)
-		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

 static void ste_post_sim(struct ofono_modem *modem)
-- =

1.7.1


--===============8776737105465559294==--

