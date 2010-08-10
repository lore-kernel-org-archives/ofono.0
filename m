Content-Type: multipart/mixed; boundary="===============8671863463717840453=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 2/2] huawei: postpone post_sim until SIM is ready
Date: Tue, 10 Aug 2010 12:57:41 +0300
Message-ID: <20100810095741.18457.64025.stgit@potku.valot.fi>
In-Reply-To: <20100810095612.18457.66344.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8671863463717840453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On my Huawei E1552 with PIN locked SIM sim_state is 0 when calling
huawei_post_sim() and gprs context is not registered. This is because
^SIMST notification is received only after huawei_post_sim() is called:

Aug 10 12:38:33 tukki ofonod[6565]: plugins/huawei.c:huawei_post_sim() 0x6c=
db50
[...]
Aug 10 12:38:34 tukki ofonod[6565]: Pcui:< \r\n^SIMST:1\r\n\r\n^SRVST:2\r\n
Aug 10 12:38:34 tukki ofonod[6565]: plugins/huawei.c:notify_sim_state() 1

Add a test to wait for sim_state to be ready and also a call to
notify_sim_state() to call huawei_post_sim() whenever needed.
---
 plugins/huawei.c |  102 ++++++++++++++++++++++++++++++--------------------=
----
 1 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index ba66513..582cba6 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -74,6 +74,7 @@ struct huawei_data {
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	guint query_sim_state;
+	gboolean post_sim;
 };
 =

 static gboolean query_sim_state(gpointer user_data);
@@ -112,6 +113,58 @@ static void huawei_debug(const char *str, void *user_d=
ata)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static void huawei_post_sim(struct ofono_modem *modem)
+{
+	struct huawei_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_netreg *netreg;
+	struct ofono_message_waiting *mw;
+
+	DBG("%p sim_state %d", modem, data->sim_state);
+
+	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_OR_LOCKED) {
+		/* let's wait for ^SIMST notification so that SIM is ready */
+		data->post_sim =3D TRUE;
+		return;
+	}
+
+	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS_AND_CS) {
+		ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
+		return;
+	}
+
+	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
+								data->pcui);
+
+	ofono_sms_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->pcui);
+	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
+								data->pcui);
+	ofono_ussd_create(modem, 0, "atmodem", data->pcui);
+	ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
+
+	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
+			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
+		data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
+		data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
+								data->modem);
+
+		if (data->gprs && data->gc)
+			ofono_gprs_add_context(data->gprs, data->gc);
+	}
+
+	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
+			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS) &&
+			ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE) {
+		ofono_call_forwarding_create(modem, 0, "atmodem", data->pcui);
+		ofono_call_settings_create(modem, 0, "atmodem", data->pcui);
+		ofono_call_barring_create(modem, 0, "atmodem", data->pcui);
+		ofono_ssn_create(modem, 0, "atmodem", data->pcui);
+
+		mw =3D ofono_message_waiting_create(modem);
+		if (mw)
+			ofono_message_waiting_register(mw);
+	}
+}
+
 static void notify_sim_state(struct ofono_modem *modem,
 				enum huawei_sim_state sim_state)
 {
@@ -130,6 +183,9 @@ static void notify_sim_state(struct ofono_modem *modem,
 		ofono_sim_inserted_notify(data->sim, TRUE);
 =

 	data->sim_state =3D sim_state;
+
+	if (data->post_sim)
+		huawei_post_sim(modem);
 }
 =

 static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -378,52 +434,6 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 		ofono_voicecall_create(modem, 0, "atmodem", data->pcui);
 }
 =

-static void huawei_post_sim(struct ofono_modem *modem)
-{
-	struct huawei_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_netreg *netreg;
-	struct ofono_message_waiting *mw;
-
-	DBG("%p", modem);
-
-	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS_AND_CS) {
-		ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
-		return;
-	}
-
-	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
-								data->pcui);
-
-	ofono_sms_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->pcui);
-	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
-								data->pcui);
-	ofono_ussd_create(modem, 0, "atmodem", data->pcui);
-	ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
-
-	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
-			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
-		data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
-		data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
-								data->modem);
-
-		if (data->gprs && data->gc)
-			ofono_gprs_add_context(data->gprs, data->gc);
-	}
-
-	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
-			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS) &&
-			ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE) {
-		ofono_call_forwarding_create(modem, 0, "atmodem", data->pcui);
-		ofono_call_settings_create(modem, 0, "atmodem", data->pcui);
-		ofono_call_barring_create(modem, 0, "atmodem", data->pcui);
-		ofono_ssn_create(modem, 0, "atmodem", data->pcui);
-
-		mw =3D ofono_message_waiting_create(modem);
-		if (mw)
-			ofono_message_waiting_register(mw);
-	}
-}
-
 static struct ofono_modem_driver huawei_driver =3D {
 	.name		=3D "huawei",
 	.probe		=3D huawei_probe,


--===============8671863463717840453==--

