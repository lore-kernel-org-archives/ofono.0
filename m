Content-Type: multipart/mixed; boundary="===============8660109862068349668=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 01/21] udevng: look also to VID
Date: Tue, 27 Sep 2011 18:04:00 -0300
Message-ID: <1317157460-17012-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8660109862068349668==
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

1.7.6.2


--===============8660109862068349668==--

