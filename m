Content-Type: multipart/mixed; boundary="===============8879713850767051762=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 05/28] huawei: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:46 +0200
Message-ID: <20170330205309.25850-6-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8879713850767051762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/udevng.c   | 41 +++++------------------------------------
 2 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index 1097b8c..66cc0a1 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -1,3 +1,54 @@
+# Huawei
+usb:v201E*
+usb:v12D1*
+ OFONO_DRIVER=3Dhuawei
+
+usb:v201E*icFFisc01ip01*
+usb:v201E*icFFisc02ip01*
+usb:v201E*icFFisc03ip01*
+usb:v201E*icFFisc01ip31*
+usb:v201E*icFFiscFFipFFin00
+usb:v12D1*icFFisc01ip01*
+usb:v12D1*icFFisc02ip01*
+usb:v12D1*icFFisc03ip01*
+usb:v12D1*icFFisc01ip31*
+usb:v12D1*icFFiscFFipFFin00
+ OFONO_LABEL=3Dmodem
+
+usb:v201E*icFFisc01ip02*
+usb:v201E*icFFisc02ip02*
+usb:v201E*icFFisc02ip12*
+usb:v201E*icFFisc03ip12*
+usb:v201E*icFFisc01ip32*
+usb:v201E*icFFiscFFipFFin0[1234]
+usb:v12D1*icFFisc01ip02*
+usb:v12D1*icFFisc02ip02*
+usb:v12D1*icFFisc02ip12*
+usb:v12D1*icFFisc03ip12*
+usb:v12D1*icFFisc01ip32*
+usb:v12D1*icFFiscFFipFFin0[1234]
+ OFONO_LABEL=3Dpcui
+
+usb:v201E*icFFisc01ip03*
+usb:v201E*icFFisc02ip03*
+usb:v201E*icFFisc01ip33*
+usb:v12D1*icFFisc01ip03*
+usb:v12D1*icFFisc02ip03*
+usb:v12D1*icFFisc01ip33*
+ OFONO_LABEL=3Ddiag
+
+usb:v201E*icFFisc01ip08*
+usb:v201E*icFFisc01ip38*
+usb:v12D1*icFFisc01ip08*
+usb:v12D1*icFFisc01ip38*
+ OFONO_LABEL=3Dnet
+
+usb:v201E*icFFisc01ip09*
+usb:v201E*icFFisc01ip39*
+usb:v12D1*icFFisc01ip09*
+usb:v12D1*icFFisc01ip39*
+ OFONO_LABEL=3Dqmi
+
 # Novatel
 usb:v1410*icFFiscFFipFF*
  OFONO_DRIVER=3Dnovatel
diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff14869..d8f077a 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -336,42 +336,16 @@ static gboolean setup_huawei(struct modem_info *modem)
 		DBG("%s %s %s %s", info->devnode, info->interface,
 						info->number, info->label);
 =

-		if (g_strcmp0(info->label, "modem") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/1/1") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/2/1") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/3/1") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/1/49") =3D=3D 0) {
+		if (g_strcmp0(info->label, "modem") =3D=3D 0)
 			mdm =3D info->devnode;
-		} else if (g_strcmp0(info->label, "pcui") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/1/2") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/2/2") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/2/18") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/3/18") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/1/50") =3D=3D 0) {
+		else if (g_strcmp0(info->label, "pcui") =3D=3D 0)
 			pcui =3D info->devnode;
-		} else if (g_strcmp0(info->label, "diag") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/1/3") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/2/3") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/1/51") =3D=3D 0) {
+		else if (g_strcmp0(info->label, "diag") =3D=3D 0)
 			diag =3D info->devnode;
-		} else if (g_strcmp0(info->interface, "255/1/8") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/1/56") =3D=3D 0) {
+		else if (g_strcmp0(info->label, "net") =3D=3D 0)
 			net =3D info->devnode;
-		} else if (g_strcmp0(info->interface, "255/1/9") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/1/57") =3D=3D 0) {
+		else if (g_strcmp0(info->label, "qmi") =3D=3D 0)
 			qmi =3D info->devnode;
-		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
-				pcui =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				pcui =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				pcui =3D info->devnode;
-			else if (g_strcmp0(info->number, "04") =3D=3D 0)
-				pcui =3D info->devnode;
-		}
 	}
 =

 	if (qmi !=3D NULL && net !=3D NULL) {
@@ -1410,11 +1384,6 @@ static struct {
 	{ "sierra",	"sierra"			},
 	{ "sierra",	"sierra_net"			},
 	{ "option",	"option",	"0af0"		},
-	{ "huawei",	"option",	"201e"		},
-	{ "huawei",	"cdc_wdm",	"12d1"		},
-	{ "huawei",	"cdc_ether",	"12d1"		},
-	{ "huawei",	"qmi_wwan",	"12d1"		},
-	{ "huawei",	"option",	"12d1"		},
 	{ "speedupcdma","option",	"1c9e", "9e00"	},
 	{ "speedup",	"option",	"1c9e"		},
 	{ "speedup",	"option",	"2020"		},
-- =

2.9.3


--===============8879713850767051762==--

