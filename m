Content-Type: multipart/mixed; boundary="===============2169257971492849781=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 18/28] sierra: label interfaces via udev rules
Date: Thu, 30 Mar 2017 22:52:59 +0200
Message-ID: <20170330205309.25850-19-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2169257971492849781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules | 11 +++++++++++
 plugins/udevng.c    | 32 ++++++++++++--------------------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index f783aab..34ff9ce 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -51,6 +51,17 @@ DRIVER=3D=3D"qmi_wwan",ENV{OFONO_DRIVER}=3D"gobi",ENV{OF=
ONO_LABEL}=3D"qmi"
 # in order to keep the below rules as minimal as possible.  The below
 # should be considered only as a fallback.
 =

+DRIVER=3D=3D"qcserial",ATTRS{idVendor}=3D"1199",ENV{OFONO_DRIVER}=3D"sierr=
a"
+DRIVER=3D=3D"sierra",ENV{OFONO_DRIVER}=3D"sierra"
+DRIVER=3D=3D"sierra_net",ENV{OFONO_DRIVER}=3D"sierra
+ENV{OFONO_DRIVER}!=3D"sierra",GOTO=3D"sierra_end"
+ENV{INTERFACE}!=3D"255/255/255",GOTO=3D"sierra_end"
+ATTR{bInterfaceNumber}=3D=3D"01",ENV{OFONO_LABEL}=3D"diag"
+ATTR{bInterfaceNumber}=3D=3D"03",ENV{OFONO_LABEL}=3D"modem"
+ATTR{bInterfaceNumber}=3D=3D"04",ENV{OFONO_LABEL}=3D"app"
+ATTR{bInterfaceNumber}=3D=3D"07",ENV{OFONO_LABEL}=3D"net"
+LABEL=3D"sierra_end"
+
 DRIVER=3D=3D"qcserial",ENV{OFONO_DRIVER}=3D"gobi"
 ENV{OFONO_DRIVER}!=3D"gobi",GOTO=3D"gobi_end"
 ENV{INTERFACE}!=3D"255/255/255",GOTO=3D"gobi_end"
diff --git a/plugins/udevng.c b/plugins/udevng.c
index b5c5c86..c4eb9fd 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -246,23 +246,19 @@ static gboolean setup_sierra(struct modem_info *modem)
 		DBG("%s %s %s %s %s", info->devnode, info->interface,
 				info->number, info->label, info->subsystem);
 =

-		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
-				diag =3D info->devnode;
-			if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "04") =3D=3D 0)
-				app =3D info->devnode;
-			else if (g_strcmp0(info->number, "07") =3D=3D 0)
+		if (g_strcmp0(info->label, "qmi") =3D=3D 0) {
+			if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
 				net =3D info->devnode;
-			else if (g_strcmp0(info->number, "0a") =3D=3D 0) {
-				if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
-					net =3D info->devnode;
-				else if (g_strcmp0(info->subsystem,
-								"usbmisc") =3D=3D 0)
-					qmi =3D info->devnode;
-			}
-		}
+			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
+				qmi =3D info->devnode;
+		} else if (g_strcmp0(info->label, "net") =3D=3D 0)
+			net =3D info->devnode;
+		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
+			mdm =3D info->devnode;
+		else if (g_strcmp0(info->label, "diag") =3D=3D 0)
+			diag =3D info->devnode;
+		else if (g_strcmp0(info->label, "app") =3D=3D 0)
+			app =3D info->devnode;
 	}
 =

 	if (qmi !=3D NULL && net !=3D NULL) {
@@ -1326,10 +1322,6 @@ static struct {
 	{ "mbm",	"cdc_acm",	"0930"		},
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
-	{ "sierra",	"qmi_wwan",	"1199"		},
-	{ "sierra",	"qcserial",	"1199"		},
-	{ "sierra",	"sierra"			},
-	{ "sierra",	"sierra_net"			},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
-- =

2.9.3


--===============2169257971492849781==--

