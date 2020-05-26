Content-Type: multipart/mixed; boundary="===============0066889186823493197=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 4/7] quectel: EC21 needs aux channel to be the first mux
 channel
Date: Tue, 26 May 2020 12:16:22 +0200
Message-ID: <20200526101625.31871-5-poeschel@lemonage.de>
In-Reply-To: <20200526101625.31871-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0066889186823493197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

The Quectel EC21 does only work correctly, if the mux channel used for
aux is the first mux channel. It does only put it's URC messages in the
first mux channel, so this has to be the aux channel in our case.
---
 plugins/quectel.c | 51 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 1d312c45..9ff75516 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -847,18 +847,38 @@ static void cmux_gatmux(struct ofono_modem *modem)
 =

 	g_at_mux_start(data->mux);
 =

-	data->modem =3D create_chat(modem, "Modem: ");
-	if (!data->modem) {
-		ofono_error("failed to create modem channel");
-		close_serial(modem);
-		return;
-	}
+	if (data->model =3D=3D QUECTEL_EC21) {
+		data->aux =3D create_chat(modem, "Aux: ");
 =

-	data->aux =3D create_chat(modem, "Aux: ");
-	if (!data->aux) {
-		ofono_error("failed to create aux channel");
-		close_serial(modem);
-		return;
+		if (!data->aux) {
+			ofono_error("failed to create aux channel");
+			close_serial(modem);
+			return;
+		}
+
+		data->modem =3D create_chat(modem, "Modem: ");
+
+		if (!data->modem) {
+			ofono_error("failed to create modem channel");
+			close_serial(modem);
+			return;
+		}
+	} else {
+		data->modem =3D create_chat(modem, "Modem: ");
+
+		if (!data->modem) {
+			ofono_error("failed to create modem channel");
+			close_serial(modem);
+			return;
+		}
+
+		data->aux =3D create_chat(modem, "Aux: ");
+
+		if (!data->aux) {
+			ofono_error("failed to create aux channel");
+			close_serial(modem);
+			return;
+		}
 	}
 =

 	setup_aux(modem);
@@ -951,8 +971,13 @@ static void cmux_ngsm(struct ofono_modem *modem)
 	 * the kernel does not yet support mapping the underlying serial device
 	 * to its virtual gsm ttys, so hard-code gsmtty1 gsmtty2 for now
 	 */
-	ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
-	ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
+	if (data->model =3D=3D QUECTEL_EC21) {
+		ofono_modem_set_string(modem, "Modem", "/dev/gsmtty2");
+		ofono_modem_set_string(modem, "Aux", "/dev/gsmtty1");
+	} else {
+		ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
+		ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
+	}
 =

 	/* wait for gsmtty devices to appear */
 	if (!l_timeout_create_ms(100, mux_ready_cb, modem, NULL)) {
-- =

2.26.2

--===============0066889186823493197==--

