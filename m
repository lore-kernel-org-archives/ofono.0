Content-Type: multipart/mixed; boundary="===============4745201701370680490=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 1/3] ublox: consolidate teardown in common function
Date: Wed, 25 Sep 2019 06:35:05 +0200
Message-ID: <20190925043507.29892-2-jonas@norrbonn.se>
In-Reply-To: <20190925043507.29892-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4745201701370680490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The code for closing all the modem devices and flagging the modem as
unpowered is repeated several times in the driver... this patch puts
this code into a common helper for readability.
---
 plugins/ublox.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 9ee38a6b..60a734ce 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -102,19 +102,25 @@ static void ublox_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

+static void close_devices(struct ofono_modem* modem)
+{
+	struct ublox_data * data =3D ofono_modem_get_data(modem);
+
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+	ofono_modem_set_powered(modem, FALSE);
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
-	struct ublox_data * data =3D ofono_modem_get_data(modem);
 =

 	DBG("ok %d", ok);
 =

 	if (!ok) {
-		g_at_chat_unref(data->aux);
-		data->aux =3D NULL;
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
-		ofono_modem_set_powered(modem, FALSE);
+		close_devices(modem);
 		return;
 	}
 =

@@ -165,11 +171,7 @@ retry:
 		return;
 =

 error:
-	g_at_chat_unref(data->aux);
-	data->aux =3D NULL;
-	g_at_chat_unref(data->modem);
-	data->modem =3D NULL;
-	ofono_modem_set_powered(modem, FALSE);
+	close_devices(modem);
 }
 =

 static void query_model_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -216,11 +218,7 @@ static void query_model_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		return;
 =

 fail:
-	g_at_chat_unref(data->aux);
-	data->aux =3D NULL;
-	g_at_chat_unref(data->modem);
-	data->modem =3D NULL;
-	ofono_modem_set_powered(modem, FALSE);
+	close_devices(modem);
 }
 =

 static int ublox_enable(struct ofono_modem *modem)
-- =

2.20.1


--===============4745201701370680490==--

