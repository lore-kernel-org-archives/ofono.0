Content-Type: multipart/mixed; boundary="===============8040605794873486773=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: [PATCH 1/3] sim800: add sim800 support
Date: Tue, 13 Nov 2018 18:19:57 +0100
Message-ID: <1542129599-6117-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8040605794873486773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/sim900.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/plugins/sim900.c b/plugins/sim900.c
index a7728cd..ace02a5 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -24,6 +24,7 @@
 #endif
 =

 #include <errno.h>
+#include <string.h>
 #include <stdlib.h>
 #include <glib.h>
 #include <gatchat.h>
@@ -60,13 +61,64 @@ static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Ne=
t: ", "SMS: ",
 =

 static const char *none_prefix[] =3D { NULL };
 =

+enum type {
+	SIMCOM_UNKNOWN,
+	SIM800,
+	SIM900,
+};
+
 struct sim900_data {
 	GIOChannel *device;
 	GAtMux *mux;
 	GAtChat * dlcs[NUM_DLC];
 	guint frame_size;
+	enum type modem_type;
 };
 =

+static void mux_ready_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs =3D NULL;
+	struct ofono_gprs_context *gc;
+
+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+					data->dlcs[SMS_DLC]);
+
+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
+	if (gprs =3D=3D NULL)
+		return;
+
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
+									"atmodem", data->dlcs[GPRS_DLC]);
+	if (gc)
+		ofono_gprs_add_context(gprs, gc);
+}
+
+static void check_model(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	GAtResultIter iter;
+	char const *model;
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+	DBG("");
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, NULL)) {
+		if (!g_at_result_iter_next_unquoted_string(&iter, &model))
+			continue;
+
+		DBG("setting type %s", model);
+		if (strstr(model, "SIM800"))
+			data->modem_type =3D SIM800;
+		else if (strstr(model, "SIM900"))
+			data->modem_type =3D SIM800;
+		else
+			data->modem_type =3D SIMCOM_UNKNOWN;
+	}
+}
+
 static int sim900_probe(struct ofono_modem *modem)
 {
 	struct sim900_data *data;
@@ -111,6 +163,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	GHashTable *options;
 =

 	device =3D ofono_modem_get_string(modem, key);
+
 	if (device =3D=3D NULL)
 		return NULL;
 =

@@ -232,6 +285,11 @@ static void setup_internal_mux(struct ofono_modem *mod=
em)
 			goto error;
 		}
 	}
+	if (data->modem_type =3D=3D SIM800) {
+		for (i =3D 0; i<NUM_DLC; i++) {
+			g_at_chat_register(data->dlcs[i], "SMS Ready", mux_ready_notify, FALSE,=
 modem, NULL);
+		}
+	}
 =

 	ofono_modem_set_powered(modem, TRUE);
 =

@@ -294,6 +352,7 @@ static int sim900_enable(struct ofono_modem *modem)
 		return -EINVAL;
 =

 	g_at_chat_send(data->dlcs[SETUP_DLC], "ATE0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CGMM", NULL,check_model, modem,=
 NULL);
 =

 	/* For obtain correct sms service number */
 	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CSCS=3D\"GSM\"", NULL,
@@ -353,18 +412,20 @@ static void sim900_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
-	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+	if (data->modem_type =3D=3D SIM900) {
+		ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
 						data->dlcs[SMS_DLC]);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
-	if (gprs =3D=3D NULL)
-		return;
+		gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
+		if (gprs =3D=3D NULL)
+			return;
 =

-	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM_SIM900,
+		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM_SIM900,
 					"atmodem", data->dlcs[GPRS_DLC]);
-	if (gc)
-		ofono_gprs_add_context(gprs, gc);
+		if (gc)
+			ofono_gprs_add_context(gprs, gc);
+	}
 }
 =

 static void sim900_post_online(struct ofono_modem *modem)
-- =

2.7.4


--===============8040605794873486773==--

