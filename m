Content-Type: multipart/mixed; boundary="===============1274919765907939830=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH] telit: notify sim inserted when sim ready
Date: Thu, 26 Jul 2012 15:36:55 +0200
Message-ID: <1343309815-2856-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1274919765907939830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use AT#QSS=3D2 instead of AT#QSS=3D1 to get an URC when the SIM is not only
inserted but ready to be used.

Remove sim_inserted_source and sim_inserted_timeout_cb which are not needed=
 anymore as a
consequence. By the way the 1 second timeout was an ugly hack.
---
 plugins/telit.c |   32 ++------------------------------
 1 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 6ae7249..7fc2666 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -68,7 +68,6 @@ struct telit_data {
 	GAtChat *chat;
 	GAtChat *aux;
 	struct ofono_sim *sim;
-	guint sim_inserted_source;
 	struct ofono_modem *sap_modem;
 	GIOChannel *bt_io;
 	GIOChannel *hw_io;
@@ -211,20 +210,6 @@ static GAtChat *open_device(struct ofono_modem *modem,
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
@@ -238,16 +223,13 @@ static void switch_sim_state_status(struct ofono_mode=
m *modem, int status)
 		break;
 	case 1:
 		DBG("SIM inserted");
-		/* We need to sleep a bit */
-		data->sim_inserted_source =3D g_timeout_add_seconds(1,
-							sim_inserted_timeout_cb,
-							modem);
 		break;
 	case 2:
 		DBG("SIM inserted and PIN unlocked");
 		break;
 	case 3:
 		DBG("SIM inserted and ready");
+		ofono_sim_inserted_notify(data->sim, TRUE);
 		break;
 	}
 }
@@ -308,7 +290,7 @@ static void cfun_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	ofono_modem_set_powered(m, TRUE);
 =

 	/* Enable sim state notification */
-	g_at_chat_send(data->chat, "AT#QSS=3D1", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
 =

 	/* Follow sim state */
 	g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
@@ -397,9 +379,6 @@ static void cfun_disable_cb(gboolean ok, GAtResult *res=
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

@@ -650,18 +629,11 @@ static int telit_probe(struct ofono_modem *modem)
 =

 static void telit_remove(struct ofono_modem *modem)
 {
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
 	DBG("%p", modem);
 =

 	bluetooth_sap_client_unregister(modem);
 =

 	ofono_modem_set_data(modem, NULL);
-
-	if (data->sim_inserted_source > 0)
-		g_source_remove(data->sim_inserted_source);
-
-	g_free(data);
 }
 =

 static struct ofono_modem_driver telit_driver =3D {
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============1274919765907939830==--

