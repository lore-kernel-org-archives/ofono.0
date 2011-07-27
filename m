Content-Type: multipart/mixed; boundary="===============2248075775542592081=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4] test: add script to set credentials for cdma connection
Date: Wed, 27 Jul 2011 16:19:29 +0200
Message-ID: <1311776369-23119-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2248075775542592081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am               |    1 +
 test/cdma-set-credentials |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100755 test/cdma-set-credentials

diff --git a/Makefile.am b/Makefile.am
index d44e62b..89190ad 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -528,6 +528,7 @@ test_scripts =3D test/backtrace \
 		test/cdma-list-call \
 		test/cdma-dial-number \
 		test/cdma-hangup \
+		test/cdma-set-credentials \
 		test/disable-call-forwarding \
 		test/list-messages \
 		test/test-sms \
diff --git a/test/cdma-set-credentials b/test/cdma-set-credentials
new file mode 100755
index 0000000..249ac11
--- /dev/null
+++ b/test/cdma-set-credentials
@@ -0,0 +1,28 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+modems =3D manager.GetModems()
+
+for path, properties in modems:
+	if "org.ofono.cdma.ConnectionManager" not in properties["Interfaces"]:
+		continue
+
+	cm =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.cdma.ConnectionManager')
+
+	print "Connecting CDMA Packet Data Service on modem %s..." % path
+
+	if len(sys.argv) > 1:
+		cm.SetProperty("Username", (sys.argv[1]))
+		print "Setting Username to %s" % (sys.argv[1])
+
+	if len(sys.argv) > 2:
+		cm.SetProperty("Password", (sys.argv[2]))
+		print "Setting Password to %s" % (sys.argv[2])
-- =

1.7.1


--===============2248075775542592081==--

