Content-Type: multipart/mixed; boundary="===============9151704605928377572=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 5/9] test: add script for setting lte atom properties
Date: Wed, 09 Nov 2016 18:43:18 +0100
Message-ID: <1478713402-30780-6-git-send-email-dragos@endocode.com>
In-Reply-To: <1478713402-30780-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9151704605928377572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/set-lte-property | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 test/set-lte-property

diff --git a/test/set-lte-property b/test/set-lte-property
new file mode 100755
index 0000000..aaf726e
--- /dev/null
+++ b/test/set-lte-property
@@ -0,0 +1,25 @@
+#!/usr/bin/python3
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 4:
+	path =3D sys.argv[1]
+	name =3D sys.argv[2]
+	value =3D sys.argv[3]
+elif len(sys.argv) =3D=3D 3:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+					'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+	name =3D sys.argv[1]
+	value =3D sys.argv[2]
+else:
+	print("%s [PATH] name value" % (sys.argv[0]))
+	sys.exit(0)
+
+print("Setting {} as {} for modem {}..." .format(name, value, path))
+lte =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofono.LTE')
+lte.SetProperty(name, value)
-- =

2.7.4


--===============9151704605928377572==--

