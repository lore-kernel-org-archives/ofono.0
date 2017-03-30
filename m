Content-Type: multipart/mixed; boundary="===============1534760472094660853=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 07/28] ublox: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:48 +0200
Message-ID: <20170330205309.25850-8-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1534760472094660853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 16 ++++++++++++++++
 plugins/udevng.c   | 31 +++----------------------------
 2 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index fc2d738..c0c050f 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -101,3 +101,19 @@ usb:v05C6p9000*icFFiscFFipFFin02
 usb:v05C6p9000*icFFiscFFipFFin03
  OFONO_LABEL=3Dmodem
 =

+# UBlox
+usb:v1546p1102*
+usb:v1546p1146*
+ OFONO_DRIVER=3Dublox
+
+usb:v1546*ic02isc02ip01in00
+ OFONO_LABEL=3Dmodem
+
+usb:v1546*ic02isc02ip01in02
+ OFONO_LABEL=3Daux
+
+usb:v1546*ic02isc06ip00*
+usb:v1546*ic0Aisc00ip00*
+usb:v1546*icE0isc01ip03*
+ OFONO_LABEL=3Dnet
+
diff --git a/plugins/udevng.c b/plugins/udevng.c
index bdf36fa..4869833 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -915,34 +915,12 @@ static gboolean setup_ublox(struct modem_info *modem)
 		DBG("%s %s %s %s", info->devnode, info->interface,
 					info->number, info->label);
 =

-		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
+		if (g_strcmp0(info->label, "aux") =3D=3D 0)
 			aux =3D info->devnode;
-			if (mdm !=3D NULL)
-				break;
-		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
+		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
 			mdm =3D info->devnode;
-			if (aux !=3D NULL)
-				break;
-		/*
-		 * "2/2/1"
-		 *  - a common modem interface both for older models like LISA,
-		 *    and for newer models like TOBY.
-		 * For TOBY-L2, NetworkInterface can be detected for each
-		 * profile:
-		 *  - low-medium throughput profile : 2/6/0
-		 *  - fairly backward-compatible profile : 10/0/0
-		 *  - high throughput profile : 224/1/3
-		 */
-		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
-			if (g_strcmp0(info->number, "02") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "00") =3D=3D 0)
-				mdm =3D info->devnode;
-		} else if (g_strcmp0(info->interface, "2/6/0") =3D=3D 0 ||
-				g_strcmp0(info->interface, "10/0/0") =3D=3D 0 ||
-				g_strcmp0(info->interface, "224/1/3") =3D=3D 0) {
+		else if (g_strcmp0(info->label, "net") =3D=3D 0)
 			net =3D info->devnode;
-		}
 	}
 =

 	/* Abort only if both interfaces are NULL, as it's highly possible that
@@ -1387,9 +1365,6 @@ static struct {
 	{ "samsung",	"option",	"04e8", "6889"	},
 	{ "samsung",	"kalmia"			},
 	{ "quectel",	"option",	"05c6", "9090"	},
-	{ "ublox",	"cdc_acm",	"1546", "1102"	},
-	{ "ublox",	"rndis_host",	"1546", "1146"	},
-	{ "ublox",	"cdc_acm",	"1546", "1146"	},
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
-- =

2.9.3


--===============1534760472094660853==--

