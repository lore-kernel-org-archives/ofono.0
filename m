Content-Type: multipart/mixed; boundary="===============2418724863982094739=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 1/2] monitor-ofono: deep pretty-print
Date: Wed, 25 Aug 2010 14:57:01 +0300
Message-ID: <1282737422-13005-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2418724863982094739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/monitor-ofono |   60 +++++++++++++++++++++++++++++++++++++++---------=
---
 1 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/test/monitor-ofono b/test/monitor-ofono
index a441d5d..94febac 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -5,22 +5,54 @@ import gobject
 import dbus
 import dbus.mainloop.glib
 =

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
 def property_changed(name, value, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	if name in ["Modems", "Interfaces", "Features",
-				"Technologies",
-				"SubscriberNumbers",
-				"EmergencyNumbers",
-				"PreferredLanguages"]:
-		val =3D ""
-		for i in value:
-			val +=3D i + " "
-	elif name in ["MobileNetworkCodeLength",
-				"VoicemailMessageCount"]:
-		val =3D int(value)
-	else:
-		val =3D str(value)
-	print "{%s} [%s] %s =3D %s" % (iface, path, name, val)
+	print "{%s} [%s] %s =3D %s" % (iface, path, name, pretty(value))
 =

 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
-- =

1.7.0.4


--===============2418724863982094739==--

