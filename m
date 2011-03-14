Content-Type: multipart/mixed; boundary="===============8780026503320064722=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Add the possibility to specify the modem in test/dial-number
Date: Mon, 14 Mar 2011 14:06:28 +0100
Message-ID: <1300107988-4603-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8780026503320064722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/dial-number |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/test/dial-number b/test/dial-number
index d66a878..8e250ea 100755
--- a/test/dial-number
+++ b/test/dial-number
@@ -3,21 +3,40 @@
 import sys
 import dbus
 =

+if (len(sys.argv) < 2):
+	print "Usage: %s [modem] <number> [hide_callerid]" % (sys.argv[0])
+	sys.exit(1)
+
 bus =3D dbus.SystemBus()
 =

 manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 						'org.ofono.Manager')
 =

 modems =3D manager.GetModems()
+modem =3D modems[0][0]
+
+hide_callerid =3D "default"
+
+if (len(sys.argv) =3D=3D 2):
+	number =3D sys.argv[1]
+elif (len(sys.argv) =3D=3D 3):
+	if (sys.argv[2] =3D=3D "default") or (sys.argv[2] =3D=3D "enabled") or \
+			(sys.argv[2] =3D=3D "disabled"):
+		number =3D sys.argv[1]
+		hide_callerid =3D sys.argv[2]
+	else:
+		modem =3D sys.argv[1]
+		number =3D sys.argv[2]
+else:
+	modem =3D sys.argv[1]
+	number =3D sys.argv[2]
+	hide_callerid =3D sys.argv[3]
 =

-path, properties =3D modems[0]
+print "Using modem %s" % modem
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', path),
+vcm =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.VoiceCallManager')
 =

-if len(sys.argv) > 2:
-    path =3D manager.Dial(sys.argv[1], sys.argv[2])
-else:
-    path =3D manager.Dial(sys.argv[1], "")
+path =3D vcm.Dial(number, hide_callerid)
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

--===============8780026503320064722==--

