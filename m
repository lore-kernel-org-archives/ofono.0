Content-Type: multipart/mixed; boundary="===============0227867012082294161=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/3] udevng: support telit modems using cdc-acm driver
Date: Thu, 04 Apr 2013 10:20:50 +0200
Message-ID: <1365063652-24286-2-git-send-email-jonas@southpole.se>
In-Reply-To: <1365063652-24286-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0227867012082294161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christopher Vogl <christopher.vogl@hale.at>

Add support for Telit modem using the cdc-acm driver, like the Telit
HE910.
---
 plugins/udevng.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index afb02ca..e77e4d9 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -599,8 +599,8 @@ static gboolean setup_telit(struct modem_info *modem)
 	for (list =3D modem->devices; list; list =3D list->next) {
 		struct device_info *info =3D list->data;
 =

-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+				info->number, info->label, info->sysattr);
 =

 		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
 			aux =3D info->devnode;
@@ -619,6 +619,13 @@ static gboolean setup_telit(struct modem_info *modem)
 				gps =3D info->devnode;
 			else if (g_strcmp0(info->number, "03") =3D=3D 0)
 				aux =3D info->devnode;
+		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
+				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+				diag =3D info->devnode;
+			else if (g_strcmp0(info->number, "06") =3D=3D 0)
+				aux =3D info->devnode;
 		}
 	}
 =

@@ -777,7 +784,7 @@ static struct {
 	{ "alcatel",	setup_alcatel	},
 	{ "novatel",	setup_novatel	},
 	{ "nokia",	setup_nokia	},
-	{ "telit",	setup_telit	},
+	{ "telit",	setup_telit,	"device/interface"	},
 	{ "simcom",	setup_simcom	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
@@ -987,6 +994,7 @@ static struct {
 	{ "zte",	"option",	"19d2"		},
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "telit",	"usbserial",	"1bc7"		},
+	{ "telit",	"cdc_acm",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
-- =

1.8.1.2


--===============0227867012082294161==--

