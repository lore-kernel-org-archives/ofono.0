Content-Type: multipart/mixed; boundary="===============3794245139714794696=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v2 01/10] ublox: query device model
Date: Wed, 13 Mar 2019 21:23:15 +0100
Message-ID: <20190313202324.16369-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3794245139714794696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a call to CGMM into the modem_enable path in order to
establish the specific device model.  From this device model string, a
model-specific capabilities structure can be selected.
---
 plugins/ublox.c | 107 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 30 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 32cf1e61..20e20567 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -42,9 +42,10 @@
 #include <ofono/lte.h>
 #include <ofono/voicecall.h>
 =

-#include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+#include <drivers/ubloxmodem/ubloxmodem.h>
+
 static const char *none_prefix[] =3D { NULL };
 =

 enum supported_models {
@@ -59,6 +60,8 @@ struct ublox_data {
 	GAtChat *aux;
 	int model_id;
 	enum ofono_vendor vendor_family;
+
+	const struct ublox_model *model;
 };
 =

 static void ublox_debug(const char *str, void *user_data)
@@ -152,38 +155,79 @@ static void cfun_enable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

-static int ublox_enable(struct ofono_modem *modem)
+static void query_model_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
+	struct ofono_modem *modem =3D user_data;
 	struct ublox_data *data =3D ofono_modem_get_data(modem);
-	const char *model_str =3D NULL;
+	struct ofono_error error;
+	const char *model;
+	const struct ublox_model *m;
+	const char *model_str;
 =

-	DBG("%p", modem);
+	decode_at_error(&error, g_at_result_final_response(result));
 =

-	model_str =3D ofono_modem_get_string(modem, "Model");
-	if (model_str =3D=3D NULL)
-		return -EINVAL;
+	if (!ok)
+		goto fail;
 =

-	/*
-	 * Toby L2 devices are more complex and special than previously
-	 * supported U-Blox devices. So they need a vendor of their own.
-	 */
-	data->model_id =3D atoi(model_str);
-
-	data->vendor_family =3D OFONO_VENDOR_UBLOX;
-
-	switch (data->model_id) {
-	case SARA_G270:
-	case TOBYL2_COMPATIBLE_MODE:
-	case TOBYL2_HIGH_THROUGHPUT_MODE:
-		break;
-	case TOBYL2_MEDIUM_THROUGHPUT_MODE:
-		DBG("low/medium throughtput profile unsupported");
-		break;
-	default:
-		DBG("unknown ublox model id %d", data->model_id);
-		return -EINVAL;
+	if (at_util_parse_attr(result, "", &model) =3D=3D FALSE) {
+		ofono_error("Failed to query modem model");
+		goto fail;
+	}
+
+	m =3D ublox_model_from_name(model);
+	if (!m) {
+		ofono_error("Unrecognized model: %s", model);
+		goto fail;
+	}
+
+	data->model =3D m;
+
+	DBG("Model: %s", data->model->name);
+
+	if (data->model->flags & UBLOX_F_TOBY_L2) {
+		model_str =3D ofono_modem_get_string(modem, "Model");
+		if (!model_str)
+			goto fail;
+
+		/*
+		 * Toby L2 devices are more complex and special than previously
+		 * supported U-Blox devices. So they need a vendor of their own.
+		 */
+		data->model_id =3D strtoul(model_str, NULL, 10);
+
+		switch (data->model_id) {
+		case TOBYL2_COMPATIBLE_MODE:
+		case TOBYL2_HIGH_THROUGHPUT_MODE:
+			break;
+		case TOBYL2_MEDIUM_THROUGHPUT_MODE:
+			DBG("low/medium throughtput profile unsupported");
+			break;
+		default:
+			DBG("unknown ublox model id %d", data->model_id);
+			goto fail;
+		}
+	} else {
+		data->vendor_family =3D OFONO_VENDOR_UBLOX;
 	}
 =

+	if (g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
+					cfun_enable, modem, NULL))
+		return;
+
+fail:
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static int ublox_enable(struct ofono_modem *modem)
+{
+	struct ublox_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
 	data->aux =3D open_device(modem, "Aux", "Aux: ");
 	/* If this is a serial modem then the device may be behind
 	 * the 'Device' attribute instead...
@@ -199,7 +243,6 @@ static int ublox_enable(struct ofono_modem *modem)
 		g_at_chat_set_slave(data->modem, data->aux);
 		g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", none_prefix,
 						NULL, NULL, NULL);
-
 		g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
 	}
 =

@@ -209,10 +252,14 @@ static int ublox_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
 					NULL, NULL, NULL);
 =

-	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
-					cfun_enable, modem, NULL);
+	if (g_at_chat_send(data->aux, "AT+CGMM", NULL,
+				query_model_cb, modem, NULL) > 0)
+		return -EINPROGRESS;
 =

-	return -EINPROGRESS;
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+
+	return -EINVAL;
 }
 =

 static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
-- =

2.19.1


--===============3794245139714794696==--

