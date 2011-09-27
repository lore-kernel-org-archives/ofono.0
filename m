Content-Type: multipart/mixed; boundary="===============6536769416430010511=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 06/21] telit: add aux GAtChat
Date: Tue, 27 Sep 2011 18:04:05 -0300
Message-ID: <1317157460-17012-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-5-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6536769416430010511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/telit.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index b9a5b23..d5db39f 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -65,6 +65,7 @@ static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
 =

 struct telit_data {
 	GAtChat *chat;
+	GAtChat *aux;
 	struct ofono_sim *sim;
 	guint sim_inserted_source;
 };
@@ -132,8 +133,8 @@ static void rsen_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	DBG("%p", modem);
 =

 	if (!ok) {
-		g_at_chat_unref(data->chat);
-		data->chat =3D NULL;
+		g_at_chat_unref(data->aux);
+		data->aux =3D NULL;
 		ofono_modem_set_powered(modem, FALSE);
 		return;
 	}
@@ -146,8 +147,8 @@ static void rsen_disable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_unref(data->chat);
-	data->chat =3D NULL;
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
 =

 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
@@ -185,21 +186,21 @@ static int telit_sap_enable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	data->chat =3D open_device(modem, "Data", "Aux: ");
-	if (data->chat =3D=3D NULL)
+	data->aux =3D open_device(modem, "Data", "Aux: ");
+	if (data->aux =3D=3D NULL)
 		return -EINVAL;
 =

 	fd =3D telit_sap_open();
 	if (fd < 0)
 		return fd;
 =

-	g_at_chat_register(data->chat, "#RSEN:", telit_rsen_notify,
+	g_at_chat_register(data->aux, "#RSEN:", telit_rsen_notify,
 				FALSE, modem, NULL);
 =

-	g_at_chat_send(data->chat, "AT#NOPT=3D3", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "AT#NOPT=3D3", NULL, NULL, NULL, NULL);
 =

 	/* Set SAP functionality */
-	g_at_chat_send(data->chat, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
+	g_at_chat_send(data->aux, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
 				rsen_enable_cb, modem, NULL);
 =

 	return fd;
-- =

1.7.6.2


--===============6536769416430010511==--

