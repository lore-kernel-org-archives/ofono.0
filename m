Content-Type: multipart/mixed; boundary="===============3086655138327426684=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-fdn PATCH 4/4] Added test/enable-fdn
Date: Thu, 26 Aug 2010 15:52:41 +0300
Message-ID: <1282827161-8351-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282827161-8351-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3086655138327426684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/enable-fdn |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100755 test/enable-fdn

diff --git a/test/enable-fdn b/test/enable-fdn
new file mode 100755
index 0000000..3061e36
--- /dev/null
+++ b/test/enable-fdn
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
+if len(sys.argv) =3D=3D 3:
+	path, pin =3D sys.argv[1:]
+elif len(sys.argv) =3D=3D 2:
+	path, pin =3D default_modem(), sys.argv[1]
+else:
+	print "%s [PATH] pin2" % (sys.argv[0])
+	sys.exit(0)
+
+print "Enable FDN for modem %s..." % (path,)
+
+modem =3D bus.get_object('org.ofono', path)
+
+simmanager =3D dbus.Interface(modem, 'org.ofono.SimManager')
+
+simmanager.EnableFDN(pin)
-- =

1.7.0.4


--===============3086655138327426684==--

