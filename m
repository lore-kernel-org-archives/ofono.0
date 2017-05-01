Content-Type: multipart/mixed; boundary="===============3895983725039820510=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 6/7] udevng/gobi: allow to detect ec20 tty devices
Date: Mon, 01 May 2017 22:52:55 +0200
Message-ID: <20170501205256.4205-6-lynxis@fe80.eu>
In-Reply-To: <20170501205256.4205-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3895983725039820510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Quectel EC20 uses the same usb id as some gobi 2000 modules (05c6:9215).
---
 plugins/udevng.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 9418bb5d..9c106060 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -214,12 +214,20 @@ static gboolean setup_gobi(struct modem_info *modem)
 			net =3D info->devnode;
 		else if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
 			if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-				if (g_strcmp0(info->number, "01") =3D=3D 0)
-					diag =3D info->devnode;
+				if (g_strcmp0(info->number, "00") =3D=3D 0)
+					diag =3D info->devnode; /* ec20 */
+				else if (g_strcmp0(info->number, "01") =3D=3D 0)
+					diag =3D info->devnode; /* gobi */
 				else if (g_strcmp0(info->number, "02") =3D=3D 0)
-					mdm =3D info->devnode;
+					mdm =3D info->devnode; /* gobi */
 				else if (g_strcmp0(info->number, "03") =3D=3D 0)
-					gps =3D info->devnode;
+					gps =3D info->devnode; /* gobi */
+			} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0) {
+				if (g_strcmp0(info->number, "01") =3D=3D 0)
+					gps =3D info->devnode; /* ec20 */
+				if (g_strcmp0(info->number, "02") =3D=3D 0)
+					mdm =3D info->devnode; /* ec20 */
+				/* ignore the 3rd device second AT/mdm iface */
 			}
 		}
 	}
-- =

2.12.2


--===============3895983725039820510==--

