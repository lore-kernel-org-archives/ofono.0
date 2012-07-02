Content-Type: multipart/mixed; boundary="===============1120424188028102421=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/2] test-ussd: new script more generic
Date: Mon, 02 Jul 2012 17:45:24 +0200
Message-ID: <1341243924-9257-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1341243924-9257-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1120424188028102421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This script can be used to handle network initiated USSD without
preliminary USSD request.
---
 test/test-ussd |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 97 insertions(+)
 create mode 100755 test/test-ussd

diff --git a/test/test-ussd b/test/test-ussd
new file mode 100755
index 0000000..f1d8215
--- /dev/null
+++ b/test/test-ussd
@@ -0,0 +1,97 @@
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
+def clear_screen(numlines=3D100):
+	import os
+	if os.name =3D=3D "posix":
+		os.system('clear')
+
+	elif os.name in ("nt", "dos", "ce"):
+		os.system('CLS')
+
+	else:
+		print '\n' * numlines
+
+def print_menu():
+	if state =3D=3D "user-response":
+		print "\n\nEnter response (c for cancel - x for exit):"
+	elif state =3D=3D "idle":
+		print "\n\nEnter USSD request (x for exit):"
+
+def ussd_notification_received(content):
+	clear_screen()
+	print("Network sent a Notification: " + content)
+	print_menu()
+
+def ussd_request_received(content):
+	clear_screen()
+	print("Network sent a Request: " + content)
+
+def ussd_property_changed(name, value):
+	global state
+	if name !=3D "State":
+		return
+	print("USSD session state is " + value)
+	state =3D str(value)
+
+	print_menu()
+
+def stdin_handler(fd, condition):
+	s =3D os.read(fd.fileno(), 182).rstrip()
+
+	if s =3D=3D 'c':
+		if state =3D=3D "user-response" or state =3D=3D 'active':
+			ss.Cancel()
+	elif s =3D=3D 'x':
+		sys.exit()
+	elif state =3D=3D "user-response":
+		print ss.Respond(s, timeout =3D 100)
+	elif state =3D=3D "idle":
+		print ss.Initiate(s, timeout =3D 100)
+	else:
+		print "Invalid state", state
+	return True
+
+if __name__ =3D=3D "__main__":
+	if (len(sys.argv) >2 or (len(sys.argv) =3D=3D 2 and
+			sys.argv[1] in ("-h", "--help"))):
+		print "Usage: %s [-h] [modem]" % (sys.argv[0])
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
+
+	if (len(sys.argv) =3D=3D 2):
+		modem =3D sys.argv[1]
+	else:
+		modem =3D modems[0][0]
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
+	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler)
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
-- =

1.7.9.5


--===============1120424188028102421==--

