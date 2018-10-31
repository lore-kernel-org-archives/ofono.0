Content-Type: multipart/mixed; boundary="===============1131932312534211238=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] udev: udpate udev to detect new 7xxx modems
Date: Wed, 31 Oct 2018 12:26:02 +0530
Message-ID: <1540968962-14314-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1131932312534211238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Newer intel modems enumerate with different subsystem numbers,
adding code to detect newer 7xxx modules.

Plan to add patch for backward compatibility of intels modems soon,
to based on interface number instead of subsystem name string.
---
 plugins/udevng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 11338f7..bf0b1c4 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1194,10 +1194,10 @@ static gboolean setup_xmm7xxx(struct modem_info *mo=
dem)
 				info->sysattr, info->subsystem);
 =

 		if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
-			if (g_strcmp0(info->number, "02") =3D=3D 0)
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
 		} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
+			if (g_strcmp0(info->number, "06") =3D=3D 0)
 				net =3D info->devnode;
 		}
 	}
-- =

2.7.4


--===============1131932312534211238==--

