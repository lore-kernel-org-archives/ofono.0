Content-Type: multipart/mixed; boundary="===============4948640031787450340=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/4] udevng.c: Assign modem channel to ttyUSB0 for speedup
 cdma dongles
Date: Fri, 26 Aug 2011 17:21:51 +0200
Message-ID: <1314372113-29410-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1314372113-29410-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4948640031787450340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 8578604..ae76317 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -311,7 +311,12 @@ static gboolean setup_speedup(struct modem_info *modem)
 			if (aux !=3D NULL)
 				break;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
+			if (g_strcmp0(info->number, "00") =3D=3D 0 &&
+					g_strcmp0(modem->driver,
+						"speedupcdma") =3D=3D 0)
+				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "01") =3D=3D 0 &&
+					mdm =3D=3D NULL)
 				mdm =3D info->devnode;
 			else if (g_strcmp0(info->number, "02") =3D=3D 0)
 				aux =3D info->devnode;
-- =

1.7.1


--===============4948640031787450340==--

