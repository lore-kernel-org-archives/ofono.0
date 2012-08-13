Content-Type: multipart/mixed; boundary="===============6801747385967740338=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 2/8] telit: add additional port for data connection
Date: Mon, 13 Aug 2012 15:17:39 +0200
Message-ID: <1344863859-22900-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6801747385967740338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use MDM port for data service and AUX for the AT chat.
Disable DCD so that the modem does not hangup after a data connection.
Add vendor for sim and gprs.

udevng: rename aux port from Data to Aux for telit.

Telit software user guide says:
USB AUX doesn=E2=80=99t support any flow control method. Therefore, this po=
rt
isn=E2=80=99t suitable for DATA service port.
We recommend this port should be used only for AT command
and URC processing.
---
 plugins/telit.c  |   76 +++++++++++++++++++++++++++++++++++++-------------=
---
 plugins/udevng.c |    2 +-
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 853fd44..8446a22 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -65,8 +65,8 @@ static const char *qss_prefix[] =3D { "#QSS:", NULL };
 static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
 =

 struct telit_data {
-	GAtChat *chat;
-	GAtChat *aux;
+	GAtChat *chat;		/* AT chat */
+	GAtChat *modem;		/* Data port */
 	struct ofono_sim *sim;
 	struct ofono_modem *sap_modem;
 	GIOChannel *bt_io;
@@ -295,6 +295,13 @@ static void cfun_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		return;
 	}
 =

+	/*
+	 * Switch data carrier detect signal off.
+	 * When the DCD is disabled the modem does not hangup anymore
+	 * after the data connection.
+	 */
+	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
+
 	ofono_modem_set_powered(m, TRUE);
 =

 	/* Enable sim state notification */
@@ -311,10 +318,19 @@ static int telit_enable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	data->chat =3D open_device(modem, "Modem", "Modem: ");
-	if (data->chat =3D=3D NULL)
+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem =3D=3D NULL)
 		return -EINVAL;
 =

+	data->chat =3D open_device(modem, "Aux", "Aux: ");
+	if (data->chat =3D=3D NULL) {
+		g_at_chat_unref(data->modem);
+		data->modem =3D NULL;
+		return -EIO;
+	}
+
+	g_at_chat_set_slave(data->modem, data->chat);
+
 	/*
 	 * Disable command echo and
 	 * enable the Extended Error Result Codes
@@ -362,8 +378,6 @@ static void rsen_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	DBG("%p", modem);
 =

 	if (!ok) {
-		g_at_chat_unref(data->aux);
-		data->aux =3D NULL;
 		ofono_modem_set_powered(data->sap_modem, FALSE);
 		sap_close_io(modem);
 		return;
@@ -380,6 +394,21 @@ static void cfun_disable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	DBG("%p", modem);
 =

+	GIOChannel *channel =3D g_at_chat_get_channel(data->modem);
+	if(channel) {
+		g_io_channel_unref(channel);
+		channel =3D NULL;
+	}
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	channel =3D g_at_chat_get_channel(data->chat);
+	if(channel) {
+		g_io_channel_unref(channel);
+		channel =3D NULL;
+	}
+
 	g_at_chat_unref(data->chat);
 	data->chat =3D NULL;
 =

@@ -394,6 +423,9 @@ static int telit_disable(struct ofono_modem *modem)
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 	DBG("%p", modem);
 =

+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
+
 	g_at_chat_cancel_all(data->chat);
 	g_at_chat_unregister_all(data->chat);
 =

@@ -411,9 +443,6 @@ static void rsen_disable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_unref(data->aux);
-	data->aux =3D NULL;
-
 	sap_close_io(modem);
 =

 	telit_disable(modem);
@@ -469,10 +498,6 @@ static int telit_sap_enable(struct ofono_modem *modem,
 	g_io_channel_set_buffered(data->hw_io, FALSE);
 	g_io_channel_set_close_on_unref(data->hw_io, TRUE);
 =

-	data->aux =3D open_device(modem, "Data", "Aux: ");
-	if (data->aux =3D=3D NULL)
-		goto error;
-
 	data->bt_io =3D g_io_channel_unix_new(bt_fd);
 	if (data->bt_io =3D=3D NULL)
 		goto error;
@@ -491,13 +516,13 @@ static int telit_sap_enable(struct ofono_modem *modem,
 =

 	data->sap_modem =3D sap_modem;
 =

-	g_at_chat_register(data->aux, "#RSEN:", telit_rsen_notify,
+	g_at_chat_register(data->chat, "#RSEN:", telit_rsen_notify,
 				FALSE, modem, NULL);
 =

-	g_at_chat_send(data->aux, "AT#NOPT=3D0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "AT#NOPT=3D0", NULL, NULL, NULL, NULL);
 =

 	/* Set SAP functionality */
-	g_at_chat_send(data->aux, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
+	g_at_chat_send(data->chat, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
 				rsen_enable_cb, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -516,10 +541,7 @@ static int telit_sap_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_cancel_all(data->aux);
-	g_at_chat_unregister_all(data->aux);
-
-	g_at_chat_send(data->aux, "AT#RSEN=3D0", rsen_prefix,
+	g_at_chat_send(data->chat, "AT#RSEN=3D0", rsen_prefix,
 				rsen_disable_cb, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -535,7 +557,7 @@ static void telit_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem", data=
->chat);
 	ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 }
 =

@@ -593,8 +615,8 @@ static void telit_post_online(struct ofono_modem *modem)
 	ofono_call_meter_create(modem, 0, "atmodem", data->chat);
 	ofono_call_barring_create(modem, 0, "atmodem", data->chat);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->ch=
at);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
@@ -633,11 +655,19 @@ static int telit_probe(struct ofono_modem *modem)
 =

 static void telit_remove(struct ofono_modem *modem)
 {
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+	=

 	DBG("%p", modem);
 =

 	bluetooth_sap_client_unregister(modem);
 =

 	ofono_modem_set_data(modem, NULL);
+	=

+	/* Cleanup after hot-unplug */
+	g_at_chat_unref(data->chat);
+	g_at_chat_unref(data->modem);
+	=

+	g_free(data);
 }
 =

 static struct ofono_modem_driver telit_driver =3D {
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 872039a..bd5e5e0 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -615,7 +615,7 @@ static gboolean setup_telit(struct modem_info *modem)
 	DBG("modem=3D%s aux=3D%s gps=3D%s diag=3D%s", mdm, aux, gps, diag);
 =

 	ofono_modem_set_string(modem->modem, "Modem", mdm);
-	ofono_modem_set_string(modem->modem, "Data", aux);
+	ofono_modem_set_string(modem->modem, "Aux", aux);
 	ofono_modem_set_string(modem->modem, "GPS", gps);
 =

 	return TRUE;
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============6801747385967740338==--

