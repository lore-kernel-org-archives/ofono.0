Content-Type: multipart/mixed; boundary="===============2599848663275615509=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 1/4] test: process-context-settings: use ip instead of
 ifconfig/route
Date: Thu, 18 Jul 2019 13:49:34 +0200
Message-ID: <20190718114937.60921-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2599848663275615509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/process-context-settings | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/process-context-settings b/test/process-context-settings
index 1d30b30d..a536a771 100755
--- a/test/process-context-settings
+++ b/test/process-context-settings
@@ -41,14 +41,14 @@ for path, properties in modems:
 			print("    IP address is %s" % (address))
 			print("    Gateway is %s" % (gateway))
 =

-			cmd =3D "ifconfig " + interface + " " + address
-			cmd +=3D " netmask 255.255.255.255"
+			cmd =3D "ip address add dev " + interface + " " + address
+			cmd +=3D "/32"
 			os.system(cmd);
 =

 			for i in settings["DomainNameServers"]:
 				print("    Nameserver is %s" % (i))
 =

-				cmd =3D "route add -host " + i
+				cmd =3D "ip route add  " + i
 				cmd +=3D" dev " + interface
 				os.system(cmd);
 		print('')
-- =

2.22.0


--===============2599848663275615509==--

