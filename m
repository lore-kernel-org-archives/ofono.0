Content-Type: multipart/mixed; boundary="===============5337212840428807471=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 03/24] telit: add support to enable SAP client
Date: Tue, 13 Sep 2011 15:58:11 -0300
Message-ID: <1315940312-1238-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5337212840428807471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.h |    1 +
 plugins/sap.c       |    4 +-
 plugins/telit.c     |  109 ++++++++++++++++++++++++++++++++++-------------=
----
 3 files changed, 76 insertions(+), 38 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index f980ebe..1658b75 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -45,6 +45,7 @@ struct bluetooth_profile {
 =

 struct bluetooth_sap_driver {
 	const char *name;
+	int (*enable) (struct ofono_modem *modem);
 };
 =

 struct server;
diff --git a/plugins/sap.c b/plugins/sap.c
index 88663c2..2a5db74 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -117,9 +117,9 @@ static void sap_remove(struct ofono_modem *modem)
 /* power up hardware */
 static int sap_enable(struct ofono_modem *modem)
 {
-	DBG("%p", modem);
+	struct sap_data *data =3D ofono_modem_get_data(modem);
 =

-	return 0;
+	return data->sap_driver->enable(data->hw_modem);
 }
 =

 static int sap_disable(struct ofono_modem *modem)
diff --git a/plugins/telit.c b/plugins/telit.c
index 18cf0c4..cc10668 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -58,6 +58,7 @@
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *qss_prefix[] =3D { "#QSS:", NULL };
+static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
 =

 struct telit_data {
 	GAtChat *chat;
@@ -65,10 +66,6 @@ struct telit_data {
 	guint sim_inserted_source;
 };
 =

-static struct bluetooth_sap_driver sap_driver =3D {
-	.name =3D "telit",
-};
-
 static void telit_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -76,6 +73,78 @@ static void telit_debug(const char *str, void *user_data)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static GAtChat *open_device(struct ofono_modem *modem,
+				const char *key, char *debug)
+{
+	const char *device;
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	GAtChat *chat;
+
+	device =3D ofono_modem_get_string(modem, key);
+	if (device =3D=3D NULL)
+		return NULL;
+
+	DBG("%s %s", key, device);
+
+	channel =3D g_at_tty_open(device, NULL);
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsmv1();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, telit_debug, debug);
+
+	return chat;
+}
+
+static void rsen_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (!ok) {
+		g_at_chat_unref(data->chat);
+		data->chat =3D NULL;
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+}
+
+static int telit_sap_enable(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->chat =3D open_device(modem, "Data", "Aux: ");
+	if (data->chat =3D=3D NULL)
+		return -EINVAL;
+
+	g_at_chat_send(data->chat, "AT#NOPT=3D3", NULL, NULL, NULL, NULL);
+
+	/* Set SAP functionality */
+	g_at_chat_send(data->chat, "AT#RSEN=3D1,1,0,2,0", rsen_prefix,
+				rsen_enable_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static struct bluetooth_sap_driver sap_driver =3D {
+	.name =3D "telit",
+	.enable =3D telit_sap_enable,
+};
+
 static int telit_probe(struct ofono_modem *modem)
 {
 	struct telit_data *data;
@@ -232,38 +301,6 @@ static void cfun_disable_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		ofono_modem_set_powered(modem, FALSE);
 }
 =

-static GAtChat *open_device(struct ofono_modem *modem,
-				const char *key, char *debug)
-{
-	const char *device;
-	GAtSyntax *syntax;
-	GIOChannel *channel;
-	GAtChat *chat;
-
-	device =3D ofono_modem_get_string(modem, key);
-	if (device =3D=3D NULL)
-		return NULL;
-
-	DBG("%s %s", key, device);
-
-	channel =3D g_at_tty_open(device, NULL);
-	if (channel =3D=3D NULL)
-		return NULL;
-
-	syntax =3D g_at_syntax_new_gsmv1();
-	chat =3D g_at_chat_new(channel, syntax);
-	g_at_syntax_unref(syntax);
-	g_io_channel_unref(channel);
-
-	if (chat =3D=3D NULL)
-		return NULL;
-
-	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(chat, telit_debug, debug);
-
-	return chat;
-}
-
 static int telit_enable(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
-- =

1.7.6.2


--===============5337212840428807471==--

