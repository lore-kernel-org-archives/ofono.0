Content-Type: multipart/mixed; boundary="===============3009915350230008889=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 10/11] test: added tests for GSM/UMTS auth algorithms
Date: Tue, 10 Oct 2017 14:36:19 -0700
Message-ID: <1507671380-7625-10-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507671380-7625-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3009915350230008889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/run-isim-umts-auth | 38 ++++++++++++++++++++++++++++++++++++++
 test/run-usim-gsm-auth  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100755 test/run-isim-umts-auth
 create mode 100755 test/run-usim-gsm-auth

diff --git a/test/run-isim-umts-auth b/test/run-isim-umts-auth
new file mode 100755
index 0000000..b921085
--- /dev/null
+++ b/test/run-isim-umts-auth
@@ -0,0 +1,38 @@
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
+	sim_auth =3D dbus.Interface(bus.get_object('org.ofono', path),
+							'org.ofono.SimAuthentication')
+	props =3D sim_auth.GetProperties()
+	for i in props:
+		if props[i][0] =3D=3D 'Ims':
+			ims_path =3D i
+
+	if not ims_path:
+		print("No Ims application found")
+		quit()
+
+	isim_auth =3D dbus.Interface(bus.get_object('org.ofono', ims_path),
+							'org.ofono.ISimApplication')
+	ret =3D isim_auth.ImsAuthenticate(bytearray.fromhex(rand),
+								bytearray.fromhex(autn))
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
index 0000000..1af2d7e
--- /dev/null
+++ b/test/run-usim-gsm-auth
@@ -0,0 +1,35 @@
+#!/usr/bin/python3
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) < 6 and len(sys.argv) > 2:
+	path =3D sys.argv[1]
+
+	rands =3D []
+	for i in sys.argv[2:]:
+		rands.append(bytearray.fromhex(i))
+
+	sim_auth =3D dbus.Interface(bus.get_object('org.ofono', path),
+							'org.ofono.SimAuthentication')
+	props =3D sim_auth.GetProperties()
+	for i in props:
+		if props[i][0] =3D=3D 'Umts':
+			umts_path =3D i
+
+	if not umts_path:
+		print("No Umts application found")
+		quit()
+
+	umts =3D dbus.Interface(bus.get_object('org.ofono', umts_path),
+						'org.ofono.USimApplication')
+	av =3D umts.GsmAuthenticate(rands)
+
+	for i in av:
+		print('SRES: ' + ''.join('%02x' % x for x in i['sres']))
+		print('KC: ' + ''.join('%02x' % x for x in i['kc']))
+
+else:
+	print("./run-usim-gsm-auth <modem> <rands>...[up to 3]")
-- =

2.7.4


--===============3009915350230008889==--

