Content-Type: multipart/mixed; boundary="===============1581267922782803196=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/2] test: Adapt data test scripts to multi-modem
Date: Tue, 10 Jun 2014 10:27:17 +0200
Message-ID: <1402388837-12816-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1402388837-12816-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1581267922782803196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some tests scripts were not ready to handle situations with more than
one modem present. This change fixes the data context scripts.
---
 test/activate-context   | 66 +++++++++++++++++++++++++++++++--------------=
----
 test/deactivate-context | 64 ++++++++++++++++++++++++++++++---------------=
--
 2 files changed, 83 insertions(+), 47 deletions(-)

diff --git a/test/activate-context b/test/activate-context
index 22ad173..9c00a17 100755
--- a/test/activate-context
+++ b/test/activate-context
@@ -5,36 +5,54 @@ import dbus
 =

 bus =3D dbus.SystemBus()
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'), 'org.ofono.Ma=
nager')
+
+if (len(sys.argv) =3D=3D 3):
+	modem =3D sys.argv[1]
+	context_idx =3D int(sys.argv[2]) - 1
+else:
+	modem =3D None
+	modems =3D manager.GetModems()
+	for path, properties in modems:
+		if "org.ofono.ConnectionManager" in properties["Interfaces"]:
+			modem =3D path
+			break
+	if (modem is None):
+		exit(2)
+	if (len(sys.argv) =3D=3D 1):
+		context_idx =3D 0
+	elif (len(sys.argv) =3D=3D 2):
+		context_idx =3D int(sys.argv[1]) - 1
+	else:
+		print("Usage: %s [modem] [context_number]" % (sys.argv[0]))
+		exit(1)
 =

-modems =3D manager.GetModems()
+modemapi =3D dbus.Interface(bus.get_object('org.ofono', modem), 'org.ofono=
.Modem')
+properties =3D modemapi.GetProperties()
 =

-for path, properties in modems:
-	if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
-		continue
+if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
+	print("org.ofono.ConnectionManager not found")
+	exit(2)
 =

-	connman =3D dbus.Interface(bus.get_object('org.ofono', path),
-					'org.ofono.ConnectionManager')
+connman =3D dbus.Interface(bus.get_object('org.ofono', modem),
+				'org.ofono.ConnectionManager')
 =

-	contexts =3D connman.GetContexts()
+contexts =3D connman.GetContexts()
 =

-	if (len(contexts) =3D=3D 0):
-		print("No context available")
-		sys.exit(1)
+if (len(contexts) =3D=3D 0):
+	print("No context available")
+	exit(1)
 =

-	connman.SetProperty("Powered", dbus.Boolean(1))
+connman.SetProperty("Powered", dbus.Boolean(1))
 =

-	if len(sys.argv) > 1:
-		path =3D contexts[int(sys.argv[1])][0]
-	else:
-		path =3D contexts[0][0]
+path =3D contexts[context_idx][0]
 =

-	context =3D dbus.Interface(bus.get_object('org.ofono', path),
-					'org.ofono.ConnectionContext')
+context =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.ConnectionContext')
+
+try:
+	context.SetProperty("Active", dbus.Boolean(1), timeout =3D 100)
+except dbus.DBusException as e:
+	print("Error activating %s: %s" % (path, str(e)))
+	exit(2)
 =

-	try:
-		context.SetProperty("Active", dbus.Boolean(1), timeout =3D 100)
-	except dbus.DBusException as e:
-		print("Error activating %s: %s" % (path, str(e)))
-		exit(2)
diff --git a/test/deactivate-context b/test/deactivate-context
index bc2ffd3..24409cb 100755
--- a/test/deactivate-context
+++ b/test/deactivate-context
@@ -5,34 +5,52 @@ import dbus
 =

 bus =3D dbus.SystemBus()
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-						'org.ofono.Manager')
+manager =3D dbus.Interface(bus.get_object('org.ofono', '/'), 'org.ofono.Ma=
nager')
+
+if (len(sys.argv) =3D=3D 3):
+	modem =3D sys.argv[1]
+	context_idx =3D int(sys.argv[2]) - 1
+else:
+	modem =3D None
+	modems =3D manager.GetModems()
+	for path, properties in modems:
+		if "org.ofono.ConnectionManager" in properties["Interfaces"]:
+			modem =3D path
+			break
+	if (modem is None):
+		exit(2)
+	if (len(sys.argv) =3D=3D 1):
+		context_idx =3D 0
+	elif (len(sys.argv) =3D=3D 2):
+		context_idx =3D int(sys.argv[1]) - 1
+	else:
+		print("Usage: %s [modem] [context_number]" % (sys.argv[0]))
+		exit(1)
 =

-modems =3D manager.GetModems()
+modemapi =3D dbus.Interface(bus.get_object('org.ofono', modem), 'org.ofono=
.Modem')
+properties =3D modemapi.GetProperties()
 =

-for path, properties in modems:
-	if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
-		continue
+if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
+	print("org.ofono.ConnectionManager not found")
+	exit(2)
 =

-	connman =3D dbus.Interface(bus.get_object('org.ofono', path),
-					'org.ofono.ConnectionManager')
+connman =3D dbus.Interface(bus.get_object('org.ofono', modem),
+				'org.ofono.ConnectionManager')
 =

-	contexts =3D connman.GetContexts()
+contexts =3D connman.GetContexts()
 =

-	if (len(contexts) =3D=3D 0):
-		print("No context available")
-		sys.exit(1)
+if (len(contexts) =3D=3D 0):
+	print("No context available")
+	sys.exit(1)
 =

-	if len(sys.argv) > 1:
-		path =3D contexts[int(sys.argv[1])][0]
-	else:
-		path =3D contexts[0][0]
+path =3D contexts[context_idx][0]
 =

-	context =3D dbus.Interface(bus.get_object('org.ofono', path),
-					'org.ofono.ConnectionContext')
+context =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.ConnectionContext')
+
+try:
+	context.SetProperty("Active", dbus.Boolean(0))
+except dbus.DBusException as e:
+	print("Error deactivating %s: %s" % (path, str(e)))
+	exit(2)
 =

-	try:
-		context.SetProperty("Active", dbus.Boolean(0))
-	except dbus.DBusException as e:
-		print("Error activating %s: %s" % (path, str(e)))
-		exit(2)
-- =

1.9.1


--===============1581267922782803196==--

