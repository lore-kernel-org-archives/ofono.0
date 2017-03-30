Content-Type: multipart/mixed; boundary="===============6054829934660790964=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 19/28] telitqmi: label interfaces via udev rules
Date: Thu, 30 Mar 2017 22:53:00 +0200
Message-ID: <20170330205309.25850-20-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6054829934660790964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index c4eb9fd..3aef447 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -629,8 +629,7 @@ static gboolean setup_telitqmi(struct modem_info *modem)
 		DBG("%s %s %s %s %s", info->devnode, info->interface,
 				info->number, info->label, info->subsystem);
 =

-		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0 &&
-				g_strcmp0(info->number, "02") =3D=3D 0) {
+		if (g_strcmp0(info->label, "qmi") =3D=3D 0) {
 			if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
 				net =3D info->devnode;
 			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
@@ -1325,7 +1324,6 @@ static struct {
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
-	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
 	{ "quectel",	"option",	"05c6", "9090"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
-- =

2.9.3


--===============6054829934660790964==--

