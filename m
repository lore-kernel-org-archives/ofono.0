Content-Type: multipart/mixed; boundary="===============3637611461184274592=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] huawei: Fix SIM state logic
Date: Tue, 03 Aug 2010 18:22:55 -0300
Message-ID: <1280870575-9714-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3637611461184274592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for voice-only SIM cards and enable phonebook atom for
non-voice modems.
---
 plugins/huawei.c |   56 +++++++++++++++++++++++++++++++++++---------------=
---
 1 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 47d59d0..fd31d2c 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -104,13 +104,15 @@ static void notify_sim_state(struct ofono_modem *mode=
m, gint sim_state)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 =

-	if (data->sim_state =3D=3D 0 && sim_state =3D=3D 1) {
-		ofono_sim_inserted_notify(data->sim, TRUE);
-		data->sim_state =3D sim_state;
-	} else if (data->sim_state =3D=3D 1 && sim_state =3D=3D 0) {
+	if (data->sim_state =3D=3D sim_state)
+		return;
+
+	if (sim_state =3D=3D 255)
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
@@ -235,7 +237,8 @@ static void huawei_disconnect(gpointer user_data)
 =

 	DBG("");
 =

-	ofono_gprs_context_remove(data->gc);
+	if (data->gc)
+		ofono_gprs_context_remove(data->gc);
 =

 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
@@ -247,13 +250,15 @@ static void huawei_disconnect(gpointer user_data)
 	g_at_chat_set_disconnect_function(data->modem,
 						huawei_disconnect, modem);
 =

-	ofono_info("Reopened GPRS context channel");
+	if (data->sim_state =3D=3D 1 || data->sim_state =3D=3D 2) {
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
@@ -333,7 +338,8 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
 	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->pcui);
 =

-	if (ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE)
+	if ((data->sim_state =3D=3D 1 || data->sim_state =3D=3D 3) &&
+			ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE)
 		ofono_voicecall_create(modem, 0, "atmodem", data->pcui);
 }
 =

@@ -345,6 +351,14 @@ static void huawei_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->sim_state =3D=3D 255)
+		return;
+
+	if (data->sim_state =3D=3D 4) {
+		ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
+		return;
+	}
+
 	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
 								data->pcui);
 =

@@ -352,19 +366,23 @@ static void huawei_post_sim(struct ofono_modem *modem)
 	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
 								data->pcui);
 	ofono_ussd_create(modem, 0, "atmodem", data->pcui);
+	ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
 =

-	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
-	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+	if (data->sim_state =3D=3D 1 || data->sim_state =3D=3D 2) {
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
+	if ((data->sim_state =3D=3D 1 || data->sim_state =3D=3D 3) &&
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


--===============3637611461184274592==--

