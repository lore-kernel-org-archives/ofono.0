Content-Type: multipart/mixed; boundary="===============6210647198139047780=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH v2 2/2] gemalto: add PIN retries support in plugin
Date: Mon, 06 Nov 2017 14:57:09 +0100
Message-ID: <1509976629-9430-2-git-send-email-gabriel.lucas@smile.fr>
In-Reply-To: <1509976629-9430-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6210647198139047780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In SimManager, the Retries property isn't used for gemalto modems.
The at command AT^SPIC is used to get the remaining retries left
for the current required password type.

This commit enable the use of the driver in the gemalto plugin
---
 plugins/gemalto.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 45ec0cf..3739d7b 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -420,7 +420,8 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
 	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION, "atmodem",
+						data->app);
 =

 	if (sim && data->have_sim =3D=3D TRUE)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

2.7.4


--===============6210647198139047780==--

