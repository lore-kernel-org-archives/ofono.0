Content-Type: multipart/mixed; boundary="===============5974298665902027497=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2] test-ussd becomes send-ussd This script can be used to
 handle network initiated USSDs
Date: Thu, 26 Jul 2012 17:57:54 +0200
Message-ID: <1343318274-19845-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1343318274-19845-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5974298665902027497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |    2 +-
 test/send-ussd |   57 ++++++++++++++++++++++++++++++++++++++++++
 test/test-ussd |   75 ----------------------------------------------------=
----
 3 files changed, 58 insertions(+), 76 deletions(-)
 create mode 100755 test/send-ussd
 delete mode 100755 test/test-ussd

diff --git a/Makefile.am b/Makefile.am
index e012d3f..b35cf1f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -583,7 +583,7 @@ test_scripts =3D test/backtrace \
 		test/test-ss-control-cf \
 		test/test-ss-control-cs \
 		test/test-voicecall \
-		test/test-ussd \
+		test/send-ussd \
 		test/cancel-ussd \
 		test/initiate-ussd \
 		test/offline-modem \
diff --git a/test/send-ussd b/test/send-ussd
new file mode 100755
index 0000000..fcabd21
--- /dev/null
+++ b/test/send-ussd
@@ -0,0 +1,57 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+if (len(sys.argv) < 2):
+	print "Usage: %s [modem] <ussd-string>" % (sys.argv[0])
+	sys.exit(1)
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+modems =3D manager.GetModems()
+
+if (len(sys.argv) =3D=3D 2):
+	path =3D modems[0][0]
+	ussdstring =3D sys.argv[1]
+else:
+	path =3D sys.argv[1]
+	ussdstring =3D sys.argv[2]
+
+ussd =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.SupplementaryServices')
+
+properties =3D ussd.GetProperties()
+state =3D properties["State"]
+
+print "State: %s" % (state)
+
+if state =3D=3D "idle":
+	result =3D ussd.Initiate(ussdstring, timeout=3D100)
+	print result[0] + ": " + result[1]
+elif state =3D=3D "user-response":
+	print ussd.Respond(ussdstring, timeout=3D100)
+else:
+	sys.exit(1);
+
+properties =3D ussd.GetProperties()
+state =3D properties["State"]
+
+if state =3D=3D "idle":
+	sys.exit(0)
+
+print "State: %s" % (state)
+
+while state =3D=3D "user-response":
+	response =3D raw_input("Enter response: ")
+
+	print ussd.Respond(response, timeout=3D100)
+
+	properties =3D ussd.GetProperties()
+	state =3D properties["State"]
+
+	if state !=3D "idle":
+		print "State: %s" % (state)
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


--===============5974298665902027497==--

