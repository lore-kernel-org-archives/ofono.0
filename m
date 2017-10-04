Content-Type: multipart/mixed; boundary="===============5039910628080606994=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 6/6] test: add scripts to test ims registration
Date: Wed, 04 Oct 2017 10:37:07 +0530
Message-ID: <1507093627-2118-4-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1507093627-2118-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5039910628080606994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |  4 +++-
 test/ims-register   | 18 ++++++++++++++++++
 test/ims-unregister | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100755 test/ims-register
 create mode 100755 test/ims-unregister

diff --git a/Makefile.am b/Makefile.am
index 1a03229..f4d7df9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -787,7 +787,9 @@ test_scripts =3D test/backtrace \
 		test/enable-throttling \
 		test/disable-throttling \
 		test/set-lte-property \
-		test/test-serving-cell-info
+		test/test-serving-cell-info \
+		test/ims-register \
+		test/ims-unregister
 =

 =

 if TEST
diff --git a/test/ims-register b/test/ims-register
new file mode 100755
index 0000000..017498a
--- /dev/null
+++ b/test/ims-register
@@ -0,0 +1,18 @@
+#!/usr/bin/python3
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+    path =3D sys.argv[1]
+else:
+    manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+                                'org.ofono.Manager')
+    modems =3D manager.GetModems()
+    path =3D modems[0][0]
+
+imsreg =3D dbus.Interface(bus.get_object('org.ofono', path),
+                            'org.ofono.IpMultimediaSystem')
+imsreg.Register()
diff --git a/test/ims-unregister b/test/ims-unregister
new file mode 100755
index 0000000..0644c09
--- /dev/null
+++ b/test/ims-unregister
@@ -0,0 +1,18 @@
+#!/usr/bin/python3
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+    path =3D sys.argv[1]
+else:
+    manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+                                'org.ofono.Manager')
+    modems =3D manager.GetModems()
+    path =3D modems[0][0]
+
+imsreg =3D dbus.Interface(bus.get_object('org.ofono', path),
+                            'org.ofono.IpMultimediaSystem')
+imsreg.Unregister()
-- =

1.9.1


--===============5039910628080606994==--

