Content-Type: multipart/mixed; boundary="===============7664999469234783103=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 1/7] plugins/ublox: give names to model ids
Date: Thu, 17 Mar 2016 13:38:27 +0100
Message-ID: <1458218313-26966-2-git-send-email-dragos@endocode.com>
In-Reply-To: <1458218313-26966-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7664999469234783103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To make it easier to understand the code.
---
 plugins/ublox.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 5e442a1..938777c 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -44,9 +44,17 @@
 =

 static const char *none_prefix[] =3D { NULL };
 =

+enum supported_models {
+	SARA_G270			=3D 1102,
+	TOBYL2_COMPATIBLE_MODE 		=3D 1141,
+	TOBYL2_MEDIUM_THROUGHPUT_MODE 	=3D 1143,
+	TOBYL2_HIGH_THROUGHPUT_MODE 	=3D 1146,
+};
+
 struct ublox_data {
 	GAtChat *modem;
 	GAtChat *aux;
+	int model_id;
 	enum ofono_vendor vendor_family;
 };
 =

@@ -140,7 +148,6 @@ static int ublox_enable(struct ofono_modem *modem)
 {
 	struct ublox_data *data =3D ofono_modem_get_data(modem);
 	const char *model_str =3D NULL;
-	int model_id;
 =

 	DBG("%p", modem);
 =

@@ -152,19 +159,20 @@ static int ublox_enable(struct ofono_modem *modem)
 	 * Toby L2 devices are more complex and special than previously
 	 * supported U-Blox devices. So they need a vendor of their own.
 	 */
-	model_id =3D atoi(model_str);
-	switch (model_id) {
-	case 1102:
+	data->model_id =3D atoi(model_str);
+
+	switch (data->model_id) {
+	case SARA_G270:
 		data->vendor_family =3D OFONO_VENDOR_UBLOX;
 		break;
-	case 1141:
-	case 1146:
+	case TOBYL2_COMPATIBLE_MODE:
+	case TOBYL2_HIGH_THROUGHPUT_MODE:
 		data->vendor_family =3D OFONO_VENDOR_UBLOX_TOBY_L2;
 		break;
-	case 1143:
+	case TOBYL2_MEDIUM_THROUGHPUT_MODE:
 		DBG("low/medium throughtput profile unsupported");
 	default:
-		DBG("unknown ublox model id %d", model_id);
+		DBG("unknown ublox model id %d", data->model_id);
 		return -EINVAL;
 	}
 =

-- =

2.5.0


--===============7664999469234783103==--

