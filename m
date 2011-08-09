Content-Type: multipart/mixed; boundary="===============8274495006305786923=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 3/3] test: Add cdma-remove-credentials script
Date: Tue, 09 Aug 2011 16:48:07 +0200
Message-ID: <1312901287-30032-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1312901287-30032-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8274495006305786923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                  |    1 +
 test/cdma-remove-credentials |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100755 test/cdma-remove-credentials

diff --git a/Makefile.am b/Makefile.am
index 62174db..eec08d8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -544,6 +544,7 @@ test_scripts =3D test/backtrace \
 		test/cdma-dial-number \
 		test/cdma-hangup \
 		test/cdma-set-credentials \
+		test/cdma-remove-credentials \
 		test/disable-call-forwarding \
 		test/list-messages \
 		test/test-sms \
diff --git a/test/cdma-remove-credentials b/test/cdma-remove-credentials
new file mode 100755
index 0000000..28bc128
--- /dev/null
+++ b/test/cdma-remove-credentials
@@ -0,0 +1,21 @@
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
+	cm.RemoveCredentials()
+	print "Removing all credentials"
-- =

1.7.1


--===============8274495006305786923==--

