Content-Type: multipart/mixed; boundary="===============8481516942548061445=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 4/9] SMS history plugin test script.
Date: Wed, 29 Dec 2010 14:51:20 +0200
Message-ID: <1293627085-24428-5-git-send-email-oleg.zhurakivskyy@nokia.com>
In-Reply-To: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8481516942548061445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-messaging-agent |   67 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 test/test-messaging-agent

diff --git a/test/test-messaging-agent b/test/test-messaging-agent
new file mode 100644
index 0000000..85d07f2
--- /dev/null
+++ b/test/test-messaging-agent
@@ -0,0 +1,67 @@
+#!/usr/bin/python
+
+import gobject
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+def message_print(method, data, props):
+	string =3D ""
+	for byte in data:
+		string +=3D str(byte)
+	print "%s" % method
+	print "%-15s%s" % ("Text", string)
+	for key in props.keys():
+		print "%-15s%s" % (key, props[key])
+
+class MessagingAgent(dbus.service.Object):
+	@dbus.service.method("org.ofono.MessagingAgent",
+					in_signature=3D"", out_signature=3D"")
+	def Release(self):
+		print "Release"
+		mainloop.quit()
+
+	@dbus.service.method("org.ofono.MessagingAgent",
+				in_signature=3D"aya{sv}", out_signature=3D"")
+	def MessageReceived(self, data, props):
+		message_print("MessageReceived", data, props)
+
+	@dbus.service.method("org.ofono.MessagingAgent",
+				in_signature=3D"aya{sv}", out_signature=3D"")
+	def MessageSendPending(self, data, props):
+		message_print("MessageSendPending", data, props)
+
+	@dbus.service.method("org.ofono.MessagingAgent",
+				in_signature=3D"aya{sv}", out_signature=3D"")
+	def MessageSendStatus(self, data, props):
+		message_print("MessageSendStatus", data, props)
+
+if __name__ =3D=3D '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+
+	manager =3D dbus.Interface(bus.get_object("org.ofono", "/"),
+						"org.ofono.Manager")
+	modems =3D manager.GetModems()
+
+	for path, properties in modems:
+		if "org.ofono.Messaging" not in properties["Interfaces"]:
+			continue
+
+		pn =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.Messaging')
+
+	path =3D "/test/agent"
+	agent =3D MessagingAgent(bus, path)
+	pn.AgentRegister(path)
+	print "MessagingAgent registered"
+
+	mainloop =3D gobject.MainLoop()
+
+	try:
+		mainloop.run()
+	except KeyboardInterrupt:
+		pn.AgentUnregister(path)
+		mainloop.run()
-- =

1.7.1


--===============8481516942548061445==--

