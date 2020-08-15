Content-Type: multipart/mixed; boundary="===============8985310128280413377=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [RFC PATCH 3/4] plugins: gemalto: add optional gprs-context driver
Date: Sun, 16 Aug 2020 00:43:57 +0300
Message-ID: <20200815214358.69100-4-geomatsi@gmail.com>
In-Reply-To: <20200815214358.69100-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8985310128280413377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setup custom gprs context driver for modems that provide
USB ethernet interfaces for data path.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 plugins/gemalto.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 13950742..238c7cc4 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -588,6 +588,8 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 	const char *model =3D ofono_modem_get_string(modem, "Model");
+	const char *driver =3D NULL;
+	const char *iface =3D NULL;
 =

 	DBG("%p", modem);
 =

@@ -596,7 +598,15 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 	ofono_sms_create(modem, OFONO_VENDOR_GEMALTO, "atmodem", data->app);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
+
+	iface =3D ofono_modem_get_string(modem, "NetworkInterface");
+	if (iface) {
+		driver =3D "gemaltomodem";
+	} else {
+		driver =3D "atmodem";
+	}
+
+	gc =3D ofono_gprs_context_create(modem, 0, driver, data->mdm);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

2.28.0

--===============8985310128280413377==--

