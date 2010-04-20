Content-Type: multipart/mixed; boundary="===============6207632531632885893=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] Add script for entering pin
Date: Tue, 20 Apr 2010 14:06:32 +0200
Message-ID: <20100420120632.GA26491@aao-dell.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6207632531632885893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 I found this script helpful during debugging. Feel free to add.

 test/enter-pin |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100755 test/enter-pin

diff --git a/test/enter-pin b/test/enter-pin
new file mode 100755
index 0000000..792b6b2
--- /dev/null
+++ b/test/enter-pin
@@ -0,0 +1,26 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 4:
+	path =3D sys.argv[1]
+	pin_type =3D sys.argv[2]
+	pin =3D sys.argv[3]
+elif len(sys.argv) =3D=3D 3:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+				 'org.ofono.Manager')
+	properties =3D manager.GetProperties()
+	path =3D properties["Modems"][0]
+	pin_type =3D sys.argv[1]
+	pin =3D sys.argv[2]
+else:
+	print "%s [PATH] pin_type pin" % (sys.argv[0])
+
+print "Enter Pin for modem %s..." % path
+simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
+			    'org.ofono.SimManager')
+
+simmanager.EnterPin(pin_type, pin)
-- =

1.6.6.1


--===============6207632531632885893==--

