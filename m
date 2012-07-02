Content-Type: multipart/mixed; boundary="===============4521251096387127319=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/2] test-ussd becomes send-ussd
Date: Mon, 02 Jul 2012 17:45:23 +0200
Message-ID: <1341243924-9257-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4521251096387127319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/send-ussd |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 test/test-ussd |   75 ----------------------------------------------------=
----
 2 files changed, 75 insertions(+), 75 deletions(-)
 create mode 100755 test/send-ussd
 delete mode 100755 test/test-ussd

diff --git a/test/send-ussd b/test/send-ussd
new file mode 100755
index 0000000..c21f5e3
--- /dev/null
+++ b/test/send-ussd
@@ -0,0 +1,75 @@
+#!/usr/bin/python
+
+import sys
+import gobject
+import os
+
+import dbus
+import dbus.mainloop.glib
+
+state =3D None
+
+def ussd_notification_received(content):
+	print("Network sent a Notification: " + content)
+
+def ussd_request_received(content):
+	print("Network sent a Request: " + content)
+	ss.Cancel()
+
+def ussd_property_changed(name, value):
+	global state
+	if name !=3D "State":
+		return
+	print("USSD session state is " + value)
+	state =3D str(value)
+
+def stdin_handler(fd, condition):
+	s =3D os.read(fd.fileno(), 160).rstrip()
+	if not s:
+		ss.Cancel()
+	elif state =3D=3D "user-response":
+		print ss.Respond(s, timeout =3D 100)
+	elif state =3D=3D "idle":
+		print ss.Initiate(s, timeout =3D 100)
+	else:
+		print "Invalid state", state
+	return True
+
+if __name__ =3D=3D "__main__":
+	if (len(sys.argv) < 2):
+		print "Usage: %s [modem] <ussd-string>" % (sys.argv[0])
+		sys.exit(1)
+
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+							'org.ofono.Manager')
+
+	modems =3D manager.GetModems()
+	modem =3D modems[0][0]
+
+	if (len(sys.argv) =3D=3D 2):
+		ussd =3D sys.argv[1]
+	else:
+		modem =3D sys.argv[1]
+		ussd =3D sys.argv[2]
+
+	ss =3D dbus.Interface(bus.get_object('org.ofono', modem),
+					'org.ofono.SupplementaryServices')
+
+	props =3D ss.GetProperties()
+	for p in props:
+		ussd_property_changed(p, props[p])
+
+	ss.connect_to_signal("NotificationReceived", ussd_notification_received)
+	ss.connect_to_signal("RequestReceived", ussd_request_received)
+	ss.connect_to_signal("PropertyChanged", ussd_property_changed)
+
+	print ss.Initiate(ussd, timeout=3D100)
+
+	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler)
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
diff --git a/test/test-ussd b/test/test-ussd
deleted file mode 100755
index c21f5e3..0000000
--- a/test/test-ussd
+++ /dev/null
@@ -1,75 +0,0 @@
-#!/usr/bin/python
-
-import sys
-import gobject
-import os
-
-import dbus
-import dbus.mainloop.glib
-
-state =3D None
-
-def ussd_notification_received(content):
-	print("Network sent a Notification: " + content)
-
-def ussd_request_received(content):
-	print("Network sent a Request: " + content)
-	ss.Cancel()
-
-def ussd_property_changed(name, value):
-	global state
-	if name !=3D "State":
-		return
-	print("USSD session state is " + value)
-	state =3D str(value)
-
-def stdin_handler(fd, condition):
-	s =3D os.read(fd.fileno(), 160).rstrip()
-	if not s:
-		ss.Cancel()
-	elif state =3D=3D "user-response":
-		print ss.Respond(s, timeout =3D 100)
-	elif state =3D=3D "idle":
-		print ss.Initiate(s, timeout =3D 100)
-	else:
-		print "Invalid state", state
-	return True
-
-if __name__ =3D=3D "__main__":
-	if (len(sys.argv) < 2):
-		print "Usage: %s [modem] <ussd-string>" % (sys.argv[0])
-		sys.exit(1)
-
-	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
-
-	bus =3D dbus.SystemBus()
-
-	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-							'org.ofono.Manager')
-
-	modems =3D manager.GetModems()
-	modem =3D modems[0][0]
-
-	if (len(sys.argv) =3D=3D 2):
-		ussd =3D sys.argv[1]
-	else:
-		modem =3D sys.argv[1]
-		ussd =3D sys.argv[2]
-
-	ss =3D dbus.Interface(bus.get_object('org.ofono', modem),
-					'org.ofono.SupplementaryServices')
-
-	props =3D ss.GetProperties()
-	for p in props:
-		ussd_property_changed(p, props[p])
-
-	ss.connect_to_signal("NotificationReceived", ussd_notification_received)
-	ss.connect_to_signal("RequestReceived", ussd_request_received)
-	ss.connect_to_signal("PropertyChanged", ussd_property_changed)
-
-	print ss.Initiate(ussd, timeout=3D100)
-
-	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler)
-
-	mainloop =3D gobject.MainLoop()
-	mainloop.run()
-- =

1.7.9.5


--===============4521251096387127319==--

