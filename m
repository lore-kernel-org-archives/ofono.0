Content-Type: multipart/mixed; boundary="===============0683127553204248575=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] test: Rename script hangup-active to hangup
Date: Mon, 30 Jul 2012 17:45:08 +0200
Message-ID: <1343663109-5542-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0683127553204248575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    2 +-
 test/hangup        |   29 +++++++++++++++++++++++++++++
 test/hangup-active |   29 -----------------------------
 3 files changed, 30 insertions(+), 30 deletions(-)
 create mode 100755 test/hangup
 delete mode 100755 test/hangup-active

diff --git a/Makefile.am b/Makefile.am
index 4410043..a3681c3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -554,7 +554,7 @@ test_scripts =3D test/backtrace \
 		test/enter-pin \
 		test/reset-pin \
 		test/hangup-all \
-		test/hangup-active \
+		test/hangup \
 		test/set-mms-details \
 		test/set-roaming-allowed \
 		test/list-contexts \
diff --git a/test/hangup b/test/hangup
new file mode 100755
index 0000000..6444b23
--- /dev/null
+++ b/test/hangup
@@ -0,0 +1,29 @@
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
+modems =3D manager.GetModems()
+path =3D modems[0][0]
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.VoiceCallManager')
+
+calls =3D manager.GetCalls()
+
+for path, properties in calls:
+		state =3D properties["State"]
+		print "[ %s ] %s" % (path, state)
+
+		if state !=3D "active":
+			continue
+
+		call =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.VoiceCall')
+
+		call.Hangup()
diff --git a/test/hangup-active b/test/hangup-active
deleted file mode 100755
index 6444b23..0000000
--- a/test/hangup-active
+++ /dev/null
@@ -1,29 +0,0 @@
-#!/usr/bin/python
-
-import sys
-import dbus
-
-bus =3D dbus.SystemBus()
-
-manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
-
-modems =3D manager.GetModems()
-path =3D modems[0][0]
-
-manager =3D dbus.Interface(bus.get_object('org.ofono', path),
-						'org.ofono.VoiceCallManager')
-
-calls =3D manager.GetCalls()
-
-for path, properties in calls:
-		state =3D properties["State"]
-		print "[ %s ] %s" % (path, state)
-
-		if state !=3D "active":
-			continue
-
-		call =3D dbus.Interface(bus.get_object('org.ofono', path),
-						'org.ofono.VoiceCall')
-
-		call.Hangup()
-- =

1.7.5.4


--===============0683127553204248575==--

