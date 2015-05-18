Content-Type: multipart/mixed; boundary="===============2691963886960207702=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/4] test: Add script for resetting contexts
Date: Mon, 18 May 2015 08:47:08 +0200
Message-ID: <1431931629-7771-3-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1431931629-7771-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2691963886960207702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/reset-contexts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 test/reset-contexts

diff --git a/test/reset-contexts b/test/reset-contexts
new file mode 100644
index 0000000..1676636
--- /dev/null
+++ b/test/reset-contexts
@@ -0,0 +1,20 @@
+#!/usr/bin/python3
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
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print("Resetting contexts for SIM on modem %s..." % path)
+cm =3D dbus.Interface(bus.get_object('org.ofono', path),
+		'org.ofono.ConnectionManager')
+
+cm.ResetContexts()
-- =

2.1.4


--===============2691963886960207702==--

