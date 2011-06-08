Content-Type: multipart/mixed; boundary="===============1816678221411564017=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Add the possibility to specify the modem to use
Date: Wed, 08 Jun 2011 16:18:57 +0200
Message-ID: <1307542737-17878-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1816678221411564017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/initiate-ussd |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/test/initiate-ussd b/test/initiate-ussd
index b6a2d86..098ec87 100755
--- a/test/initiate-ussd
+++ b/test/initiate-ussd
@@ -4,7 +4,7 @@ import sys
 import dbus
 =

 if (len(sys.argv) < 2):
-	print "Usage: %s <ussd-string>" % (sys.argv[0])
+	print "Usage: %s [modem] <ussd-string>" % (sys.argv[0])
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -13,7 +13,13 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '=
/'),
 						'org.ofono.Manager')
 =

 modems =3D manager.GetModems()
-path =3D modems[0][0]
+
+if (len(sys.argv) =3D=3D 2):
+	path =3D modems[0][0]
+	ussdstring =3D sys.argv[1]
+else:
+	path =3D sys.argv[1]
+	ussdstring =3D sys.argv[2]
 =

 ussd =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.SupplementaryServices')
@@ -26,7 +32,7 @@ print "State: %s" % (state)
 if state !=3D "idle":
 	sys.exit(1);
 =

-result =3D ussd.Initiate(sys.argv[1], timeout=3D100)
+result =3D ussd.Initiate(ussdstring, timeout=3D100)
 =

 properties =3D ussd.GetProperties()
 state =3D properties["State"]
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============1816678221411564017==--

