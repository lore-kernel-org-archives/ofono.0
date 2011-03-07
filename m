Content-Type: multipart/mixed; boundary="===============2812215211742412491=="
MIME-Version: 1.0
From: Miia Leinonen <miia.leinonen@tieto.com>
Subject: [PATCH 2/2] test: Restructure CBS tests
Date: Mon, 07 Mar 2011 13:33:03 +0200
Message-ID: <1299497583-29072-2-git-send-email-miia.leinonen@tieto.com>
In-Reply-To: <1299497583-29072-1-git-send-email-miia.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2812215211742412491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove old CBS test scripts.

---
 Makefile.am         |    2 --
 test/enable-cbs     |   20 --------------------
 test/set-cbs-topics |   24 ------------------------
 3 files changed, 0 insertions(+), 46 deletions(-)
 delete mode 100755 test/enable-cbs
 delete mode 100755 test/set-cbs-topics

diff --git a/Makefile.am b/Makefile.am
index 029b87f..71edcda 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -481,8 +481,6 @@ test_scripts =3D test/backtrace \
 		test/get-tech-preference \
 		test/set-tech-preference \
 		test/set-use-sms-reports \
-		test/set-cbs-topics \
-		test/enable-cbs \
 		test/lock-pin \
 		test/unlock-pin \
 		test/enable-gprs \
diff --git a/test/enable-cbs b/test/enable-cbs
deleted file mode 100755
index 9b5b57b..0000000
--- a/test/enable-cbs
+++ /dev/null
@@ -1,20 +0,0 @@
-#!/usr/bin/python
-
-import dbus
-import sys
-
-bus =3D dbus.SystemBus()
-
-if len(sys.argv) =3D=3D 2:
-	path =3D sys.argv[1]
-else:
-	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
-	modems =3D manager.GetModems()
-	path =3D modems[0][0]
-
-print "Enabling cell broadcast on modem %s..." % path
-cbs =3D dbus.Interface(bus.get_object('org.ofono', path),
-					'org.ofono.CellBroadcast')
-
-cbs.SetProperty("Powered", dbus.Boolean(1))
diff --git a/test/set-cbs-topics b/test/set-cbs-topics
deleted file mode 100755
index fbf7aa4..0000000
--- a/test/set-cbs-topics
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/usr/bin/python
-
-import dbus
-import sys
-
-bus =3D dbus.SystemBus()
-
-if len(sys.argv) =3D=3D 3:
-	path =3D sys.argv[1]
-	topics =3D sys.argv[2]
-elif len(sys.argv) =3D=3D 2:
-	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
-	modems =3D manager.GetModems()
-	path =3D modems[0][0]
-	topics =3D sys.argv[1]
-else:
-	print "%s [PATH] topics" % (sys.argv[0])
-
-print "Setting cell broadcast topics for modem %s..." % path
-cbs =3D dbus.Interface(bus.get_object('org.ofono', path),
-					'org.ofono.CellBroadcast')
-
-cbs.SetProperty("Topics", topics);
-- =

1.7.1


--===============2812215211742412491==--

