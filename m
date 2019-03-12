Content-Type: multipart/mixed; boundary="===============1940435861117632780=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 07/14] ublox: query USBCONF for applicable devices
Date: Tue, 12 Mar 2019 12:10:01 +0100
Message-ID: <20190312111008.29258-8-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1940435861117632780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The TOBY L2 series of modems presents a number of different
configurations with different throughtput characteristics.  These
configurations are packaged up as USB profiles; moreover, changing the
profile actually changes the USB model ID so this is even more like
selecting a different "device" altogether.  Nonetheless, all we need to
know is which profile is selected in order to set things up correctly
and this can be queried directly.

This patch adds a call to UUSBCONF for applicable modems in order to
query the USB configuration to find out which profile is active.
---
 plugins/ublox.c | 82 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 23 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index efb0afbc..f7c2a374 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -46,6 +46,7 @@
 =

 #include <drivers/ubloxmodem/ubloxmodem.h>
 =

+static const char *uusbconf_prefix[] =3D { "+UUSBCONF:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 enum supported_models {
@@ -155,6 +156,57 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

+static void query_usbconf_cb(gboolean ok, GAtResult *result, gpointer user=
_data){
+	struct ofono_modem* modem =3D user_data;
+	struct ublox_data *data =3D ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	int profile;
+
+	if (!ok) {
+		ofono_error("Unable to query USB configuration");
+		goto error;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+retry:
+	if (!g_at_result_iter_next(&iter, "+UUSBCONF")) {
+		ofono_error("Unable to query USB configuration");
+		goto error;
+	}
+
+	if (!g_at_result_iter_next_number(&iter, &profile))
+		goto retry;
+
+	switch (profile) {
+	case 0: /* Fairly back compatible */
+	case 1: /* Fairly back compatible plus audio */
+		data->model_id =3D  TOBYL2_COMPATIBLE_MODE;
+		break;
+	case 2: /* Low/medium throughput */
+		data->model_id =3D TOBYL2_MEDIUM_THROUGHPUT_MODE;
+		break;
+	case 3: /* High throughput mode */
+		data->model_id =3D TOBYL2_HIGH_THROUGHPUT_MODE;
+		break;
+	default:
+		ofono_error("Unexpected USB profile: %d", profile);
+		goto error;
+	}
+
+	if (g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
+					cfun_enable, modem, NULL))
+		return;
+
+error:
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+
 static void query_model_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_modem* modem =3D user_data;
@@ -162,7 +214,6 @@ static void query_model_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	struct ofono_error error;
 	const char *model;
 	const struct ublox_model* m;
-	const char* model_str;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 =

@@ -184,28 +235,13 @@ static void query_model_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	DBG("Model: %s", data->model->name);
 =

-	if (data->model->flags & UBLOX_F_TOBY_L2) {
-		model_str =3D ofono_modem_get_string(modem, "Model");
-		if (!model_str)
-			goto fail;
-
-		/*
-		 * Toby L2 devices are more complex and special than previously
-		 * supported U-Blox devices. So they need a vendor of their own.
-		 */
-		data->model_id =3D atoi(model_str);
-
-		switch (data->model_id) {
-		case TOBYL2_COMPATIBLE_MODE:
-		case TOBYL2_HIGH_THROUGHPUT_MODE:
-			break;
-		case TOBYL2_MEDIUM_THROUGHPUT_MODE:
-			DBG("low/medium throughtput profile unsupported");
-			break;
-		default:
-			DBG("unknown ublox model id %d", data->model_id);
-			goto fail;
-		}
+	if (data->model->flags & UBLOX_F_HAVE_USBCONF) {
+		if (g_at_chat_send(data->aux, "AT+UUSBCONF?", uusbconf_prefix,
+					query_usbconf_cb, modem, NULL))
+			return;
+
+		ofono_error("Unable to query USB configuration");
+		goto fail;
 	} else {
 		data->vendor_family =3D OFONO_VENDOR_UBLOX;
 	}
-- =

2.19.1


--===============1940435861117632780==--

