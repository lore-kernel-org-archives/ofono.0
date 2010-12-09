Content-Type: multipart/mixed; boundary="===============4890983951327626821=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/6] test: add scripts for setting frequency band
Date: Thu, 09 Dec 2010 14:43:35 -0200
Message-ID: <1291913020-3103-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4890983951327626821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    4 +++-
 test/set-gsm-band  |   25 +++++++++++++++++++++++++
 test/set-umts-band |   25 +++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletions(-)
 create mode 100755 test/set-gsm-band
 create mode 100755 test/set-umts-band

diff --git a/Makefile.am b/Makefile.am
index cdb3166..881204a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -423,7 +423,9 @@ test_scripts =3D test/backtrace \
 		test/test-push-notification \
 		test/test-smart-messaging \
 		test/send-vcard \
-		test/set-tty
+		test/set-tty \
+		test/set-gsm-band \
+		test/set-umts-band
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/set-gsm-band b/test/set-gsm-band
new file mode 100755
index 0000000..9586d81
--- /dev/null
+++ b/test/set-gsm-band
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
+	band =3D sys.argv[2]
+elif len(sys.argv) =3D=3D 2:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+	band =3D sys.argv[1]
+else:
+	print "%s [PATH] band" % (sys.argv[0])
+	exit(1)
+
+print "Setting gsm band for modem %s..." % path
+radiosettings =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.RadioSettings')
+
+radiosettings.SetProperty("GsmBand", band);
diff --git a/test/set-umts-band b/test/set-umts-band
new file mode 100755
index 0000000..510a40b
--- /dev/null
+++ b/test/set-umts-band
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
+	band =3D sys.argv[2]
+elif len(sys.argv) =3D=3D 2:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+	band =3D sys.argv[1]
+else:
+	print "%s [PATH] band" % (sys.argv[0])
+	exit(1)
+
+print "Setting umts band for modem %s..." % path
+radiosettings =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.RadioSettings')
+
+radiosettings.SetProperty("UmtsBand", band);
-- =

1.7.3.3


--===============4890983951327626821==--

