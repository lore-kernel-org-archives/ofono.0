Content-Type: multipart/mixed; boundary="===============6251058039511100026=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 06/28] simcom: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:47 +0200
Message-ID: <20170330205309.25850-7-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6251058039511100026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 17 +++++++++++++++++
 plugins/udevng.c   | 23 ++++++-----------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index 66cc0a1..fc2d738 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -84,3 +84,20 @@ usb:v1BBBp0017*icFFiscFFipFFin03
 =

 usb:v1BBBp0017*icFFiscFFipFFin05
  OFONO_LABEL=3Dmodem
+
+# Simcom
+usb:v05C6p9000*icFFiscFFipFF*
+ OFONO_DRIVER=3Dsimcom
+
+usb:v05C6p9000*icFFiscFFipFFin00
+ OFONO_LABEL=3Ddiag
+
+usb:v05C6p9000*icFFiscFFipFFin01
+ OFONO_LABEL=3Dgps
+
+usb:v05C6p9000*icFFiscFFipFFin02
+ OFONO_LABEL=3Daux
+
+usb:v05C6p9000*icFFiscFFipFFin03
+ OFONO_LABEL=3Dmodem
+
diff --git a/plugins/udevng.c b/plugins/udevng.c
index d8f077a..bdf36fa 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -686,24 +686,14 @@ static gboolean setup_simcom(struct modem_info *modem)
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
-		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
-				diag =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
-				gps =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
-		}
+		else if (g_strcmp0(info->label, "gps") =3D=3D 0)
+			gps =3D info->devnode;
+		else if (g_strcmp0(info->label, "diag") =3D=3D 0)
+			diag =3D info->devnode;
 	}
 =

 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
@@ -1387,7 +1377,6 @@ static struct {
 	{ "speedupcdma","option",	"1c9e", "9e00"	},
 	{ "speedup",	"option",	"1c9e"		},
 	{ "speedup",	"option",	"2020"		},
-	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
-- =

2.9.3


--===============6251058039511100026==--

