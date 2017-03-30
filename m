Content-Type: multipart/mixed; boundary="===============1222648534723779711=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 23/28] quectel: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:53:04 +0200
Message-ID: <20170330205309.25850-24-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1222648534723779711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 10 ++++++++++
 plugins/udevng.c   | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index 145e985..a2ca4b8 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -249,6 +249,16 @@ usb:v230D*ic02isc02ip01in01
 usb:v230D*ic02isc02ip01in03
  OFONO_LABEL=3Dmodem
 =

+# Quectel
+usb:v05C6p9090*icFFiscFFipFF*
+ OFONO_DRIVER=3Dquectel
+
+usb:v05C6p9090*icFFiscFFipFFin02
+ OFONO_LABEL=3Daux
+
+usb:v05C6p9090*icFFiscFFipFFin03
+ OFONO_LABEL=3Dmodem
+
 # Telit
 usb:v1BC7*icFFiscFFipFF*
 usb:v1BC7p0021*icFFiscFFipFF*
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 16c9328..1fe7d34 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -734,17 +734,8 @@ static gboolean setup_quectel(struct modem_info *modem)
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
-			if (g_strcmp0(info->number, "02") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
 		}
 	}
 =

@@ -1287,7 +1278,6 @@ static struct {
 	{ "mbm",	"cdc_acm",	"0930"		},
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
-	{ "quectel",	"option",	"05c6", "9090"	},
 	{ }
 };
 =

-- =

2.9.3


--===============1222648534723779711==--

