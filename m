Content-Type: multipart/mixed; boundary="===============3154648544219679640=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 03/14] ublox: make device selection more flexible
Date: Tue, 12 Mar 2019 12:09:57 +0100
Message-ID: <20190312111008.29258-4-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3154648544219679640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Many ublox modems can sit on either the USB bus or talk directly to a
UART.  The udev plugin mostly takes care of figuring out what ports to
talk to and the protocol is common for all devices after that.

This patch simplifies the setup a bit:
i)  There must always be an aux channel for communication with the modem
ii)  The aux channel may be found behind the string Aux for USB modems
or Device for serial modems
iii)  If the Modem string is set, use it; if not set, assume it's not
available.
---
 plugins/ublox.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 4b9d0410..32cf1e61 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -185,19 +185,18 @@ static int ublox_enable(struct ofono_modem *modem)
 	}
 =

 	data->aux =3D open_device(modem, "Aux", "Aux: ");
-	if (data->aux =3D=3D NULL)
-		return -EINVAL;
-
-	if (data->model_id =3D=3D SARA_G270) {
-		data->modem =3D open_device(modem, "Modem", "Modem: ");
-		if (data->modem =3D=3D NULL) {
-			g_at_chat_unref(data->aux);
-			data->aux =3D NULL;
-			return -EIO;
-		}
+	/* If this is a serial modem then the device may be behind
+	 * the 'Device' attribute instead...
+	 */
+	if (data->aux =3D=3D NULL) {
+		data->aux =3D open_device(modem, "Device", "Aux: ");
+		if (data->aux =3D=3D NULL)
+			return -EINVAL;
+	}
 =

+	data->modem =3D open_device(modem, "Modem", "Modem: ");
+	if (data->modem) {
 		g_at_chat_set_slave(data->modem, data->aux);
-
 		g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", none_prefix,
 						NULL, NULL, NULL);
 =

-- =

2.19.1


--===============3154648544219679640==--

