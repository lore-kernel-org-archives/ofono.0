Content-Type: multipart/mixed; boundary="===============8149699223620242035=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 3/3] modem: Add test script for the Lockdown property
Date: Wed, 22 Dec 2010 16:51:05 -0200
Message-ID: <1293043865-24968-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1293043865-24968-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8149699223620242035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    1 +
 test/lockdown-modem |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100755 test/lockdown-modem

diff --git a/Makefile.am b/Makefile.am
index 252b5da..94d5c09 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -428,6 +428,7 @@ test_scripts =3D test/backtrace \
 		test/set-tty \
 		test/set-gsm-band \
 		test/set-umts-band
+		test/lockdown-modem
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/lockdown-modem b/test/lockdown-modem
new file mode 100755
index 0000000..5d98154
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
+print "press ENTER to unlock the modem %s" % path
+sys.stdin.readline()
+
+modem.SetProperty("Lockdown", dbus.Boolean(0))
-- =

1.7.3.4


--===============8149699223620242035==--

