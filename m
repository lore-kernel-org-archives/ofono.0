Content-Type: multipart/mixed; boundary="===============2003789678880891580=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 15/16] elect: Add test scripts
Date: Tue, 13 Dec 2011 16:00:09 +0100
Message-ID: <1323788410-9988-16-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2003789678880891580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 test/elect-connect    |   20 +++++++++
 test/elect-disconnect |   20 +++++++++
 test/monitor-elect    |  109 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 149 insertions(+), 0 deletions(-)
 create mode 100755 test/elect-connect
 create mode 100755 test/elect-disconnect
 create mode 100755 test/monitor-elect

diff --git a/test/elect-connect b/test/elect-connect
new file mode 100755
index 0000000..09e592e
--- /dev/null
+++ b/test/elect-connect
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono.elect', '/'),
+			'org.ofono.elect.Manager')
+	devices =3D manager.GetDevices()
+	path =3D devices[0][0]
+
+print "Connect device %s..." % path
+device =3D dbus.Interface(bus.get_object('org.ofono.elect', path),
+						'org.ofono.elect.Device')
+
+device.Connect()
diff --git a/test/elect-disconnect b/test/elect-disconnect
new file mode 100755
index 0000000..76ff74c
--- /dev/null
+++ b/test/elect-disconnect
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono.elect', '/'),
+			'org.ofono.elect.Manager')
+	devices =3D manager.GetDevices()
+	path =3D devices[0][0]
+
+print "Disonnect device %s..." % path
+device =3D dbus.Interface(bus.get_object('org.ofono.elect', path),
+						'org.ofono.elect.Device')
+
+device.Disconnect()
diff --git a/test/monitor-elect b/test/monitor-elect
new file mode 100755
index 0000000..684f5e3
--- /dev/null
+++ b/test/monitor-elect
@@ -0,0 +1,109 @@
+#!/usr/bin/python
+
+import gobject
+
+import dbus
+import dbus.mainloop.glib
+
+_dbus2py =3D {
+	dbus.String : unicode,
+	dbus.UInt32 : int,
+	dbus.Int32 : int,
+	dbus.Int16 : int,
+	dbus.UInt16 : int,
+	dbus.UInt64 : int,
+	dbus.Int64 : int,
+	dbus.Byte : int,
+	dbus.Boolean : bool,
+	dbus.ByteArray : str,
+	dbus.ObjectPath : str
+    }
+
+def dbus2py(d):
+	t =3D type(d)
+	if t in _dbus2py:
+		return _dbus2py[t](d)
+	if t is dbus.Dictionary:
+		return dict([(dbus2py(k), dbus2py(v)) for k, v in d.items()])
+	if t is dbus.Array and d.signature =3D=3D "y":
+		return "".join([chr(b) for b in d])
+	if t is dbus.Array or t is list:
+		return [dbus2py(v) for v in d]
+	if t is dbus.Struct or t is tuple:
+		return tuple([dbus2py(v) for v in d])
+	return d
+
+def pretty(d):
+	d =3D dbus2py(d)
+	t =3D type(d)
+
+	if t in (dict, tuple, list) and len(d) > 0:
+		if t is dict:
+			d =3D ", ".join(["%s =3D %s" % (k, pretty(v))
+					for k, v in d.items()])
+			return "{ %s }" % d
+
+		d =3D " ".join([pretty(e) for e in d])
+
+		if t is tuple:
+			return "( %s )" % d
+
+	return str(d)
+
+def property_changed(name, value, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s =3D %s" % (iface, path, name, pretty(value))
+
+def added(name, value, member, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s %s" % (iface, member, name, pretty(value))
+
+def removed(name, member, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s" % (iface, member, name)
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
+def ussd(msg, member, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s %s" % (iface, path, member, str(msg))
+
+def value(value, member, path, interface):
+	iface =3D interface[interface.rfind(".") + 1:]
+	print "{%s} [%s] %s %s" % (iface, path, member, str(value))
+
+if __name__ =3D=3D '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+
+	bus.add_signal_receiver(property_changed,
+					bus_name=3D"org.ofono.elect",
+					signal_name =3D "PropertyChanged",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
+	bus.add_signal_receiver(added,
+					bus_name=3D"org.ofono.elect",
+					signal_name =3D "DeviceAdded",
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
+	bus.add_signal_receiver(removed,
+					bus_name=3D"org.ofono.elect",
+					signal_name =3D "DeviceRemoved",
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
-- =

1.7.8.110.g4cb5d1


--===============2003789678880891580==--

