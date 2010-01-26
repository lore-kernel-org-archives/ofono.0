Content-Type: multipart/mixed; boundary="===============8833568141559250630=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] enable passing of modem name via command line
Date: Tue, 26 Jan 2010 18:58:15 -0200
Message-ID: <1264539495-18329-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8833568141559250630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/disable-modem |   14 ++++++++------
 test/enable-modem  |   14 ++++++++------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/test/disable-modem b/test/disable-modem
index dee34fd..47b8531 100755
--- a/test/disable-modem
+++ b/test/disable-modem
@@ -1,15 +1,17 @@
 #!/usr/bin/python
 =

 import dbus
+import sys
 =

 bus =3D dbus.SystemBus()
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
-
-properties =3D manager.GetProperties()
-
-path =3D properties["Modems"][0]
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+	properties =3D manager.GetProperties()
+	path =3D properties["Modems"][0]
 =

 modem =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.Modem')
diff --git a/test/enable-modem b/test/enable-modem
index 0f9f604..86362af 100755
--- a/test/enable-modem
+++ b/test/enable-modem
@@ -1,15 +1,17 @@
 #!/usr/bin/python
 =

 import dbus
+import sys
 =

 bus =3D dbus.SystemBus()
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
-
-properties =3D manager.GetProperties()
-
-path =3D properties["Modems"][0]
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+			'org.ofono.Manager')
+	properties =3D manager.GetProperties()
+	path =3D properties["Modems"][0]
 =

 modem =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.Modem')
-- =

1.6.4.4


--===============8833568141559250630==--

