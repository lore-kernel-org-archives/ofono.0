Content-Type: multipart/mixed; boundary="===============8295632129730408398=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 10/28] linktop: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:51 +0200
Message-ID: <20170330205309.25850-11-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8295632129730408398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 10 ++++++++++
 plugins/udevng.c   | 11 ++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index d6e7e9d..5686163 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -166,3 +166,13 @@ usb:v1C9Ep9E00*in00
 usb:v1C9Ep9E00*in03
  OFONO_LABEL=3Daux
 =

+# Linktop
+usb:v230D*ic02isc02ip01*
+ OFONO_DRIVER=3Dlinktop
+
+usb:v230D*ic02isc02ip01in01
+ OFONO_LABEL=3Daux
+
+usb:v230D*ic02isc02ip01in03
+ OFONO_LABEL=3Dmodem
+
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 3be047d..5b858f2 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -416,12 +416,10 @@ static gboolean setup_linktop(struct modem_info *mode=
m)
 		DBG("%s %s %s %s", info->devnode, info->interface,
 						info->number, info->label);
 =

-		if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
-		}
+		if (g_strcmp0(info->label, "aux") =3D=3D 0)
+			aux =3D info->devnode;
+		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
+			mdm =3D info->devnode;
 	}
 =

 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
@@ -1322,7 +1320,6 @@ static struct {
 	const char *pid;
 } vendor_list[] =3D {
 	{ "isiusb",	"cdc_phonet"			},
-	{ "linktop",	"cdc_acm",	"230d"		},
 	{ "icera",	"cdc_acm",	"19d2"		},
 	{ "icera",	"cdc_ether",	"19d2"		},
 	{ "icera",	"cdc_acm",	"04e8", "6872"	},
-- =

2.9.3


--===============8295632129730408398==--

