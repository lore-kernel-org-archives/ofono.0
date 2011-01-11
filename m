Content-Type: multipart/mixed; boundary="===============0500391634252262706=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v5, 2/5] test: Add CDMA MO Call Support
Date: Mon, 10 Jan 2011 17:45:29 -0800
Message-ID: <1294710332-6028-3-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0500391634252262706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    5 ++++-
 test/cdma-dial-number |   25 +++++++++++++++++++++++++
 test/cdma-hangup      |   20 ++++++++++++++++++++
 test/cdma-list-call   |   31 +++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 1 deletions(-)
 create mode 100755 test/cdma-dial-number
 create mode 100755 test/cdma-hangup
 create mode 100755 test/cdma-list-call

diff --git a/Makefile.am b/Makefile.am
index 5f54efe..7bced88 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -445,7 +445,10 @@ test_scripts =3D test/backtrace \
 		test/set-tty \
 		test/set-gsm-band \
 		test/set-umts-band \
-		test/lockdown-modem
+		test/lockdown-modem \
+		test/cdma-list-call \
+		test/cdma-dial-number \
+		test/cdma-hangup
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/cdma-dial-number b/test/cdma-dial-number
new file mode 100755
index 0000000..0b3693e
--- /dev/null
+++ b/test/cdma-dial-number
@@ -0,0 +1,25 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+if len(sys.argv) > 2:
+	path =3D sys.argv[1]
+	number =3D sys.argv[2]
+else:
+	modems =3D manager.GetModems()
+	path, properties =3D modems[0]
+	number =3D sys.argv[1]
+
+print "Using modem %s" % path
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.cdma.VoiceCallManager')
+
+manager.Dial(number)
+
diff --git a/test/cdma-hangup b/test/cdma-hangup
new file mode 100755
index 0000000..f8e631e
--- /dev/null
+++ b/test/cdma-hangup
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+if len(sys.argv) > 2:
+	path =3D sys.argv[1]
+else:
+	modems =3D manager.GetModems()
+	path, properties =3D modems[0]
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.cdma.VoiceCallManager')
+
+manager.Hangup()
diff --git a/test/cdma-list-call b/test/cdma-list-call
new file mode 100755
index 0000000..8a2e04e
--- /dev/null
+++ b/test/cdma-list-call
@@ -0,0 +1,31 @@
+#!/usr/bin/python
+
+import dbus
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+modems =3D manager.GetModems()
+
+for path, properties in modems:
+	print "[ %s ]" % (path)
+
+	if "org.ofono.cdma.VoiceCallManager" not in properties["Interfaces"]:
+		continue
+
+	mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.cdma.VoiceCallManager')
+
+	properties =3D mgr.GetProperties()
+
+	for key in properties.keys():
+		if key in ["Interfaces", "Features"]:
+			val =3D ""
+			for i in properties[key]:
+				val +=3D i + " "
+		else:
+			val =3D str(properties[key])
+		print "    %s =3D %s" % (key, val)
+
-- =

1.7.0.4


--===============0500391634252262706==--

