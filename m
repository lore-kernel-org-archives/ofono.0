Content-Type: multipart/mixed; boundary="===============3857520500204242697=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 08/28] gemalto: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:49 +0200
Message-ID: <20170330205309.25850-9-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3857520500204242697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 16 ++++++++++++++++
 plugins/udevng.c   | 21 +++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index c0c050f..d35d422 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -117,3 +117,19 @@ usb:v1546*ic0Aisc00ip00*
 usb:v1546*icE0isc01ip03*
  OFONO_LABEL=3Dnet
 =

+# Gemalto
+usb:v1E2Dp0053*icFFiscFFipFF*
+ OFONO_DRIVER=3Dgemalto
+
+usb:v1E2Dp0053*icFFiscFFipFFin01
+ OFONO_LABEL=3Dgps
+
+usb:v1E2Dp0053*icFFiscFFipFFin02
+ OFONO_LABEL=3Dapp
+
+usb:v1E2Dp0053*icFFiscFFipFFin03
+ OFONO_LABEL=3Dmodem
+
+usb:v1E2Dp0053*icFFiscFFipFF*
+ OFONO_LABEL=3Dmaybeqmi
+
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4869833..0f54986 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -954,16 +954,16 @@ static gboolean setup_gemalto(struct modem_info* mode=
m)
 		DBG("%s %s %s %s %s", info->devnode, info->interface,
 				info->number, info->label, info->subsystem);
 =

-		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
-				gps =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				app =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+		if (!g_strcmp0(info->label, "gps"))
+			gps =3D info->devnode;
+		else if (!g_strcmp0(info->label, "app"))
+			app =3D info->devnode;
+		else if (!g_strcmp0(info->label, "modem"))
+			app =3D info->devnode;
+		else if (!g_strcmp0(info->label, "maybeqmi")) {
+			if (g_strcmp0(info->subsystem, "net"))
 				net =3D info->devnode;
-			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
+			else if (g_strcmp0(info->subsystem, "usbmisc"))
 				qmi =3D info->devnode;
 		}
 	}
@@ -1365,9 +1365,6 @@ static struct {
 	{ "samsung",	"option",	"04e8", "6889"	},
 	{ "samsung",	"kalmia"			},
 	{ "quectel",	"option",	"05c6", "9090"	},
-	{ "gemalto",	"option",	"1e2d",	"0053"	},
-	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
-	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
 	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
 	{ }
-- =

2.9.3


--===============3857520500204242697==--

