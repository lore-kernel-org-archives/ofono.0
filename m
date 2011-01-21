Content-Type: multipart/mixed; boundary="===============3667740854851793038=="
MIME-Version: 1.0
From: christian.lam@nokia.com
Subject: [PATCH 6/7] test: add CDMA Connection Manager support scripts
Date: Fri, 21 Jan 2011 15:06:49 -0800
Message-ID: <1295651210-22922-7-git-send-email-christian.lam@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3667740854851793038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christian Lam <christian.lam@nokia.com>

---
 test/disable-cdma-connman |   20 ++++++++++++++++++++
 test/enable-cdma-connman  |   20 ++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100755 test/disable-cdma-connman
 create mode 100755 test/enable-cdma-connman

diff --git a/test/disable-cdma-connman b/test/disable-cdma-connman
new file mode 100755
index 0000000..a1c9568
--- /dev/null
+++ b/test/disable-cdma-connman
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print "Disconnecting CDMA Packet Data Service on modem %s..." % path
+cm =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.cdma.ConnectionManager')
+
+cm.SetProperty("Powered", dbus.Boolean(0))
diff --git a/test/enable-cdma-connman b/test/enable-cdma-connman
new file mode 100755
index 0000000..699240d
--- /dev/null
+++ b/test/enable-cdma-connman
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print "Connecting CDMA Packet Data Service on modem %s..." % path
+cm =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.cdma.ConnectionManager')
+
+cm.SetProperty("Powered", dbus.Boolean(1))
-- =

1.7.0.4


--===============3667740854851793038==--

