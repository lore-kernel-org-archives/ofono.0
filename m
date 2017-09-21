Content-Type: multipart/mixed; boundary="===============3015310669328585392=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 6/7] test: added test to run USIM auth algorithm
Date: Thu, 21 Sep 2017 11:11:59 -0700
Message-ID: <1506017520-22482-6-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506017520-22482-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3015310669328585392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/run-isim-umts-auth | 25 +++++++++++++++++++++++++
 test/run-usim-gsm-auth  | 17 +++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100755 test/run-isim-umts-auth
 create mode 100755 test/run-usim-gsm-auth

diff --git a/test/run-isim-umts-auth b/test/run-isim-umts-auth
new file mode 100755
index 0000000..7341cf5
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
+	ret =3D isim_auth.UMTSAuthenticate(bytearray.fromhex(rand), bytearray.fro=
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
+	print("./run-isim-umts-auth <modem> <rand> <autn>")
diff --git a/test/run-usim-gsm-auth b/test/run-usim-gsm-auth
new file mode 100755
index 0000000..21ee748
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
o.ISimApplication')
+	sres, kc =3D usim_auth.GSMAuthenticate(bytearray.fromhex(rand))
+	print('SRES: ' + ''.join('%02x' % x for x in sres))
+	print('KC: ' + ''.join('%02x' % x for x in kc))
+else:
+	print("./run-usim-gsm-auth <modem> <rand>")
-- =

2.7.4


--===============3015310669328585392==--

