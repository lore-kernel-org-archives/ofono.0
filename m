Content-Type: multipart/mixed; boundary="===============1552542705223453547=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 04/21] telit: add telit_sap_disable()
Date: Tue, 27 Sep 2011 18:04:03 -0300
Message-ID: <1317157460-17012-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1552542705223453547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Support to disable the SAP modem from the sap plugin
---
 plugins/bluetooth.h |    1 +
 plugins/telit.c     |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 6cde7bc..96e3215 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -46,6 +46,7 @@ struct bluetooth_profile {
 struct bluetooth_sap_driver {
 	const char *name;
 	int (*enable) (struct ofono_modem *modem);
+	int (*disable) (struct ofono_modem *modem);
 };
 =

 struct server;
diff --git a/plugins/telit.c b/plugins/telit.c
index a5f9941..b9a5b23 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -139,6 +139,20 @@ static void rsen_enable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	}
 }
 =

+static void rsen_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	if (ok)
+		ofono_modem_set_powered(modem, FALSE);
+}
+
 static int telit_sap_open()
 {
 	const char *device =3D "/dev/ttyUSB4";
@@ -191,9 +205,25 @@ static int telit_sap_enable(struct ofono_modem *modem)
 	return fd;
 }
 =

+static int telit_sap_disable(struct ofono_modem *modem)
+{
+	struct telit_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_cancel_all(data->chat);
+	g_at_chat_unregister_all(data->chat);
+
+	g_at_chat_send(data->chat, "AT#RSEN=3D0", rsen_prefix,
+				rsen_disable_cb, modem, NULL);
+
+	return 0;
+}
+
 static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
+	.disable =3D telit_sap_disable,
 };
 =

 static int telit_probe(struct ofono_modem *modem)
-- =

1.7.6.2


--===============1552542705223453547==--

