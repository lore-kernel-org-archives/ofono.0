Content-Type: multipart/mixed; boundary="===============8572844824845542231=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] test: Add new script for SS GCF test cases
Date: Wed, 23 May 2012 10:42:01 +0200
Message-ID: <1337762521-5210-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8572844824845542231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This script uses dynamic SS codes in input and
displays answers to the different requests.
It handles all SS: call barring, call forwarding,
call waiting, CLIP, CLIR, ...
---
 test/test-ss |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 test/test-ss

diff --git a/test/test-ss b/test/test-ss
new file mode 100755
index 0000000..adeff33
--- /dev/null
+++ b/test/test-ss
@@ -0,0 +1,55 @@
+#!/usr/bin/python
+
+import sys
+import gobject
+
+import dbus
+import dbus.mainloop.glib
+
+if __name__ =3D=3D "__main__":
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+							'org.ofono.Manager')
+
+	modems =3D manager.GetModems()
+	modem =3D modems[0][0]
+
+	if (len(sys.argv) =3D=3D 2):
+		ss_code =3D sys.argv[1]
+	else:
+		modem =3D sys.argv[1]
+		ss_code =3D sys.argv[2]
+
+	ss =3D dbus.Interface(bus.get_object('org.ofono', modem),
+					'org.ofono.SupplementaryServices')
+
+	try:
+		ss_type, properties =3D ss.Initiate(ss_code, timeout=3D100)
+	except dbus.DBusException, e:
+		print "Unable to perform operation: ", e
+		sys.exit(1);
+
+	if (ss_type =3D=3D "CallBarring"):
+		print "%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properties=
[0], properties[1])
+		for key in properties[2]:
+			print "%s : %s" % (key, properties[2][key])
+		sys.exit(1);
+	elif (ss_type =3D=3D "CallForwarding"):
+		print "%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properties=
[0], properties[1])
+		for key in properties[2]:
+			print "%s : %s" % (key, properties[2][key])
+		sys.exit(1);
+	elif (ss_type =3D=3D "CallWaiting"):
+		print "%s : Operation [ %s ]" % (ss_type, properties[0])
+		for key in properties[1]:
+			print "%s : %s" % (key, properties[1][key])
+		sys.exit(1);
+	else:
+		print "%s : Operation [ %s ] Status [ %s ]" % (ss_type, properties[0], p=
roperties[1])
+		sys.exit(1);
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
-- =

1.7.5.4


--===============8572844824845542231==--

