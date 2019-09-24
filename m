Content-Type: multipart/mixed; boundary="===============3348839039524291514=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 2/3] ublox: raise call to open device
Date: Tue, 24 Sep 2019 13:33:31 +0200
Message-ID: <20190924113332.31729-2-jonas@norrbonn.se>
In-Reply-To: <20190924113332.31729-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3348839039524291514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index b65bc52a..9ee38a6b 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -102,13 +102,6 @@ static void ublox_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

-static GAtChat *open_device(struct ofono_modem *modem,
-				const char *key, char *debug)
-{
-	return at_util_open_device(modem, key, ublox_debug, debug,
-					NULL);
-}
-
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -236,17 +229,20 @@ static int ublox_enable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	data->aux =3D open_device(modem, "Aux", "Aux: ");
+	data->aux =3D at_util_open_device(modem, "Aux",
+					ublox_debug, "Aux: ", NULL);
 	/* If this is a serial modem then the device may be behind
 	 * the 'Device' attribute instead...
 	 */
 	if (data->aux =3D=3D NULL) {
-		data->aux =3D open_device(modem, "Device", "Aux: ");
+		data->aux =3D at_util_open_device(modem, "Device",
+						ublox_debug, "Aux: ", NULL);
 		if (data->aux =3D=3D NULL)
 			return -EINVAL;
 	}
 =

-	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	data->modem =3D at_util_open_device(modem, "Modem",
+						ublox_debug, "Modem: ", NULL);
 	if (data->modem) {
 		g_at_chat_set_slave(data->modem, data->aux);
 		g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", none_prefix,
-- =

2.20.1


--===============3348839039524291514==--

