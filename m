Content-Type: multipart/mixed; boundary="===============8662942272362572789=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 5/8] atmodem/gprs.c: Add CEREG support
Date: Fri, 15 Feb 2019 14:11:39 +0200
Message-ID: <20190215121142.28163-6-philippedeswert@gmail.com>
In-Reply-To: <20190215121142.28163-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8662942272362572789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tommi Rekosuo <tommi.rekosuo@treon.fi>

For NB-IoT modems we need to use AT+CEREG instead of AT+CGREG
when in LTE network and detecting network registration in initial boot.
Enable +CEREG URC and use that also to detect registration state.
---
 drivers/atmodem/gprs.c | 60 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index de7c7864..d6128a42 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -34,6 +34,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/gprs.h>
+#include <ofono/netreg.h>
 =

 #include "gatchat.h"
 #include "gatresult.h"
@@ -42,6 +43,7 @@
 #include "vendor.h"
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
+static const char *cereg_prefix[] =3D { "+CEREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

@@ -108,12 +110,38 @@ static void at_cgreg_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	cb(&error, status, cbd->data);
 }
 =

+static void at_cereg_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int status;
+	struct gprs_data *gd =3D cbd->user;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	if (at_util_parse_reg(result, "+CEREG:", NULL, &status,
+                        NULL, NULL, NULL, gd->vendor) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	cb(&error, status, cbd->data);
+}
+
 static void at_gprs_registration_status(struct ofono_gprs *gprs,
 					ofono_gprs_status_cb_t cb,
 					void *data)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct ofono_netreg *netreg =3D ofono_gprs_get_netreg(gprs);
+	int ret =3D 0;
 =

 	cbd->user =3D gd;
 =

@@ -136,9 +164,16 @@ static void at_gprs_registration_status(struct ofono_g=
prs *gprs,
 		break;
 	}
 =

-	if (g_at_chat_send(gd->chat, "AT+CGREG?", cgreg_prefix,
-				at_cgreg_cb, cbd, g_free) > 0)
-		return;
+	if (ofono_netreg_get_technology(netreg) >=3D 7) {
+		ret =3D g_at_chat_send(gd->chat, "AT+CEREG?", cereg_prefix,
+				     at_cereg_cb, cbd, g_free);
+	} else {
+		ret =3D g_at_chat_send(gd->chat, "AT+CGREG?", cgreg_prefix,
+				     at_cgreg_cb, cbd, g_free);
+	}
+
+	if (ret > 0)
+	  return;
 =

 	g_free(cbd);
 =

@@ -418,6 +453,19 @@ static void ublox_ureg_notify(GAtResult *result, gpoin=
ter user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

+static void ublox_cereg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	int status;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	if (at_util_parse_reg_unsolicited(result, "+CEREG:", &status,
+					  NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
+	  return;
+
+	ofono_gprs_status_notify(gprs, status);
+}
+
 static void cpsb_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -458,6 +506,8 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	case OFONO_VENDOR_UBLOX_TOBY_L2:
 		g_at_chat_register(gd->chat, "+UREG:", ublox_ureg_notify,
 						FALSE, gprs, NULL);
+		g_at_chat_register(gd->chat, "+CEREG:", ublox_cereg_notify,
+				   FALSE, gprs, NULL);
 		g_at_chat_send(gd->chat, "AT+UREG=3D1", none_prefix,
 						NULL, NULL, NULL);
 		break;
@@ -528,6 +578,10 @@ retry:
 		goto error;
 =

 	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
+	/* Enable +CEREG URC for UBLOX */
+	if (gd->vendor =3D=3D OFONO_VENDOR_UBLOX) {
+		g_at_chat_send(gd->chat, "AT+CEREG=3D2", none_prefix, NULL, NULL, NULL);
+	}
 	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
 =

 	switch (gd->vendor) {
-- =

2.20.1


--===============8662942272362572789==--

