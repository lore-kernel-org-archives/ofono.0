Content-Type: multipart/mixed; boundary="===============7414273254715979691=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 17/28] samsung: label interfaces via udev rules and hwdb
Date: Thu, 30 Mar 2017 22:52:58 +0200
Message-ID: <20170330205309.25850-18-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7414273254715979691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.hwdb  | 11 +++++++++++
 plugins/ofono.rules |  6 ++++++
 plugins/udevng.c    |  6 ++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/plugins/ofono.hwdb b/plugins/ofono.hwdb
index 70842c7..02db1cd 100644
--- a/plugins/ofono.hwdb
+++ b/plugins/ofono.hwdb
@@ -127,6 +127,17 @@ usb:v0421p060E*ic0Aisc00ip00in04
 usb:v0421p0623*ic0Aisc00ip00in04
  OFONO_LABEL=3Daux
 =

+# Samsung
+usb:v04E8p6889*ic0Aisc00ip00*
+usb:v04E8p6889*icFFisc00ip00*
+ OFONO_DRIVER=3Dsamsung
+
+usb:v04E8*ic0Aisc00ip00*
+ OFONO_LABEL=3Dcontrol
+
+usb:v04E8*icFFisc00ip00*
+ OFONO_LABEL=3Dnet
+
 # UBlox
 usb:v1546p1102*
 usb:v1546p1146*
diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 4d70735..f783aab 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -60,4 +60,10 @@ ATTR{bInterfaceNumber}=3D=3D"02",ENV{OFONO_LABEL}=3D"mod=
em"
 ATTR{bInterfaceNumber}=3D=3D"03",ENV{OFONO_LABEL}=3D"gps"
 LABEL=3D"gobi_end"
 =

+DRIVER=3D=3D"kalmia",ENV{OFONO_DRIVER}=3D"samsung"
+ENV{OFONO_DRIVER}!=3D"samsung",GOTO=3D"samsung_end"
+ENV{INTERFACE}=3D=3D"10/0/0",ENV{OFONO_LABEL}=3D"control"
+ENV{INTERFACE}=3D=3D"255/0/0",ENV{OFONO_LABEL}=3D"net"
+LABEL=3D"samsung_end"
+
 LABEL=3D"ofono_end"
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 095d1fc..b5c5c86 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -735,9 +735,9 @@ static gboolean setup_samsung(struct modem_info *modem)
 		DBG("%s %s %s %s", info->devnode, info->interface,
 						info->number, info->label);
 =

-		if (g_strcmp0(info->interface, "10/0/0") =3D=3D 0)
+		if (g_strcmp0(info->label, "control") =3D=3D 0)
 			control =3D info->devnode;
-		else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0)
+		else if (g_strcmp0(info->label, "net") =3D=3D 0)
 			network =3D info->devnode;
 	}
 =

@@ -1335,8 +1335,6 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
-	{ "samsung",	"option",	"04e8", "6889"	},
-	{ "samsung",	"kalmia"			},
 	{ "quectel",	"option",	"05c6", "9090"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
 	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
-- =

2.9.3


--===============7414273254715979691==--

