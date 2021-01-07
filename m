Content-Type: multipart/mixed; boundary="===============1076154612385524381=="
MIME-Version: 1.0
From: s.e.golubtsov@gmail.com
Subject: [PATCH v2] quectel: adding support for the Quectel EC200 USB modem
 series
Date: Thu, 07 Jan 2021 23:40:17 +0300
Message-ID: <20210107204017.3382-3-s.e.golubtsov@gmail.com>
In-Reply-To: <20210107204017.3382-1-s.e.golubtsov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1076154612385524381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergei Golubtsov <s.e.golubtsov@gmail.com>

Support for the Quectel EC200 USB modem series has been added. The model
identification AT command has been added as the first step in the
communication with a Quectel USB modem.
---
 plugins/quectel.c | 128 +++++++++++++++++++++++++++++-----------------
 plugins/udevng.c  |   6 ++-
 2 files changed, 85 insertions(+), 49 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 82fc688d..950f7ce6 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -64,7 +64,7 @@ static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *cbc_prefix[] =3D { "+CBC:", NULL };
 static const char *qinistat_prefix[] =3D { "+QINISTAT:", NULL };
 static const char *cgmm_prefix[] =3D { "UC15", "Quectel_M95", "Quectel_MC6=
0",
-					"EC21", NULL };
+					"EC21", "EC200", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static const uint8_t gsm0710_terminate[] =3D {
@@ -84,6 +84,7 @@ enum quectel_model {
 	QUECTEL_M95,
 	QUECTEL_MC60,
 	QUECTEL_EC21,
+	QUECTEL_EC200,
 };
 =

 struct quectel_data {
@@ -127,6 +128,15 @@ enum quectel_power_event {
 =

 static const char dbus_hw_interface[] =3D OFONO_SERVICE ".quectel.Hardware=
";
 =

+static ofono_bool_t has_serial_connection(struct ofono_modem *modem)
+{
+
+	if (ofono_modem_get_string(modem, "Device"))
+		return TRUE;
+
+	return FALSE;
+}
+
 static void quectel_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -543,6 +553,7 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 	switch (data->model) {
 	case QUECTEL_UC15:
 	case QUECTEL_EC21:
+	case QUECTEL_EC200:
 		g_at_chat_register(data->aux, "+QIND",  qind_notify, FALSE, hw,
 					NULL);
 		break;
@@ -591,6 +602,13 @@ static void qinistat_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		/* UC15 uses a bitmap of 1 + 2 + 4 =3D 7 */
 		ready =3D 7;
 		break;
+	case QUECTEL_EC200:
+		/*
+		 * EC200T doesn't indicate that the Phonebook initialization
+		 * is completed (=3D=3D4) when AT+CFUN=3D4, that's why 1 + 2 =3D 3
+		 */
+		ready =3D 3;
+		break;
 	case QUECTEL_M95:
 	case QUECTEL_MC60:
 		/* M95 and MC60 uses a counter to 3 */
@@ -807,6 +825,9 @@ static void setup_aux(struct ofono_modem *modem)
 				NULL, NULL, NULL);
 		g_at_chat_send(data->aux, "AT+QURCCFG=3D\"urcport\",\"uart1\"", none_pre=
fix,
 				NULL, NULL, NULL);
+	} else if (data->model =3D=3D QUECTEL_EC200) {
+		g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1", none_prefix,
+				NULL, NULL, NULL);
 	} else
 		g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1; +QIURC=3D0",
 				none_prefix, NULL, NULL, NULL);
@@ -815,6 +836,59 @@ static void setup_aux(struct ofono_modem *modem)
 			NULL);
 }
 =

+static void cgmm_cb(int ok, GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const char *model;
+
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
+		data->vendor =3D OFONO_VENDOR_QUECTEL_EC2X;
+		data->model =3D QUECTEL_EC21;
+	} else if (strstr(model, "EC200")) {
+		DBG("%p model %s", modem, model);
+		data->vendor =3D OFONO_VENDOR_QUECTEL_EC2X;
+		data->model =3D QUECTEL_EC200;
+	} else {
+		ofono_warn("%p unknown model: '%s'", modem, model);
+		data->vendor =3D OFONO_VENDOR_QUECTEL;
+		data->model =3D QUECTEL_UNKNOWN;
+	}
+
+	setup_aux(modem);
+}
+
+static void identify_model(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_send(data->aux, "AT+CGMM", cgmm_prefix, cgmm_cb, modem,
+			NULL);
+}
+
 static int open_ttys(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -834,7 +908,7 @@ static int open_ttys(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

-	setup_aux(modem);
+	identify_model(modem);
 =

 	return -EINPROGRESS;
 }
@@ -898,7 +972,7 @@ static void cmux_gatmux(struct ofono_modem *modem)
 		return;
 	}
 =

-	setup_aux(modem);
+	identify_model(modem);
 }
 =

 static void mux_ready_cb(struct l_timeout *timeout, void *user_data)
@@ -1031,46 +1105,6 @@ static void cmux_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	close_serial(modem);
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
-		data->vendor =3D OFONO_VENDOR_QUECTEL_EC2X;
-		data->model =3D QUECTEL_EC21;
-	} else {
-		ofono_warn("%p unknown model: '%s'", modem, model);
-		data->vendor =3D OFONO_VENDOR_QUECTEL;
-		data->model =3D QUECTEL_UNKNOWN;
-	}
-
-	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
-			cmux_cb, modem, NULL);
-}
-
 static void ate_cb(int ok, GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -1078,8 +1112,8 @@ static void ate_cb(int ok, GAtResult *result, void *u=
ser_data)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_send(data->uart, "AT+CGMM", cgmm_prefix, cgmm_cb, modem,
-			NULL);
+	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
+		cmux_cb, modem, NULL);
 }
 =

 static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
@@ -1211,7 +1245,7 @@ static int quectel_enable(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
 =

-	if (ofono_modem_get_string(modem, "Device"))
+	if (has_serial_connection(modem))
 		return open_serial(modem);
 	else
 		return open_ttys(modem);
@@ -1315,7 +1349,7 @@ static void quectel_post_sim(struct ofono_modem *mode=
m)
 	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
 	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
 =

-	if (data->model =3D=3D QUECTEL_EC21) {
+	if (data->model =3D=3D QUECTEL_EC21 || data->model =3D=3D QUECTEL_EC200) {
 		ofono_ussd_create(modem, data->vendor, "atmodem", data->aux);
 		ofono_lte_create(modem, data->vendor, "atmodem", data->aux);
 	}
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 3458fe89..34ac1cc0 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -941,10 +941,12 @@ static gboolean setup_quectel_serial(struct modem_inf=
o *modem)
 =

 static gboolean setup_quectel(struct modem_info *modem)
 {
-	if (modem->serial)
+	if (modem->type =3D=3D MODEM_TYPE_SERIAL)
 		return setup_quectel_serial(modem);
-	else
+	else if (modem->type =3D=3D MODEM_TYPE_USB)
 		return setup_quectel_usb(modem);
+	else
+		return FALSE;
 }
 =

 static gboolean setup_quectelqmi(struct modem_info *modem)
-- =

2.17.1

--===============1076154612385524381==--

