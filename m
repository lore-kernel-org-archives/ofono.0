Content-Type: multipart/mixed; boundary="===============5531040510646716859=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/2] test: Adapt voice call test scripts to multi-modem
Date: Tue, 10 Jun 2014 10:27:16 +0200
Message-ID: <1402388837-12816-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5531040510646716859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some tests scripts were not ready to handle situations with more than
one modem present. This change fixes the scripts that handle voice
calls.
---
 test/create-multiparty  | 12 +++++++-----
 test/hangup-active      | 10 ++++++++--
 test/private-chat       | 17 ++++++++---------
 test/release-and-answer | 35 ++++++++++++++++++++++++++---------
 test/release-and-swap   | 35 ++++++++++++++++++++++++++---------
 5 files changed, 75 insertions(+), 34 deletions(-)

diff --git a/test/create-multiparty b/test/create-multiparty
index b6395e8..1b76010 100755
--- a/test/create-multiparty
+++ b/test/create-multiparty
@@ -8,12 +8,14 @@ bus =3D dbus.SystemBus()
 manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 						'org.ofono.Manager')
 =

-modems =3D manager.GetModems()
-
-path =3D modems[0][0]
-
-if (len(sys.argv) =3D=3D 2):
+if (len(sys.argv) =3D=3D 1):
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+elif (len(sys.argv) =3D=3D 2):
 	path =3D sys.argv[1]
+else:
+	print("Usage: %s [modem]" % (sys.argv[0]))
+	sys.exit(1)
 =

 manager =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.VoiceCallManager')
diff --git a/test/hangup-active b/test/hangup-active
index 8e65bc4..82e0eb0 100755
--- a/test/hangup-active
+++ b/test/hangup-active
@@ -8,8 +8,14 @@ bus =3D dbus.SystemBus()
 manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 						'org.ofono.Manager')
 =

-modems =3D manager.GetModems()
-path =3D modems[0][0]
+if (len(sys.argv) =3D=3D 1):
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+elif (len(sys.argv) =3D=3D 2):
+	path =3D sys.argv[1]
+else:
+	print("Usage: %s [modem]" % (sys.argv[0]))
+	sys.exit(1)
 =

 manager =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.VoiceCallManager')
diff --git a/test/private-chat b/test/private-chat
index 17d17d0..e7e5406 100755
--- a/test/private-chat
+++ b/test/private-chat
@@ -3,24 +3,23 @@
 import sys
 import dbus
 =

+if (len(sys.argv) !=3D 2):
+	print("Usage: %s [voicecall_path]" % (sys.argv[0]))
+	exit(1)
+
 bus =3D dbus.SystemBus()
 =

 manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 						'org.ofono.Manager')
 =

-modems =3D manager.GetModems()
-path =3D modems[0][0]
-
-if (len(sys.argv) =3D=3D 3):
-	path =3D sys.argv[1]
-	callid =3D sys.argv[2]
-else:
-	callid =3D sys.argv[1]
+call =3D sys.argv[1]
+sep =3D call.find("/", 1)
+path =3D call[0:sep]
 =

 manager =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.VoiceCallManager')
 =

-mpty =3D manager.PrivateChat(callid, timeout=3D100)
+mpty =3D manager.PrivateChat(call, timeout=3D100)
 =

 for path in mpty:
 	print(path)
diff --git a/test/release-and-answer b/test/release-and-answer
index 62eaa79..dec8e17 100755
--- a/test/release-and-answer
+++ b/test/release-and-answer
@@ -1,5 +1,6 @@
 #!/usr/bin/python3
 =

+import sys
 import dbus
 =

 bus =3D dbus.SystemBus()
@@ -7,16 +8,32 @@ bus =3D dbus.SystemBus()
 manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 						'org.ofono.Manager')
 =

-modems =3D manager.GetModems()
+if (len(sys.argv) =3D=3D 1):
+	path =3D None
+	modems =3D manager.GetModems()
+	for path_i, properties in modems:
+		if "org.ofono.VoiceCallManager" in properties["Interfaces"]:
+			path =3D path_i
+			break
+	if (path is None):
+		exit(2)
+elif (len(sys.argv) =3D=3D 2):
+	path =3D sys.argv[1]
+else:
+	print("Usage: %s [modem]" % (sys.argv[0]))
+	exit(1)
 =

-for path, properties in modems:
-	print("[ %s ]" % (path))
+modemapi =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofono.=
Modem')
+properties =3D modemapi.GetProperties()
 =

-	if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
-		continue
+if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
+	print("org.ofono.VoiceCallManager not found")
+	exit(2)
 =

-	mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
-					'org.ofono.VoiceCallManager')
+print("[ %s ]" % (path))
+
+mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
+			'org.ofono.VoiceCallManager')
+
+mgr.ReleaseAndAnswer()
 =

-	mgr.ReleaseAndAnswer()
-	break
diff --git a/test/release-and-swap b/test/release-and-swap
index b4c0af1..cb8c84e 100755
--- a/test/release-and-swap
+++ b/test/release-and-swap
@@ -1,5 +1,6 @@
 #!/usr/bin/python3
 =

+import sys
 import dbus
 =

 bus =3D dbus.SystemBus()
@@ -7,16 +8,32 @@ bus =3D dbus.SystemBus()
 manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 						'org.ofono.Manager')
 =

-modems =3D manager.GetModems()
+if (len(sys.argv) =3D=3D 1):
+	modem =3D None
+	modems =3D manager.GetModems()
+	for path, properties in modems:
+		if "org.ofono.VoiceCallManager" in properties["Interfaces"]:
+			modem =3D path
+			break
+	if (modem is None):
+		exit(2)
+elif (len(sys.argv) =3D=3D 2):
+	modem =3D sys.argv[1]
+else:
+	print("Usage: %s [modem]" % (sys.argv[0]))
+	exit(1)
 =

-for path, properties in modems:
-	print("[ %s ]" % (path))
+modemapi =3D dbus.Interface(bus.get_object('org.ofono', modem), 'org.ofono=
.Modem')
+properties =3D modemapi.GetProperties()
 =

-	if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
-		continue
+if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
+	print("org.ofono.VoiceCallManager not found")
+	exit(2)
 =

-	mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
-					'org.ofono.VoiceCallManager')
+print("[ %s ]" % (modem))
+
+mgr =3D dbus.Interface(bus.get_object('org.ofono', modem),
+			'org.ofono.VoiceCallManager')
+
+mgr.ReleaseAndSwap()
 =

-	mgr.ReleaseAndSwap()
-	break
-- =

1.9.1


--===============5531040510646716859==--

