Content-Type: multipart/mixed; boundary="===============4711679948933359444=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/4] udevng.c: Switch aux channel and modem channel for
 Speedup dongles
Date: Fri, 26 Aug 2011 17:21:50 +0200
Message-ID: <1314372113-29410-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1314372113-29410-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4711679948933359444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1365bd1..8578604 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -312,11 +312,11 @@ static gboolean setup_speedup(struct modem_info *mode=
m)
 				break;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
 			if (g_strcmp0(info->number, "01") =3D=3D 0)
-				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
 				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+				aux =3D info->devnode;
 			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
+				aux =3D info->devnode;
 		}
 	}
 =

-- =

1.7.1


--===============4711679948933359444==--

