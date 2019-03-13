Content-Type: multipart/mixed; boundary="===============8396178366788209789=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v4 3/6] udevng: detect ublox TOBY L4
Date: Wed, 13 Mar 2019 22:35:58 +0100
Message-ID: <20190313213601.24971-3-jonas@norrbonn.se>
In-Reply-To: <20190313213601.24971-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8396178366788209789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ttyACM0 (USB interface 02) is reportedly unreliable (breaking DHCP setup)
so the recommended approach is to use ttyACM2 (USB interface 06)
exclusively.
---
 plugins/udevng.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4473c0a6..f689b756 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1090,11 +1090,17 @@ static gboolean setup_ublox(struct modem_info *mode=
m)
 		 *  - high throughput profile : 224/1/3
 		 */
 		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
-			if (g_strcmp0(info->number, "02") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "00") =3D=3D 0)
+			if (!g_strcmp0(modem->model, "1010")) {
+				if (g_strcmp0(info->number, "06") =3D=3D 0)
+					aux =3D info->devnode;
+			} else {
+				if (g_strcmp0(info->number, "02") =3D=3D 0)
+					aux =3D info->devnode;
+			}
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
 		} else if (g_strcmp0(info->interface, "2/6/0") =3D=3D 0 ||
+				g_strcmp0(info->interface, "2/13/0") =3D=3D 0 ||
 				g_strcmp0(info->interface, "10/0/0") =3D=3D 0 ||
 				g_strcmp0(info->interface, "224/1/3") =3D=3D 0) {
 			net =3D info->devnode;
@@ -1691,6 +1697,8 @@ static struct {
 	{ "quectelqmi",	"qcserial",	"2c7c", "0121"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0125"	},
 	{ "quectelqmi",	"qcserial",	"2c7c", "0125"	},
+	{ "ublox",	"cdc_acm",	"1546", "1010"	},
+	{ "ublox",	"cdc_ncm",	"1546", "1010"	},
 	{ "ublox",	"cdc_acm",	"1546", "1102"	},
 	{ "ublox",	"rndis_host",	"1546", "1146"	},
 	{ "ublox",	"cdc_acm",	"1546", "1146"	},
-- =

2.19.1


--===============8396178366788209789==--

