Content-Type: multipart/mixed; boundary="===============0844359281692275929=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] test: Fix number of arguments check in change-pin
Date: Tue, 27 Nov 2018 15:22:46 +0530
Message-ID: <1543312366-24613-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0844359281692275929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the number of arguments checked in second case of change-pin.
---
 test/change-pin | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/change-pin b/test/change-pin
index 301c6ce..b8b1ad7 100755
--- a/test/change-pin
+++ b/test/change-pin
@@ -10,7 +10,7 @@ if len(sys.argv) =3D=3D 5:
 	pin_type =3D sys.argv[2]
 	old_pin =3D sys.argv[3]
 	new_pin =3D sys.argv[4]
-elif len(sys.argv) =3D=3D 3:
+elif len(sys.argv) =3D=3D 4:
 	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 					'org.ofono.Manager')
 	modems =3D manager.GetModems()
-- =

2.7.4


--===============0844359281692275929==--

