Content-Type: multipart/mixed; boundary="===============2538329651137547037=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 3/3] nettime: Mock Timed for testing
Date: Wed, 09 Feb 2011 21:12:51 +0200
Message-ID: <1297278771-14468-4-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1297278771-14468-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2538329651137547037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-nettime |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100755 test/test-nettime

diff --git a/test/test-nettime b/test/test-nettime
new file mode 100755
index 0000000..acdd167
--- /dev/null
+++ b/test/test-nettime
@@ -0,0 +1,35 @@
+#!/usr/bin/python
+
+import gobject
+import dbus
+import sys
+import time
+import dbus.service
+import dbus.mainloop.glib
+
+
+class NetworkTime(dbus.service.Object):
+	def __init__(self):
+		busName =3D dbus.service.BusName('com.meego.timed',
+					bus =3D dbus.SystemBus())
+		dbus.service.Object.__init__(self, busName, '/com/meego/timed')
+	@dbus.service.method(dbus_interface=3D"com.meego.NetworkTime",
+					in_signature=3D"a{sv}", out_signature=3D"")
+	def Notify(self, arg):
+		print arg
+		print
+		print "Time from mobile: %d" % arg["UTC"]
+		print "DST: %d" % arg["DST"]
+		print "Timezone: %d" % arg["Timezone"]
+		print "MNC: %s" % arg["MobileNetworkCode"]
+		print "MCC: %s" % arg["MobileCountryCode"]
+
+if __name__ =3D=3D '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+	agent =3D NetworkTime()
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
+
+
+
-- =

1.7.1


--===============2538329651137547037==--

