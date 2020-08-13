Content-Type: multipart/mixed; boundary="===============3576263964861368496=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v3] gprs: Quectel EC21 does not understand AT+CPSB
Date: Thu, 13 Aug 2020 15:33:47 +0200
Message-ID: <20200813133347.489923-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3576263964861368496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

The Quectel EC21 modem does not understand the AT+CPSB command, so
aquire the current packet switched bearer from quectel proprietary
QIND:"act" URC.
---
 drivers/atmodem/gprs.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index b637f733..4e00d3cf 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -40,6 +40,7 @@
 #include "gatresult.h"
 =

 #include "atmodem.h"
+#include "common.h"
 #include "vendor.h"
 =

 #define MAX_CONTEXTS 255
@@ -596,6 +597,48 @@ static void cpsb_notify(GAtResult *result, gpointer us=
er_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

+static void quectel_qind_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	int bearer;
+	const char *str;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+QIND:"))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &str))
+		return;
+
+	if (g_str_equal("act", str)) {
+		if (!g_at_result_iter_next_string(&iter, &str))
+			return;
+
+		DBG("technology %s", str);
+		bearer =3D PACKET_BEARER_NONE;
+		if (g_str_equal("GSM", str))
+			bearer =3D PACKET_BEARER_GPRS;
+		else if (g_str_equal("EGPRS", str))
+			bearer =3D PACKET_BEARER_EGPRS;
+		else if (g_str_equal("WCDMA", str))
+			bearer =3D PACKET_BEARER_UMTS;
+		else if (g_str_equal("HSDPA", str))
+			bearer =3D PACKET_BEARER_HSDPA;
+		else if (g_str_equal("HSUPA", str))
+			bearer =3D PACKET_BEARER_HSUPA;
+		else if (g_str_equal("HSDPA&HSUPA", str))
+			bearer =3D PACKET_BEARER_HSUPA_HSDPA;
+		else if (g_str_equal("LTE", str))
+			bearer =3D PACKET_BEARER_EPS;
+
+		ofono_gprs_bearer_notify(gprs, bearer);
+	}
+}
+
+
 static void gprs_initialized(gboolean ok, GAtResult *result, gpointer user=
_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -624,6 +667,12 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
 						NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_QUECTEL_EC2X:
+		g_at_chat_register(gd->chat, "+QIND",
+				quectel_qind_notify, FALSE, gprs, NULL);
+		/* The "QIND: \"act\", ..." URC is activated in
+		 * network-registration.c */
+		break;
 	default:
 		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
 						FALSE, gprs, NULL);
-- =

2.27.0

--===============3576263964861368496==--

