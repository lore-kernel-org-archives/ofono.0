Content-Type: multipart/mixed; boundary="===============3750032452254286180=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2] test: Add new script for SS GCF test cases
Date: Wed, 30 May 2012 10:28:16 +0200
Message-ID: <1338366496-17700-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3750032452254286180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This script uses dynamic SS codes in input and
displays answers to the different requests.
It handles all SS: call barring, call forwarding,
call waiting, CLIP, CLIR, ...
---
 Makefile.am  |    1 +
 test/test-ss |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100755 test/test-ss

diff --git a/Makefile.am b/Makefile.am
index 56fa75a..f4bca7f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -558,6 +558,7 @@ test_scripts =3D test/backtrace \
 		test/test-network-registration \
 		test/test-phonebook \
 		test/test-cbs \
+		test/test-ss \
 		test/test-ss-control-cb \
 		test/test-ss-control-cf \
 		test/test-ss-control-cs \
diff --git a/test/test-ss b/test/test-ss
new file mode 100755
index 0000000..d5488d7
--- /dev/null
+++ b/test/test-ss
@@ -0,0 +1,42 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+modems =3D manager.GetModems()
+modem =3D modems[0][0]
+
+if (len(sys.argv) =3D=3D 2):
+	ss_code =3D sys.argv[1]
+else:
+	modem =3D sys.argv[1]
+	ss_code =3D sys.argv[2]
+
+ss =3D dbus.Interface(bus.get_object('org.ofono', modem),
+				'org.ofono.SupplementaryServices')
+
+try:
+	ss_type, properties =3D ss.Initiate(ss_code, timeout=3D100)
+except dbus.DBusException, e:
+	print "Unable to perform operation: ", e
+	sys.exit(1);
+
+if (ss_type =3D=3D "CallBarring"):
+	print "%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properties[=
0], properties[1])
+	for key in properties[2]:
+		print "%s : %s" % (key, properties[2][key])
+elif (ss_type =3D=3D "CallForwarding"):
+	print "%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properties[=
0], properties[1])
+	for key in properties[2]:
+		print "%s : %s" % (key, properties[2][key])
+elif (ss_type =3D=3D "CallWaiting"):
+	print "%s : Operation [ %s ]" % (ss_type, properties[0])
+	for key in properties[1]:
+		print "%s : %s" % (key, properties[1][key])
+else:
+	print "%s : Operation [ %s ] Status [ %s ]" % (ss_type, properties[0], pr=
operties[1])
-- =

1.7.5.4


--===============3750032452254286180==--

