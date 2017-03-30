Content-Type: multipart/mixed; boundary="===============6393434637280939228=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 16/28] nokia: label interfaces via hwdb
Date: Thu, 30 Mar 2017 22:52:57 +0200
Message-ID: <20170330205309.25850-17-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6393434637280939228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb | 13 +++++++++++++
 plugins/udevng.c   | 16 ++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index 655a897..70842c7 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -114,6 +114,19 @@ usb:v05C6p9000*icFFiscFFipFFin02
 usb:v05C6p9000*icFFiscFFipFFin03
  OFONO_LABEL=3Dmodem
 =

+# Nokia
+usb:v0421p060E*ic0Aisc00ip00*
+usb:v0421p0623*ic0Aisc00ip00*
+ OFONO_DRIVER=3Dnokia
+
+usb:v0421p060E*ic0Aisc00ip00in02
+usb:v0421p0623*ic0Aisc00ip00in02
+ OFONO_LABEL=3Dmodem
+
+usb:v0421p060E*ic0Aisc00ip00in04
+usb:v0421p0623*ic0Aisc00ip00in04
+ OFONO_LABEL=3Daux
+
 # UBlox
 usb:v1546p1102*
 usb:v1546p1146*
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2e0320b..095d1fc 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -547,20 +547,10 @@ static gboolean setup_nokia(struct modem_info *modem)
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
-		} else if (g_strcmp0(info->interface, "10/0/0") =3D=3D 0) {
-			if (g_strcmp0(info->number, "02") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "04") =3D=3D 0)
-				aux =3D info->devnode;
-		}
 	}
 =

 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
@@ -1345,8 +1335,6 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
-	{ "nokia",	"option",	"0421", "060e"	},
-	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
 	{ "samsung",	"kalmia"			},
 	{ "quectel",	"option",	"05c6", "9090"	},
-- =

2.9.3


--===============6393434637280939228==--

