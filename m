Content-Type: multipart/mixed; boundary="===============3829567201969386077=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 2/3] plugins: gemalto: add radio-settings atom
Date: Sun, 04 Jul 2021 18:53:47 +0300
Message-ID: <20210704155348.432964-3-geomatsi@gmail.com>
In-Reply-To: <20210704155348.432964-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3829567201969386077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instantiate Gemalto radio-settings atom in post_sim.

---
 plugins/gemalto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 135e2d26..a2e8a39c 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -49,6 +49,7 @@
 #include <ofono/gprs-context.h>
 #include <ofono/location-reporting.h>
 #include <ofono/netmon.h>
+#include <ofono/radio-settings.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -597,6 +598,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 	ofono_phonebook_create(modem, 0, "atmodem", data->app);
 =

 	ofono_sms_create(modem, OFONO_VENDOR_GEMALTO, "atmodem", data->app);
+	ofono_radio_settings_create(modem, 0, "gemaltomodem", data->app);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
=20
--===============3829567201969386077==--

