Content-Type: multipart/mixed; boundary="===============1831665649530335779=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 4/5] telit: add suport the disable SAP client
Date: Wed, 28 Sep 2011 17:48:59 -0300
Message-ID: <1317242940-4014-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317242940-4014-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1831665649530335779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <gustavo@padovan.org>

---
 plugins/bluetooth.h |    1 +
 plugins/telit.c     |  100 ++++++++++++++++++++++++++++++++++-------------=
---
 2 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 7e94f96..d38e72e 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -47,6 +47,7 @@ struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem,
 								int bt_fd);
+	int (*disable) (struct ofono_modem *modem);
 };
 =

 struct server;
diff --git a/plugins/telit.c b/plugins/telit.c
index 1c177c0..d81fbd1 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -245,6 +245,58 @@ static void rsen_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

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
+static void rsen_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+
+	sap_close_io(modem);
+
+	telit_disable(modem);
+}
+
 static int telit_sap_open()
 {
 	const char *device =3D "/dev/ttyUSB4";
@@ -332,9 +384,25 @@ static int telit_sap_enable(struct ofono_modem *modem,
 	return -EINPROGRESS;
 }
 =

+static int telit_sap_disable(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_cancel_all(data->aux);
+	g_at_chat_unregister_all(data->aux);
+
+	g_at_chat_send(data->aux, "AT#RSEN=3D0", rsen_prefix,
+				rsen_disable_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
 static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
+	.disable =3D telit_sap_disable,
 };
 =

 static int telit_probe(struct ofono_modem *modem)
@@ -476,23 +544,6 @@ static void cfun_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 				telit_qss_cb, modem, NULL);
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
 static int telit_enable(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
@@ -517,21 +568,6 @@ static int telit_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

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
 static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	struct cb_data *cbd =3D user_data;
-- =

1.7.6.2


--===============1831665649530335779==--

