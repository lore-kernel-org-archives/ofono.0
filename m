Content-Type: multipart/mixed; boundary="===============6176742593296102327=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 7/7] Add script to enable/disable text-telephony support
Date: Tue, 23 Nov 2010 16:04:18 -0200
Message-ID: <1290535458-18786-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1290535458-18786-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6176742593296102327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/set-tty |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100755 test/set-tty

diff --git a/test/set-tty b/test/set-tty
new file mode 100755
index 0000000..cbbb043
--- /dev/null
+++ b/test/set-tty
@@ -0,0 +1,25 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 3:
+	path =3D sys.argv[1]
+	enable =3D int(sys.argv[2])
+elif len(sys.argv) =3D=3D 2:
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+	enable =3D int(sys.argv[1])
+else:
+	print "%s [PATH] {0|1}" % (sys.argv[0])
+	exit(1)
+
+print "Setting TTY for modem %s..." % path
+texttelephony =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.TextTelephony')
+
+texttelephony.SetProperty("Powered", dbus.Boolean(enable));
-- =

1.7.3.2


--===============6176742593296102327==--

