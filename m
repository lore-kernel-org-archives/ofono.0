Content-Type: multipart/mixed; boundary="===============0130280910209256443=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 7/7] Add test sms agent implementation
Date: Mon, 27 Sep 2010 19:54:19 +0300
Message-ID: <1285606459-1297-8-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1285606459-1297-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0130280910209256443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/sms-agent |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100755 test/sms-agent

diff --git a/test/sms-agent b/test/sms-agent
new file mode 100755
index 0000000..58b33c3
--- /dev/null
+++ b/test/sms-agent
@@ -0,0 +1,59 @@
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
+		print "ContentType: %s" % props["ContentType"]
+		print "Text: %s" % message
+
+if __name__ =3D=3D '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+	manager =3D dbus.Interface(bus.get_object("org.ofono", "/"),
+						"org.ofono.Manager")
+
+	modems =3D manager.GetModems()
+
+	for path, props in modems:
+
+		if "org.ofono.MessageManager" not in props["Interfaces"]:
+			continue
+
+		sms =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.MessageManager')
+
+	path =3D "/test/agent"
+	agent =3D SmsAgent(bus, path)
+	sms.RegisterAgent(path)
+
+	mainloop =3D gobject.MainLoop()
+
+	try:
+		mainloop.run()
+	except KeyboardInterrupt:
+		sms.UnregisterAgent(path)
+		mainloop.run()
-- =

1.7.0.4


--===============0130280910209256443==--

