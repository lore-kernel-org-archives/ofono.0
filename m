Content-Type: multipart/mixed; boundary="===============0131979962206078155=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] telit: enable extended sim status notification
Date: Wed, 29 Aug 2012 17:01:09 +0200
Message-ID: <1346252469-29513-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <503CDB69.5040705@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0131979962206078155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use AT#QSS=3D2 instead of AT#QSS=3D1 to get an URC when the SIM is not only
inserted but also when PIN is unlocked and when SMS + phonebook are
ready to be used.

Disable sim state notification in telit_enable() so that we sure get a
notification when we enable it later again. This way we don't have to
query the state the first time. Without this the Telit modem does not
always send an URC when AT#QSS=3D2 is sent.

Remove sim_inserted_source and sim_inserted_timeout_cb which are not
needed anymore as a consequence.
By the way the 1 second timeout was an ugly hack.

Don't query current SIM status in cfun_enable_cb() as the SIM is
disabled due to prior AT+CFUN=3D4.

Register '#QSS:' before enabling sim state notifications.

Remove telit_qss_cb() which was used as a callback for querying the
current SIM status.

Move sms atom creation into switch_sim_state_status() and add creation
of phonebook atom. These are created when QSS: 3 is received.

Avoid a reset  when switching between online and offline (airplane)
mode in telit_set_online(). +CFUN accepts a second parameter (0), which
disables a reset: AT+CFUN=3Dx,0.
---
 plugins/telit.c |   99 +++++++++++++++++++--------------------------------=
---
 1 files changed, 35 insertions(+), 64 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index ec57f01..fe2ccd6 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -61,14 +61,14 @@
 #include "bluetooth.h"
 =

 static const char *none_prefix[] =3D { NULL };
-static const char *qss_prefix[] =3D { "#QSS:", NULL };
 static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
 =

 struct telit_data {
 	GAtChat *chat;		/* AT chat */
 	GAtChat *modem;		/* Data port */
 	struct ofono_sim *sim;
-	guint sim_inserted_source;
+	ofono_bool_t have_sim;
+	ofono_bool_t sms_phonebook_added;
 	struct ofono_modem *sap_modem;
 	GIOChannel *bt_io;
 	GIOChannel *hw_io;
@@ -211,43 +211,36 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

-static gboolean sim_inserted_timeout_cb(gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	data->sim_inserted_source =3D 0;
-
-	ofono_sim_inserted_notify(data->sim, TRUE);
-
-	return FALSE;
-}
-
 static void switch_sim_state_status(struct ofono_modem *modem, int status)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 =

-	DBG("%p", modem);
+	DBG("%p, SIM status: %d", modem, status);
 =

 	switch (status) {
-	case 0:
-		DBG("SIM not inserted");
-		ofono_sim_inserted_notify(data->sim, FALSE);
+	case 0:	/* SIM not inserted */
+		if (data->have_sim =3D=3D TRUE) {
+			ofono_sim_inserted_notify(data->sim, FALSE);
+			data->have_sim =3D FALSE;
+			data->sms_phonebook_added =3D FALSE;
+		}
 		break;
-	case 1:
-		DBG("SIM inserted");
-		/* We need to sleep a bit */
-		data->sim_inserted_source =3D g_timeout_add_seconds(1,
-							sim_inserted_timeout_cb,
-							modem);
+	case 1:	/* SIM inserted */
+	case 2:	/* SIM inserted and PIN unlocked */
+		if (data->have_sim =3D=3D FALSE) {
+			ofono_sim_inserted_notify(data->sim, TRUE);
+			data->have_sim =3D TRUE;
+		}
 		break;
-	case 2:
-		DBG("SIM inserted and PIN unlocked");
+	case 3:	/* SIM inserted, SMS and phonebook ready */
+		if (data->sms_phonebook_added =3D=3D FALSE) {
+			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+			ofono_sms_create(modem, 0, "atmodem", data->chat);
+			data->sms_phonebook_added =3D TRUE;
+		}
 		break;
-	case 3:
-		DBG("SIM inserted and ready");
+	default:
+		ofono_warn("Unknown SIM state %d received", status);
 		break;
 	}
 }
@@ -270,25 +263,6 @@ static void telit_qss_notify(GAtResult *result, gpoint=
er user_data)
 	switch_sim_state_status(modem, status);
 }
 =

-static void telit_qss_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
-{
-	struct ofono_modem *modem =3D user_data;
-	int mode;
-	int status;
-	GAtResultIter iter;
-	g_at_result_iter_init(&iter, result);
-
-	DBG("%p", modem);
-
-	if (!g_at_result_iter_next(&iter, "#QSS:"))
-		return;
-
-	g_at_result_iter_next_number(&iter, &mode);
-	g_at_result_iter_next_number(&iter, &status);
-
-	switch_sim_state_status(modem, status);
-}
-
 static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -312,6 +286,9 @@ static void cfun_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	 */
 	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
 =

+	data->have_sim =3D FALSE;
+	data->sms_phonebook_added =3D FALSE;
+
 	ofono_modem_set_powered(m, TRUE);
 =

 	/*
@@ -321,16 +298,12 @@ static void cfun_enable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
 				NULL, NULL, NULL);
 =

-	/* Enable sim state notification */
-	g_at_chat_send(data->chat, "AT#QSS=3D1", none_prefix, NULL, NULL, NULL);
-
 	/* Follow sim state */
 	g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
 				FALSE, modem, NULL);
 =

-	/* Query current sim state */
-	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
-				telit_qss_cb, modem, NULL);
+	/* Enable sim state notification */
+	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
 }
 =

 static int telit_enable(struct ofono_modem *modem)
@@ -359,6 +332,12 @@ static int telit_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
 				NULL, NULL, NULL);
 =

+	/*
+	 * Disable sim state notification so that we sure get a notification
+	 * when we enable it again later and don't have to query it.
+	 */
+	g_at_chat_send(data->chat, "AT#QSS=3D0", none_prefix, NULL, NULL, NULL);
+
 	/* Set phone functionality */
 	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
 				cfun_enable_cb, modem, NULL);
@@ -418,9 +397,6 @@ static void cfun_disable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	g_at_chat_unref(data->chat);
 	data->chat =3D NULL;
 =

-	if (data->sim_inserted_source > 0)
-		g_source_remove(data->sim_inserted_source);
-
 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
 =

@@ -583,8 +559,6 @@ static void telit_post_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_sms_create(modem, 0, "atmodem", data->chat);
-
 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
 					data->chat);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
@@ -608,7 +582,7 @@ static void telit_set_online(struct ofono_modem *modem,=
 ofono_bool_t online,
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+	char const *command =3D online ? "AT+CFUN=3D1,0" : "AT+CFUN=3D4,0";
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

@@ -675,9 +649,6 @@ static void telit_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

-	if (data->sim_inserted_source > 0)
-		g_source_remove(data->sim_inserted_source);
-
 	/* Cleanup after hot-unplug */
 	g_at_chat_unref(data->chat);
 	g_at_chat_unref(data->modem);
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============0131979962206078155==--

