Content-Type: multipart/mixed; boundary="===============6933647374600989341=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH] Add GPRS, mux,
 volume control support in SIMCOM sim900 modem module
Date: Thu, 28 Feb 2013 19:43:34 +0400
Message-ID: <1362066215-27452-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6933647374600989341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

---
 plugins/sim900.c |  162 +++++++++++++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 137 insertions(+), 25 deletions(-)

diff --git a/plugins/sim900.c b/plugins/sim900.c
index 496faa6..f228c0e 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -29,6 +29,7 @@
 #include <glib.h>
 #include <gatchat.h>
 #include <gattty.h>
+#include <gatmux.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -44,13 +45,28 @@
 #include <ofono/history.h>
 #include <ofono/log.h>
 #include <ofono/voicecall.h>
+#include <ofono/call-volume.h>
 =

 #include <drivers/atmodem/vendor.h>
 =

+#define NUM_DLC 5
+
+#define SETUP_DLC   0
+#define VOICE_DLC   1
+#define NETREG_DLC  2
+#define SMS_DLC     3
+#define GPRS_DLC    4
+
+
+static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", "Net: ", "SMS: ", "GPR=
S: " , "Setup: "};
+
 static const char *none_prefix[] =3D { NULL };
 =

 struct sim900_data {
-	GAtChat *modem;
+	GIOChannel *device;
+	GAtMux *mux;
+	GAtChat *dlcs[NUM_DLC];
+	guint frame_size;
 };
 =

 static int sim900_probe(struct ofono_modem *modem)
@@ -76,7 +92,7 @@ static void sim900_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

-	g_at_chat_unref(data->modem);
+	g_at_chat_unref(data->dlcs[SETUP_DLC]);
 =

 	g_free(data);
 }
@@ -91,6 +107,7 @@ static void sim900_debug(const char *str, void *user_dat=
a)
 static GAtChat *open_device(struct ofono_modem *modem,
 				const char *key, char *debug)
 {
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
 	const char *device;
 	GAtSyntax *syntax;
 	GIOChannel *channel;
@@ -119,10 +136,33 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	if (channel =3D=3D NULL)
 		return NULL;
 =

+	data->device =3D channel;
 	syntax =3D g_at_syntax_new_gsm_permissive();
 	chat =3D g_at_chat_new(channel, syntax);
 	g_at_syntax_unref(syntax);
 =

+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, sim900_debug, debug);
+
+	return chat;
+}
+
+
+static GAtChat *create_chat(GIOChannel *channel, struct ofono_modem *modem,
+								char *debug)
+{
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsmv1();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
 	g_io_channel_unref(channel);
 =

 	if (chat =3D=3D NULL)
@@ -134,6 +174,65 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static void setup_internal_mux(struct ofono_modem *modem)
+{
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+	int i;
+
+	DBG("");
+
+	data->frame_size =3D 128;
+
+	data->mux =3D g_at_mux_new_gsm0710_basic(data->device, data->frame_size);
+	if (data->mux =3D=3D NULL)
+		goto error;
+
+	if (getenv("OFONO_MUX_DEBUG"))
+		g_at_mux_set_debug(data->mux, sim900_debug, "MUX: ");
+
+	if(!g_at_mux_start(data->mux)) =

+		goto error;
+
+	for (i =3D 0; i < NUM_DLC; i++) {
+		GIOChannel *channel =3D g_at_mux_create_channel(data->mux);
+
+		data->dlcs[i] =3D create_chat(channel, modem, dlc_prefixes[i]);
+		if (data->dlcs[i] =3D=3D NULL) {
+			ofono_error("Failed to create channel");
+			goto error;
+		}
+	}
+
+	ofono_modem_set_powered(modem, TRUE);
+
+	return;
+
+error:
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static void mux_setup_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim900_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(data->dlcs[SETUP_DLC]);
+	data->dlcs[SETUP_DLC] =3D NULL;
+
+	if (!ok)
+		goto error;
+
+	setup_internal_mux(modem);
+	=

+	return;
+	=

+error:
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -142,11 +241,9 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	DBG("");
 =

 	if (!ok) {
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
+		g_at_chat_unref(data->dlcs[SETUP_DLC]);
+		data->dlcs[SETUP_DLC] =3D NULL;
 	}
-
-	ofono_modem_set_powered(modem, ok);
 }
 =

 static int sim900_enable(struct ofono_modem *modem)
@@ -155,21 +252,22 @@ static int sim900_enable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	data->modem =3D open_device(modem, "Device", "Device: ");
-	if (data->modem =3D=3D NULL) {
-		DBG("return -EINVAL");
+	data->dlcs[SETUP_DLC] =3D open_device(modem, "Device", "Setup: ");
+	if (data->dlcs[SETUP_DLC] =3D=3D NULL) =

 		return -EINVAL;
-	}
 =

-	g_at_chat_send(data->modem, "ATE0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->dlcs[SETUP_DLC], "ATE0", NULL, NULL, NULL, NULL);
 =

 	/* For obtain correct sms service number */
-	g_at_chat_send(data->modem, "AT+CSCS=3D\"GSM\"", NULL,
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CSCS=3D\"GSM\"", NULL,
 					NULL, NULL, NULL);
 =

-	g_at_chat_send(data->modem, "AT+CFUN=3D1", none_prefix,
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D1", none_prefix,
 					cfun_enable, modem, NULL);
 =

+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CMUX=3D0,0,5,128,10,3,30,10,2", =

+		NULL, mux_setup_cb, modem, NULL);
+
 	return -EINPROGRESS;
 }
 =

