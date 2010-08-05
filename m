Content-Type: multipart/mixed; boundary="===============3965126101979562904=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] huawei: Fix SIM state logic
Date: Thu, 05 Aug 2010 16:13:08 -0300
Message-ID: <1281035588-17040-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3965126101979562904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for voice-only SIM cards and enable phonebook atom for
non-voice modems.
---
 plugins/huawei.c |   76 ++++++++++++++++++++++++++++++++++++--------------=
---
 1 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 47d59d0..f8ada24 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -57,11 +57,20 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
 =

+enum huawei_sim_state {
+	HUAWEI_SIM_STATE_INVALID_OR_LOCKED =3D	0,
+	HUAWEI_SIM_STATE_VALID =3D		1,
+	HUAWEI_SIM_STATE_INVALID_CS =3D		2,
+	HUAWEI_SIM_STATE_INVALID_PS =3D		3,
+	HUAWEI_SIM_STATE_INVALID_PS_AND_CS =3D	4,
+	HUAWEI_SIM_STATE_NOT_EXISTENT =3D		255
+};
+
 struct huawei_data {
 	GAtChat *modem;
 	GAtChat *pcui;
 	struct ofono_sim *sim;
-	gint sim_state;
+	enum huawei_sim_state sim_state;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 };
@@ -100,17 +109,17 @@ static void huawei_debug(const char *str, void *user_=
data)
 	ofono_info("%s%s", prefix, str);
 }
 =

-static void notify_sim_state(struct ofono_modem *modem, gint sim_state)
+static void notify_sim_state(struct ofono_modem *modem,
+				enum huawei_sim_state sim_state)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 =

-	if (data->sim_state =3D=3D 0 && sim_state =3D=3D 1) {
-		ofono_sim_inserted_notify(data->sim, TRUE);
-		data->sim_state =3D sim_state;
-	} else if (data->sim_state =3D=3D 1 && sim_state =3D=3D 0) {
+	if (sim_state =3D=3D HUAWEI_SIM_STATE_NOT_EXISTENT)
 		ofono_sim_inserted_notify(data->sim, FALSE);
-		data->sim_state =3D sim_state;
-	}
+	else
+		ofono_sim_inserted_notify(data->sim, TRUE);
+
+	data->sim_state =3D sim_state;
 }
 =

 static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -142,24 +151,24 @@ static void sysinfo_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	if (!g_at_result_iter_next_number(&iter, &sim_state))
 		return;
 =

-	notify_sim_state(modem, sim_state);
+	notify_sim_state(modem, (enum huawei_sim_state) sim_state);
 }
 =

 static void simst_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	GAtResultIter iter;
-	int state;
+	gint sim_state;
 =

 	g_at_result_iter_init(&iter, result);
 =

 	if (!g_at_result_iter_next(&iter, "^SIMST:"))
 		return;
 =

-	if (!g_at_result_iter_next_number(&iter, &state))
+	if (!g_at_result_iter_next_number(&iter, &sim_state))
 		return;
 =

-	notify_sim_state(modem, state);
+	notify_sim_state(modem, (enum huawei_sim_state) sim_state);
 }
 =

 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
@@ -235,7 +244,8 @@ static void huawei_disconnect(gpointer user_data)
 =

 	DBG("");
 =

-	ofono_gprs_context_remove(data->gc);
+	if (data->gc)
+		ofono_gprs_context_remove(data->gc);
 =

 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
@@ -247,13 +257,16 @@ static void huawei_disconnect(gpointer user_data)
 	g_at_chat_set_disconnect_function(data->modem,
 						huawei_disconnect, modem);
 =

-	ofono_info("Reopened GPRS context channel");
+	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
+			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
+		ofono_info("Reopened GPRS context channel");
 =

-	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
-							data->modem);
+		data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
+								data->modem);
 =

-	if (data->gprs && data->gc)
-		ofono_gprs_add_context(data->gprs, data->gc);
+		if (data->gprs && data->gc)
+			ofono_gprs_add_context(data->gprs, data->gc);
+	}
 }
 =

 static int huawei_enable(struct ofono_modem *modem)
@@ -333,7 +346,9 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
 	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->pcui);
 =

-	if (ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE)
+	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
+			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS) &&
+			ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE)
 		ofono_voicecall_create(modem, 0, "atmodem", data->pcui);
 }
 =

@@ -345,6 +360,11 @@ static void huawei_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS_AND_CS) {
+		ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
+		return;
+	}
+
 	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
 								data->pcui);
 =

@@ -352,19 +372,25 @@ static void huawei_post_sim(struct ofono_modem *modem)
 	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
 								data->pcui);
 	ofono_ussd_create(modem, 0, "atmodem", data->pcui);
+	ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
 =

-	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
-	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
+			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
+		data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
+		data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
+								data->modem);
 =

-	if (data->gprs && data->gc)
-		ofono_gprs_add_context(data->gprs, data->gc);
+		if (data->gprs && data->gc)
+			ofono_gprs_add_context(data->gprs, data->gc);
+	}
 =

-	if (ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE) {
+	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
+			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS) &&
+			ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE) {
 		ofono_call_forwarding_create(modem, 0, "atmodem", data->pcui);
 		ofono_call_settings_create(modem, 0, "atmodem", data->pcui);
 		ofono_call_barring_create(modem, 0, "atmodem", data->pcui);
 		ofono_ssn_create(modem, 0, "atmodem", data->pcui);
-		ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
 =

 		mw =3D ofono_message_waiting_create(modem);
 		if (mw)
-- =

1.7.0.4


--===============3965126101979562904==--

