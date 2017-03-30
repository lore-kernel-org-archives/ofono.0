Content-Type: multipart/mixed; boundary="===============3864507166219231856=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 15/28] option: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:56 +0200
Message-ID: <20170330205309.25850-16-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3864507166219231856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 13 +++++++++++++
 plugins/udevng.c   | 16 ++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index 5686163..655a897 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -1,3 +1,16 @@
+# Option
+usb:v0AF0*icFFiscFFipFF*
+ OFONO_DRIVER=3Doption
+
+usb:v0AF0*icFFiscFFipFFin00
+ OFONO_LABEL=3Dmodem
+
+usb:v0AF0*icFFiscFFipFFin01
+ OFONO_LABEL=3Ddiag
+
+usb:v0AF0*icFFiscFFipFFin02
+ OFONO_LABEL=3Daux
+
 # Huawei
 usb:v201E*
 usb:v12D1*
diff --git a/plugins/udevng.c b/plugins/udevng.c
index c19dc1c..2e0320b 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -298,15 +298,12 @@ static gboolean setup_option(struct modem_info *modem)
 		DBG("%s %s %s %s", info->devnode, info->interface,
 						info->number, info->label);
 =

-		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
-				diag =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				aux =3D info->devnode;
-		}
-
+		if (g_strcmp0(info->label, "modem") =3D=3D 0)
+			mdm =3D info->devnode;
+		else if (g_strcmp0(info->label, "aux") =3D=3D 0)
+			aux =3D info->devnode;
+		else if (g_strcmp0(info->label, "diag") =3D=3D 0)
+			diag =3D info->devnode;
 	}
 =

 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
@@ -1343,7 +1340,6 @@ static struct {
 	{ "sierra",	"qcserial",	"1199"		},
 	{ "sierra",	"sierra"			},
 	{ "sierra",	"sierra_net"			},
-	{ "option",	"option",	"0af0"		},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
-- =

2.9.3


--===============3864507166219231856==--

