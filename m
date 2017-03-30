Content-Type: multipart/mixed; boundary="===============0164576696338220276=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 12/28] hso: label interfaces via udev rules
Date: Thu, 30 Mar 2017 22:52:53 +0200
Message-ID: <20170330205309.25850-13-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0164576696338220276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules | 6 ++++++
 plugins/udevng.c    | 7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 450f6c6..59c78d5 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -26,4 +26,10 @@ ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{ID_SERIAL_SHO=
RT}=3D""
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
 =

+
+DRIVER=3D=3D"hso",ENV{OFONO_DRIVER}=3D"hso"
+ENV{OFONO_DRIVER}=3D=3D"hso",ATTR{hsotype}=3D=3D"Control",ENV{OFONO_LABEL}=
=3D"control"
+ENV{OFONO_DRIVER}=3D=3D"hso",ATTR{hsotype}=3D=3D"Application",ENV{OFONO_LA=
BEL}=3D"app"
+ENV{OFONO_DRIVER}=3D=3D"hso",ATTR{hsotype}=3D=3D"Modem",ENV{OFONO_LABEL}=
=3D"modem"
+
 LABEL=3D"ofono_end"
diff --git a/plugins/udevng.c b/plugins/udevng.c
index f66a8b1..2082a47 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -168,11 +168,11 @@ static gboolean setup_hso(struct modem_info *modem)
 		DBG("%s %s %s %s %s", info->devnode, info->interface,
 				info->number, info->label, info->sysattr);
 =

-		if (g_strcmp0(info->sysattr, "Control") =3D=3D 0)
+		if (g_strcmp0(info->label, "control") =3D=3D 0)
 			ctl =3D info->devnode;
-		else if (g_strcmp0(info->sysattr, "Application") =3D=3D 0)
+		else if (g_strcmp0(info->label, "app") =3D=3D 0)
 			app =3D info->devnode;
-		else if (g_strcmp0(info->sysattr, "Modem") =3D=3D 0)
+		else if (g_strcmp0(info->label, "modem") =3D=3D 0)
 			mdm =3D info->devnode;
 	}
 =

@@ -1338,7 +1338,6 @@ static struct {
 	{ "mbm",	"cdc_acm",	"0930"		},
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
-	{ "hso",	"hso"				},
 	{ "gobi",	"qmi_wwan"			},
 	{ "gobi",	"qcserial"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
-- =

2.9.3


--===============0164576696338220276==--

