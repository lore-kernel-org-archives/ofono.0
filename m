Content-Type: multipart/mixed; boundary="===============0620991437790826840=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-reset-pin PATCH 4/4] Added test/reset-pin
Date: Thu, 26 Aug 2010 15:49:17 +0300
Message-ID: <1282826957-8238-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282826957-8238-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0620991437790826840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/reset-pin |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100755 test/reset-pin

diff --git a/test/reset-pin b/test/reset-pin
new file mode 100755
index 0000000..f7b5449
--- /dev/null
+++ b/test/reset-pin
@@ -0,0 +1,32 @@
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
+	path, pin_type, puk, pin =3D sys.argv[1:]
+elif len(sys.argv) =3D=3D 4:
+	path =3D default_modem()
+	pin_type, puk, pin =3D sys.argv[1:]
+else:
+	print "%s [PATH] pin_type puk pin" % (sys.argv[0])
+	sys.exit(0)
+
+print "Reset %s for modem %s..." % (pin_type, path)
+
+modem =3D bus.get_object('org.ofono', path)
+
+simmanager =3D dbus.Interface(modem, 'org.ofono.SimManager')
+
+simmanager.ResetPin(pin_type, puk, pin)
-- =

1.7.0.4


--===============0620991437790826840==--

