Content-Type: multipart/mixed; boundary="===============2917504011880131041=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 4/4] test: process-context-settings: add argument for default
 connection
Date: Thu, 18 Jul 2019 13:49:37 +0200
Message-ID: <20190718114937.60921-4-martin@geanix.com>
In-Reply-To: <20190718114937.60921-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2917504011880131041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add an optional argument to specify an interface to as default
connection for the system. This changes the printet commands so that the
gateway is configured as default route, and nameservers are written to
resolv.conf.

Output without a default interface:

  root(a)iwg26:/usr/lib/ofono/test# ./process-context-settings
  Configuring /quectel_0/context1
      Interface is ppp0
      IP address is 100.64.0.151
      Gateway is 0.0.0.0
      Nameserver is 8.8.8.8
      Nameserver is 8.8.4.4

  ip address add dev ppp0 100.64.0.151/32
  ip route add  8.8.8.8 dev ppp0
  ip route add  8.8.4.4 dev ppp0

Output with ppp0 as default interface:

  root(a)iwg26:/usr/lib/ofono/test# ./process-context-settings ppp0
  Using ppp0 as default link
  Configuring /quectel_0/context1
      Interface is ppp0
      IP address is 100.64.0.151
      Gateway is 0.0.0.0
      Nameserver is 8.8.8.8
      Nameserver is 8.8.4.4

  ip address add dev ppp0 100.64.0.151/32
  ip route add default via 0.0.0.0 dev ppp0
  echo nameserver 8.8.8.8 >  /etc/resolv.conf
  echo nameserver 8.8.4.4 >>  /etc/resolv.conf

Example of evaluating the commands:

  root(a)iwg26:/usr/lib/ofono/test# eval "$(./process-context-settings ppp0=
)"
  Using ppp0 as default link
  Configuring /quectel_0/context1
      Interface is ppp0
      IP address is 100.64.0.151
      Gateway is 0.0.0.0
      Nameserver is 8.8.8.8
      Nameserver is 8.8.4.4
---
 test/process-context-settings | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/test/process-context-settings b/test/process-context-settings
index ee3f17d3..15e23618 100755
--- a/test/process-context-settings
+++ b/test/process-context-settings
@@ -10,6 +10,11 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '=
/'),
 =

 modems =3D manager.GetModems()
 =

+default =3D None
+if len(sys.argv) > 1:
+	default =3D sys.argv[1]
+	print("Using %s as default link" % (default), file=3Dsys.stderr)
+
 commands =3D []
 =

 for path, properties in modems:
@@ -51,12 +56,22 @@ for path, properties in modems:
 			cmd +=3D "/32"
 			commands.append(cmd)
 =

-			for i in settings["DomainNameServers"]:
-				print("    Nameserver is %s" % (i),
+			if interface =3D=3D default:
+				cmd =3D "ip route add default via " + gateway
+				cmd +=3D " dev " + interface
+				commands.append(cmd)
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
+					cmd +=3D " /etc/resolv.conf"
+				else:
+					cmd =3D "ip route add  " + dns
+					cmd +=3D" dev " + interface
 =

 				commands.append(cmd)
 =

-- =

2.22.0


--===============2917504011880131041==--

