Content-Type: multipart/mixed; boundary="===============2720648157400599274=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 03/28] novatel: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:44 +0200
Message-ID: <20170330205309.25850-4-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2720648157400599274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 10 ++++++++++
 plugins/udevng.c   | 15 ++-------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index 75e553b..881497d 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -1,3 +1,13 @@
+# Novatel
+usb:v1410*icFFiscFFipFF*
+ OFONO_DRIVER=3Dnovatel
+
+usb:v1410*icFFiscFFipFFin00
+ OFONO_LABEL=3Daux
+
+usb:v1410*icFFiscFFipFFin01
+ OFONO_LABEL=3Dmodem
+
 # ZTE
 usb:v19D2*icFFiscFFipFF*
  OFONO_DRIVER=3Dzte
diff --git a/plugins/udevng.c b/plugins/udevng.c
index d95f71f..3662370 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -558,20 +558,10 @@ static gboolean setup_novatel(struct modem_info *mode=
m)
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
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
-				mdm =3D info->devnode;
-		}
 	}
 =

 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
@@ -1438,7 +1428,6 @@ static struct {
 	{ "speedup",	"option",	"1c9e"		},
 	{ "speedup",	"option",	"2020"		},
 	{ "alcatel",	"option",	"1bbb", "0017"	},
-	{ "novatel",	"option",	"1410"		},
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
-- =

2.9.3


--===============2720648157400599274==--