@@ -181,8 +279,8 @@ static void cfun_disable(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	DBG("");
 =

-	g_at_chat_unref(data->modem);
-	data->modem =3D NULL;
+	g_at_chat_unref(data->dlcs[SETUP_DLC]);
+	data->dlcs[SETUP_DLC] =3D NULL;
 =

 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
@@ -194,10 +292,10 @@ static int sim900_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_cancel_all(data->modem);
-	g_at_chat_unregister_all(data->modem);
+	g_at_chat_cancel_all(data->dlcs[SETUP_DLC]);
+	g_at_chat_unregister_all(data->dlcs[SETUP_DLC]);
 =

-	g_at_chat_send(data->modem, "AT+CFUN=3D4", none_prefix,
+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D4", none_prefix,
 					cfun_disable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -210,9 +308,9 @@ static void sim900_pre_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "atmodem", data->modem);
+	ofono_devinfo_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
 	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
-				data->modem);
+				data->dlcs[VOICE_DLC]);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
@@ -221,12 +319,25 @@ static void sim900_pre_sim(struct ofono_modem *modem)
 static void sim900_post_sim(struct ofono_modem *modem)
 {
 	struct sim900_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

-	ofono_phonebook_create(modem, 0, "atmodem", data->modem);
+	ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
 	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
-				data->modem);
+				data->dlcs[SMS_DLC]);
+
+	gprs =3D ofono_gprs_create(modem, 0,		=

+					"atmodem", data->dlcs[GPRS_DLC]);
+	if (gprs =3D=3D NULL)
+		return;
+
+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
+					"atmodem", data->dlcs[GPRS_DLC]);
+	if (gc)
+		ofono_gprs_add_context(gprs, gc);
+
 }
 =

 static void sim900_post_online(struct ofono_modem *modem)
@@ -235,9 +346,10 @@ static void sim900_post_online(struct ofono_modem *mod=
em)
 =

 	DBG("%p", modem);
 =

-	ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->modem);
-	ofono_ussd_create(modem, 0, "atmodem", data->modem);
-	ofono_voicecall_create(modem, 0, "atmodem", data->modem);
+	ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->dlcs[VOI=
CE_DLC]);
+	ofono_ussd_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	ofono_voicecall_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
+	ofono_call_volume_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
 }
 =

 static struct ofono_modem_driver sim900_driver =3D {
-- =

1.7.10.4


--===============6933647374600989341==--

