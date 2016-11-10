Content-Type: multipart/mixed; boundary="===============8682940374328528739=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 5/9] test: add script for setting lte atom properties
Date: Thu, 10 Nov 2016 17:55:52 +0100
Message-ID: <1478796956-22500-6-git-send-email-dragos@endocode.com>
In-Reply-To: <1478796956-22500-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8682940374328528739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/set-lte-property | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 test/set-lte-property

diff --git a/test/set-lte-property b/test/set-lte-property
new file mode 100755
index 0000000..a34e60a
--- /dev/null
+++ b/test/set-lte-property
@@ -0,0 +1,26 @@
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
+lte =3D dbus.Interface(bus.get_object('org.ofono', path),
+			'org.ofono.LongTermEvolution')
+lte.SetProperty(name, value)
-- =

2.7.4


--===============8682940374328528739==--

