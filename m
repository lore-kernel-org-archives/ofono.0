Content-Type: multipart/mixed; boundary="===============8843238640798222934=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: [PATCH] ste: Add support for multiple AT channels
Date: Wed, 02 Mar 2011 11:33:53 +0200
Message-ID: <1299058433-16980-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8843238640798222934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ste.c |  138 ++++++++++++++++++++++++++++++++++++-----------------=
----
 1 files changed, 87 insertions(+), 51 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index b786571..9a1d3d3 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -65,13 +65,19 @@
 #include <drivers/stemodem/caif_socket.h>
 #include <drivers/stemodem/if_caif.h>
 =

-#define NUM_CHAT	1
+#define NUM_CHAT	5
+#define AT_DEFAULT	0
+#define AT_NET	1
+#define AT_VOICE	2
+#define AT_GPRS	3
+#define AT_SIM	4
 #define MAX_PDP_CONTEXTS	4
 =

-static char *chat_prefixes[NUM_CHAT] =3D { "Default: " };
+static char *chat_prefixes[NUM_CHAT] =3D { "Default: ", "Net: ", "Voice: ",
+					"GPRS: ", "SIM: " };
 =

 struct ste_data {
-	GAtChat *chat;
+	GAtChat *chat[NUM_CHAT];
 	gboolean have_sim;
 	struct ofono_sim *sim;
 };
@@ -105,12 +111,14 @@ static int ste_probe(struct ofono_modem *modem)
 static void ste_remove(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
+	int i;
 =

 	DBG("%p", modem);
 =

 	ofono_modem_set_data(modem, NULL);
 =

-	g_at_chat_unref(data->chat);
+	for (i =3D 0; i < NUM_CHAT; i++)
+		g_at_chat_unref(data->chat[i]);
 =

 	g_free(data);
 }
