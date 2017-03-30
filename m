Content-Type: multipart/mixed; boundary="===============7420947397424293160=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 13/28] isiusb: label interfaces via udev rules
Date: Thu, 30 Mar 2017 22:52:54 +0200
Message-ID: <20170330205309.25850-14-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7420947397424293160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |  4 ++++
 plugins/udevng.c    | 11 +++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 59c78d5..fe673cd 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -32,4 +32,8 @@ ENV{OFONO_DRIVER}=3D=3D"hso",ATTR{hsotype}=3D=3D"Control"=
,ENV{OFONO_LABEL}=3D"control"
 ENV{OFONO_DRIVER}=3D=3D"hso",ATTR{hsotype}=3D=3D"Application",ENV{OFONO_LA=
BEL}=3D"app"
 ENV{OFONO_DRIVER}=3D=3D"hso",ATTR{hsotype}=3D=3D"Modem",ENV{OFONO_LABEL}=
=3D"modem"
 =

+DRIVER=3D=3D"cdc_phonet",ENV{OFONO_DRIVER}=3D"isiusb"
+ENV{OFONO_DRIVER}=3D=3D"isiusb",ATTR{type}=3D=3D"820",ENV{OFONO_LABEL}=3D"=
modem"
+ENV{OFONO_LABEL}=3D=3D"modem",ENV{INTERFACE}=3D=3D"2/254/0",ENV{OFONO_LABE=
L}=3D"modem16"
+
 LABEL=3D"ofono_end"
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2082a47..508db04 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -88,11 +88,11 @@ static gboolean setup_isi(struct modem_info *modem)
 		DBG("%s %s %s %s %s", info->devnode, info->interface,
 				info->number, info->label, info->sysattr);
 =

-		if (g_strcmp0(info->sysattr, "820") =3D=3D 0) {
-			if (g_strcmp0(info->interface, "2/254/0") =3D=3D 0)
-				addr =3D 16;
-
+		if (g_str_has_prefix(info->label, "modem")) {
 			node =3D info->devnode;
+
+			if (!g_strcmp0(info->label, "modem16"))
+				addr =3D 16;
 		}
 	}
 =

@@ -983,7 +983,7 @@ static struct {
 	gboolean (*setup)(struct modem_info *modem);
 	const char *sysattr;
 } driver_list[] =3D {
-	{ "isiusb",	setup_isi,	"type"			},
+	{ "isiusb",	setup_isi,	},
 	{ "mbm",	setup_mbm,	"device/interface"	},
 	{ "hso",	setup_hso,	"hsotype"		},
 	{ "gobi",	setup_gobi	},
@@ -1316,7 +1316,6 @@ static struct {
 	const char *vid;
 	const char *pid;
 } vendor_list[] =3D {
-	{ "isiusb",	"cdc_phonet"			},
 	{ "icera",	"cdc_acm",	"19d2"		},
 	{ "icera",	"cdc_ether",	"19d2"		},
 	{ "icera",	"cdc_acm",	"04e8", "6872"	},
-- =

2.9.3


--===============7420947397424293160==--

