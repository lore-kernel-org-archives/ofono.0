Content-Type: multipart/mixed; boundary="===============7607107263377669886=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH] G1: Add an SMS quirk for CNMI mode
Date: Wed, 02 Sep 2009 21:59:09 -0400
Message-ID: <20090902215909.7b7a6c52@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7607107263377669886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From 853ec0707530ee9c35a41bea3f8a6cfd067c7317 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Wed, 2 Sep 2009 19:35:40 -0400
Subject: [PATCH] G1: Add an SMS quirk for CNMI mode

The G1 doesn't support mode2, despite advertising it.
The G1 chokes w/ an "Error 303" when we specify NMI mode 2.  Adding a quirk
to drop that mode from the supported list (just use mode 1) allows the G1
to properly deal with SMS.
---
 drivers/atmodem/sms.c    |   19 ++++++++++++++-----
 drivers/atmodem/vendor.h |    1 +
 plugins/g1.c             |    3 +++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index fc6c052..fc53480 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -35,6 +35,7 @@
 #include <ofono/sms.h>
 #include "smsutil.h"
 #include "util.h"
+#include "vendor.h"
 =

 #include "gatchat.h"
 #include "gatresult.h"
@@ -570,17 +571,25 @@ static inline gboolean append_cnmi_element(char *buf,=
 int *len, int cap,
 }
 =

 static gboolean build_cnmi_string(char *buf, int *cnmi_opts,
-					gboolean cnma_enabled)
+					struct sms_data *data)
 {
+	const char *mode;
 	int len =3D sprintf(buf, "AT+CNMI=3D");
 =

-	/* Mode doesn't matter, but sounds like 2 is the sanest option */
-	if (!append_cnmi_element(buf, &len, cnmi_opts[0], "2310", FALSE))
+	if (data->vendor =3D=3D OFONO_VENDOR_HTC_G1)
+		/* The G1 advertises support for mode 2, but returns an error
+		 * if we attempt to actually use it. */
+		mode =3D "1";
+	else
+		/* Sounds like 2 is the sanest mode */
+		mode =3D "2310";
+
+	if (!append_cnmi_element(buf, &len, cnmi_opts[0], mode, FALSE))
 		return FALSE;
 =

 	/* Prefer to deliver SMS via +CMT if CNMA is supported */
 	if (!append_cnmi_element(buf, &len, cnmi_opts[1],
-					cnma_enabled ? "21" : "1", FALSE))
+					data->cnma_enabled ? "21" : "1", FALSE))
 		return FALSE;
 =

 	/* Always deliver CB via +CBM, otherwise don't deliver at all */
@@ -666,7 +675,7 @@ static void at_cnmi_query_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 			goto out;
 	}
 =

-	if (build_cnmi_string(buf, cnmi_opts, data->cnma_enabled))
+	if (build_cnmi_string(buf, cnmi_opts, data))
 		supported =3D TRUE;
 =

 	if (data->cnma_enabled)
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index ebf771b..9551a10 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -21,4 +21,5 @@
 =

 enum ofono_vendor {
 	OFONO_VENDOR_GENERIC =3D 0,
+	OFONO_VENDOR_HTC_G1 =3D 1,
 };
diff --git a/plugins/g1.c b/plugins/g1.c
index 30b9f94..c515575 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -47,6 +47,8 @@
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 =

+#include <drivers/atmodem/vendor.h>
+
 /* Supply our own syntax parser */
 =

 enum G1_STATE_ {
@@ -234,6 +236,7 @@ static void g1_populate(struct ofono_modem *modem)
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
 	ofono_ssn_create(modem, 0, "atmodem", chat);
+	ofono_sms_create(modem, OFONO_VENDOR_HTC_G1, "atmodem", chat);
 	ofono_phonebook_create(modem, 0, "atmodem", chat);
 =

 	mw =3D ofono_message_waiting_create(modem);
-- =

1.6.3.3


--===============7607107263377669886==--

