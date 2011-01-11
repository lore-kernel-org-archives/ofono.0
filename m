Content-Type: multipart/mixed; boundary="===============2051278978451211119=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v2 8/9] gps: add test scripts
Date: Tue, 11 Jan 2011 00:23:57 -0300
Message-ID: <1294716238-21218-9-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1294716238-21218-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2051278978451211119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am      |    4 +++-
 test/disable-gps |   20 ++++++++++++++++++++
 test/enable-gps  |   20 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletions(-)
 create mode 100755 test/disable-gps
 create mode 100755 test/enable-gps

diff --git a/Makefile.am b/Makefile.am
index a41b629..3352f24 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -444,7 +444,9 @@ test_scripts =3D test/backtrace \
 		test/set-tty \
 		test/set-gsm-band \
 		test/set-umts-band \
-		test/lockdown-modem
+		test/lockdown-modem \
+		test/enable-gps \
+		test/disable-gps
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/disable-gps b/test/disable-gps
new file mode 100755
index 0000000..adb6ba5
--- /dev/null
+++ b/test/disable-gps
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
+print "Powering OFF the GPS on modem %s..." % path
+gps =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.LocationReporting')
+
+gps.SetProperty("Powered", dbus.Boolean(0))
diff --git a/test/enable-gps b/test/enable-gps
new file mode 100755
index 0000000..e70eb2b
--- /dev/null
+++ b/test/enable-gps
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
+						'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print "Powering ON the GPS for modem %s..." % path
+gps =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.LocationReporting')
+
+gps.SetProperty("Powered", dbus.Boolean(1))
-- =

1.7.2.3


--===============2051278978451211119==--

