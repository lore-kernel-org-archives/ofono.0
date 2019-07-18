Content-Type: multipart/mixed; boundary="===============2877192051325654678=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 2/4] test: process-context-settings: print settings to stderr
Date: Thu, 18 Jul 2019 13:49:35 +0200
Message-ID: <20190718114937.60921-2-martin@geanix.com>
In-Reply-To: <20190718114937.60921-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2877192051325654678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare the test to print commands to execute and let the caller
evaluate those. In that way, more commands can be added to also set up
name servers and default routes without secretly breaking the existing
system network setup.
---
 test/process-context-settings | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/test/process-context-settings b/test/process-context-settings
index a536a771..7ffb12b3 100755
--- a/test/process-context-settings
+++ b/test/process-context-settings
@@ -1,6 +1,7 @@
 #!/usr/bin/python3
 =

 import os
+import sys
 import dbus
 =

 bus =3D dbus.SystemBus()
@@ -23,13 +24,14 @@ for path, properties in modems:
 		if properties["Active"] =3D=3D dbus.Boolean(0):
 			continue
 =

-		print("Configuring %s" % (path))
+		print("Configuring %s" % (path), file=3Dsys.stderr)
 =

 		settings =3D properties["Settings"]
 		interface =3D settings["Interface"]
 =

 		if settings["Method"] =3D=3D "dhcp":
-			print("    Run DHCP on interface %s" % (interface))
+			print("    Run DHCP on interface %s" % (interface),
+				file=3Dsys.stderr)
 		else:
 			address =3D settings["Address"]
 			try:
@@ -37,18 +39,22 @@ for path, properties in modems:
 			except:
 				gateway =3D "0.0.0.0";
 =

-			print("    Interface is %s" % (interface))
-			print("    IP address is %s" % (address))
-			print("    Gateway is %s" % (gateway))
+			print("    Interface is %s" % (interface),
+				file=3Dsys.stderr)
+			print("    IP address is %s" % (address),
+				file=3Dsys.stderr)
+			print("    Gateway is %s" % (gateway),
+				file=3Dsys.stderr)
 =

 			cmd =3D "ip address add dev " + interface + " " + address
 			cmd +=3D "/32"
 			os.system(cmd);
 =

 			for i in settings["DomainNameServers"]:
-				print("    Nameserver is %s" % (i))
+				print("    Nameserver is %s" % (i),
+					file=3Dsys.stderr)
 =

 				cmd =3D "ip route add  " + i
 				cmd +=3D" dev " + interface
 				os.system(cmd);
-		print('')
+		print('', file=3Dsys.stderr)
-- =

2.22.0


--===============2877192051325654678==--

