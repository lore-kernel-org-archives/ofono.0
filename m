Content-Type: multipart/mixed; boundary="===============5689649932415495019=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 2/5] ublox: pass model_id to gprs-context driver
Date: Thu, 14 Mar 2019 23:28:40 +0100
Message-ID: <20190314222843.9232-2-jonas@norrbonn.se>
In-Reply-To: <20190314222843.9232-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5689649932415495019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Depending on the transport used on the data connection we want either
the "atmodem" (PPP) driver or the "ubloxmodem".  For the "ubloxmodem",
we want to pass the model data so this patch wrangles some parameters to
make sure that right driver and right variant data are passed.
---
 plugins/ublox.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 1c74fe09..8100dfba 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -388,19 +388,34 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	GAtChat *chat =3D data->modem ? data->modem : data->aux;
-	const char *driver =3D data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE ?
-						"ubloxmodem" : "atmodem";
+	const char *driver;
 	/* Toby L2: Create same number of contexts as supported PDP contexts. */
 	int ncontexts =3D data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE ? 8 :=
 1;
+	int variant;
 =

 	DBG("%p", modem);
 =

 	gprs =3D ofono_gprs_create(modem, data->vendor_family, "atmodem",
 					data->aux);
 =

+	if (ublox_is_toby_l4(data->model)) {
+		driver =3D "ubloxmodem";
+		variant =3D ublox_model_to_id(data->model);
+	} else if (ublox_is_toby_l2(data->model)) {
+		if (data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE) {
+			driver =3D "ubloxmodem";
+			variant =3D ublox_model_to_id(data->model);
+		} else {
+			driver =3D "atmodem";
+			variant =3D OFONO_VENDOR_UBLOX;
+		}
+	} else {
+		driver =3D "atmodem";
+		variant =3D OFONO_VENDOR_UBLOX;
+	}
+
 	while (ncontexts) {
-		gc =3D ofono_gprs_context_create(modem, data->vendor_family,
-						driver, chat);
+		gc =3D ofono_gprs_context_create(modem, variant, driver, chat);
 =

 		if (gprs && gc)
 			ofono_gprs_add_context(gprs, gc);
-- =

2.19.1


--===============5689649932415495019==--

