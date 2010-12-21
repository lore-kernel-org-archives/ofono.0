Content-Type: multipart/mixed; boundary="===============0161034802758429910=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH] test: Add script to turn ON/OFF GPS
Date: Tue, 21 Dec 2010 11:13:12 -0300
Message-ID: <1292940792-6503-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0161034802758429910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am  |    3 ++-
 test/set-gps |   29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletions(-)
 create mode 100644 test/set-gps

diff --git a/Makefile.am b/Makefile.am
index 12b3c33..cf678ec 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -423,7 +423,8 @@ test_scripts =3D test/backtrace \
 		test/test-push-notification \
 		test/test-smart-messaging \
 		test/send-vcard \
-		test/set-tty
+		test/set-tty \
+		test/set-gps
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/set-gps b/test/set-gps
new file mode 100644
index 0000000..5e38cae
--- /dev/null
+++ b/test/set-gps
@@ -0,0 +1,29 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 3:
+	path =3D sys.argv[1]
+	power =3D int(sys.argv[2])
+elif len(sys.argv) =3D=3D 2:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+	power =3D int(sys.argv[1])
+else:
+	print "%s [PATH] {0|1}" % (sys.argv[0])
+	exit(1)
+
+if power > 0:
+	print "Turning ON GPS for modem %s..." % path
+else:
+	print "Turning OFF GPS for modem %s..." % path
+
+gps =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.Gps')
+
+gps.SetProperty("Powered", dbus.Boolean(power));
-- =

1.7.2.3


--===============0161034802758429910==--

