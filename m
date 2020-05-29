Content-Type: multipart/mixed; boundary="===============8635381186077783439=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v3] quectel: EC21 needs aux channel to be the first mux channel
Date: Fri, 29 May 2020 14:43:47 +0200
Message-ID: <20200529124347.25767-1-poeschel@lemonage.de>
In-Reply-To: <998d385e-341d-e8ff-178f-eaa8cea086d0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8635381186077783439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

The Quectel EC21 does only work correctly, if the mux channel used for
aux is the first mux channel. It does only put it's URC messages in the
first mux channel, so this has to be the aux channel in our case.
To be flexible on the mux order we introduce two arrays here, that then
contain the initialization data in their needed order.
Initialization data is then applied by for-looping over this array.
---
 plugins/quectel.c | 61 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 043d39f9..cb15e147 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -78,6 +78,27 @@ static const uint8_t gsm0710_terminate[] =3D {
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
+static const struct mux_initialization_data mux_order_default[] =3D {
+		{ QUECTEL_MUX_TYPE_MODEM, "Modem: ", "Modem", "/dev/gsmtty1"},
+		{ QUECTEL_MUX_TYPE_AUX, "Aux: ", "Aux", "/dev/gsmtty2"} };
+
+static const struct mux_initialization_data mux_order_ec21[] =3D {
+		{ QUECTEL_MUX_TYPE_AUX, "Aux: ", "Aux", "/dev/gsmtty1"},
+		{ QUECTEL_MUX_TYPE_MODEM, "Modem: ", "Modem", "/dev/gsmtty2"} };
+
 enum quectel_model {
 	QUECTEL_UNKNOWN,
 	QUECTEL_UC15,
@@ -106,6 +127,7 @@ struct quectel_data {
 	struct l_timeout *init_timeout;
 	size_t init_count;
 	guint init_cmd;
+	const struct mux_initialization_data *mux_order;
 };
 =

 struct dbus_hw {
@@ -838,6 +860,7 @@ static GAtChat *create_chat(struct ofono_modem *modem, =
char *debug)
 static void cmux_gatmux(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GAtChat *chat;
 =

 	DBG("%p", modem);
 =

@@ -853,18 +876,21 @@ static void cmux_gatmux(struct ofono_modem *modem)
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
+		chat =3D create_chat(modem, data->mux_order[i].chat_debug);
+
+		if (!chat) {
+			ofono_error("failed to create %schannel",
+					data->mux_order[i].chat_debug);
+			close_serial(modem);
+			return;
+		}
+
+		if (data->mux_order[i].mux_type =3D=3D QUECTEL_MUX_TYPE_AUX)
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
@@ -880,7 +906,9 @@ static void mux_ready_cb(struct l_timeout *timeout, voi=
d *user_data)
 	DBG("%p", modem);
 =

 	/* check if the last (and thus all) virtual gsm tty's are created */
-	ret =3D stat(ofono_modem_get_string(modem, "Modem"), &st);
+	ret =3D stat(ofono_modem_get_string(modem,
+			data->mux_order[QUECTEL_MUX_TYPE_MAX - 1].n_gsm_key),
+			&st);
 	if (ret < 0) {
 		if (data->mux_ready_count++ < 5) {
 			/* not ready yet; try again in 100 ms*/
@@ -957,8 +985,10 @@ static void cmux_ngsm(struct ofono_modem *modem)
 	 * the kernel does not yet support mapping the underlying serial device
 	 * to its virtual gsm ttys, so hard-code gsmtty1 gsmtty2 for now
 	 */
-	ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
-	ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
+	for (int i =3D 0; i < QUECTEL_MUX_TYPE_MAX; i++) {
+		ofono_modem_set_string(modem, data->mux_order[i].n_gsm_key,
+					data->mux_order[i].n_gsm_value);
+	}
 =

 	/* wait for gsmtty devices to appear */
 	if (!l_timeout_create_ms(100, mux_ready_cb, modem, NULL)) {
@@ -1014,6 +1044,8 @@ static void cgmm_cb(int ok, GAtResult *result, void *=
user_data)
 		return;
 	}
 =

+	data->mux_order =3D mux_order_default;
+
 	if (strcmp(model, "UC15") =3D=3D 0) {
 		DBG("%p model UC15", modem);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
@@ -1030,6 +1062,7 @@ static void cgmm_cb(int ok, GAtResult *result, void *=
user_data)
 		DBG("%p model EC21", modem);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
 		data->model =3D QUECTEL_EC21;
+		data->mux_order =3D mux_order_ec21;
 	} else {
 		ofono_warn("%p unknown model: '%s'", modem, model);
 		data->vendor =3D OFONO_VENDOR_QUECTEL;
-- =

2.26.2

--===============8635381186077783439==--

