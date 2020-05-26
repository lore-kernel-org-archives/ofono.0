Content-Type: multipart/mixed; boundary="===============3230302602934576633=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 3/7] quectel: Query the model before setting up the mux
Date: Tue, 26 May 2020 12:16:21 +0200
Message-ID: <20200526101625.31871-4-poeschel@lemonage.de>
In-Reply-To: <20200526101625.31871-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3230302602934576633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

This is a change for the EC21. It will require specific handling before
and right after setting up the mux. So this change prepares this. It
queries the modem model before the mux (CMUX) is activated.
---
 plugins/quectel.c | 86 +++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 0f6896b1..1d312c45 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -765,46 +765,6 @@ static void cfun_query(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		cfun_enable(TRUE, NULL, modem);
 }
 =

-static void cgmm_cb(int ok, GAtResult *result, void *user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	const char *model;
-
-	DBG("%p ok %d", modem, ok);
-
-	if (!at_util_parse_attr(result, "", &model)) {
-		ofono_error("Failed to query modem model");
-		close_serial(modem);
-		return;
-	}
-
-	if (strcmp(model, "UC15") =3D=3D 0) {
-		DBG("%p model UC15", modem);
-		data->vendor =3D OFONO_VENDOR_QUECTEL;
-		data->model =3D QUECTEL_UC15;
-	} else if (strcmp(model, "Quectel_M95") =3D=3D 0) {
-		DBG("%p model M95", modem);
-		data->vendor =3D OFONO_VENDOR_QUECTEL_SERIAL;
-		data->model =3D QUECTEL_M95;
-	} else if (strcmp(model, "Quectel_MC60") =3D=3D 0) {
-		DBG("%p model MC60", modem);
-		data->vendor =3D OFONO_VENDOR_QUECTEL_SERIAL;
-		data->model =3D QUECTEL_MC60;
-	} else if (strcmp(model, "EC21") =3D=3D 0) {
-		DBG("%p model EC21", modem);
-		data->vendor =3D OFONO_VENDOR_QUECTEL;
-		data->model =3D QUECTEL_EC21;
-	} else {
-		ofono_warn("%p unknown model: '%s'", modem, model);
-		data->vendor =3D OFONO_VENDOR_QUECTEL;
-		data->model =3D QUECTEL_UNKNOWN;
-	}
-
-	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix, cfun_query, modem,
-			NULL);
-}
-
 static void setup_aux(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -814,7 +774,7 @@ static void setup_aux(struct ofono_modem *modem)
 	g_at_chat_set_slave(data->modem, data->aux);
 	g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1; +QIURC=3D0", none_prefix,
 			NULL, NULL, NULL);
-	g_at_chat_send(data->aux, "AT+CGMM", cgmm_prefix, cgmm_cb, modem,
+	g_at_chat_send(data->aux, "AT+CFUN?", cfun_prefix, cfun_query, modem,
 			NULL);
 }
 =

@@ -1034,17 +994,57 @@ static void cmux_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	close_serial(modem);
 }
 =

-static void ate_cb(int ok, GAtResult *result, void *user_data)
+static void cgmm_cb(int ok, GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const char *model;
 =

-	DBG("%p", modem);
+	DBG("%p ok %d", modem, ok);
+
+	if (!at_util_parse_attr(result, "", &model)) {
+		ofono_error("Failed to query modem model");
+		close_serial(modem);
+		return;
+	}
+
+	if (strcmp(model, "UC15") =3D=3D 0) {
+		DBG("%p model UC15", modem);
+		data->vendor =3D OFONO_VENDOR_QUECTEL;
+		data->model =3D QUECTEL_UC15;
+	} else if (strcmp(model, "Quectel_M95") =3D=3D 0) {
+		DBG("%p model M95", modem);
+		data->vendor =3D OFONO_VENDOR_QUECTEL_SERIAL;
+		data->model =3D QUECTEL_M95;
+	} else if (strcmp(model, "Quectel_MC60") =3D=3D 0) {
+		DBG("%p model MC60", modem);
+		data->vendor =3D OFONO_VENDOR_QUECTEL_SERIAL;
+		data->model =3D QUECTEL_MC60;
+	} else if (strcmp(model, "EC21") =3D=3D 0) {
+		DBG("%p model EC21", modem);
+		data->vendor =3D OFONO_VENDOR_QUECTEL;
+		data->model =3D QUECTEL_EC21;
+	} else {
+		ofono_warn("%p unknown model: '%s'", modem, model);
+		data->vendor =3D OFONO_VENDOR_QUECTEL;
+		data->model =3D QUECTEL_UNKNOWN;
+	}
 =

 	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
 			cmux_cb, modem, NULL);
 }
 =

+static void ate_cb(int ok, GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_send(data->uart, "AT+CGMM", cgmm_prefix, cgmm_cb, modem,
+			NULL);
+}
+
 static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
-- =

2.26.2

--===============3230302602934576633==--

