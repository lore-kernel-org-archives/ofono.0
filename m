Content-Type: multipart/mixed; boundary="===============0239920612967772880=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] udev: enhance udev detection for intel 7xxx modems
Date: Wed, 31 Oct 2018 16:13:04 +0530
Message-ID: <1540982584-8727-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0239920612967772880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle newer 7xxx modem enumeration based on ProductId.
Preserving the previous gen support too.
---
 plugins/udevng.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 11338f7..e9f16e8 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1193,13 +1193,24 @@ static gboolean setup_xmm7xxx(struct modem_info *mo=
dem)
 				info->interface, info->number, info->label,
 				info->sysattr, info->subsystem);
 =

-		if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
-			if (g_strcmp0(info->number, "02") =3D=3D 0)
-				mdm =3D info->devnode;
-		} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
-				net =3D info->devnode;
+		if (g_strcmp0(modem->model,"095a") =3D=3D 0) {
+			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
+				if (g_strcmp0(info->number, "00") =3D=3D 0)
+					mdm =3D info->devnode;
+			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
+				if (g_strcmp0(info->number, "06") =3D=3D 0)
+					net =3D info->devnode;
+			}
 		}
+		else {
+			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
+                               if (g_strcmp0(info->number, "02") =3D=3D 0)
+                                       mdm =3D info->devnode;
+			 } else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
+                                if (g_strcmp0(info->number, "00") =3D=3D 0)
+                                        net =3D info->devnode;
+                        }
+                }
 	}
 =

 	if (mdm =3D=3D NULL || net =3D=3D NULL)
-- =

2.7.4


--===============0239920612967772880==--

