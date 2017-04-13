Content-Type: multipart/mixed; boundary="===============6227112211798731380=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH v3 1/3] gemalto: Clean post init functions
Date: Thu, 13 Apr 2017 10:05:45 +0200
Message-ID: <1492070747-7252-2-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <1492070747-7252-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6227112211798731380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove inappropriate interfaces.
Move GPRS init from post_online to post_sim.
---
 plugins/gemalto.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index ffe6814..846e263 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -34,18 +34,11 @@
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
-#include <ofono/call-barring.h>
-#include <ofono/call-forwarding.h>
-#include <ofono/call-meter.h>
-#include <ofono/call-settings.h>
 #include <ofono/devinfo.h>
-#include <ofono/message-waiting.h>
 #include <ofono/netreg.h>
 #include <ofono/phonebook.h>
 #include <ofono/sim.h>
 #include <ofono/sms.h>
-#include <ofono/ussd.h>
-#include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/location-reporting.h>
@@ -193,7 +186,6 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
-	ofono_voicecall_create(modem, 0, "atmodem", data->app);
 	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
 =

 	if (sim)
@@ -203,39 +195,29 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 static void gemalto_post_sim(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

 	ofono_phonebook_create(modem, 0, "atmodem", data->app);
 =

 	ofono_sms_create(modem, 0, "atmodem", data->app);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
 }
 =

 static void gemalto_post_online(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_message_waiting *mw;
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

-	ofono_ussd_create(modem, 0, "atmodem", data->app);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->app);
-	ofono_call_settings_create(modem, 0, "atmodem", data->app);
 	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);
-	ofono_call_meter_create(modem, 0, "atmodem", data->app);
-	ofono_call_barring_create(modem, 0, "atmodem", data->app);
-
-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
-
-	mw =3D ofono_message_waiting_create(modem);
-	if (mw)
-		ofono_message_waiting_register(mw);
 }
 =

 static struct ofono_modem_driver gemalto_driver =3D {
-- =

1.9.1


--===============6227112211798731380==--

