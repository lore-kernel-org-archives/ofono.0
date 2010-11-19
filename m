Content-Type: multipart/mixed; boundary="===============2127256334058923535=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] Add test script for the Lockdown property
Date: Fri, 19 Nov 2010 20:20:18 -0200
Message-ID: <1290205218-23337-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1290202629-23235-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2127256334058923535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/lockdown-modem |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100755 test/lockdown-modem

diff --git a/test/lockdown-modem b/test/lockdown-modem
new file mode 100755
index 0000000..73f2199
--- /dev/null
+++ b/test/lockdown-modem
@@ -0,0 +1,25 @@
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
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+print "Locking and disconnecting modem %s..." % path
+modem =3D dbus.Interface(bus.get_object('org.ofono', path),
+						'org.ofono.Modem')
+
+modem.SetProperty("Lockdown", dbus.Boolean(1))
+
+print "press ENTER to power up and unlock the modem %s" % path
+sys.stdin.readline()
+
+modem.SetProperty("Lockdown", dbus.Boolean(0))
-- =

1.7.3.1


--===============2127256334058923535==--

