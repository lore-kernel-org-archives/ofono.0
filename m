Content-Type: multipart/mixed; boundary="===============6593681667542921413=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 7/7] test: Add test-history script
Date: Thu, 19 Apr 2012 11:20:56 +0300
Message-ID: <1334823656-3366-8-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334823656-3366-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6593681667542921413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-history |   71 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 test/test-history

diff --git a/test/test-history b/test/test-history
new file mode 100755
index 0000000..c93c816
--- /dev/null
+++ b/test/test-history
@@ -0,0 +1,71 @@
+#!/usr/bin/python
+
+import gobject
+import sys
+
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+HISTORY_INTERFACE =3D "org.ofono.History"
+AGENT_INTERFACE =3D "org.ofono.HistoryAgent"
+
+def print_data(data):
+	print "%s()" % sys._getframe(1).f_code.co_name
+	for key in data.keys():
+		print "\t%-10s %s" % (key, data[key])
+
+class HistoryAgent(dbus.service.Object):
+	@dbus.service.method(AGENT_INTERFACE)
+	def Release(self):
+		print "Release()"
+		mainloop.quit()
+
+	@dbus.service.method(AGENT_INTERFACE, in_signature=3D"a{sv}")
+	def CallEnded(self, data):
+		print_data(data)
+
+	@dbus.service.method(AGENT_INTERFACE, in_signature=3D"a{sv}")
+	def CallMissed(self, data):
+		print_data(data)
+
+	@dbus.service.method(AGENT_INTERFACE, in_signature=3D"a{sv}")
+	def MessageReceived(self, data):
+		print_data(data)
+
+	@dbus.service.method(AGENT_INTERFACE, in_signature=3D"a{sv}")
+	def MessageSubmitted(self, data):
+		print_data(data)
+
+	@dbus.service.method(AGENT_INTERFACE, in_signature=3D"a{sv}")
+	def MessageStatus(self, data):
+		print_data(data)
+
+if __name__ =3D=3D '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+	bus =3D dbus.SystemBus()
+	manager =3D dbus.Interface(bus.get_object("org.ofono", "/"),
+			"org.ofono.Manager")
+
+	modems =3D manager.GetModems()
+	for path, properties in modems:
+		if HISTORY_INTERFACE not in properties["Interfaces"]:
+			continue
+
+		history =3D dbus.Interface(bus.get_object("org.ofono", path),
+					HISTORY_INTERFACE)
+
+	path =3D "/test/history"
+	agent =3D HistoryAgent(bus, path)
+
+	history.RegisterAgent(path)
+	print "HistoryAgent registered"
+
+	mainloop =3D gobject.MainLoop()
+
+	try:
+		mainloop.run()
+	except KeyboardInterrupt:
+		history.UnregisterAgent(path)
+		mainloop.quit()
+
-- =

1.7.5.4


--===============6593681667542921413==--

