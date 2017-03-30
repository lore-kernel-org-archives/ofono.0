Content-Type: multipart/mixed; boundary="===============8085146827352737830=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 22/28] icera: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:53:03 +0200
Message-ID: <20170330205309.25850-23-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8085146827352737830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 36 ++++++++++++++++++++++++++++++++++++
 plugins/udevng.c   | 29 ++++++-----------------------
 2 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index d3a19aa..145e985 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -72,6 +72,42 @@ usb:v1410*icFFiscFFipFFin00
 usb:v1410*icFFiscFFipFFin01
  OFONO_LABEL=3Dmodem
 =

+# Icera
+usb:v19D2*ic02isc02ip01*
+usb:v19D2*ic02isc06ip00*
+usb:v04E8p6872*ic02isc02ip01*
+usb:v04E8p6872*ic02isc06ip00*
+usb:v04E8p6833*ic02isc02ip01*
+usb:v04E8p6833*ic02isc06ip00*
+ OFONO_DRIVER=3Dicera
+
+usb:v19D2*ic02isc02ip01in00
+usb:v04E8p6872*ic02isc02ip01in00
+usb:v04E8p6833*ic02isc02ip01in00
+usb:v19D2*ic02isc02ip01in01
+usb:v04E8p6872*ic02isc02ip01in01
+usb:v04E8p6833*ic02isc02ip01in01
+ OFONO_LABEL=3Daux
+
+usb:v19D2*ic02isc02ip01in02
+usb:v04E8p6872*ic02isc02ip01in02
+usb:v04E8p6833*ic02isc02ip01in02
+usb:v19D2*ic02isc02ip01in03
+usb:v04E8p6872*ic02isc02ip01in03
+usb:v04E8p6833*ic02isc02ip01in03
+ OFONO_LABEL=3Dmodem
+
+usb:v19D2*ic02isc06ip00in05
+usb:v04E8p6872*ic02isc06ip00in05
+usb:v04E8p6833*ic02isc06ip00in05
+usb:v19D2*ic02isc06ip00in06
+usb:v04E8p6872*ic02isc06ip00in06
+usb:v04E8p6833*ic02isc06ip00in06
+usb:v19D2*ic02isc06ip00in07
+usb:v04E8p6872*ic02isc06ip00in07
+usb:v04E8p6833*ic02isc06ip00in07
+ OFONO_LABEL=3Dnet
+
 # ZTE
 usb:v19D2*icFFiscFFipFF*
  OFONO_DRIVER=3Dzte
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 45b64bd..16c9328 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -438,23 +438,12 @@ static gboolean setup_icera(struct modem_info *modem)
 		DBG("%s %s %s %s", info->devnode, info->interface,
 						info->number, info->label);
 =

-		if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
-		} else if (g_strcmp0(info->interface, "2/6/0") =3D=3D 0) {
-			if (g_strcmp0(info->number, "05") =3D=3D 0)
-				net =3D info->devnode;
-			else if (g_strcmp0(info->number, "06") =3D=3D 0)
-				net =3D info->devnode;
-			else if (g_strcmp0(info->number, "07") =3D=3D 0)
-				net =3D info->devnode;
-		}
+		if (g_strcmp0(info->label, "aux") =3D=3D 0)
+			aux =3D info->devnode;
+		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
+			mdm =3D info->devnode;
+		else if (g_strcmp0(info->label, "net") =3D=3D 0)
+			mdm =3D info->devnode;
 	}
 =

 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
@@ -1283,12 +1272,6 @@ static struct {
 	const char *vid;
 	const char *pid;
 } vendor_list[] =3D {
-	{ "icera",	"cdc_acm",	"19d2"		},
-	{ "icera",	"cdc_ether",	"19d2"		},
-	{ "icera",	"cdc_acm",	"04e8", "6872"	},
-	{ "icera",	"cdc_ether",	"04e8", "6872"	},
-	{ "icera",	"cdc_acm",	"0421", "0633"	},
-	{ "icera",	"cdc_ether",	"0421", "0633"	},
 	{ "mbm",	"cdc_acm",	"0bdb"		},
 	{ "mbm",	"cdc_ether",	"0bdb"		},
 	{ "mbm",	"cdc_ncm",	"0bdb"		},
-- =

2.9.3


--===============8085146827352737830==--

