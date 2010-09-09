Content-Type: multipart/mixed; boundary="===============8885073798554494319=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCHv3 6/6] Add test message agent
Date: Thu, 09 Sep 2010 13:06:26 +0300
Message-ID: <1284026786-15972-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8885073798554494319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/sms-agent |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100755 test/sms-agent

diff --git a/test/sms-agent b/test/sms-agent
new file mode 100755
index 0000000..2fea2a6
--- /dev/null
+++ b/test/sms-agent
@@ -0,0 +1,84 @@
+#!/usr/bin/python
+
+import gobject
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+class SmsAgent(dbus.service.Object):
+
+	def __init__(self, bus, path):
+		dbus.service.Object.__init__(self, bus, path)
+
+		print "Started agent %s at %s" % (bus, path)
+
+	@dbus.service.method("org.ofono.MessageAgent",
+				in_signature=3D"", out_signature=3D"")
+	def Release(self):
+		print "Release, quitting"
+		mainloop.quit()
+
+	@dbus.service.method("org.ofono.MessageAgent",
+				in_signature=3D"sa{sv}", out_signature=3D"")
+	def HandleMessage(self, message, props):
+		print "From: %s" % props["Sender"]
+		print "SentTime: %s" % props["SentTime"]
+		print "LocalSentTime: %s" % props["LocalSentTime"]
+		print "Text: %s" % message
+
+	@dbus.service.method("org.ofono.MessageAgent",
+					in_signature=3D"aya{sv}", out_signature=3D"")
+	def HandleDatagram(self, data, props):
+		print "From: %s" % props["Sender"]
+		try:
+			print "ContentType: %s" % props["ContentType"]
+		except KeyError:
+			print "DestinationPort: %s" % props["DestinationPort"]
+
+		print "SourcePort: %d" % props["SourcePort"]
+		print "SentTime: %s" % props["SentTime"]
+		print "LocalSentTime: %s" % props["LocalSentTime"]
+		print "Size: %d bytes" % len(data)
+
+		outstr =3D u''
+		for byte in data:
+			if byte > 128:
+				outstr +=3D '?'
+			else:
+				outstr +=3D chr(byte)
+
+		print outstr
+
+if __name__ =3D=3D '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	if len(sys.argv) < 2:
+		print "Usage: %s <media_type>" % sys.argv[0]
+		sys.exit(1)
+
+	bus =3D dbus.SystemBus()
+	manager =3D dbus.Interface(bus.get_object("org.ofono", "/"),
+						"org.ofono.Manager")
+
+	properties =3D manager.GetProperties()
+
+	for path in properties["Modems"]:
+		modem =3D dbus.Interface(bus.get_object('org.ofono', path),
+							'org.ofono.Modem')
+
+		properties =3D modem.GetProperties()
+
+		if "org.ofono.MessageManager" not in properties["Interfaces"]:
+			continue
+
+		sms =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.MessageManager')
+
+	path =3D "/test/agent"
+	agent =3D SmsAgent(bus, path)
+	sms.RegisterAgent(path, sys.argv[1])
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
-- =

1.7.0.4


--===============8885073798554494319==--

