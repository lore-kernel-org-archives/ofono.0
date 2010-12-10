Content-Type: multipart/mixed; boundary="===============8638766235160602422=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 3/4 v2] plugins: Test scripts for nettime plugin
Date: Fri, 10 Dec 2010 09:53:57 +0200
Message-ID: <1291967638-12371-4-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1291967638-12371-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8638766235160602422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/get-nettime  |   25 +++++++++++++++++++++++++
 test/test-nettime |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 test/get-nettime
 create mode 100755 test/test-nettime

diff --git a/test/get-nettime b/test/get-nettime
new file mode 100755
index 0000000..39aa232
--- /dev/null
+++ b/test/get-nettime
@@ -0,0 +1,25 @@
+#!/usr/bin/python
+
+import gobject
+import dbus
+import sys
+import time
+import dbus.mainloop.glib
+
+def time_changed( arg ) :
+	print "--time_changed callback called"
+	if "UTC" in arg :
+		print "UTC Time from mobile: %d" % arg["UTC"]
+	print "DST: %d" % arg["DST"]
+	print "Timezone: %d" % arg["Timezone"]
+	print "UTC time is: %d"  % time.time()
+
+bus =3D dbus.SystemBus()
+manager =3D dbus.Interface(bus.get_object('org.ofono','/'), 'org.ofono.Man=
ager')
+path =3D manager.GetModems()[0][0]
+
+modem_proxy =3D bus.get_object('org.ofono', path)
+nettime_iface =3D dbus.Interface(modem_proxy, 'org.ofono.NetworkTime')
+answer =3D nettime_iface.GetNetworkTime()
+time_changed(answer)
+
diff --git a/test/test-nettime b/test/test-nettime
new file mode 100755
index 0000000..c2d533c
--- /dev/null
+++ b/test/test-nettime
@@ -0,0 +1,46 @@
+#!/usr/bin/python
+
+import gobject
+import dbus
+import sys
+import time
+import dbus.mainloop.glib
+
+
+def time_changed( arg ) :
+	print "Time from mobile: %d" % arg["UTC"]
+	print "DST: %d" % arg["DST"]
+	print "Timezone: %d" % arg["Timezone"]
+	print "UTC is: %d"  % time.time()
+
+
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+bus =3D dbus.SystemBus()
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'), 'org.ofono.Ma=
nager')
+modems =3D manager.GetModems()
+path =3D modems[0][0]
+
+print "Connecting modem %s..." % path
+modem =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.Modem')
+
+print "Powering up modem %s..." % (path)
+modem.SetProperty("Powered", dbus.Boolean(1))
+
+print "Go Online modem %s..." % (path)
+modem.SetProperty("Online", dbus.Boolean(1))
+print "Go Offline modem %s..." % (path)
+modem.SetProperty("Online", dbus.Boolean(0))
+print "Go Online modem %s..." % (path)
+modem.SetProperty("Online", dbus.Boolean(1))
+
+nettime =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.NetworkTime')
+nettime.connect_to_signal("NetworkTimeChanged", time_changed)
+
+mainloop =3D gobject.MainLoop()
+mainloop.run()
+
+
+
-- =

1.7.1


--===============8638766235160602422==--

