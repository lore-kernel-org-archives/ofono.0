Content-Type: multipart/mixed; boundary="===============7314565309576788842=="
MIME-Version: 1.0
From: Ryan M. Raasch <ryan.raasch@gmail.com>
Subject: [PATCH] Added test script to enter pin to sim card.
Date: Tue, 24 Nov 2009 10:46:24 +0100
Message-ID: <1259055984-30527-1-git-send-email-ryan.raasch@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7314565309576788842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/enter-pin.py |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100755 test/enter-pin.py

diff --git a/test/enter-pin.py b/test/enter-pin.py
new file mode 100755
index 0000000..77de93a
--- /dev/null
+++ b/test/enter-pin.py
@@ -0,0 +1,28 @@
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
+path =3D properties["Modems"][0]
+
+if len(path)=3D=3D0:
+    print "No modems found"
+    exit
+
+modem =3D dbus.Interface(bus.get_object('org.ofono', path),
+                       'org.ofono.SimManager')
+properties =3D modem.GetProperties()
+if properties.has_key('PinRequired') and properties['PinRequired'] =3D=3D =
sys.argv[1] :
+    modem.EnterPin(sys.argv[1], sys.argv[2])
+elif properties.has_key('PinRequired') and properties['PinRequired'] =3D=
=3D 'none' :
+    print "Pin not needed"
+elif properties.has_key('PinRequired'):
+    print "Error: Pin type not supported (%s !=3D %s)" % (sys.argv[1],prop=
erties['PinRequired'])
+
+
-- =

1.6.4.GIT


--===============7314565309576788842==--

