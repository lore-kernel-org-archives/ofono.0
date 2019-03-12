Content-Type: multipart/mixed; boundary="===============6485387551728113929=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 02/14] ublox: drop vendor type for Toby L2 model
Date: Tue, 12 Mar 2019 12:09:56 +0100
Message-ID: <20190312111008.29258-3-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6485387551728113929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'Toby L2'-specific vendor type is used only to prevent the CMER
command from attempting to set mode '3'.  For all u-blox models, mode
'3' is just an alias for mode '1'.  As such, mode '1' can be used in
place of mode '3', removing the model-specific quirk in favour of a
vendor-specific quirk.

With this change, the L2-specific vendor type is no longer needed.
---
 drivers/atmodem/gprs.c                 | 1 -
 drivers/atmodem/network-registration.c | 7 +++++--
 drivers/atmodem/sim.c                  | 1 -
 drivers/atmodem/vendor.h               | 1 -
 plugins/ublox.c                        | 7 +++----
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index de7c7864..d3fd893c 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -455,7 +455,6 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 						FALSE, gprs, NULL);
 		break;
 	case OFONO_VENDOR_UBLOX:
-	case OFONO_VENDOR_UBLOX_TOBY_L2:
 		g_at_chat_register(gd->chat, "+UREG:", ublox_ureg_notify,
 						FALSE, gprs, NULL);
 		g_at_chat_send(gd->chat, "AT+UREG=3D1", none_prefix,
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 1704f98c..ffd8aa33 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1655,8 +1655,11 @@ static ofono_bool_t build_cmer_string(char *buf, int=
 *cmer_opts,
 	DBG("");
 =

 	switch (nd->vendor) {
-	case OFONO_VENDOR_UBLOX_TOBY_L2:
-		/* UBX-13002752 R33: TOBY L2 doesn't support mode 2 and 3 */
+	case OFONO_VENDOR_UBLOX:
+		/* For all u-blox models, mode 3 is equivalent to mode 1;
+		 * since some models do not support setting modes 2 nor 3
+		 * (see UBX-13002752), we prefer mode 1 for all models.
+		 */
 		mode =3D "1";
 		break;
 	default:
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 51f84818..5f66a09c 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1221,7 +1221,6 @@ static void at_pin_retries_query(struct ofono_sim *si=
m,
 			return;
 		break;
 	case OFONO_VENDOR_UBLOX:
-	case OFONO_VENDOR_UBLOX_TOBY_L2:
 		if (g_at_chat_send(sd->chat, "AT+UPINCNT", upincnt_prefix,
 					upincnt_cb, cbd, g_free) > 0)
 			return;
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index cd70c283..10c04315 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -46,7 +46,6 @@ enum ofono_vendor {
 	OFONO_VENDOR_QUECTEL,
 	OFONO_VENDOR_QUECTEL_M95,
 	OFONO_VENDOR_UBLOX,
-	OFONO_VENDOR_UBLOX_TOBY_L2,
 	OFONO_VENDOR_XMM,
 	OFONO_VENDOR_GEMALTO,
 };
diff --git a/plugins/ublox.c b/plugins/ublox.c
index 2b3fc5eb..4b9d0410 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -169,13 +169,12 @@ static int ublox_enable(struct ofono_modem *modem)
 	 */
 	data->model_id =3D atoi(model_str);
 =

+	data->vendor_family =3D OFONO_VENDOR_UBLOX;
+
 	switch (data->model_id) {
 	case SARA_G270:
-		data->vendor_family =3D OFONO_VENDOR_UBLOX;
-		break;
 	case TOBYL2_COMPATIBLE_MODE:
 	case TOBYL2_HIGH_THROUGHPUT_MODE:
-		data->vendor_family =3D OFONO_VENDOR_UBLOX_TOBY_L2;
 		break;
 	case TOBYL2_MEDIUM_THROUGHPUT_MODE:
 		DBG("low/medium throughtput profile unsupported");
@@ -189,7 +188,7 @@ static int ublox_enable(struct ofono_modem *modem)
 	if (data->aux =3D=3D NULL)
 		return -EINVAL;
 =

-	if (data->vendor_family =3D=3D OFONO_VENDOR_UBLOX) {
+	if (data->model_id =3D=3D SARA_G270) {
 		data->modem =3D open_device(modem, "Modem", "Modem: ");
 		if (data->modem =3D=3D NULL) {
 			g_at_chat_unref(data->aux);
-- =

2.19.1


--===============6485387551728113929==--

