Content-Type: multipart/mixed; boundary="===============8871300670332881814=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] gemalto plugin: sim vendor to GEMALTO
Date: Tue, 25 Sep 2018 09:12:33 +0200
Message-ID: <20180925071233.25070-2-gciofono@gmail.com>
In-Reply-To: <20180925071233.25070-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8871300670332881814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

switched from CINTERION.
Note that the cinterion plugin itself does not use the specific vendor
for the sms atom.
---
 plugins/gemalto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index b7734124..6e0d765b 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -571,7 +571,7 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
 	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
-	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION, "atmodem",
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_GEMALTO, "atmodem",
 						data->app);
 =

 	if (data->sim && data->have_sim =3D=3D TRUE)
-- =

2.17.1


--===============8871300670332881814==--

