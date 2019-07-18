Content-Type: multipart/mixed; boundary="===============8398236457728229375=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 06/10] ublox: determine gprs-context driver from network
 interface
Date: Thu, 18 Jul 2019 12:23:10 +0200
Message-ID: <20190718102314.28094-6-jonas@norrbonn.se>
In-Reply-To: <20190718102314.28094-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8398236457728229375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some u-blox devices present a USB network class device for data and some
just switch to PPP on (one of) the communication channel(s).  Whether
the atmodem or ubloxmodem gprs-context driver should be used depends on
whether or not the network interface is present; check this condition
directly when deciding which driver to us.
---
 plugins/ublox.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 918bd3ec..c6ff7eaa 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -359,6 +359,7 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	const char *driver;
 	/* Toby L2: Create same number of contexts as supported PDP contexts. */
 	int ncontexts =3D data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE ? 8 :=
 1;
+	const char *iface;
 	int variant;
 =

 	DBG("%p", modem);
@@ -366,17 +367,10 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	gprs =3D ofono_gprs_create(modem, data->vendor_family, "atmodem",
 					data->aux);
 =

-	if (ublox_is_toby_l4(data->model)) {
+	iface =3D ofono_modem_get_string(modem, "NetworkInterface");
+	if (iface) {
 		driver =3D "ubloxmodem";
 		variant =3D ublox_model_to_id(data->model);
-	} else if (ublox_is_toby_l2(data->model)) {
-		if (data->flags & UBLOX_DEVICE_F_HIGH_THROUGHPUT_MODE) {
-			driver =3D "ubloxmodem";
-			variant =3D ublox_model_to_id(data->model);
-		} else {
-			driver =3D "atmodem";
-			variant =3D OFONO_VENDOR_UBLOX;
-		}
 	} else {
 		driver =3D "atmodem";
 		variant =3D OFONO_VENDOR_UBLOX;
-- =

2.20.1


--===============8398236457728229375==--

