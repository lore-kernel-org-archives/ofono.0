Content-Type: multipart/mixed; boundary="===============3186017645839845246=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 18/23] telit: improve sap disable
Date: Mon, 26 Sep 2011 14:27:11 -0300
Message-ID: <1317058036-32641-18-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317058036-32641-17-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3186017645839845246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/telit.c |   78 +++++++++++++++++++++++++++++----------------------=
----
 1 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 5d72b79..47a82d9 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -280,6 +280,43 @@ static void rsen_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	}
 }
 =

+static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	if(data->sap_modem)
+		modem =3D data->sap_modem;
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	if (data->sim_inserted_source > 0)
+		g_source_remove(data->sim_inserted_source);
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+
+	data->sap_modem =3D NULL;
+}
+
+static int telit_disable(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+	DBG("%p", modem);
+
+	g_at_chat_cancel_all(data->chat);
+	g_at_chat_unregister_all(data->chat);
+
+	/* Power down modem */
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
+				cfun_disable_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
 static void rsen_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -290,8 +327,7 @@ static void rsen_disable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	g_at_chat_unref(data->aux);
 	data->aux =3D NULL;
 =

-	if (ok)
-		ofono_modem_set_powered(data->sap_modem, FALSE);
+	telit_disable(modem);
 }
 =

 static int telit_sap_open(struct ofono_modem *modem)
@@ -350,10 +386,10 @@ static int telit_sap_disable(struct ofono_modem *mode=
m)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_cancel_all(data->chat);
-	g_at_chat_unregister_all(data->chat);
+	g_at_chat_cancel_all(data->aux);
+	g_at_chat_unregister_all(data->aux);
 =

-	g_at_chat_send(data->chat, "AT#RSEN=3D0", rsen_prefix,
+	g_at_chat_send(data->aux, "AT#RSEN=3D0", rsen_prefix,
 				rsen_disable_cb, modem, NULL);
 =

 	return 0;
@@ -482,38 +518,6 @@ static void telit_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

-static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	g_at_chat_unref(data->chat);
-	data->chat =3D NULL;
-
-	if (data->sim_inserted_source > 0)
-		g_source_remove(data->sim_inserted_source);
-
-	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
-}
-
-static int telit_disable(struct ofono_modem *modem)
-{
-	struct telit_data *data =3D ofono_modem_get_data(modem);
-	DBG("%p", modem);
-
-	g_at_chat_cancel_all(data->chat);
-	g_at_chat_unregister_all(data->chat);
-
-	/* Power down modem */
-	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
-				cfun_disable_cb, modem, NULL);
-
-	return -EINPROGRESS;
-}
-
 static struct ofono_modem_driver telit_driver =3D {
 	.name		=3D "telit",
 	.probe		=3D telit_probe,
-- =

1.7.6.2


--===============3186017645839845246==--

