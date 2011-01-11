Content-Type: multipart/mixed; boundary="===============8843886062957745146=="
MIME-Version: 1.0
From: Jussi.Kangas@tieto.com
Subject: [PATCH] test: add change-pin test case
Date: Tue, 11 Jan 2011 14:17:08 +0200
Message-ID: <20A4FB08D632914F9C09B9F05CBDF258192D753023@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8843886062957745146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am     |    3 ++-
 test/change-pin |   29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletions(-)
 create mode 100755 test/change-pin

diff --git a/Makefile.am b/Makefile.am
index cc30624..4c9add4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -446,7 +446,8 @@ test_scripts =3D test/backtrace \
         test/set-tty \
         test/set-gsm-band \
         test/set-umts-band \
-        test/lockdown-modem
+        test/lockdown-modem \
+        test/change-pin
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/change-pin b/test/change-pin new file mode 100755 index 0=
000000..a2444d6
--- /dev/null
+++ b/test/change-pin
@@ -0,0 +1,29 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 5:
+    path =3D sys.argv[1]
+    pin_type =3D sys.argv[2]
+    orig_pin =3D sys.argv[3]
+    new_pin =3D sys.argv[4]
+elif len(sys.argv) =3D=3D 4:
+    manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+                    'org.ofono.Manager')
+    modems =3D manager.GetModems()
+    path =3D modems[0][0]
+    pin_type =3D sys.argv[1]
+    orig_pin =3D sys.argv[2]
+    new_pin =3D sys.argv[3]
+else:
+    print "%s [PATH] pin_type pin" % (sys.argv[0])
+    sys.exit(0)
+
+print "Change Pin for modem %s..." % path simmanager =3D =

+dbus.Interface(bus.get_object('org.ofono', path),
+                'org.ofono.SimManager')
+
+simmanager.ChangePin(pin_type, orig_pin, new_pin)
--
1.7.1

--===============8843886062957745146==--

