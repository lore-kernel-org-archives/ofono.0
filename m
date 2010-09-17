Content-Type: multipart/mixed; boundary="===============8591554895121342495=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/1] Enable some atoms for hso modem
Date: Fri, 17 Sep 2010 16:50:22 +0800
Message-ID: <1284713422-3558-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1284713422-3558-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8591554895121342495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hso.c |   34 ++++++++++++++++++++++++++++++++--
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/plugins/hso.c b/plugins/hso.c
index 25ca157..1fbde58 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -34,14 +34,23 @@
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
 #include <ofono/modem.h>
+#include <ofono/call-barring.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-meter.h>
+#include <ofono/call-settings.h>
+#include <ofono/call-volume.h>
 #include <ofono/devinfo.h>
+#include <ofono/message-waiting.h>
 #include <ofono/netreg.h>
+#include <ofono/phonebook.h>
 #include <ofono/sim.h>
 #include <ofono/cbs.h>
 #include <ofono/sms.h>
+#include <ofono/ssn.h>
 #include <ofono/ussd.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/voicecall.h>
 #include <ofono/radio-settings.h>
 #include <ofono/log.h>
 =

@@ -257,24 +266,40 @@ static void hso_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->control);
 	sim =3D ofono_sim_create(modem, OFONO_VENDOR_OPTION_HSO,
 				"atmodem", data->control);
+	ofono_voicecall_create(modem, 0, "atmodem", data->app);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

+
+static void hso_post_sim(struct ofono_modem *modem)
+{
+	struct hso_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->app);
+}
+
 static void hso_post_online(struct ofono_modem *modem)
 {
 	struct hso_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

+	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
+	ofono_call_settings_create(modem, 0, "atmodem", data->app);
 	ofono_netreg_create(modem, OFONO_VENDOR_OPTION_HSO,
 				"atmodem", data->app);
-
+	ofono_call_meter_create(modem, 0, "atmodem", data->app);
+	ofono_call_barring_create(modem, 0, "atmodem", data->app);
+	ofono_ssn_create(modem, 0, "atmodem", data->app);
+	ofono_call_volume_create(modem, 0, "atmodem", data->app);
 	ofono_radio_settings_create(modem, 0, "hsomodem", data->app);
-
 	ofono_sms_create(modem, OFONO_VENDOR_OPTION_HSO, "atmodem", data->app);
 	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 				"atmodem", data->app);
@@ -286,6 +311,10 @@ static void hso_post_online(struct ofono_modem *modem)
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
+
+	mw =3D ofono_message_waiting_create(modem);
+	if (mw)
+		ofono_message_waiting_register(mw);
 }
 =

 static struct ofono_modem_driver hso_driver =3D {
@@ -296,6 +325,7 @@ static struct ofono_modem_driver hso_driver =3D {
 	.disable	=3D hso_disable,
 	.set_online     =3D hso_set_online,
 	.pre_sim	=3D hso_pre_sim,
+	.post_sim	=3D hso_post_sim,
 	.post_online	=3D hso_post_online,
 };
 =

-- =

1.7.2.3


--===============8591554895121342495==--

