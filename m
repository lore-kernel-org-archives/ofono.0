Content-Type: multipart/mixed; boundary="===============7959674773145947053=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v3 6/7] gps: add test script
Date: Wed, 26 Jan 2011 12:32:53 -0300
Message-ID: <1296055974-9640-7-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1296055974-9640-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7959674773145947053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                  |    3 +-
 test/test-location-reporting |   49 ++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 51 insertions(+), 1 deletions(-)
 create mode 100755 test/test-location-reporting

diff --git a/Makefile.am b/Makefile.am
index 4c00f16..49bf8f3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -472,7 +472,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-list-call \
 		test/cdma-dial-number \
 		test/cdma-hangup \
-		test/disable-call-forwarding
+		test/disable-call-forwarding \
+		test/test-location-reporting
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/test-location-reporting b/test/test-location-reporting
new file mode 100755
index 0000000..fe478c6
--- /dev/null
+++ b/test/test-location-reporting
@@ -0,0 +1,49 @@
+#!/usr/bin/python
+
+import gobject
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+class LocationReportingAgent(dbus.service.Object):
+	@dbus.service.method("org.ofono.LocationReportingAgent",
+					in_signature=3D"", out_signature=3D"")
+	def Release(self):
+		print "Release"
+		mainloop.quit()
+
+	@dbus.service.method("org.ofono.LocationReportingAgent",
+				in_signature=3D"i", out_signature=3D"")
+	def ReceiveGpsFileDescriptor(self, fd):
+		print "FD: %d" % (fd, )
+
+if __name__ =3D=3D '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+	manager =3D dbus.Interface(bus.get_object("org.ofono", "/"),
+							"org.ofono.Manager")
+
+	modems =3D manager.GetModems()
+
+	for path, properties in modems:
+		if "org.ofono.LocationReporting" not in properties["Interfaces"]:
+			continue
+
+		pn =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.LocationReporting')
+
+	path =3D "/test/agent"
+	agent =3D LocationReportingAgent(bus, path)
+	pn.RegisterAgent(path)
+	print "Agent registered"
+
+	mainloop =3D gobject.MainLoop()
+
+	try:
+		mainloop.run()
+	except KeyboardInterrupt:
+		pn.UnregisterAgent(path)
+		mainloop.run()
-- =

1.7.2.3


--===============7959674773145947053==--

