Content-Type: multipart/mixed; boundary="===============1028947918355774136=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 01/20] udevng: look also to VID
Date: Mon, 05 Sep 2011 15:03:30 -0300
Message-ID: <1315245829-6887-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315245829-6887-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1028947918355774136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Some drivers name are not properly set, so we need to rely on the VID
information as well
---
 plugins/udevng.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1365bd1..5fd9475 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -857,14 +857,16 @@ static void check_usb_device(struct udev_device *devi=
ce)
 		DBG("%s [%s:%s]", drv, vid, pid);
 =

 		for (i =3D 0; vendor_list[i].driver; i++) {
-			if (g_str_equal(vendor_list[i].drv, drv) =3D=3D FALSE)
-				continue;
-
-			if (vendor_list[i].vid =3D=3D NULL) {
-				driver =3D vendor_list[i].driver;
-				break;
+			if (g_str_equal(vendor_list[i].drv, drv) =3D=3D TRUE) {
+				if (vendor_list[i].vid =3D=3D NULL) {
+					driver =3D vendor_list[i].driver;
+					break;
+				}
 			}
 =

+			if (vendor_list[i].vid =3D=3D NULL)
+				continue;
+
 			if (g_str_equal(vendor_list[i].vid, vid) =3D=3D TRUE) {
 				if (vendor_list[i].pid =3D=3D NULL) {
 					if (driver =3D=3D NULL)
-- =

1.7.6.1


--===============1028947918355774136==--

