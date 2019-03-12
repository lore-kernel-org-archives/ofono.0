Content-Type: multipart/mixed; boundary="===============6190937832907319733=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 09/14] ublox: add device flags
Date: Tue, 12 Mar 2019 12:10:03 +0100
Message-ID: <20190312111008.29258-10-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6190937832907319733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some aspects of a device are detectable at runtime, like the USB profile
detection that was added in a patch preceding this one.  This patch
switches the driver over from creating a new "vendor id" for each
profile to just setting a flag.  This is more easily extensible as we
detect other features of the modem.
---
 plugins/ublox.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index f7c2a374..038b55d5 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -49,20 +49,17 @@
 static const char *uusbconf_prefix[] =3D { "+UUSBCONF:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

-enum supported_models {
-	SARA_G270			=3D 1102,
-	TOBYL2_COMPATIBLE_MODE		=3D 1141,
-	TOBYL2_MEDIUM_THROUGHPUT_MODE	=3D 1143,
-	TOBYL2_HIGH_THROUGHPUT_MODE	=3D 1146,
+enum ublox_device_flags {
+	UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE	=3D (1 << 0),
 };
 =

 struct ublox_data {
 	GAtChat *modem;
 	GAtChat *aux;
-	int model_id;
 	enum ofono_vendor vendor_family;
 =

 	const struct ublox_model* model;
+	int flags;
 };
 =

 static void ublox_debug(const char *str, void *user_data)
@@ -148,7 +145,7 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		return;
 	}
 =

-	if (data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE)
+	if (data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE)
 		/* use bridged mode until routed mode support is added */
 		g_at_chat_send(data->aux, "AT+UBMCONF=3D2", none_prefix,
 						NULL, NULL, NULL);
@@ -181,13 +178,12 @@ retry:
 	switch (profile) {
 	case 0: /* Fairly back compatible */
 	case 1: /* Fairly back compatible plus audio */
-		data->model_id =3D  TOBYL2_COMPATIBLE_MODE;
 		break;
 	case 2: /* Low/medium throughput */
-		data->model_id =3D TOBYL2_MEDIUM_THROUGHPUT_MODE;
-		break;
+		ofono_error("Medium throughput mode not supported");
+		goto error;
 	case 3: /* High throughput mode */
-		data->model_id =3D TOBYL2_HIGH_THROUGHPUT_MODE;
+		data->flags |=3D UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE;
 		break;
 	default:
 		ofono_error("Unexpected USB profile: %d", profile);
@@ -389,10 +385,10 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	GAtChat *chat =3D data->modem ? data->modem : data->aux;
-	const char *driver =3D data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE ?
+	const char *driver =3D data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE ?
 						"ubloxmodem" : "atmodem";
 	/* Toby L2: Create same number of contexts as supported PDP contexts. */
-	int ncontexts =3D data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE ? 8 :=
 1;
+	int ncontexts =3D data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE ? 8 :=
 1;
 =

 	DBG("%p", modem);
 =

-- =

2.19.1


--===============6190937832907319733==--

