Content-Type: multipart/mixed; boundary="===============4584222951052553130=="
MIME-Version: 1.0
From: baloo@gandi.net
Subject: [PATCH] udevng/huawei: Add support for Huawei ME906s-158
Date: Thu, 20 Jul 2017 08:19:48 +0000
Message-ID: <20170720081948.6453-1-baloo@gandi.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4584222951052553130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Arthur Gautier <baloo@gandi.net>

---
 plugins/udevng.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index aa28bcb8911ec..4fb0dd016f17e 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -315,6 +315,7 @@ static gboolean setup_huawei(struct modem_info *modem)
 				g_strcmp0(info->interface, "255/1/1") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/2/1") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/3/1") =3D=3D 0 ||
+				g_strcmp0(info->interface, "255/6/16") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/49") =3D=3D 0) {
 			mdm =3D info->devnode;
 		} else if (g_strcmp0(info->label, "pcui") =3D=3D 0 ||
@@ -322,6 +323,7 @@ static gboolean setup_huawei(struct modem_info *modem)
 				g_strcmp0(info->interface, "255/2/2") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/2/18") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/3/18") =3D=3D 0 ||
+				g_strcmp0(info->interface, "255/6/18") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/50") =3D=3D 0) {
 			pcui =3D info->devnode;
 		} else if (g_strcmp0(info->label, "diag") =3D=3D 0 ||
@@ -330,7 +332,8 @@ static gboolean setup_huawei(struct modem_info *modem)
 				g_strcmp0(info->interface, "255/1/51") =3D=3D 0) {
 			diag =3D info->devnode;
 		} else if (g_strcmp0(info->interface, "255/1/8") =3D=3D 0 ||
-				g_strcmp0(info->interface, "255/1/56") =3D=3D 0) {
+				g_strcmp0(info->interface, "255/1/56") =3D=3D 0 ||
+				g_strcmp0(info->interface, "255/6/22") =3D=3D 0) {
 			net =3D info->devnode;
 		} else if (g_strcmp0(info->interface, "255/1/9") =3D=3D 0 ||
 				g_strcmp0(info->interface, "255/1/57") =3D=3D 0) {
-- =

2.13.3


--===============4584222951052553130==--

