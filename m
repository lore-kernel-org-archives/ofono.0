Content-Type: multipart/mixed; boundary="===============8547564354699529247=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 21/28] telit: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:53:02 +0200
Message-ID: <20170330205309.25850-22-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8547564354699529247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 plugins/udevng.c   | 36 +++++++-----------------------------
 2 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index 02db1cd..d3a19aa 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -213,3 +213,49 @@ usb:v230D*ic02isc02ip01in01
 usb:v230D*ic02isc02ip01in03
  OFONO_LABEL=3Dmodem
 =

+# Telit
+usb:v1BC7*icFFiscFFipFF*
+usb:v1BC7p0021*icFFiscFFipFF*
+usb:v1BC7p0036*icFFiscFFipFF*
+ OFONO_DRIVER=3Dtelit
+
+usb:v1BC7*icFFiscFFipFFin00
+usb:v1BC7p0021*icFFiscFFipFFin00
+usb:v1BC7p0036*icFFiscFFipFFin00
+ OFONO_LABEL=3Dmodem
+
+usb:v1BC7*icFFiscFFipFFin02
+usb:v1BC7p0021*icFFiscFFipFFin02
+usb:v1BC7p0036*icFFiscFFipFFin02
+ OFONO_LABEL=3Dgps
+
+usb:v1BC7*icFFiscFFipFFin03
+usb:v1BC7p0021*icFFiscFFipFFin03
+usb:v1BC7p0036*icFFiscFFipFFin03
+ OFONO_LABEL=3Daux
+
+usb:v1BC7*ic02isc02ip01in00
+usb:v1BC7p0021*ic02isc02ip01in00
+usb:v1BC7p0036*ic02isc02ip01in00
+ OFONO_LABEL=3Dmodem
+
+usb:v1BC7*ic02isc02ip01in06
+usb:v1BC7p0021*ic02isc02ip01in06
+usb:v1BC7p0036*ic02isc02ip01in06
+ OFONO_LABEL=3Daux
+
+usb:v1BC7*ic02isc02ip01in0a
+usb:v1BC7p0021*ic02isc02ip01in0a
+usb:v1BC7p0036*ic02isc02ip01in0a
+ OFONO_LABEL=3Dgps
+
+
+# The Telit catch-all vendor rule above prevents us from using the generic
+# qmi udev rule for QMI devices.  Replace the above catch-all rule and
+# the following can be dropped
+usb:v1BC7p1201*icFFiscFFipFF*
+ OFONO_DRIVER=3Dtelitqmi
+
+usb:v1BC7p1201*icFFiscFFipFFin02
+ OFONO_LABEL=3Dqmi
+
diff --git a/plugins/udevng.c b/plugins/udevng.c
index d02cc6e..45b64bd 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -573,32 +573,15 @@ static gboolean setup_telit(struct modem_info *modem)
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
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				gps =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				aux =3D info->devnode;
-		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "06") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "0a") =3D=3D 0)
-				gps =3D info->devnode;
-		} else if (info->sysattr && (g_str_has_suffix(info->sysattr,
-						"CDC NCM") =3D=3D TRUE)) {
-			net =3D info->devnode;
-		}
+		else if (g_strcmp0(info->label, "gps") =3D=3D 0)
+			gps =3D info->devnode;
+		else if (info->sysattr)
+			if (g_str_has_suffix(info->sysattr, "CDC NCM"))
+				net =3D info->devnode;
 	}
 =

 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
@@ -1321,12 +1304,7 @@ static struct {
 	{ "mbm",	"cdc_acm",	"0930"		},
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
-	{ "telit",	"usbserial",	"1bc7"		},
-	{ "telit",	"option",	"1bc7"		},
-	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "quectel",	"option",	"05c6", "9090"	},
-	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
-	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
 	{ }
 };
 =

-- =

2.9.3


--===============8547564354699529247==--

