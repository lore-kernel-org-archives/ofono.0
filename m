Content-Type: multipart/mixed; boundary="===============3378894707358660652=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 12/12] test: add test-gnss
Date: Fri, 11 Mar 2011 14:23:09 +0200
Message-ID: <1299846189-15132-13-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1299846189-15132-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3378894707358660652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |    3 +-
 test/test-gnss |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 93 insertions(+), 1 deletions(-)
 create mode 100755 test/test-gnss

diff --git a/Makefile.am b/Makefile.am
index 3dae7f4..daa5dd0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -503,7 +503,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-hangup \
 		test/disable-call-forwarding \
 		test/list-messages \
-		test/test-sms
+		test/test-sms \
+		test/test-gnss
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/test-gnss b/test/test-gnss
new file mode 100755
index 0000000..d7d9027
--- /dev/null
+++ b/test/test-gnss
@@ -0,0 +1,91 @@
+#!/usr/bin/python
+
+import gobject
+import sys
+import os
+
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+class PositioningAgent(dbus.service.Object):
+	@dbus.service.method("org.ofono.PositioningRequestAgent",
+					in_signature=3D"", out_signature=3D"")
+	def Release(self):
+		print "Release"
+		mainloop.quit()
+
+	@dbus.service.method("org.ofono.PositioningRequestAgent",
+					in_signature=3D"s", out_signature=3D"")
+	def Request(self, xml):
+		print "positioning data: %s" % (xml)
+
+	@dbus.service.method("org.ofono.PositioningRequestAgent",
+					in_signature=3D"", out_signature=3D"")
+	def ResetAssistanceData(self):
+		print "Reset Assistance Data request received"
+
+def print_menu():
+	print "Select test case"
+	print "-----------------------------------------------------------"
+	print "[0] SendPositioningElement"
+	print "[1] RegisterPositioningRequestAgent"
+	print "[2] UnregisterPositioningRequestAgent"
+	print "[x] Exit"
+	print "-----------------------------------------------------------"
+
+def stdin_handler(fd, condition, positioning, path):
+
+	in_key =3D os.read(fd.fileno(), 8).rstrip()
+	if in_key =3D=3D '0':
+		xml =3D raw_input('type the element and press enter: ')
+		try:
+			positioning.SendPositioningElement(dbus.String(xml))
+			print "ok"
+		except dbus.DBusException, e:
+			print "Unable to send positioning element"
+
+	elif in_key =3D=3D '1':
+		try:
+			positioning.RegisterPositioningRequestAgent("/test/posagent")
+			print "ok"
+		except dbus.DBusException, e:
+			print "Unable to register positioning agent"
+
+	elif in_key =3D=3D '2':
+		try:
+			positioning.UnregisterPositioningRequestAgent(path)
+			print "ok"
+		except dbus.DBusException, e:
+			print "Unable to unregister positioning agent"
+	elif in_key =3D=3D 'x':
+		sys.exit(1)
+
+	return True
+
+if __name__ =3D=3D "__main__":
+
+	if len(sys.argv) < 1:
+		sys.exit(1)
+
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+	bus =3D dbus.SystemBus()
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+							'org.ofono.Manager')
+
+	modems =3D manager.GetModems()
+	for path, properties in modems:
+		if "org.ofono.AssistedSatelliteNavigation" not in properties["Interfaces=
"]:
+			continue
+
+		positioning =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.AssistedSatelliteNavigation')
+
+	path =3D "/test/posagent"
+	agent =3D PositioningAgent(bus, path)
+
+	print_menu()
+
+	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler, positioning=
, path)
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
-- =

1.7.0.4


--===============3378894707358660652==--

