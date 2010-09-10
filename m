Content-Type: multipart/mixed; boundary="===============8672393696973398387=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 4/4] test: add enable-gprs and disable-gprs scripts
Date: Fri, 10 Sep 2010 16:50:59 +0300
Message-ID: <1284126659-18741-5-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1284126659-18741-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8672393696973398387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/disable-gprs |   20 ++++++++++++++++++++
 test/enable-gprs  |   20 ++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100755 test/disable-gprs
 create mode 100755 test/enable-gprs

diff --git a/test/disable-gprs b/test/disable-gprs
new file mode 100755
index 0000000..cca2c78
--- /dev/null
+++ b/test/disable-gprs
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
+print "Disconnecting GPRS on modem %s..." % path
+cm =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.ConnectionManager')
+
+cm.SetProperty("Powered", dbus.Boolean(0))
diff --git a/test/enable-gprs b/test/enable-gprs
new file mode 100755
index 0000000..2b273a7
--- /dev/null
+++ b/test/enable-gprs
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
+print "Connecting modem %s..." % path
+cm =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.ConnectionManager')
+
+cm.SetProperty("Powered", dbus.Boolean(1))
-- =

1.7.0.4


--===============8672393696973398387==--

