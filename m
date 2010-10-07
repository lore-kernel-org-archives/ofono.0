Content-Type: multipart/mixed; boundary="===============3906422641947711409=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 4/4] test: add scripts to enable and disable fast dormancy
Date: Thu, 07 Oct 2010 16:37:33 +0300
Message-ID: <1286458653-12096-5-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1286458653-12096-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3906422641947711409==
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
index 6c56459..7a56cb4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -407,7 +407,9 @@ test_scripts =3D test/backtrace \
 		test/lock-pin \
 		test/unlock-pin \
 		test/enable-gprs \
-		test/disable-gprs
+		test/disable-gprs \
+		test/enable-fast-dormancy \
+		test/disable-fast-dormancy
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/disable-fast-dormancy b/test/disable-fast-dormancy
new file mode 100755
index 0000000..ec326aa
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
+cm =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.RadioSettings')
+
+cm.SetProperty("FastDormancy", dbus.Boolean(0))
diff --git a/test/enable-fast-dormancy b/test/enable-fast-dormancy
new file mode 100755
index 0000000..93ec1d5
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
+cm =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.RadioSettings')
+
+cm.SetProperty("FastDormancy", dbus.Boolean(1))
-- =

1.7.0.4


--===============3906422641947711409==--

