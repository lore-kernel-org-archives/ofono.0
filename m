Content-Type: multipart/mixed; boundary="===============4019225221487627950=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv2] test: process-context-settings: add argument for default
 connection
Date: Fri, 19 Jul 2019 10:48:01 +0200
Message-ID: <20190719084801.112610-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4019225221487627950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add an optional argument to specify an interface to as default
connection for the system. This changes the constructed commands so that
the gateway is configured as default route, and nameservers are written
to resolv.conf.
---

I decided to drop the print-instead-execute approach, and simply add the
interface argument to get the default route and dns settings. These
changes were mostly to enable easy setup of internet on my board...

 test/process-context-settings | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/test/process-context-settings b/test/process-context-settings
index 7ffb12b3..e0bc1083 100755
--- a/test/process-context-settings
+++ b/test/process-context-settings
@@ -11,6 +11,11 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '=
/'),
 =

 modems =3D manager.GetModems()
 =

+default =3D None
+if len(sys.argv) > 1:
+	default =3D sys.argv[1]
+	print("Using %s as default link" % (default), file=3Dsys.stderr)
+
 for path, properties in modems:
 	if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
 		continue
@@ -50,11 +55,23 @@ for path, properties in modems:
 			cmd +=3D "/32"
 			os.system(cmd);
 =

-			for i in settings["DomainNameServers"]:
-				print("    Nameserver is %s" % (i),
+			if interface =3D=3D default:
+				cmd =3D "ip route add default via " + gateway
+				cmd +=3D " dev " + interface
+				os.system(cmd)
+
+			for i,dns in enumerate(settings["DomainNameServers"]):
+				print("    Nameserver is %s" % (dns),
 					file=3Dsys.stderr)
 =

-				cmd =3D "ip route add  " + i
-				cmd +=3D" dev " + interface
+				if interface =3D=3D default:
+					redirect =3D " > " if i =3D=3D 0 else " >> "
+					cmd =3D "echo nameserver " + dns + redirect
+					cmd +=3D "/etc/resolv.conf"
+				else:
+					cmd =3D "ip route add  " + dns
+					cmd +=3D " dev " + interface
+
 				os.system(cmd);
+
 		print('', file=3Dsys.stderr)
-- =

2.22.0


--===============4019225221487627950==--

