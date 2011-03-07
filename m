Content-Type: multipart/mixed; boundary="===============2208494754879627028=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND 3 PATCH 05/13] test: modify test scripts for IPv6
Date: Mon, 07 Mar 2011 16:02:31 +0200
Message-ID: <1299506559-32365-6-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1299506559-32365-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2208494754879627028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am               |    3 ++-
 test/set-context-property |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletions(-)
 create mode 100755 test/set-context-property

diff --git a/Makefile.am b/Makefile.am
index 3f20717..dc6ae39 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -501,7 +501,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-hangup \
 		test/disable-call-forwarding \
 		test/list-messages \
-		test/test-sms
+		test/test-sms \
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


--===============2208494754879627028==--

