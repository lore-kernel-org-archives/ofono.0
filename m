Content-Type: multipart/mixed; boundary="===============6181036206165781866=="
MIME-Version: 1.0
From: rehsack@vfnet.de
Subject: [PATCH] Adding some test scripts to fetch properties dictionaries
 from ofono
Date: Fri, 29 Jun 2012 06:48:50 +0000
Message-ID: <1340952509-4463-1-git-send-email-rehsack@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6181036206165781866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jens Rehsack <sno@NetBSD.org>

---
 test/nw-properties    |   43 +++++++++++++++++++++++++++++++++++++++++++
 test/radio-properties |   40 ++++++++++++++++++++++++++++++++++++++++
 test/sim-properties   |   40 ++++++++++++++++++++++++++++++++++++++++
 3 Dateien ge=C3=A4ndert, 123 Zeilen hinzugef=C3=BCgt(+)
 create mode 100755 test/nw-properties
 create mode 100755 test/radio-properties
 create mode 100755 test/sim-properties

diff --git a/test/nw-properties b/test/nw-properties
new file mode 100755
index 0000000..bc86c48
--- /dev/null
+++ b/test/nw-properties
@@ -0,0 +1,43 @@
+#!/usr/bin/python
+
+# from dbus import SystemBus, Interface, DBusException, UInt32, Int32, UIn=
t64, Int64, Boolean
+import sys
+import dbus
+
+def dedbustype(v):
+	if isinstance(v, bool) or isinstance(v, dbus.Boolean):
+		return bool(v)
+	elif isinstance(v, float):
+		return float(v)
+	elif isinstance(v, int) or isinstance(v, dbus.Int64) or isinstance(v, dbu=
s.UInt64) or isinstance(v, dbus.Int32) or isinstance(v, dbus.UInt32):
+		return int(v)
+	elif isinstance(v, basestring):
+		return unicode(v)
+	elif isinstance(v, dict):
+		return dict([(str(n), dedbustype(m), ) for n, m in v.items()]) # use str=
ings for names to allow **
+	elif isinstance(v, list) or isinstance(v, tuple):
+		return [dedbustype(m) for m in v]
+	else:
+		raise Exception('unsupported type %s'% type(v))
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+elif len(sys.argv) =3D=3D 1:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+					'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+else:
+	print "%s [PATH]" % (sys.argv[0])
+	sys.exit(0)
+
+nwmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.NetworkRegistration')
+properties =3D nwmanager.GetProperties()
+dd_p =3D dedbustype(properties)
+print '--- nwreg_properties', dd_p
+operators =3D nwmanager.GetOperators()
+dd_o =3D dedbustype(operators)
+print '--- nwreg_operators', dd_o
diff --git a/test/radio-properties b/test/radio-properties
new file mode 100755
index 0000000..69e8431
--- /dev/null
+++ b/test/radio-properties
@@ -0,0 +1,40 @@
+#!/usr/bin/python
+
+# from dbus import SystemBus, Interface, DBusException, UInt32, Int32, UIn=
t64, Int64, Boolean
+import sys
+import dbus
+
+def dedbustype(v):
+	if isinstance(v, bool) or isinstance(v, dbus.Boolean):
+		return bool(v)
+	elif isinstance(v, float):
+		return float(v)
+	elif isinstance(v, int) or isinstance(v, dbus.Int64) or isinstance(v, dbu=
s.UInt64) or isinstance(v, dbus.Int32) or isinstance(v, dbus.UInt32):
+		return int(v)
+	elif isinstance(v, basestring):
+		return unicode(v)
+	elif isinstance(v, dict):
+		return dict([(str(n), dedbustype(m), ) for n, m in v.items()]) # use str=
ings for names to allow **
+	elif isinstance(v, list) or isinstance(v, tuple):
+		return [dedbustype(m) for m in v]
+	else:
+		raise Exception('unsupported type %s'% type(v))
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+elif len(sys.argv) =3D=3D 1:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+					'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+else:
+	print "%s [PATH]" % (sys.argv[0])
+	sys.exit(0)
+
+radiosettings =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.RadioSettings')
+properties =3D radiosettings.GetProperties()
+dd_r =3D dedbustype(properties)
+print '--- radio_settings_properties', dd_r
diff --git a/test/sim-properties b/test/sim-properties
new file mode 100755
index 0000000..0c629a7
--- /dev/null
+++ b/test/sim-properties
@@ -0,0 +1,40 @@
+#!/usr/bin/python
+
+# from dbus import SystemBus, Interface, DBusException, UInt32, Int32, UIn=
t64, Int64, Boolean
+import sys
+import dbus
+
+def dedbustype(v):
+	if isinstance(v, bool) or isinstance(v, dbus.Boolean):
+		return bool(v)
+	elif isinstance(v, float):
+		return float(v)
+	elif isinstance(v, int) or isinstance(v, dbus.Int64) or isinstance(v, dbu=
s.UInt64) or isinstance(v, dbus.Int32) or isinstance(v, dbus.UInt32):
+		return int(v)
+	elif isinstance(v, basestring):
+		return unicode(v)
+	elif isinstance(v, dict):
+		return dict([(str(n), dedbustype(m), ) for n, m in v.items()]) # use str=
ings for names to allow **
+	elif isinstance(v, list) or isinstance(v, tuple):
+		return [dedbustype(m) for m in v]
+	else:
+		raise Exception('unsupported type %s'% type(v))
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+elif len(sys.argv) =3D=3D 1:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+					'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+else:
+	print "%s [PATH]" % (sys.argv[0])
+	sys.exit(0)
+
+simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.SimManager')
+properties =3D simmanager.GetProperties()
+dd_p =3D dedbustype(properties)
+print '--- sim_manager_properties', dd_p
-- =

1.7.10.5


--===============6181036206165781866==--

