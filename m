Content-Type: multipart/mixed; boundary="===============3484656534908322209=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v2] quectel: EC21 needs aux channel to be the first mux channel
Date: Thu, 28 May 2020 11:32:39 +0200
Message-ID: <20200528093239.14347-1-poeschel@lemonage.de>
In-Reply-To: <20200527150852.x7kqb3bwxfodgtaa@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3484656534908322209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

The Quectel EC21 does only work correctly, if the mux channel used for
aux is the first mux channel. It does only put it's URC messages in the
first mux channel, so this has to be the aux channel in our case.
To be flexible on the mux order we introduce an array here, that
contains the initialization data in it's needed order and is then simply
applied by a for-loop. Initialization of this array is done after we
queried the modem model.
---
 plugins/quectel.c | 72 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 043d39f9..1cad35d6 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -78,6 +78,21 @@ static const uint8_t gsm0710_terminate[] =3D {
 	0xf9, /* close flag */
 };
 =

+enum mux_type {
+	QUECTEL_MUX_TYPE_AUX =3D 0,
+	QUECTEL_MUX_TYPE_MODEM,
+	QUECTEL_MUX_TYPE_MAX,
+};
+
+struct mux_initialization_data {
+	enum mux_type mux_type;
+	char *chat_debug;
+	const char *n_gsm_key;
+	const char *n_gsm_value;
+};
+
+static struct mux_initialization_data mux_order[QUECTEL_MUX_TYPE_MAX];
+
 enum quectel_model {
 	QUECTEL_UNKNOWN,
 	QUECTEL_UC15,
@@ -838,6 +853,7 @@ static GAtChat *create_chat(struct ofono_modem *modem, =
char *debug)
 static void cmux_gatmux(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GAtChat *chat;
 =

 	DBG("%p", modem);
 =

@@ -853,18 +869,21 @@ static void cmux_gatmux(struct ofono_modem *modem)
 =

 	g_at_mux_start(data->mux);
 =

-	data->modem =3D create_chat(modem, "Modem: ");
-	if (!data->modem) {
-		ofono_error("failed to create modem channel");
-		close_serial(modem);
-		return;
-	}
+	for (int i =3D 0; i < QUECTEL_MUX_TYPE_MAX; i++) {
+		chat =3D create_chat(modem, mux_order[i].chat_debug);
+
+		if (!chat) {
+			ofono_error("failed to create %schannel",
+					mux_order[i].chat_debug);
+			close_serial(modem);
+			return;
+		}
+
+		if (mux_order[i].mux_type =3D=3D QUECTEL_MUX_TYPE_AUX)
+			data->aux =3D chat;
+		else
+			data->modem =3D chat;
 =

-	data->aux =3D create_chat(modem, "Aux: ");
-	if (!data->aux) {
-		ofono_error("failed to create aux channel");
-		close_serial(modem);
-		return;
 	}
 =

 	setup_aux(modem);
@@ -880,7 +899,9 @@ static void mux_ready_cb(struct l_timeout *timeout, voi=
d *user_data)
 	DBG("%p", modem);
 =

 	/* check if the last (and thus all) virtual gsm tty's are created */
-	ret =3D stat(ofono_modem_get_string(modem, "Modem"), &st);
+	ret =3D stat(ofono_modem_get_string(modem,
+				mux_order[QUECTEL_MUX_TYPE_MAX - 1].n_gsm_key),
+				&st);
 	if (ret < 0) {
 		if (data->mux_ready_count++ < 5) {
 			/* not ready yet; try again in 100 ms*/
@@ -957,8 +978,10 @@ static void cmux_ngsm(struct ofono_modem *modem)
 	 * the kernel does not yet support mapping the underlying serial device
 	 * to its virtual gsm ttys, so hard-code gsmtty1 gsmtty2 for now
 	 */
-	ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
-	ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
+	for (int i =3D 0; i < QUECTEL_MUX_TYPE_MAX; i++) {
+		ofono_modem_set_string(modem, mux_order[i].n_gsm_key,
+					mux_order[i].n_gsm_value);
+	}
 =

 	/* wait for gsmtty devices to appear */
 	if (!l_timeout_create_ms(100, mux_ready_cb, modem, NULL)) {
@@ -1014,6 +1037,17 @@ static void cgmm_cb(int ok, GAtResult *result, void =
*user_data)
 		return;
 	}
 =

+	mux_order[0] =3D (struct mux_initialization_data)
+			{ QUECTEL_MUX_TYPE_MODEM,
+			"Modem: ",
+			"Modem",
+			"/dev/gsmtty1"};
+	mux_order[1] =3D (struct mux_initialization_data)
+			{ QUECTEL_MUX_TYPE_AUX,
+			"Aux: ",
+			"Aux",
+			"/dev/gsmtty2"};
+
 	if (strcmp(model, "UC15") =3D=3D 0) {
 		DBG("%p model UC15", modem);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
@@ -1030,6 +1064,16 @@ static void cgmm_cb(int ok, GAtResult *result, void =
*user_data)
 		DBG("%p model EC21", modem);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
 		data->model =3D QUECTEL_EC21;
+		mux_order[0] =3D (struct mux_initialization_data)
+				{ QUECTEL_MUX_TYPE_AUX,
+				"Aux: ",
+				"Aux",
+				"/dev/gsmtty1"};
+		mux_order[1] =3D (struct mux_initialization_data)
+				{ QUECTEL_MUX_TYPE_MODEM,
+				"Modem: ",
+				"Modem",
+				"/dev/gsmtty2"};
 	} else {
 		ofono_warn("%p unknown model: '%s'", modem, model);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
-- =

2.26.2

--===============3484656534908322209==--

