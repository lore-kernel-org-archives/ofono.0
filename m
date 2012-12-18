Content-Type: multipart/mixed; boundary="===============7305147697804150827=="
MIME-Version: 1.0
From: Mingli Wu <mingli@southpole.se>
Subject: [PATCH] Telit: Add a timer for CPIN callback
Date: Tue, 18 Dec 2012 18:14:31 +0100
Message-ID: <1355850871-28886-2-git-send-email-mingli@southpole.se>
In-Reply-To: <1355850871-28886-1-git-send-email-mingli@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7305147697804150827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For some sim cards which do not support SMS, Telit HE910 modem
never reports new status of the sim card after "AT+CPIN?" is
sent.  Now a timer is added. After it is timeout, if no new
status of sim card is reported, timer callback will inform the
ofono that the sim card is inserted.
---
 plugins/telit.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index cd67ef4..6015060 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -75,6 +75,8 @@ struct telit_data {
 	GIOChannel *hw_io;
 	guint bt_watch;
 	guint hw_watch;
+	int sim_status;
+	guint sim_status_source;
 };
 =

 static void telit_debug(const char *str, void *user_data)
@@ -212,6 +214,31 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static gboolean cpin_sim_status_timeout_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	/* Callback of QSS already did it */
+	if(data->sim_status >=3D 2)
+		return TRUE;
+	=

+	if (data->have_sim =3D=3D FALSE) {
+		ofono_sim_inserted_notify(data->sim, TRUE);
+		data->have_sim =3D TRUE;
+	}
+
+	if (data->sms_phonebook_added =3D=3D FALSE) {
+		ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+		ofono_sms_create(modem, 0, "atmodem", data->chat);
+		data->sms_phonebook_added =3D TRUE;
+	}
+
+	data->sim_status =3D 3;
+
+	return TRUE;
+}
+
 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -230,8 +257,19 @@ static void at_cpin_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	g_at_result_iter_next_unquoted_string(&iter, &pin_required);
 =

 	// No PIN required, we can wait for #QSS: 3.
-	if (strcmp(pin_required, "READY")=3D=3D0)
+	if (strcmp(pin_required, "READY")=3D=3D0){
+		/* =

+		 * For some sim cards which do not support SMS, Telit =

+		 * HE910 modem never reports new status of the sim =

+		 * card after "AT+CPIN?" is sent.  Now a timer is added.
+		 * after it is timeout, if no new status of sim card is =

+		 * reported, timer callback will inform the ofono that =

+		 * the sim card is inserted.
+		 */
+		data->sim_status_source =3D
+				g_timeout_add_seconds(25, cpin_sim_status_timeout_cb, modem);
 		return;
+	}
 =

 	if (data->have_sim =3D=3D FALSE) {
 		ofono_sim_inserted_notify(data->sim, TRUE);
@@ -245,6 +283,8 @@ static void switch_sim_state_status(struct ofono_modem =
*modem, int status)
 =

 	DBG("%p, SIM status: %d", modem, status);
 =

+	data->sim_status =3D status;
+
 	switch (status) {
 	case 0:	/* SIM not inserted */
 		if (data->have_sim =3D=3D TRUE) {
@@ -343,6 +383,8 @@ static void cfun_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	/* Enable sim state notification */
 	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
+
+	data->sim_status_source =3D 0;
 }
 =

 static int telit_enable(struct ofono_modem *modem)
@@ -380,6 +422,8 @@ static int telit_enable(struct ofono_modem *modem)
 	/* Set phone functionality */
 	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
 				cfun_enable_cb, modem, NULL);
+	=

+	data->sim_status =3D 0;
 =

 	return -EINPROGRESS;
 }
@@ -433,6 +477,9 @@ static void cfun_disable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 	DBG("%p", modem);
 =

+	if (data->sim_status_source > 0)
+		g_source_remove(data->sim_status_source);
+
 	g_at_chat_unref(data->chat);
 	data->chat =3D NULL;
 =

-- =

1.7.9.5


--===============7305147697804150827==--

