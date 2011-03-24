Content-Type: multipart/mixed; boundary="===============0711161330989165080=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 2/2] test: add a script to set any GPRS context property
Date: Thu, 24 Mar 2011 14:32:24 +0200
Message-ID: <1300969944-20659-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1300969944-20659-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0711161330989165080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am               |    3 ++-
 test/set-context-property |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletions(-)
 create mode 100755 test/set-context-property

diff --git a/Makefile.am b/Makefile.am
index b0cbcd7..fce9cd8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -506,7 +506,8 @@ test_scripts =3D test/backtrace \
 		test/test-sms \
 		test/test-message-waiting \
 		test/cdma-connman-disable \
-		test/cdma-connman-enable
+		test/cdma-connman-enable \
+		test/set-context-property
 =

 if TEST
 testdir =3D $(pkglibdir)/test
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


--===============0711161330989165080==--

