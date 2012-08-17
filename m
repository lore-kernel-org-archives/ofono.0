Content-Type: multipart/mixed; boundary="===============4562550731386224082=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 2/2] telit: add additional port for data connection
Date: Fri, 17 Aug 2012 11:04:36 +0200
Message-ID: <1345194276-30324-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <1345193591-30179-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4562550731386224082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use MDM port for data service and AUX for the AT chat.
Disable DCD so that the modem does not hangup after a data connection.
---
 plugins/telit.c |   55 ++++++++++++++++++++++++++++++++++-----------------=
----
 1 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index d49ec11..3c3cf4f 100644
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
 	guint sim_inserted_source;
 	struct ofono_modem *sap_modem;
@@ -305,6 +305,13 @@ static void cfun_enable_cb(gboolean ok, GAtResult *res=
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
@@ -325,10 +332,19 @@ static int telit_enable(struct ofono_modem *modem)
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
@@ -376,8 +392,6 @@ static void rsen_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	DBG("%p", modem);
 =

 	if (!ok) {
-		g_at_chat_unref(data->aux);
-		data->aux =3D NULL;
 		ofono_modem_set_powered(data->sap_modem, FALSE);
 		sap_close_io(modem);
 		return;
@@ -411,6 +425,11 @@ static int telit_disable(struct ofono_modem *modem)
 	struct telit_data *data =3D ofono_modem_get_data(modem);
 	DBG("%p", modem);
 =

+	g_at_chat_cancel_all(data->modem);
+	g_at_chat_unregister_all(data->modem);
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
 	g_at_chat_cancel_all(data->chat);
 	g_at_chat_unregister_all(data->chat);
 =

@@ -428,9 +447,6 @@ static void rsen_disable_cb(gboolean ok, GAtResult *res=
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
@@ -486,10 +502,6 @@ static int telit_sap_enable(struct ofono_modem *modem,
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
@@ -508,13 +520,13 @@ static int telit_sap_enable(struct ofono_modem *modem,
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
@@ -533,10 +545,7 @@ static int telit_sap_disable(struct ofono_modem *modem)
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
@@ -572,7 +581,7 @@ static void telit_post_sim(struct ofono_modem *modem)
 =

 	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
 					data->chat);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
+	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
@@ -663,6 +672,10 @@ static void telit_remove(struct ofono_modem *modem)
 	if (data->sim_inserted_source > 0)
 		g_source_remove(data->sim_inserted_source);
 =

+	/* Cleanup after hot-unplug */
+	g_at_chat_unref(data->chat);
+	g_at_chat_unref(data->modem);
+
 	g_free(data);
 }
 =

-- =

1.7.7.6


--
Scanned by MailScanner.


--===============4562550731386224082==--

