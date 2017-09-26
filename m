Content-Type: multipart/mixed; boundary="===============6893991641555261723=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 6/7] test: added tests for GSM/UMTS auth algorithms
Date: Tue, 26 Sep 2017 09:26:08 -0700
Message-ID: <1506443169-19755-6-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506443169-19755-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6893991641555261723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/run-isim-umts-auth | 25 +++++++++++++++++++++++++
 test/run-usim-gsm-auth  | 17 +++++++++++++++++
 test/run-usim-umts-auth | 25 +++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100755 test/run-isim-umts-auth
 create mode 100755 test/run-usim-gsm-auth
 create mode 100755 test/run-usim-umts-auth

diff --git a/test/run-isim-umts-auth b/test/run-isim-umts-auth
new file mode 100755
index 0000000..12fa2f0
--- /dev/null
+++ b/test/run-isim-umts-auth
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
+	rand =3D sys.argv[2]
+	autn =3D sys.argv[3]
+
+	isim_auth =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofon=
o.ISimApplication')
+	ret =3D isim_auth.ImsAuthenticate(bytearray.fromhex(rand), bytearray.from=
hex(autn))
+
+	if 'auts' in ret:
+		print('Sync Failure')
+		print('AUTS: ' + ''.join('%02x' % x for x in ret['auts']))
+	else:
+		print('Success')
+		print('RES: ' +  ''.join('%02x' % x for x in ret['res']))
+		print('CK: ' + ''.join('%02x' % x for x in ret['ck']))
+		print('IK: ' + ''.join('%02x' % x for x in ret['ik']))
+else:
+	print("./run-isim-umts-auth <modem> <rand> <autn>")
diff --git a/test/run-usim-gsm-auth b/test/run-usim-gsm-auth
new file mode 100755
index 0000000..034f7e4
--- /dev/null
+++ b/test/run-usim-gsm-auth
@@ -0,0 +1,17 @@
+#!/usr/bin/python3
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 3:
+	path =3D sys.argv[1]
+	rand =3D sys.argv[2]
+
+	usim_auth =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofon=
o.USimApplication')
+	sres, kc =3D usim_auth.GsmAuthenticate(bytearray.fromhex(rand))
+	print('SRES: ' + ''.join('%02x' % x for x in sres))
+	print('KC: ' + ''.join('%02x' % x for x in kc))
+else:
+	print("./run-usim-gsm-auth <modem> <rand>")
diff --git a/test/run-usim-umts-auth b/test/run-usim-umts-auth
new file mode 100755
index 0000000..8930b0f
--- /dev/null
+++ b/test/run-usim-umts-auth
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
+	rand =3D sys.argv[2]
+	autn =3D sys.argv[3]
+
+	usim_auth =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofon=
o.USimApplication')
+	ret =3D usim_auth.UmtsAuthenticate(bytearray.fromhex(rand), bytearray.fro=
mhex(autn))
+
+	if 'auts' in ret:
+		print('Sync Failure')
+		print('AUTS: ' + ''.join('%02x' % x for x in ret['auts']))
+	else:
+		print('Success')
+		print('RES: ' +  ''.join('%02x' % x for x in ret['res']))
+		print('CK: ' + ''.join('%02x' % x for x in ret['ck']))
+		print('IK: ' + ''.join('%02x' % x for x in ret['ik']))
+else:
+	print("./run-usim-umts-auth <modem> <rand> <autn>")
-- =

2.7.4


--===============6893991641555261723==--

