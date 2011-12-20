Content-Type: multipart/mixed; boundary="===============7847517112820445393=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/2] udevng: Do only label assignment for Speedup dongles
Date: Tue, 20 Dec 2011 17:55:41 +0100
Message-ID: <1324400142-23449-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7847517112820445393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index be87320..2c0633d 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -310,13 +310,6 @@ static gboolean setup_speedup(struct modem_info *modem)
 			mdm =3D info->devnode;
 			if (aux !=3D NULL)
 				break;
-		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
 		}
 	}
 =

-- =

1.7.1


--===============7847517112820445393==--

