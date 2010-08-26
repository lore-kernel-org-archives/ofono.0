Content-Type: multipart/mixed; boundary="===============8150914615086152182=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-reset-pin PATCH 3/4] Added test/change-pin
Date: Thu, 26 Aug 2010 15:49:16 +0300
Message-ID: <1282826957-8238-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282826957-8238-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8150914615086152182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/change-pin |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100755 test/change-pin

diff --git a/test/change-pin b/test/change-pin
new file mode 100755
index 0000000..19e9302
--- /dev/null
+++ b/test/change-pin
@@ -0,0 +1,31 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+def default_modem():
+	manager =3D bus.get_object('org.ofono', '/')
+	properties =3D manager.GetProperties(dbus_interface =3D 'org.ofono.Manage=
r')
+	modems =3D properties["Modems"]
+	if not modems:
+		sys.stderr.write("No modems available\n")
+		sys.exit(1)
+	return modems[0]
+
+if len(sys.argv) =3D=3D 5:
+	path, pin_type, old_pin, new_pin =3D sys.argv[1:]
+elif len(sys.argv) =3D=3D 4:
+	path =3D default_modem()
+	pin_type, old_pin, new_pin =3D sys.argv[1:]
+else:
+	print "%s [PATH] pin_type old_pin new_pin" % (sys.argv[0])
+
+print "Change %s for modem %s..." % (pin_type, path)
+
+modem =3D bus.get_object('org.ofono', path)
+
+simmanager =3D dbus.Interface(modem, 'org.ofono.SimManager')
+
+simmanager.ChangePin(pin_type, old_pin, new_pin)
-- =

1.7.0.4


--===============8150914615086152182==--

