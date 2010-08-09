Content-Type: multipart/mixed; boundary="===============8559264007188552170=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH] Add test scripts to to lock and unlock pin
Date: Mon, 09 Aug 2010 17:22:31 +0300
Message-ID: <20100809142231.30805.82378.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8559264007188552170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


---
 Makefile.am     |    4 +++-
 test/lock-pin   |   27 +++++++++++++++++++++++++++
 test/unlock-pin |   27 +++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletions(-)
 create mode 100755 test/lock-pin
 create mode 100755 test/unlock-pin

diff --git a/Makefile.am b/Makefile.am
index 8d1d2c2..38210e2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -344,7 +344,9 @@ test_scripts =3D test/activate-context \
 		test/set-use-sms-reports \
 		test/set-cbs-topics \
 		test/enable-cbs \
-		test/propose-scan
+		test/propose-scan \
+		test/lock-pin \
+		test/unlock-pin
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/lock-pin b/test/lock-pin
new file mode 100755
index 0000000..a0b6e30
--- /dev/null
+++ b/test/lock-pin
@@ -0,0 +1,27 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 4:
+	path =3D sys.argv[1]
+	pin_type =3D sys.argv[2]
+	pin =3D sys.argv[3]
+elif len(sys.argv) =3D=3D 3:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+				 'org.ofono.Manager')
+	properties =3D manager.GetProperties()
+	path =3D properties["Modems"][0]
+	pin_type =3D sys.argv[1]
+	pin =3D sys.argv[2]
+else:
+	print "%s [PATH] pin_type pin" % (sys.argv[0])
+	sys.exit(0)
+
+print "Lock %s %s for modem %s..." % (pin_type, pin, path)
+
+simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
+			    'org.ofono.SimManager')
+simmanager.LockPin(pin_type, pin)
diff --git a/test/unlock-pin b/test/unlock-pin
new file mode 100755
index 0000000..4a05cd4
--- /dev/null
+++ b/test/unlock-pin
@@ -0,0 +1,27 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 4:
+	path =3D sys.argv[1]
+	pin_type =3D sys.argv[2]
+	pin =3D sys.argv[3]
+elif len(sys.argv) =3D=3D 3:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+				 'org.ofono.Manager')
+	properties =3D manager.GetProperties()
+	path =3D properties["Modems"][0]
+	pin_type =3D sys.argv[1]
+	pin =3D sys.argv[2]
+else:
+	print "%s [PATH] pin_type pin" % (sys.argv[0])
+	sys.exit(0)
+
+print "Unlock %s %s for modem %s..." % (pin_type, pin, path)
+
+simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
+			    'org.ofono.SimManager')
+simmanager.UnlockPin(pin_type, pin)


--===============8559264007188552170==--

