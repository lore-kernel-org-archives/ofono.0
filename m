Content-Type: multipart/mixed; boundary="===============4290865312484481205=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 4/6] test: add script to control fast dormancy
Date: Tue, 26 Oct 2010 18:31:51 +0300
Message-ID: <1288107113-2740-5-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288107113-2740-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4290865312484481205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am            |    3 ++-
 test/set-fast-dormancy |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)
 create mode 100755 test/set-fast-dormancy

diff --git a/Makefile.am b/Makefile.am
index 17797ae..5a541c7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -410,7 +410,8 @@ test_scripts =3D test/backtrace \
 		test/enable-gprs \
 		test/disable-gprs \
 		test/get-icon \
-		test/deactivate-all
+		test/deactivate-all \
+		test/set-fast-dormancy
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/set-fast-dormancy b/test/set-fast-dormancy
new file mode 100755
index 0000000..6951813
--- /dev/null
+++ b/test/set-fast-dormancy
@@ -0,0 +1,25 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 3:
+	path =3D sys.argv[1]
+	enable =3D int(sys.argv[2])
+elif len(sys.argv) =3D=3D 2:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+	enable =3D int(sys.argv[1])
+else:
+	print "%s [PATH] {0|1}" % (sys.argv[0])
+	exit(1)
+
+print "Setting fast dormancy for modem %s..." % path
+radiosettings =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.RadioSettings')
+
+radiosettings.SetProperty("FastDormancy", dbus.Boolean(enable));
-- =

1.7.0.4


--===============4290865312484481205==--

