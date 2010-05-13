Content-Type: multipart/mixed; boundary="===============6825844606173654154=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 14/16] emulator: Add destroy-emulator script
Date: Thu, 13 May 2010 18:02:37 +0800
Message-ID: <1273744959-3711-15-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-14-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6825844606173654154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To remove all emulators in current modem
---
 test/destroy-emulator |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100755 test/destroy-emulator

diff --git a/test/destroy-emulator b/test/destroy-emulator
new file mode 100755
index 0000000..3b8ecfb
--- /dev/null
+++ b/test/destroy-emulator
@@ -0,0 +1,19 @@
+#!/usr/bin/python
+
+import dbus
+import sys
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
+emulator =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.EmulatorManager')
+
+emulator.DestroyAll()
-- =

1.6.3.3


--===============6825844606173654154==--

