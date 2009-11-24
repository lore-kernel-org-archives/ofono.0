Content-Type: multipart/mixed; boundary="===============4526418809905978792=="
MIME-Version: 1.0
From: Ryan M. Raasch <ryan.raasch@gmail.com>
Subject: [PATCH] Added test script to unlock sim card (revised).
Date: Tue, 24 Nov 2009 13:35:42 +0100
Message-ID: <1259066142-4601-1-git-send-email-ryan.raasch@gmail.com>
In-Reply-To: <1259059544.2967.33.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4526418809905978792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am     |    3 ++-
 test/unlock-sim |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)
 create mode 100755 test/unlock-sim

diff --git a/Makefile.am b/Makefile.am
index 4b0d7e8..2420c2c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -242,7 +242,8 @@ test_files =3D test/test-manager test/test-modem test/t=
est-voicecall \
 		test/receive-sms test/send-sms \
 		test/list-contexts test/create-context \
 		test/activate-context test/deactivate-context \
-		test/process-context-settings
+		test/process-context-settings \
+		test/unlock-sim
 =

 conf_files =3D src/ofono.conf plugins/modem.conf
 =

diff --git a/test/unlock-sim b/test/unlock-sim
new file mode 100755
index 0000000..38ae38d
--- /dev/null
+++ b/test/unlock-sim
@@ -0,0 +1,25 @@
+#!/usr/bin/env python
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+                         'org.ofono.Manager')
+
+properties =3D manager.GetProperties()
+
+try:
+    path =3D properties["Modems"][0]
+except:
+    print "No modems found "
+    sys.exit(2)
+
+modem =3D dbus.Interface(bus.get_object('org.ofono', path),
+                    'org.ofono.SimManager')
+properties =3D modem.GetProperties()
+
+try:
+    modem.EnterPin(properties['PinRequired'], sys.argv[1])
+except:
+    print "PinRequried =3D %s " % properties['PinRequired']
-- =

1.6.4.GIT


--===============4526418809905978792==--

