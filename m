Content-Type: multipart/mixed; boundary="===============6964532279403258676=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 5/5] gprs: Quectel EC21 does not understand AT+CPSB
Date: Tue, 04 Aug 2020 14:38:49 +0200
Message-ID: <20200804123849.909105-5-poeschel@lemonage.de>
In-Reply-To: <20200804123849.909105-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6964532279403258676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

The Quectel EC21 modem does not understand the AT+CPSB command, so
aquire the current packet switched bearer from CGREG URC.
---
 drivers/atmodem/gprs.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index b637f733..5583d6fa 100644
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
@@ -98,6 +99,29 @@ static void list_contexts_data_unref(gpointer user_data)
 	g_free(ld);
 }
 =

+static int act_to_bearer(int act)
+{
+	switch (act) {
+		case 0:
+		case 1:
+			return PACKET_BEARER_GPRS;
+		case 2:
+			return PACKET_BEARER_UMTS;
+		case 3:
+			return PACKET_BEARER_EGPRS;
+		case 4:
+			return PACKET_BEARER_HSDPA;
+		case 5:
+			return PACKET_BEARER_HSUPA;
+		case 6:
+			return PACKET_BEARER_HSUPA_HSDPA;
+		case 7:
+			return PACKET_BEARER_EPS;
+		default:
+			return PACKET_BEARER_NONE;
+	}
+};
+
 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -342,11 +366,11 @@ static void at_gprs_list_active_contexts(struct ofono=
_gprs *gprs,
 static void cgreg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
-	int status;
+	int status, tech;
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

 	if (at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
-				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
+				NULL, NULL, &tech, gd->vendor) =3D=3D FALSE)
 		return;
 =

 	/*
@@ -372,6 +396,8 @@ static void cgreg_notify(GAtResult *result, gpointer us=
er_data)
 	}
 =

 	ofono_gprs_status_notify(gprs, status);
+	if (gd->vendor =3D=3D OFONO_VENDOR_QUECTEL_EC2X)
+		ofono_gprs_bearer_notify(gprs, act_to_bearer(tech));
 }
 =

 static void cgev_notify(GAtResult *result, gpointer user_data)
@@ -624,6 +650,8 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
 						NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_QUECTEL_EC2X:
+		break;
 	default:
 		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
 						FALSE, gprs, NULL);
-- =

2.27.0

--===============6964532279403258676==--

