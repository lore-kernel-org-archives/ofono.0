Content-Type: multipart/mixed; boundary="===============1875873201218975992=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 04/28] alcatel: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:45 +0200
Message-ID: <20170330205309.25850-5-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1875873201218975992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb |  9 +++++++++
 plugins/udevng.c   | 10 ----------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index 881497d..1097b8c 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -24,3 +24,12 @@ usb:v19D2p0016*icFFiscFFipFFin03
 usb:v19D2p0017*icFFiscFFipFFin03
  OFONO_LABEL=3Dnone
 =

+# Alcatel
+usb:v1BBBp0017*icFFiscFFipFF*
+ OFONO_DRIVER=3Dalcatel
+
+usb:v1BBBp0017*icFFiscFFipFFin03
+ OFONO_LABEL=3Daux
+
+usb:v1BBBp0017*icFFiscFFipFFin05
+ OFONO_LABEL=3Dmodem
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 3662370..ff14869 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -520,17 +520,8 @@ static gboolean setup_alcatel(struct modem_info *modem)
 =

 		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
 			aux =3D info->devnode;
-			if (mdm !=3D NULL)
-				break;
 		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
 			mdm =3D info->devnode;
-			if (aux !=3D NULL)
-				break;
-		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "03") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "05") =3D=3D 0)
-				mdm =3D info->devnode;
 		}
 	}
 =

@@ -1427,7 +1418,6 @@ static struct {
 	{ "speedupcdma","option",	"1c9e", "9e00"	},
 	{ "speedup",	"option",	"1c9e"		},
 	{ "speedup",	"option",	"2020"		},
-	{ "alcatel",	"option",	"1bbb", "0017"	},
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
-- =

2.9.3


--===============1875873201218975992==--

