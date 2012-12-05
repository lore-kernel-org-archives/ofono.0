Content-Type: multipart/mixed; boundary="===============2109329436442243487=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 2/2] atmodem: Probe device for previous APN.
Date: Wed, 05 Dec 2012 14:02:04 -0500
Message-ID: <20121205190204.GB27739@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2109329436442243487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

If the device has retained parameters for a previously defined IP
context, is is probed via AT+CGDCONT?.
---
 drivers/atmodem/gprs.c |   55 ++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 3005867..280ca49 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -35,6 +35,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/gprs.h>
+#include <ofono/gprs-provision.h>
 =

 #include "gatchat.h"
 #include "gatresult.h"
@@ -408,6 +409,56 @@ error:
 	ofono_gprs_remove(gprs);
 }
 =

+static void at_cgdcont_read_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	GAtResultIter iter;
+	gint cid;
+	const char *pdp_type;
+	const char *apn;
+	struct ofono_gprs_provision_data *ap;
+	gboolean found =3D FALSE;
+
+	if (!ok)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (!found && g_at_result_iter_next(&iter, "+CGDCONT:")) {
+		if (!g_at_result_iter_next_number(&iter, &cid))
+			continue;
+
+		if (!g_at_result_iter_next_string(&iter, &pdp_type))
+			continue;
+
+		if (!g_at_result_iter_next_string(&iter, &apn))
+			continue;
+
+		/* We look for IP PDPs */
+		if (g_str_equal(pdp_type, "IP"))
+			found =3D TRUE;
+	}
+
+	if (found =3D=3D FALSE)
+		goto done;
+
+	ap =3D g_try_new0(struct ofono_gprs_provision_data, 1);
+	if (ap =3D=3D NULL)
+		goto done;
+
+	ap->type =3D OFONO_GPRS_CONTEXT_TYPE_INTERNET;
+	ap->proto =3D OFONO_GPRS_PROTO_IP;
+	ap->apn =3D g_strdup(apn);
+	ofono_info("Probed AP %s from device", apn);
+	ofono_gprs_set_probed_ap(gprs, ap);
+
+done:
+	g_at_chat_send(gd->chat, "AT+CGREG=3D?", cgreg_prefix,
+			at_cgreg_test_cb, gprs, NULL);
+}
+
 static void at_cgdcont_test_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -454,8 +505,8 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResult *=
result,
 =

 	ofono_gprs_set_cid_range(gprs, min, max);
 =

-	g_at_chat_send(gd->chat, "AT+CGREG=3D?", cgreg_prefix,
-			at_cgreg_test_cb, gprs, NULL);
+	g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
+			at_cgdcont_read_cb, gprs, NULL);
 =

 	return;
 =

-- =

1.7.0.4

--===============2109329436442243487==--

