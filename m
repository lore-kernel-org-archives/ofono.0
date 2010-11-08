Content-Type: multipart/mixed; boundary="===============0886749459378970083=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Add test/reset-pin
Date: Mon, 08 Nov 2010 22:28:33 +0200
Message-ID: <1289248113-3225-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0886749459378970083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/reset-pin |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100755 test/reset-pin

diff --git a/test/reset-pin b/test/reset-pin
new file mode 100755
index 0000000..d0145fe
--- /dev/null
+++ b/test/reset-pin
@@ -0,0 +1,23 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 5:
+	path, puk_type, puk, pin =3D sys.argv[1:]
+elif len(sys.argv) =3D=3D 4:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+					'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+	puk_type, puk, pin =3D sys.argv[1:]
+else:
+	print "%s [PATH] puk_type puk pin" % (sys.argv[0])
+
+print "Reset pin for modem %s..." % path
+simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.SimManager')
+
+simmanager.ResetPin(puk_type, puk, pin)
-- =

1.7.1


--===============0886749459378970083==--

