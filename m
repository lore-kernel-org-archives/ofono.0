Content-Type: multipart/mixed; boundary="===============6304504904122277199=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 3/6] test: add scripts to enable and disable fast dormancy
Date: Mon, 25 Oct 2010 16:28:07 +0300
Message-ID: <1288013290-6124-4-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288013290-6124-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6304504904122277199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                |    4 +++-
 test/disable-fast-dormancy |   20 ++++++++++++++++++++
 test/enable-fast-dormancy  |   20 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletions(-)
 create mode 100755 test/disable-fast-dormancy
 create mode 100755 test/enable-fast-dormancy

diff --git a/Makefile.am b/Makefile.am
index 25c18bd..cd2cf78 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -410,7 +410,9 @@ test_scripts =3D test/backtrace \
 		test/unlock-pin \
 		test/enable-gprs \
 		test/disable-gprs \
-		test/get-icon
+		test/get-icon \
+		test/enable-fast-dormancy \
+		test/disable-fast-dormancy
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/disable-fast-dormancy b/test/disable-fast-dormancy
new file mode 100755
index 0000000..a9d7286
--- /dev/null
+++ b/test/disable-fast-dormancy
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print "Disabling fast dormancy on modem %s..." % path
+rs =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.RadioSettings')
+
+rs.SetProperty("FastDormancy", dbus.Boolean(0))
diff --git a/test/enable-fast-dormancy b/test/enable-fast-dormancy
new file mode 100755
index 0000000..518a662
--- /dev/null
+++ b/test/enable-fast-dormancy
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print "Enabling fast dormancy on modem %s..." % path
+rs =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.RadioSettings')
+
+rs.SetProperty("FastDormancy", dbus.Boolean(1))
-- =

1.7.0.4


--===============6304504904122277199==--

