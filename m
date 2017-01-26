Content-Type: multipart/mixed; boundary="===============1841621028811671107=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 2/2] plugins: Handle HE910 and UE910 variants
Date: Thu, 26 Jan 2017 17:22:53 +0100
Message-ID: <20170126162253.25442-3-gluedig@gmail.com>
In-Reply-To: <20170126162253.25442-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1841621028811671107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Telit modems HE910 and UE910 share the same USB
vendor and device IDs (1bc7:0021) but they are
different devices.
HE910 is HSPA Class 14/6 and UE910 is Class 8/6.
Both come in voice-enabled variants.
HE910 also comes in variants with built-in GPS.
---
 plugins/xe910.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++++----=
----
 1 file changed, 143 insertions(+), 24 deletions(-)

diff --git a/plugins/xe910.c b/plugins/xe910.c
index 24fe1ade..9925879a 100644
--- a/plugins/xe910.c
+++ b/plugins/xe910.c
@@ -62,12 +62,40 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *qss_prefix[] =3D { "#QSS:", NULL };
 =

+enum modem_model {
+    HE910 =3D 1,
+    UE910
+};
+
+static struct {
+	enum modem_model model;
+	const char *variant;
+	gboolean has_voice;
+	gboolean has_gps;
+} variants_list[] =3D {
+    { HE910,	NULL,	FALSE,	FALSE },
+    { HE910,	"G",	TRUE,	TRUE },
+    { HE910,	"GL",	TRUE,	FALSE },
+    { HE910,	"EUR",	TRUE,	FALSE },
+    { HE910,	"NAR",	TRUE,	FALSE },
+    { HE910,	"DG",	FALSE,	TRUE },
+    { HE910,	"EUG",	FALSE,	TRUE },
+    { HE910,	"NAG",	FALSE,	TRUE },
+    { UE910,	NULL,	FALSE,	FALSE },
+    { UE910,	"EUR",	TRUE,	FALSE },
+    { UE910,	"NAR",	TRUE,	FALSE },
+    { }
+};
+
 struct xe910_data {
 	GAtChat *chat;		/* AT chat */
 	GAtChat *modem;		/* Data port */
 	struct ofono_sim *sim;
 	ofono_bool_t have_sim;
 	ofono_bool_t sms_phonebook_added;
+	enum modem_model model;
+	gboolean has_voice;
+	gboolean has_gps;
 };
 =

 static void xe910_debug(const char *str, void *user_data)
@@ -201,16 +229,8 @@ static void cfun_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 	DBG("%p", modem);
 =

-	if (!ok) {
-		g_at_chat_unref(data->chat);
-		data->chat =3D NULL;
-
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
-
-		ofono_modem_set_powered(modem, FALSE);
-		return;
-	}
+	if (!ok)
+	    return;
 =

 	/*
 	 * Switch data carrier detect signal off.
@@ -242,6 +262,97 @@ static void cfun_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 			qss_query_cb, modem, NULL);
 }
 =

+static gboolean find_model_variant(struct ofono_modem *modem, const char *=
 model_variant)
+{
+    struct xe910_data *data =3D ofono_modem_get_data(modem);
+    char model[32];
+    char variant[32];
+    gchar ** tokens;
+    int i;
+
+    if(!model_variant || model_variant[0] =3D=3D '\0')
+	return FALSE;
+
+    DBG("%s", model_variant);
+
+    tokens =3D g_strsplit(model_variant, "-", 2);
+
+    if(!tokens || !tokens[0] || !tokens[1])
+	return FALSE;
+
+    g_strlcpy(model, tokens[0], sizeof(model));
+    g_strlcpy(variant, tokens[1], sizeof(variant));
+    g_strfreev(tokens);
+
+    if (g_str_equal(model, "HE910"))
+	data->model =3D HE910;
+    else if (g_str_equal(model, "UE910"))
+	data->model =3D UE910;
+    else
+	return FALSE;
+
+    DBG("Model: %s", model);
+
+    for (i=3D0; variants_list[i].model; i++) {
+
+	if (variants_list[i].model !=3D data->model)
+	    continue;
+
+	/* Set model defaults */
+	if (variants_list[i].variant =3D=3D NULL) {
+	    data->has_voice =3D variants_list[i].has_voice;
+	    data->has_gps =3D variants_list[i].has_gps;
+	    continue;
+	}
+
+	/* Specific variant match */
+	if (g_str_equal(variant, variants_list[i].variant)) {
+	    DBG("Variant: %s", variant);
+	    data->has_voice =3D variants_list[i].has_voice;
+	    data->has_gps =3D variants_list[i].has_gps;
+	}
+    }
+
+    return TRUE;
+}
+
+static void cfun_gmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct xe910_data *data =3D ofono_modem_get_data(modem);
+	const char * model_variant;
+
+	DBG("%p", modem);
+
+	if (!ok)
+	    goto error;
+
+	/* Get +GMM response */
+	if(!at_util_parse_attr(result, "", &model_variant))
+	    goto error;
+
+	/* Try to find modem model and variant */
+	if(!find_model_variant(modem, model_variant)) {
+	    ofono_info("Unknown xE910 model/variant %s", model_variant);
+	    goto error;
+	}
+
+	/* Set phone functionality */
+	if (g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
+				cfun_enable_cb, modem, NULL) > 0)
+	    return;
+
+error:
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	ofono_modem_set_powered(modem, FALSE);
+	return;
+}
+
 static int xe910_enable(struct ofono_modem *modem)
 {
 	struct xe910_data *data =3D ofono_modem_get_data(modem);
@@ -268,9 +379,11 @@ static int xe910_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
 				NULL, NULL, NULL);
 =

-	/* Set phone functionality */
-	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
-				cfun_enable_cb, modem, NULL);
+
+	/* Get modem model and variant */
+	g_at_chat_send(data->chat, "AT+GMM", NULL,
+				cfun_gmm_cb, modem, NULL);
+
 =

 	return -EINPROGRESS;
 }
@@ -319,29 +432,35 @@ static void xe910_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem",
 					data->chat);
-	ofono_location_reporting_create(modem, 0, "telitmodem", data->chat);
+
+	if (data->has_gps)
+	    ofono_location_reporting_create(modem, 0, "telitmodem", data->chat);
 }
 =

 static void xe910_post_online(struct ofono_modem *modem)
 {
 	struct xe910_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 =

 	DBG("%p", modem);
 =

-	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 	ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
-	ofono_ussd_create(modem, 0, "atmodem", data->chat);
-	ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
-	ofono_call_settings_create(modem, 0, "atmodem", data->chat);
-	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
-	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
-
-	mw =3D ofono_message_waiting_create(modem);
-	if (mw)
+
+	if(data->has_voice) {
+	    struct ofono_message_waiting *mw;
+
+	    ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+	    ofono_ussd_create(modem, 0, "atmodem", data->chat);
+	    ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
+	    ofono_call_settings_create(modem, 0, "atmodem", data->chat);
+	    ofono_call_meter_create(modem, 0, "atmodem", data->chat);
+	    ofono_call_barring_create(modem, 0, "atmodem", data->chat);
+
+	    mw =3D ofono_message_waiting_create(modem);
+	    if (mw)
 		ofono_message_waiting_register(mw);
+	}
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
 					data->chat);
-- =

2.11.0


--===============1841621028811671107==--