@@ -185,7 +193,7 @@ static gboolean init_sim_reporting(gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct ste_data *data =3D ofono_modem_get_data(modem);
 =

-	g_at_chat_send(data->chat, "AT*ESIMSR=3D1;*ESIMSR?", NULL,
+	g_at_chat_send(data->chat[AT_SIM], "AT*ESIMSR=3D1;*ESIMSR?", NULL,
 			handle_sim_state,
 			modem, NULL);
 =

@@ -195,11 +203,21 @@ static gboolean init_sim_reporting(gpointer user_data)
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
+	struct ste_data *data =3D ofono_modem_get_data(modem);
+	int i;
 =

 	DBG("");
 =

 	if (!ok) {
 		ofono_modem_set_powered(modem, FALSE);
+
+		for (i =3D 0; i < NUM_CHAT; i++) {
+			g_at_chat_cancel_all(data->chat[i]);
+			g_at_chat_unregister_all(data->chat[i]);
+			g_at_chat_unref(data->chat[i]);
+			data->chat[i] =3D NULL;
+		}
+
 		return;
 	}
 =

@@ -295,35 +313,47 @@ static void esimsr_notify(GAtResult *result, gpointer=
 user_data)
 static int ste_enable(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
-	GIOChannel *channel;
 	GAtSyntax *syntax;
+	int i;
 =

 	syntax =3D g_at_syntax_new_gsm_permissive();
 =

-	channel =3D ste_create_channel(modem);
-	if (!channel)
-		return -EIO;
+	for (i =3D 0; i < NUM_CHAT; i++) {
+		GIOChannel *channel =3D ste_create_channel(modem);
 =

-	data->chat =3D g_at_chat_new_blocking(channel, syntax);
-	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
-			NULL, NULL, NULL, NULL);
+		data->chat[i] =3D g_at_chat_new_blocking(channel, syntax);
+		if (data->chat[i] =3D=3D NULL)
+			return -EIO;
 =

-	/* All STE modems support UTF-8 */
-	g_at_chat_send(data->chat, "AT+CSCS=3D\"UTF-8\"",
-			NULL, NULL, NULL, NULL);
+		g_at_chat_send(data->chat[i], "AT&F E0 V1 X4 &C1 +CMEE=3D1",
+				NULL, NULL, NULL, NULL);
 =

-	g_io_channel_unref(channel);
-	g_at_syntax_unref(syntax);
+		/* All STE modems support UTF-8 */
+		g_at_chat_send(data->chat[i], "AT+CSCS=3D\"UTF-8\"",
+				NULL, NULL, NULL, NULL);
 =

-	if (data->chat =3D=3D NULL)
-		return -ENOMEM;
+		g_io_channel_unref(channel);
+	}
 =

-	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(data->chat, ste_debug, chat_prefixes[0]);
+	g_at_syntax_unref(syntax);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL, cfun_enable, modem, NULL);
+	if (getenv("OFONO_AT_DEBUG")) {
+		g_at_chat_set_debug(data->chat[AT_DEFAULT], ste_debug,
+					chat_prefixes[0]);
+		g_at_chat_set_debug(data->chat[AT_NET], ste_debug,
+					chat_prefixes[1]);
+		g_at_chat_set_debug(data->chat[AT_VOICE], ste_debug,
+					chat_prefixes[2]);
+		g_at_chat_set_debug(data->chat[AT_GPRS], ste_debug,
+					chat_prefixes[3]);
+		g_at_chat_set_debug(data->chat[AT_SIM], ste_debug,
+					chat_prefixes[4]);
+	}
 =

-	g_at_chat_register(data->chat, "*ESIMSR:", esimsr_notify,
+	g_at_chat_send(data->chat[AT_DEFAULT], "AT+CFUN=3D4", NULL, cfun_enable,
+				modem, NULL);
+
+	g_at_chat_register(data->chat[AT_SIM], "*ESIMSR:", esimsr_notify,
 				FALSE, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -333,11 +363,14 @@ static void cfun_disable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct ste_data *data =3D ofono_modem_get_data(modem);
+	int i;
 =

 	DBG("");
 =

-	g_at_chat_unref(data->chat);
-	data->chat =3D NULL;
+	for (i =3D 0; i < NUM_CHAT; i++) {
+		g_at_chat_unref(data->chat[i]);
+		data->chat[i] =3D NULL;
+	}
 =

 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
@@ -346,15 +379,15 @@ static void cfun_disable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 static int ste_disable(struct ofono_modem *modem)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
+	int i;
 =

 	DBG("%p", modem);
 =

-	if (data->chat =3D=3D NULL)
-		return 0;
-
-	g_at_chat_cancel_all(data->chat);
-	g_at_chat_unregister_all(data->chat);
-	g_at_chat_send(data->chat, "AT+CFUN=3D4", NULL,
+	for (i =3D 0; i < NUM_CHAT; i++) {
+		g_at_chat_cancel_all(data->chat[i]);
+		g_at_chat_unregister_all(data->chat[i]);
+	}
+	g_at_chat_send(data->chat[AT_DEFAULT], "AT+CFUN=3D4", NULL,
 					cfun_disable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -375,7 +408,7 @@ static void ste_set_online(struct ofono_modem *modem, o=
fono_bool_t online,
 				ofono_modem_online_cb_t cb, void *user_data)
 {
 	struct ste_data *data =3D ofono_modem_get_data(modem);
-	GAtChat *chat =3D data->chat;
+	GAtChat *chat =3D data->chat[AT_DEFAULT];
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
 	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
 =

@@ -395,10 +428,10 @@ static void ste_pre_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
+	ofono_devinfo_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_MBM, "atmodem",
-					data->chat);
-	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
+					data->chat[AT_SIM]);
+	ofono_voicecall_create(modem, 0, "stemodem", data->chat[AT_VOICE]);
 }
 =

 static void ste_post_sim(struct ofono_modem *modem)
@@ -407,11 +440,11 @@ static void ste_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
-	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
-	ofono_radio_settings_create(modem, 0, "stemodem", data->chat);
+	ofono_stk_create(modem, 0, "mbmmodem", data->chat[AT_SIM]);
+	ofono_phonebook_create(modem, 0, "atmodem", data->chat[AT_SIM]);
+	ofono_radio_settings_create(modem, 0, "stemodem", data->chat[AT_NET]);
 =

-	ofono_sms_create(modem, 0, "atmodem", data->chat);
+	ofono_sms_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
 }
 =

 static void ste_post_online(struct ofono_modem *modem)
@@ -424,22 +457,25 @@ static void ste_post_online(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_ussd_create(modem, 0, "atmodem", data->chat);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
-	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-	ofono_netreg_create(modem, OFONO_VENDOR_MBM, "atmodem", data->chat);
-	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
-	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-	ofono_ssn_create(modem, 0, "atmodem", data->chat);
-	ofono_call_volume_create(modem, 0, "atmodem", data->chat);
-	ofono_cbs_create(modem, 0, "atmodem", data->chat);
+	ofono_ussd_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
+	ofono_call_forwarding_create(modem, 0,
+					"atmodem", data->chat[AT_DEFAULT]);
+	ofono_call_settings_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
+	ofono_netreg_create(modem, OFONO_VENDOR_MBM,
+					"atmodem", data->chat[AT_NET]);
+	ofono_call_meter_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
+	ofono_call_barring_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
+	ofono_ssn_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
+	ofono_call_volume_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
+	ofono_cbs_create(modem, 0, "atmodem", data->chat[AT_DEFAULT]);
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
-					"atmodem", data->chat);
+					"atmodem", data->chat[AT_GPRS]);
+
 	if (gprs) {
 		for (i =3D 0; i < MAX_PDP_CONTEXTS; i++) {
-			gc =3D ofono_gprs_context_create(
-					modem, 0, "stemodem", data->chat);
+			gc =3D ofono_gprs_context_create(modem, 0, "stemodem",
+					 data->chat[AT_GPRS]);
 			if (gc =3D=3D NULL)
 				break;
 =

-- =

1.7.0.4


--===============8843238640798222934==--

