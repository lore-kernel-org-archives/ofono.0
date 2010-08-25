Content-Type: multipart/mixed; boundary="===============1964041367395927222=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 2/2] test-monitor: monitor irregular signals
Date: Wed, 25 Aug 2010 14:57:02 +0300
Message-ID: <1282737422-13005-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282737422-13005-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1964041367395927222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/monitor-ofono |   63 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/test/monitor-ofono b/test/monitor-ofono
index 94febac..86239eb 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -54,6 +54,23 @@ def property_changed(name, value, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
 	print "{%s} [%s] %s =3D %s" % (iface, path, name, pretty(value))
 =

+def added(name, value, member, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s %s" % (iface, member, name, pretty(value))
+
+def removed(name, member, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s" % (iface, name, member)
+
+def event(member, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s" % (iface, path, member)
+
+def message(msg, args, member, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s %s (%s)" % (iface, path, member,
+					str(msg), pretty(args))
+
 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

@@ -65,5 +82,51 @@ if __name__ =3D=3D '__main__':
 						path_keyword=3D"path",
 						interface_keyword=3D"interface")
 =

+	for member in ["IncomingBarringInEffect",
+		       "OutgoingBarringInEffect",
+		       "NearMaximumWarning"]:
+		bus.add_signal_receiver(event,
+					bus_name=3D"org.ofono",
+					signal_name =3D member,
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
+	bus.add_signal_receiver(added,
+					bus_name=3D"org.ofono",
+					signal_name =3D "ContextAdded",
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
+	bus.add_signal_receiver(removed,
+					bus_name=3D"org.ofono",
+					signal_name =3D "ContextRemoved",
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
+	bus.add_signal_receiver(added,
+				bus_name=3D"org.ofono",
+					signal_name =3D "CallAdded",
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+	bus.add_signal_receiver(removed,
+				bus_name=3D"org.ofono",
+					signal_name =3D "CallRemoved",
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
+	for member in ["IncomingBroadcast", "EmergencyBroadcast",
+		       "IncomingMessage", "ImmediateMessage"]:
+		bus.add_signal_receiver(message,
+					bus_name=3D"org.ofono",
+					signal_name =3D member,
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
-- =

1.7.0.4


--===============1964041367395927222==--

