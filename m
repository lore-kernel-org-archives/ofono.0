Content-Type: multipart/mixed; boundary="===============5256467967489149418=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-fdn PATCH 3/4] Added test/disable-fdn
Date: Thu, 26 Aug 2010 15:52:40 +0300
Message-ID: <1282827161-8351-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1282827161-8351-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5256467967489149418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/disable-fdn |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100755 test/disable-fdn

diff --git a/test/disable-fdn b/test/disable-fdn
new file mode 100755
index 0000000..61b731d
--- /dev/null
+++ b/test/disable-fdn
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
+print "Disable FDN for modem %s..." % (path,)
+
+modem =3D bus.get_object('org.ofono', path)
+
+simmanager =3D dbus.Interface(modem, 'org.ofono.SimManager')
+
+simmanager.DisableFDN(pin)
-- =

1.7.0.4


--===============5256467967489149418==--

