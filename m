Content-Type: multipart/mixed; boundary="===============7028038430382589970=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 3/3] atmodem: gprs: do CEREG instead of CGREG for LTE
Date: Sat, 12 Mar 2016 15:51:32 +0100
Message-ID: <1457794292-21184-4-git-send-email-dragos@endocode.com>
In-Reply-To: <1457794292-21184-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7028038430382589970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If we do CGREG in LTE we might get a bad registration status. That is
it will return unknown/out of coverage because it's registered on
on LTE.
---
 drivers/atmodem/gprs.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 0165253..ba0c802 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -39,10 +39,12 @@
 #include "gatchat.h"
 #include "gatresult.h"
 =

+#include "common.h"
 #include "atmodem.h"
 #include "vendor.h"
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
+static const char *cereg_prefix[] =3D { "+CEREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

@@ -104,12 +106,38 @@ static void at_cgreg_cb(gboolean ok, GAtResult *resul=
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
+				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	cb(&error, status, cbd->data);
+
+}
+
 static void at_gprs_registration_status(struct ofono_gprs *gprs,
 					ofono_gprs_status_cb_t cb,
 					void *data)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
+	int ret;
 =

 	cbd->user =3D gd;
 =

@@ -132,8 +160,18 @@ static void at_gprs_registration_status(struct ofono_g=
prs *gprs,
 		break;
 	}
 =

-	if (g_at_chat_send(gd->chat, "AT+CGREG?", cgreg_prefix,
-				at_cgreg_cb, cbd, g_free) > 0)
+	switch (ofono_gprs_get_technology(gprs)) {
+	case ACCESS_TECHNOLOGY_EUTRAN:
+		ret =3D g_at_chat_send(gd->chat, "AT+CEREG?", cereg_prefix,
+					at_cereg_cb, cbd, g_free);
+		break;
+	default:
+		ret =3D g_at_chat_send(gd->chat, "AT+CGREG?", cgreg_prefix,
+					at_cgreg_cb, cbd, g_free);
+		break;
+	}
+
+	if (ret > 0)
 		return;
 =

 	g_free(cbd);
-- =

2.5.0


--===============7028038430382589970==--

