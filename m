Content-Type: multipart/mixed; boundary="===============8216502596831187218=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 04/12] test: modify test scripts for IPv6
Date: Thu, 03 Feb 2011 11:03:21 +0200
Message-ID: <1296723809-32676-5-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1296723809-32676-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8216502596831187218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am               |    3 ++-
 test/list-contexts        |    6 +++---
 test/set-context-property |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 4 deletions(-)
 create mode 100755 test/set-context-property

diff --git a/Makefile.am b/Makefile.am
index a38fcb9..3002f56 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -478,7 +478,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-dial-number \
 		test/cdma-hangup \
 		test/disable-call-forwarding \
-		test/list-messages
+		test/list-messages \
+		test/set-context-property
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/list-contexts b/test/list-contexts
index 68dae6a..9519ade 100755
--- a/test/list-contexts
+++ b/test/list-contexts
@@ -24,15 +24,15 @@ for path, properties in modems:
 		print "    [ %s ]" % (path)
 =

 		for key in properties.keys():
-			if key in ["Settings"]:
+			if key in ["Settings"] or key in ["IPv6Settings"]:
 				val =3D "{"
 				for i in properties[key].keys():
 					val +=3D " " + i + "=3D"
 					if i in ["DomainNameServers"]:
 						for n in properties[key][i]:
-							val +=3D n + ","
+							val +=3D str(n) + ","
 					else:
-						val +=3D properties[key][i]
+						val +=3D str(properties[key][i])
 				val +=3D " }"
 			else:
 				val =3D str(properties[key])
diff --git a/test/set-context-property b/test/set-context-property
new file mode 100755
index 0000000..8ea0e3a
--- /dev/null
+++ b/test/set-context-property
@@ -0,0 +1,38 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+
+if len(sys.argv) < 4:
+	print "Usage: set-context-property <context> <name> <value>"
+	sys.exit(1)
+
+bus =3D dbus.SystemBus()
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+modems =3D manager.GetModems()
+
+for path, properties in modems:
+	if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
+		continue
+
+	connman =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.ConnectionManager')
+
+	contexts =3D connman.GetContexts()
+
+	if (len(contexts) =3D=3D 0):
+		print "No context available"
+		sys.exit(1)
+
+	path =3D contexts[int(sys.argv[1])][0]
+	context =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.ConnectionContext')
+
+	try:
+		context.SetProperty(sys.argv[2], sys.argv[3])
+	except dbus.DBusException, e:
+		print "Error setting context %s property %s: %s" % (path, sys.argv[2], s=
tr(e))
+		exit(2)
-- =

1.7.1


--===============8216502596831187218==--

