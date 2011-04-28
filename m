Content-Type: multipart/mixed; boundary="===============1559887156218195226=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Modify send vcard test to be able to set the modem to use
Date: Thu, 28 Apr 2011 14:02:01 +0200
Message-ID: <1303992121-22556-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1559887156218195226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/send-vcard |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/test/send-vcard b/test/send-vcard
index d11d5ac..3955990 100755
--- a/test/send-vcard
+++ b/test/send-vcard
@@ -3,18 +3,30 @@
 import sys
 import dbus
 =

+if len(sys.argv) < 3:
+	print "Usage: %s [modem] <to> <vcard file>" % (sys.argv[0])
+	sys.exit(1)
+
 bus =3D dbus.SystemBus()
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
+if len(sys.argv) =3D=3D 4:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+					'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
 =

-modems =3D manager.GetModems()
-path =3D modems[0][0]
+print "Send vcard using modem %s ..." % path
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', path),
+sm =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.SmartMessaging')
 =

-vcard =3D file(sys.argv[2]).read()
-path =3D manager.SendBusinessCard(sys.argv[1], vcard)
+if len(sys.argv) =3D=3D 4:
+	vcard =3D file(sys.argv[3]).read()
+	path =3D sm.SendBusinessCard(sys.argv[2], vcard)
+else:
+	vcard =3D file(sys.argv[2]).read()
+	path =3D sm.SendBusinessCard(sys.argv[1], vcard)
 =

 print path
-- =

1.7.1

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

--===============1559887156218195226==--

