Content-Type: multipart/mixed; boundary="===============2942473120696030528=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 2/4] Add: test scripts online-modem and offline-modem
Date: Wed, 26 May 2010 00:14:39 +0300
Message-ID: <1274822081-930-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274822081-930-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2942473120696030528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/offline-modem |   17 +++++++++++++++++
 test/online-modem  |   17 +++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100755 test/offline-modem
 create mode 100755 test/online-modem

diff --git a/test/offline-modem b/test/offline-modem
new file mode 100755
index 0000000..16325ad
--- /dev/null
+++ b/test/offline-modem
@@ -0,0 +1,17 @@
+#!/usr/bin/python
+
+import dbus, sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+	properties =3D manager.GetProperties()
+	path =3D properties["Modems"][0]
+
+print "Setting modem %s offline..." % path
+modem =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofono.Mod=
em')
+modem.SetProperty("Online", dbus.Boolean(0))
diff --git a/test/online-modem b/test/online-modem
new file mode 100755
index 0000000..db0b9f5
--- /dev/null
+++ b/test/online-modem
@@ -0,0 +1,17 @@
+#!/usr/bin/python
+
+import dbus, sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+	properties =3D manager.GetProperties()
+	path =3D properties["Modems"][0]
+
+print "Setting modem %s online..." % path
+modem =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofono.Mod=
em')
+modem.SetProperty("Online", dbus.Boolean(1))
-- =

1.6.3.3


--===============2942473120696030528==--

