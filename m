Content-Type: multipart/mixed; boundary="===============0421970140927610723=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] test: add compatibility with python3
Date: Tue, 30 Nov 2010 18:12:13 -0200
Message-ID: <1291147933-27708-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0421970140927610723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following conversion was made to python scripts, which maintains
compatibility with both python 2.6 and 3.x:

- except dbus.DBusException, e:
+ except dbus.DBusException as e:

- print "Release"
+ print("Release")

- for key in props.keys():
+ for key in list(props.keys()):

- if properties.has_key('Manufacturer'):
+ if 'Manufacturer' in properties:

Scripts that use raw_input() or use a unicode object are
not yet compatible with python3.
---
 test/activate-context          |    6 +-
 test/answer-calls              |    4 +-
 test/backtrace                 |    8 ++--
 test/cancel-ussd               |    2 +-
 test/create-internet-context   |   10 ++--
 test/create-mms-context        |   10 ++--
 test/create-multiparty         |    2 +-
 test/deactivate-context        |    6 +-
 test/dial-number               |    2 +-
 test/disable-gprs              |    2 +-
 test/disable-modem             |    2 +-
 test/enable-cbs                |    2 +-
 test/enable-gprs               |    2 +-
 test/enable-modem              |    2 +-
 test/enter-pin                 |    4 +-
 test/get-icon                  |    4 +-
 test/get-operators             |    8 ++--
 test/get-tech-preference       |    2 +-
 test/initiate-ussd             |   12 +++---
 test/list-calls                |   10 ++--
 test/list-contexts             |   12 +++---
 test/list-modems               |   14 +++---
 test/list-operators            |   10 ++--
 test/lock-pin                  |    4 +-
 test/monitor-ofono             |   20 ++++----
 test/offline-modem             |    2 +-
 test/online-modem              |    2 +-
 test/private-chat              |    2 +-
 test/process-context-settings  |   14 +++---
 test/receive-sms               |    4 +-
 test/remove-contexts           |    2 +-
 test/reset-pin                 |    4 +-
 test/scan-for-operators        |   10 ++--
 test/send-sms                  |    2 +-
 test/send-vcard                |    2 +-
 test/set-cbs-topics            |    4 +-
 test/set-fast-dormancy         |    4 +-
 test/set-mms-details           |    8 ++--
 test/set-roaming-allowed       |    2 +-
 test/set-tech-preference       |    4 +-
 test/set-tty                   |    4 +-
 test/set-use-sms-reports       |    4 +-
 test/test-advice-of-charge     |   36 ++++++++--------
 test/test-call-barring         |   24 +++++-----
 test/test-call-forwarding      |   70 +++++++++++++++---------------
 test/test-call-settings        |   36 ++++++++--------
 test/test-modem                |   18 ++++----
 test/test-network-registration |   34 +++++++-------
 test/test-phonebook            |    2 +-
 test/test-push-notification    |   10 ++--
 test/test-smart-messaging      |   20 ++++----
 test/test-ss-control-cb        |   76 ++++++++++++++++----------------
 test/test-ss-control-cf        |   32 +++++++-------
 test/test-ss-control-cs        |   92 ++++++++++++++++++++----------------=
----
 test/test-stk-menu             |   48 ++++++++++----------
 test/test-ussd                 |   16 ++++----
 test/test-voicecall            |   38 ++++++++--------
 test/unlock-pin                |    4 +-
 58 files changed, 395 insertions(+), 395 deletions(-)

diff --git a/test/activate-context b/test/activate-context
index 2e64db5..0b83b41 100755
--- a/test/activate-context
+++ b/test/activate-context
@@ -20,7 +20,7 @@ for path, properties in modems:
 	contexts =3D connman.GetContexts()
 =

 	if (len(contexts) =3D=3D 0):
-		print "No context available"
+		print("No context available")
 		sys.exit(1)
 =

 	connman.SetProperty("Powered", dbus.Boolean(1))
@@ -35,6 +35,6 @@ for path, properties in modems:
 =

 	try:
 		context.SetProperty("Active", dbus.Boolean(1))
-	except dbus.DBusException, e:
-		print "Error activating %s: %s" % (path, str(e))
+	except dbus.DBusException as e:
+		print("Error activating %s: %s" % (path, str(e)))
 		exit(2)
diff --git a/test/answer-calls b/test/answer-calls
index 0deb832..45ff08f 100755
--- a/test/answer-calls
+++ b/test/answer-calls
@@ -10,7 +10,7 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '/=
'),
 modems =3D manager.GetModems()
 =

 for path, properties in modems:
-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

 	if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
 		continue
@@ -22,7 +22,7 @@ for path, properties in modems:
 =

 	for path, properties in calls:
 		state =3D properties["State"]
-		print "[ %s ] %s" % (path, state)
+		print("[ %s ] %s" % (path, state))
 =

 		if state !=3D "incoming":
 			continue
diff --git a/test/backtrace b/test/backtrace
index c906f36..c624709 100755
--- a/test/backtrace
+++ b/test/backtrace
@@ -6,7 +6,7 @@ import sys
 import subprocess
 =

 if (len(sys.argv) < 3):
-	print "Usage: %s [binary] [log]" % (sys.argv[0])
+	print("Usage: %s [binary] [log]" % (sys.argv[0]))
 	sys.exit(1)
 =

 binary =3D sys.argv[1]
@@ -50,8 +50,8 @@ child_stdout.close()
 frame_count =3D len(frames);
 =

 count =3D 0
-print "-------- backtrace --------"
+print("-------- backtrace --------")
 while count < frame_count:
-	print "[%d]: %s() [%s]" % (count/2, frames[count], frames[count + 1])
+	print("[%d]: %s() [%s]" % (count/2, frames[count], frames[count + 1]))
 	count =3D count + 2
-print "---------------------------"
+print("---------------------------")
diff --git a/test/cancel-ussd b/test/cancel-ussd
index 7379622..2a7407d 100755
--- a/test/cancel-ussd
+++ b/test/cancel-ussd
@@ -18,7 +18,7 @@ ussd =3D dbus.Interface(bus.get_object('org.ofono', path),
 properties =3D ussd.GetProperties()
 state =3D properties["State"]
 =

-print "State: %s" % (state)
+print("State: %s" % (state))
 =

 if state !=3D "idle":
 	ussd.Cancel()
diff --git a/test/create-internet-context b/test/create-internet-context
index 3d548d0..efd0998 100755
--- a/test/create-internet-context
+++ b/test/create-internet-context
@@ -27,21 +27,21 @@ for path, properties in modems:
 =

 	if path =3D=3D "":
 		path =3D connman.AddContext("internet")
-		print "Created new context %s" % (path)
+		print("Created new context %s" % (path))
 	else:
-		print "Found context %s" % (path)
+		print("Found context %s" % (path))
 =

 	context =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.ConnectionContext')
 =

 	if len(sys.argv) > 1:
 		context.SetProperty("AccessPointName", sys.argv[1])
-		print "Setting APN to %s" % (sys.argv[1])
+		print("Setting APN to %s" % (sys.argv[1]))
 =

 	if len(sys.argv) > 2:
 		context.SetProperty("Username", sys.argv[2])
-		print "Setting username to %s" % (sys.argv[2])
+		print("Setting username to %s" % (sys.argv[2]))
 =

 	if len(sys.argv) > 3:
 		context.SetProperty("Password", sys.argv[3])
-		print "Setting password to %s" % (sys.argv[3])
+		print("Setting password to %s" % (sys.argv[3]))
diff --git a/test/create-mms-context b/test/create-mms-context
index 861ca7c..e5be08d 100755
--- a/test/create-mms-context
+++ b/test/create-mms-context
@@ -27,21 +27,21 @@ for path, properties in modems:
 =

 	if path =3D=3D "":
 		path =3D connman.AddContext("mms")
-		print "Created new context %s" % (path)
+		print("Created new context %s" % (path))
 	else:
-		print "Found context %s" % (path)
+		print("Found context %s" % (path))
 =

 	context =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.ConnectionContext')
 =

 	if len(sys.argv) > 1:
 		context.SetProperty("AccessPointName", sys.argv[1])
-		print "Setting APN to %s" % (sys.argv[1])
+		print("Setting APN to %s" % (sys.argv[1]))
 =

 	if len(sys.argv) > 2:
 		context.SetProperty("Username", sys.argv[2])
-		print "Setting username to %s" % (sys.argv[2])
+		print("Setting username to %s" % (sys.argv[2]))
 =

 	if len(sys.argv) > 3:
 		context.SetProperty("Password", sys.argv[3])
-		print "Setting password to %s" % (sys.argv[3])
+		print("Setting password to %s" % (sys.argv[3]))
diff --git a/test/create-multiparty b/test/create-multiparty
index 79e98a6..649936a 100755
--- a/test/create-multiparty
+++ b/test/create-multiparty
@@ -18,4 +18,4 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', pa=
th),
 mpty =3D manager.CreateMultiparty()
 =

 for path in mpty:
-	print path
+	print(path)
diff --git a/test/deactivate-context b/test/deactivate-context
index e3754c2..848bcbd 100755
--- a/test/deactivate-context
+++ b/test/deactivate-context
@@ -20,7 +20,7 @@ for path, properties in modems:
 	contexts =3D connman.GetContexts()
 =

 	if (len(contexts) =3D=3D 0):
-		print "No context available"
+		print("No context available")
 		sys.exit(1)
 =

 	if len(sys.argv) > 1:
@@ -33,6 +33,6 @@ for path, properties in modems:
 =

 	try:
 		context.SetProperty("Active", dbus.Boolean(0))
-	except dbus.DBusException, e:
-		print "Error activating %s: %s" % (path, str(e))
+	except dbus.DBusException as e:
+		print("Error activating %s: %s" % (path, str(e)))
 		exit(2)
diff --git a/test/dial-number b/test/dial-number
index d66a878..3d344cb 100755
--- a/test/dial-number
+++ b/test/dial-number
@@ -20,4 +20,4 @@ if len(sys.argv) > 2:
 else:
     path =3D manager.Dial(sys.argv[1], "")
 =

-print path
+print(path)
diff --git a/test/disable-gprs b/test/disable-gprs
index cca2c78..c6c40a5 100755
--- a/test/disable-gprs
+++ b/test/disable-gprs
@@ -13,7 +13,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Disconnecting GPRS on modem %s..." % path
+print("Disconnecting GPRS on modem %s..." % path)
 cm =3D dbus.Interface(bus.get_object('org.ofono', path),
 		'org.ofono.ConnectionManager')
 =

diff --git a/test/disable-modem b/test/disable-modem
index 45ac2a9..b9373b6 100755
--- a/test/disable-modem
+++ b/test/disable-modem
@@ -13,7 +13,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Disconnecting modem %s..." % path
+print("Disconnecting modem %s..." % path)
 modem =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.Modem')
 =

diff --git a/test/enable-cbs b/test/enable-cbs
index 9b5b57b..c08bf2b 100755
--- a/test/enable-cbs
+++ b/test/enable-cbs
@@ -13,7 +13,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Enabling cell broadcast on modem %s..." % path
+print("Enabling cell broadcast on modem %s..." % path)
 cbs =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.CellBroadcast')
 =

diff --git a/test/enable-gprs b/test/enable-gprs
index 2b273a7..8664891 100755
--- a/test/enable-gprs
+++ b/test/enable-gprs
@@ -13,7 +13,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Connecting modem %s..." % path
+print("Connecting modem %s..." % path)
 cm =3D dbus.Interface(bus.get_object('org.ofono', path),
 		'org.ofono.ConnectionManager')
 =

diff --git a/test/enable-modem b/test/enable-modem
index 44ce64a..2b12e22 100755
--- a/test/enable-modem
+++ b/test/enable-modem
@@ -13,7 +13,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Connecting modem %s..." % path
+print("Connecting modem %s..." % path)
 modem =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.Modem')
 =

diff --git a/test/enter-pin b/test/enter-pin
index 0bfe112..faeb22b 100755
--- a/test/enter-pin
+++ b/test/enter-pin
@@ -17,9 +17,9 @@ elif len(sys.argv) =3D=3D 3:
 	pin_type =3D sys.argv[1]
 	pin =3D sys.argv[2]
 else:
-	print "%s [PATH] pin_type pin" % (sys.argv[0])
+	print("%s [PATH] pin_type pin" % (sys.argv[0]))
 =

-print "Enter Pin for modem %s..." % path
+print("Enter Pin for modem %s..." % path)
 simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.SimManager')
 =

diff --git a/test/get-icon b/test/get-icon
index 326d562..bba463d 100755
--- a/test/get-icon
+++ b/test/get-icon
@@ -8,7 +8,7 @@ bus =3D dbus.SystemBus()
 if len(sys.argv) =3D=3D 2:
 	id =3D sys.argv[1]
 else:
-	print "%s <icon id>" % (sys.argv[0])
+	print("%s <icon id>" % (sys.argv[0]))
 	sys.exit(0)
 =

 manager =3D dbus.Interface(bus.get_object("org.ofono", "/"),
@@ -28,4 +28,4 @@ icon =3D sim.GetIcon(dbus.Byte(int(sys.argv[1])))
 xpm =3D ""
 for byte in icon:
 	xpm +=3D str(byte)
-print xpm
+print(xpm)
diff --git a/test/get-operators b/test/get-operators
index f5bac12..7f70abf 100755
--- a/test/get-operators
+++ b/test/get-operators
@@ -22,16 +22,16 @@ for entry in operators:
 	path =3D entry[0]
 	properties =3D entry[1]
 =

-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

-	for key in properties.keys():
+	for key in list(properties.keys()):
 		if key in ["Technologies"]:
 			val =3D ""
 			for i in properties[key]:
 				val +=3D i + " "
 		else:
 			val =3D str(properties[key])
-		print "    %s =3D %s" % (key, val)
+		print("    %s =3D %s" % (key, val))
 =

-	print
+	print()
 =

diff --git a/test/get-tech-preference b/test/get-tech-preference
index fc65536..77d20d0 100755
--- a/test/get-tech-preference
+++ b/test/get-tech-preference
@@ -17,4 +17,4 @@ radiosettings =3D dbus.Interface(bus.get_object('org.ofon=
o', path),
 =

 properties =3D radiosettings.GetProperties()
 =

-print "Technology preference: %s" % (properties["TechnologyPreference"])
+print("Technology preference: %s" % (properties["TechnologyPreference"]))
diff --git a/test/initiate-ussd b/test/initiate-ussd
index b6a2d86..5f5c0ae 100755
--- a/test/initiate-ussd
+++ b/test/initiate-ussd
@@ -4,7 +4,7 @@ import sys
 import dbus
 =

 if (len(sys.argv) < 2):
-	print "Usage: %s <ussd-string>" % (sys.argv[0])
+	print("Usage: %s <ussd-string>" % (sys.argv[0]))
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -21,7 +21,7 @@ ussd =3D dbus.Interface(bus.get_object('org.ofono', path),
 properties =3D ussd.GetProperties()
 state =3D properties["State"]
 =

-print "State: %s" % (state)
+print("State: %s" % (state))
 =

 if state !=3D "idle":
 	sys.exit(1);
@@ -31,12 +31,12 @@ result =3D ussd.Initiate(sys.argv[1], timeout=3D100)
 properties =3D ussd.GetProperties()
 state =3D properties["State"]
 =

-print result[0] + ": " + result[1]
+print(result[0] + ": " + result[1])
 =

 if state =3D=3D "idle":
 	sys.exit(0)
 =

-print "State: %s" % (state)
+print("State: %s" % (state))
 =

 while state =3D=3D "user-response":
 	response =3D raw_input("Enter response: ")
@@ -46,7 +46,7 @@ while state =3D=3D "user-response":
 	properties =3D ussd.GetProperties()
 	state =3D properties["State"]
 =

-	print result
+	print(result)
 =

 	if state !=3D "idle":
-		print "State: %s" % (state)
+		print("State: %s" % (state))
diff --git a/test/list-calls b/test/list-calls
index 53124dc..b305dc2 100755
--- a/test/list-calls
+++ b/test/list-calls
@@ -10,7 +10,7 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '/=
'),
 modems =3D manager.GetModems()
 =

 for path, properties in modems:
-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

 	if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
 		continue
@@ -21,10 +21,10 @@ for path, properties in modems:
 	calls =3D mgr.GetCalls()
 =

 	for path, properties in calls:
-		print "    [ %s ]" % (path)
+		print("    [ %s ]" % (path))
 =

-		for key in properties.keys():
+		for key in list(properties.keys()):
 			val =3D str(properties[key])
-			print "        %s =3D %s" % (key, val)
+			print("        %s =3D %s" % (key, val))
 =

-		print
+		print()
diff --git a/test/list-contexts b/test/list-contexts
index 68dae6a..bab06ad 100755
--- a/test/list-contexts
+++ b/test/list-contexts
@@ -10,7 +10,7 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '/=
'),
 modems =3D manager.GetModems()
 =

 for path, properties in modems:
-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

 	if "org.ofono.ConnectionManager" not in properties["Interfaces"]:
 		continue
@@ -21,12 +21,12 @@ for path, properties in modems:
 	contexts =3D connman.GetContexts()
 =

 	for path, properties in contexts:
-		print "    [ %s ]" % (path)
+		print("    [ %s ]" % (path))
 =

-		for key in properties.keys():
+		for key in list(properties.keys()):
 			if key in ["Settings"]:
 				val =3D "{"
-				for i in properties[key].keys():
+				for i in list(properties[key].keys()):
 					val +=3D " " + i + "=3D"
 					if i in ["DomainNameServers"]:
 						for n in properties[key][i]:
@@ -36,6 +36,6 @@ for path, properties in modems:
 				val +=3D " }"
 			else:
 				val =3D str(properties[key])
-			print "        %s =3D %s" % (key, val)
+			print("        %s =3D %s" % (key, val))
 =

-		print
+		print()
diff --git a/test/list-modems b/test/list-modems
index 557efd5..5e7f74b 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -10,29 +10,29 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', =
'/'),
 modems =3D manager.GetModems()
 =

 for path, properties in modems:
-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

-	for key in properties.keys():
+	for key in list(properties.keys()):
 		if key in ["Interfaces", "Features"]:
 			val =3D ""
 			for i in properties[key]:
 				val +=3D i + " "
 		else:
 			val =3D str(properties[key])
-		print "    %s =3D %s" % (key, val)
+		print("    %s =3D %s" % (key, val))
 =

 	for interface in properties["Interfaces"]:
 		object =3D dbus.Interface(bus.get_object('org.ofono', path),
 								interface)
 =

-		print "    [ %s ]" % (interface)
+		print("    [ %s ]" % (interface))
 =

 		try:
 			properties =3D object.GetProperties()
 		except:
 			continue
 =

-		for key in properties.keys():
+		for key in list(properties.keys()):
 			if key in ["Calls",
 					"MultipartyCalls",
 					"EmergencyNumbers",
@@ -58,6 +58,6 @@ for path, properties in modems:
 					")" for text, icon in properties[key] ])
 			else:
 				val =3D str(properties[key])
-			print "        %s =3D %s" % (key, val)
+			print("        %s =3D %s" % (key, val))
 =

-	print
+	print()
diff --git a/test/list-operators b/test/list-operators
index be00c5b..f7a149e 100755
--- a/test/list-operators
+++ b/test/list-operators
@@ -11,7 +11,7 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '/=
'),
 modems =3D manager.GetModems()
 =

 for path, properties in modems:
-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

 	if "org.ofono.NetworkRegistration" not in properties["Interfaces"]:
 		continue
@@ -25,15 +25,15 @@ for path, properties in modems:
 		operators =3D netreg.GetOperators()
 =

 	for path, properties in operators:
-		print "    [ %s ]" % (path)
+		print("    [ %s ]" % (path))
 =

-		for key in properties.keys():
+		for key in list(properties.keys()):
 			if key in ["Technologies"]:
 				val =3D ""
 				for i in properties[key]:
 					val +=3D i + " "
 			else:
 				val =3D str(properties[key])
-			print "        %s =3D %s" % (key, val)
+			print("        %s =3D %s" % (key, val))
 =

-		print
+		print()
diff --git a/test/lock-pin b/test/lock-pin
index 60c3afb..5579735 100755
--- a/test/lock-pin
+++ b/test/lock-pin
@@ -17,10 +17,10 @@ elif len(sys.argv) =3D=3D 3:
 	pin_type =3D sys.argv[1]
 	pin =3D sys.argv[2]
 else:
-	print "%s [PATH] pin_type pin" % (sys.argv[0])
+	print("%s [PATH] pin_type pin" % (sys.argv[0]))
 	sys.exit(0)
 =

-print "Lock %s %s for modem %s..." % (pin_type, pin, path)
+print("Lock %s %s for modem %s..." % (pin_type, pin, path))
 =

 simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.SimManager')
diff --git a/test/monitor-ofono b/test/monitor-ofono
index 8570c34..2c544f0 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -24,7 +24,7 @@ def dbus2py(d):
 	if t in _dbus2py:
 		return _dbus2py[t](d)
 	if t is dbus.Dictionary:
-		return dict([(dbus2py(k), dbus2py(v)) for k, v in d.items()])
+		return dict([(dbus2py(k), dbus2py(v)) for k, v in list(d.items())])
 	if t is dbus.Array and d.signature =3D=3D "y":
 		return "".join([chr(b) for b in d])
 	if t is dbus.Array or t is list:
@@ -40,7 +40,7 @@ def pretty(d):
 	if t in (dict, tuple, list) and len(d) > 0:
 		if t is dict:
 			d =3D ", ".join(["%s =3D %s" % (k, pretty(v))
-					for k, v in d.items()])
+					for k, v in list(d.items())])
 			return "{ %s }" % d
 =

 		d =3D " ".join([pretty(e) for e in d])
@@ -52,32 +52,32 @@ def pretty(d):
 =

 def property_changed(name, value, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s =3D %s" % (iface, path, name, pretty(value))
+	print("{%s} [%s] %s =3D %s" % (iface, path, name, pretty(value)))
 =

 def added(name, value, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s %s" % (iface, member, name, pretty(value))
+	print("{%s} [%s] %s %s" % (iface, member, name, pretty(value)))
 =

 def removed(name, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s" % (iface, name, member)
+	print("{%s} [%s] %s" % (iface, name, member))
 =

 def event(member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s" % (iface, path, member)
+	print("{%s} [%s] %s" % (iface, path, member))
 =

 def message(msg, args, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s %s (%s)" % (iface, path, member,
-					str(msg), pretty(args))
+	print("{%s} [%s] %s %s (%s)" % (iface, path, member,
+					str(msg), pretty(args)))
 =

 def ussd(msg, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s %s" % (iface, path, member, str(msg))
+	print("{%s} [%s] %s %s" % (iface, path, member, str(msg)))
 =

 def value(value, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s %s" % (iface, path, member, str(value))
+	print("{%s} [%s] %s %s" % (iface, path, member, str(value)))
 =

 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
diff --git a/test/offline-modem b/test/offline-modem
index 793e9d4..e450d12 100755
--- a/test/offline-modem
+++ b/test/offline-modem
@@ -12,6 +12,6 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Setting modem %s offline..." % path
+print("Setting modem %s offline..." % path)
 modem =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofono.Mod=
em')
 modem.SetProperty("Online", dbus.Boolean(0))
diff --git a/test/online-modem b/test/online-modem
index f37b046..bd10b50 100755
--- a/test/online-modem
+++ b/test/online-modem
@@ -12,6 +12,6 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Setting modem %s online..." % path
+print("Setting modem %s online..." % path)
 modem =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofono.Mod=
em')
 modem.SetProperty("Online", dbus.Boolean(1))
diff --git a/test/private-chat b/test/private-chat
index 4938a25..a9edfb6 100755
--- a/test/private-chat
+++ b/test/private-chat
@@ -17,4 +17,4 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', pa=
th),
 mpty =3D manager.PrivateChat(sys.argv[1])
 =

 for path in mpty:
-	print path
+	print(path)
diff --git a/test/process-context-settings b/test/process-context-settings
index 09635b3..a0c582d 100755
--- a/test/process-context-settings
+++ b/test/process-context-settings
@@ -23,7 +23,7 @@ for path, properties in modems:
 		if properties["Active"] =3D=3D dbus.Boolean(0):
 			continue
 =

-		print "Configuring %s" % (path)
+		print("Configuring %s" % (path))
 =

 		settings =3D properties["Settings"]
 =

@@ -35,20 +35,20 @@ for path, properties in modems:
 			gateway =3D "0.0.0.0";
 =

 		if settings["Method"] =3D=3D "dhcp":
-			print "    Run DHCP on interface %s" % (interface)
+			print("    Run DHCP on interface %s" % (interface))
 		else:
-			print "    Interface is %s" % (interface)
-			print "    IP address is %s" % (address)
-			print "    Gateway is %s" % (gateway)
+			print("    Interface is %s" % (interface))
+			print("    IP address is %s" % (address))
+			print("    Gateway is %s" % (gateway))
 =

 			cmd =3D "ifconfig " + interface + " " + address
 			cmd +=3D " netmask 255.255.255.255"
 			os.system(cmd);
 =

 			for i in settings["DomainNameServers"]:
-				print "    Nameserver is %s" % (i)
+				print("    Nameserver is %s" % (i))
 =

 				cmd =3D "route add -host " + i
 				cmd +=3D" dev " + interface
 				os.system(cmd);
-		print
+		print()
diff --git a/test/receive-sms b/test/receive-sms
index a658c58..b40ce3c 100755
--- a/test/receive-sms
+++ b/test/receive-sms
@@ -6,11 +6,11 @@ import dbus
 import dbus.mainloop.glib
 =

 def incoming_message(message, details, path, interface):
-	print "%s" % (message)
+	print("%s" % (message))
 =

 	for key in details:
 		val =3D details[key]
-		print "    %s =3D %s" % (key, val)
+		print("    %s =3D %s" % (key, val))
 =

 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
diff --git a/test/remove-contexts b/test/remove-contexts
index a600d0b..c5082cb 100755
--- a/test/remove-contexts
+++ b/test/remove-contexts
@@ -20,4 +20,4 @@ for path, properties in modems:
 =

 	for path, properties in contexts:
 		connman.RemoveContext(path)
-		print"Removed: [ %s ]" % (path)
+		print("Removed: [ %s ]" % (path))
diff --git a/test/reset-pin b/test/reset-pin
index d0145fe..b429254 100755
--- a/test/reset-pin
+++ b/test/reset-pin
@@ -14,9 +14,9 @@ elif len(sys.argv) =3D=3D 4:
 	path =3D modems[0][0]
 	puk_type, puk, pin =3D sys.argv[1:]
 else:
-	print "%s [PATH] puk_type puk pin" % (sys.argv[0])
+	print("%s [PATH] puk_type puk pin" % (sys.argv[0]))
 =

-print "Reset pin for modem %s..." % path
+print("Reset pin for modem %s..." % path)
 simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.SimManager')
 =

diff --git a/test/scan-for-operators b/test/scan-for-operators
index 285f111..5c1af10 100755
--- a/test/scan-for-operators
+++ b/test/scan-for-operators
@@ -13,7 +13,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Propose scanning for modem %s..." % path
+print("Propose scanning for modem %s..." % path)
 netreg =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.NetworkRegistration')
 =

@@ -23,16 +23,16 @@ for entry in operators:
 	path =3D entry[0]
 	properties =3D entry[1]
 =

-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

-	for key in properties.keys():
+	for key in list(properties.keys()):
 		if key in ["Technologies"]:
 			val =3D ""
 			for i in properties[key]:
 				val +=3D i + " "
 		else:
 			val =3D str(properties[key])
-		print "    %s =3D %s" % (key, val)
+		print("    %s =3D %s" % (key, val))
 =

-	print
+	print()
 =

diff --git a/test/send-sms b/test/send-sms
index bd1fae5..00b130e 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -21,4 +21,4 @@ if len(sys.argv) =3D=3D 4:
 else:
 	path =3D manager.SendMessage(sys.argv[1], sys.argv[2])
 =

-print path
+print(path)
diff --git a/test/send-vcard b/test/send-vcard
index d11d5ac..2f54a0c 100755
--- a/test/send-vcard
+++ b/test/send-vcard
@@ -17,4 +17,4 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', pa=
th),
 vcard =3D file(sys.argv[2]).read()
 path =3D manager.SendBusinessCard(sys.argv[1], vcard)
 =

-print path
+print(path)
diff --git a/test/set-cbs-topics b/test/set-cbs-topics
index fbf7aa4..78d6d44 100755
--- a/test/set-cbs-topics
+++ b/test/set-cbs-topics
@@ -15,9 +15,9 @@ elif len(sys.argv) =3D=3D 2:
 	path =3D modems[0][0]
 	topics =3D sys.argv[1]
 else:
-	print "%s [PATH] topics" % (sys.argv[0])
+	print("%s [PATH] topics" % (sys.argv[0]))
 =

-print "Setting cell broadcast topics for modem %s..." % path
+print("Setting cell broadcast topics for modem %s..." % path)
 cbs =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.CellBroadcast')
 =

diff --git a/test/set-fast-dormancy b/test/set-fast-dormancy
index 6951813..7bf7715 100755
--- a/test/set-fast-dormancy
+++ b/test/set-fast-dormancy
@@ -15,10 +15,10 @@ elif len(sys.argv) =3D=3D 2:
 	path =3D modems[0][0]
 	enable =3D int(sys.argv[1])
 else:
-	print "%s [PATH] {0|1}" % (sys.argv[0])
+	print("%s [PATH] {0|1}" % (sys.argv[0]))
 	exit(1)
 =

-print "Setting fast dormancy for modem %s..." % path
+print("Setting fast dormancy for modem %s..." % path)
 radiosettings =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.RadioSettings')
 =

diff --git a/test/set-mms-details b/test/set-mms-details
index 7540948..d2d0838 100755
--- a/test/set-mms-details
+++ b/test/set-mms-details
@@ -26,18 +26,18 @@ for path, properties in modems:
 			break
 =

 	if path =3D=3D "":
-		print "No MMS context"
+		print("No MMS context")
 		exit(1)
 =

 	context =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.ConnectionContext')
 =

 	if len(sys.argv) < 3:
-		print "Usage: %s <proxy> <center>" % (sys.argv[0])
+		print("Usage: %s <proxy> <center>" % (sys.argv[0]))
 		exit(1)
 =

 	context.SetProperty("MessageProxy", sys.argv[1])
-	print "Setting MMS Proxy to %s" % (sys.argv[1])
+	print("Setting MMS Proxy to %s" % (sys.argv[1]))
 =

 	context.SetProperty("MessageCenter", sys.argv[2])
-	print "Setting MMSC to %s" % (sys.argv[2])
+	print("Setting MMSC to %s" % (sys.argv[2]))
diff --git a/test/set-roaming-allowed b/test/set-roaming-allowed
index f7f9c9d..9e3e058 100755
--- a/test/set-roaming-allowed
+++ b/test/set-roaming-allowed
@@ -24,4 +24,4 @@ for path, properties in modems:
 =

 	connman.SetProperty("RoamingAllowed", allowed)
 =

-	print "Setting %s to RoamingAllowed=3D%d" % (path, allowed)
+	print("Setting %s to RoamingAllowed=3D%d" % (path, allowed))
diff --git a/test/set-tech-preference b/test/set-tech-preference
index cc735ce..2666cbd 100755
--- a/test/set-tech-preference
+++ b/test/set-tech-preference
@@ -15,9 +15,9 @@ elif len(sys.argv) =3D=3D 2:
 	path =3D modems[0][0]
 	tech =3D sys.argv[1]
 else:
-	print "%s [PATH] technology" % (sys.argv[0])
+	print("%s [PATH] technology" % (sys.argv[0]))
 =

-print "Setting technology preference for modem %s..." % path
+print("Setting technology preference for modem %s..." % path)
 radiosettings =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.RadioSettings')
 =

diff --git a/test/set-tty b/test/set-tty
index 67876af..53d6b99 100755
--- a/test/set-tty
+++ b/test/set-tty
@@ -15,10 +15,10 @@ elif len(sys.argv) =3D=3D 2:
 	path =3D modems[0][0]
 	enable =3D int(sys.argv[1])
 else:
-	print "%s [PATH] {0|1}" % (sys.argv[0])
+	print("%s [PATH] {0|1}" % (sys.argv[0]))
 	exit(1)
 =

-print "Setting TTY for modem %s..." % path
+print("Setting TTY for modem %s..." % path)
 texttelephony =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.TextTelephony')
 =

diff --git a/test/set-use-sms-reports b/test/set-use-sms-reports
index 1188197..f1aa87e 100755
--- a/test/set-use-sms-reports
+++ b/test/set-use-sms-reports
@@ -15,10 +15,10 @@ elif len(sys.argv) =3D=3D 2:
 	path =3D modems[0][0]
 	enabled =3D sys.argv[1]
 else:
-	print "%s [PATH] on/off" % (sys.argv[0])
+	print("%s [PATH] on/off" % (sys.argv[0]))
 	sys.exit(1)
 =

-print "Setting delivery report use for modem %s..." % path
+print("Setting delivery report use for modem %s..." % path)
 sms =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.MessageManager')
 =

diff --git a/test/test-advice-of-charge b/test/test-advice-of-charge
index d71b7c6..07af425 100755
--- a/test/test-advice-of-charge
+++ b/test/test-advice-of-charge
@@ -7,16 +7,16 @@ import dbus.mainloop.glib
 =

 =

 def cm_property_changed(name, value):
-	print "CallMeter property: '%s' changed to '%s'" % (name, str(value))
+	print("CallMeter property: '%s' changed to '%s'" % (name, str(value)))
 	if canexit:
 		mainloop.quit()
 =

 def cm_maximum_reached():
-	print "Only 30 seconds call time remains, recharge."
+	print("Only 30 seconds call time remains, recharge.")
 =

 def print_useage(s):
-	print "Usage: %s <property> <newvalue> <password>" % (s)
-	print "Usage: %s reset <password>" % (s)
+	print("Usage: %s <property> <newvalue> <password>" % (s))
+	print("Usage: %s reset <password>" % (s))
 	sys.exit(1);
 =

 if __name__ =3D=3D "__main__":
@@ -51,24 +51,24 @@ if __name__ =3D=3D "__main__":
 =

 	properties =3D cm.GetProperties()
 =

-	print "Currency: %s" % (properties['Currency'])
-	print "PricePerUnit %s" % (properties['PricePerUnit'])
-	print "Call meter for the current call: %s" % (properties['CallMeter'])
-	print "Call meter for current and previous calls: %s" %\
-		properties['AccumulatedCallMeter']
-	print "Call meter maximum, once reached calls are not possible: %s" %\
-		properties['AccumulatedCallMeterMaximum']
+	print("Currency: %s" % (properties['Currency']))
+	print("PricePerUnit %s" % (properties['PricePerUnit']))
+	print("Call meter for the current call: %s" % (properties['CallMeter']))
+	print("Call meter for current and previous calls: %s" %\
+		properties['AccumulatedCallMeter'])
+	print("Call meter maximum, once reached calls are not possible: %s" %\
+		properties['AccumulatedCallMeterMaximum'])
 =

 	total =3D properties['PricePerUnit'] * properties['AccumulatedCallMeter']
-	print "Accumulated Meter in Currency: %s %s" %\
-		(total, properties['Currency'])
+	print("Accumulated Meter in Currency: %s %s" %\
+		(total, properties['Currency']))
 =

 	if (sys.argv[1] =3D=3D 'reset'):
-		print "Resetting Accumulated Call Meter"
+		print("Resetting Accumulated Call Meter")
 		try:
 			cm.Reset(pin)
-		except dbus.DBusException, e:
-			print "Unable to reset ACM: ", e
+		except dbus.DBusException as e:
+			print("Unable to reset ACM: ", e)
 			sys.exit(1)
 	else:
 		try:
@@ -77,8 +77,8 @@ if __name__ =3D=3D "__main__":
 			elif property =3D=3D 'PricePerUnit':
 				newvalue =3D float(newvalue)
 			cm.SetProperty(property, newvalue, pin)
-		except dbus.DBusException, e:
-			print "Unable to set property: ", e
+		except dbus.DBusException as e:
+			print("Unable to set property: ", e)
 			sys.exit(1)
 =

 	canexit =3D True
diff --git a/test/test-call-barring b/test/test-call-barring
index 5385a10..ad5841a 100755
--- a/test/test-call-barring
+++ b/test/test-call-barring
@@ -7,13 +7,13 @@ import dbus.mainloop.glib
 =

 =

 def property_changed(name, value):
-	print "CallBarring property: '%s' changed to '%s'" % (name, str(value))
+	print("CallBarring property: '%s' changed to '%s'" % (name, str(value)))
 	if canexit:
 		mainloop.quit()
 =

 def print_useage(s):
-	print "Usage: %s <property> <newvalue> <password>" % (s)
-	print "Usage: %s disableall <password>" % (s)
+	print("Usage: %s <property> <newvalue> <password>" % (s))
+	print("Usage: %s disableall <password>" % (s))
 	sys.exit(1);
 =

 if __name__ =3D=3D "__main__":
@@ -47,23 +47,23 @@ if __name__ =3D=3D "__main__":
 =

 	properties =3D cb.GetProperties()
 =

-	print "Barring settings for Incoming Voice calls: %s" %\
-		(properties['VoiceIncoming'])
-	print "Barring settings for Outgoing Calls: %s" %\
-		(properties['VoiceOutgoing'])
+	print("Barring settings for Incoming Voice calls: %s" %\
+		(properties['VoiceIncoming']))
+	print("Barring settings for Outgoing Calls: %s" %\
+		(properties['VoiceOutgoing']))
 =

 	if (sys.argv[1] =3D=3D 'disableall'):
-		print "Disabling all barrings"
+		print("Disabling all barrings")
 		try:
 			cb.DisableAll(pin)
-		except dbus.DBusException, e:
-			print "Unable to Disable All barrings: ", e
+		except dbus.DBusException as e:
+			print("Unable to Disable All barrings: ", e)
 			sys.exit(1)
 	else:
 		try:
 			cb.SetProperty(property, newvalue, pin)
-		except dbus.DBusException, e:
-			print "Unable to set property: ", e
+		except dbus.DBusException as e:
+			print("Unable to set property: ", e)
 			sys.exit(1)
 =

 	canexit =3D True
diff --git a/test/test-call-forwarding b/test/test-call-forwarding
index 85aca23..a7ec1e4 100755
--- a/test/test-call-forwarding
+++ b/test/test-call-forwarding
@@ -6,16 +6,16 @@ import dbus
 import dbus.mainloop.glib
 =

 def property_changed(property, value):
-	print "CallForwarding property %s changed to %s" % (property, value)
+	print("CallForwarding property %s changed to %s" % (property, value))
 =

 def print_properties(cf):
 	properties =3D cf.GetProperties()
 =

 	for p in properties:
 		if len(properties[p].__str__()) > 0:
-			print "%s call forwarding rule is: %s" % (p, properties[p])
+			print("%s call forwarding rule is: %s" % (p, properties[p]))
 		else:
-			print "%s call forwarding rule disabled" % (p)
+			print("%s call forwarding rule disabled" % (p))
 =

 if __name__ =3D=3D "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -36,84 +36,84 @@ if __name__ =3D=3D "__main__":
 =

 	try:
 		cf.SetProperty("FoobarNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+	except dbus.DBusException as e:
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("VoiceNotReachableTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+	except dbus.DBusException as e:
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("VoiceNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+	except dbus.DBusException as e:
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("DataNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+	except dbus.DBusException as e:
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("FaxNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+	except dbus.DBusException as e:
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("SmsNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+	except dbus.DBusException as e:
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("VoiceNoReply", "")
-	except dbus.DBusException, e:
-		print "Unable to erase voice no reply rule - Bad"
+	except dbus.DBusException as e:
+		print("Unable to erase voice no reply rule - Bad")
 =

 	try:
 		cf.SetProperty("VoiceNoReply", "+134444")
-	except dbus.DBusException, e:
-		print "Unable to register voice no reply rule - Bad"
+	except dbus.DBusException as e:
+		print("Unable to register voice no reply rule - Bad")
 =

 	try:
 		cf.SetProperty("VoiceNoReplyTimeout", dbus.UInt16(30))
-	except dbus.DBusException, e:
-		print "Unable to set voice no reply timeout - Bad"
+	except dbus.DBusException as e:
+		print("Unable to set voice no reply timeout - Bad")
 =

 	properties =3D cf.GetProperties()
 =

-	print properties["VoiceNoReply"]
-	print properties["VoiceNoReplyTimeout"]
+	print(properties["VoiceNoReply"])
+	print(properties["VoiceNoReplyTimeout"])
 =

 	try:
 		cf.SetProperty("VoiceUnconditional", "+155555")
-	except dbus.DBusException, e:
-		print "Unable to set Voice Unconditional - Bad"
+	except dbus.DBusException as e:
+		print("Unable to set Voice Unconditional - Bad")
 =

 	properties =3D cf.GetProperties()
 =

-	print properties["VoiceUnconditional"]
+	print(properties["VoiceUnconditional"])
 =

 	try:
 		cf.DisableAll("foobar")
-	except dbus.DBusException, e:
-		print "Unable to delete invalids - Good"
+	except dbus.DBusException as e:
+		print("Unable to delete invalids - Good")
 =

 	try:
 		cf.DisableAll("conditional")
-	except dbus.DBusException, e:
-		print "Unable to delete all conditional - Bad"
+	except dbus.DBusException as e:
+		print("Unable to delete all conditional - Bad")
 =

 	properties =3D cf.GetProperties()
 =

-	print properties["VoiceNoReply"]
-	print properties["VoiceNoReplyTimeout"]
+	print(properties["VoiceNoReply"])
+	print(properties["VoiceNoReplyTimeout"])
 =

 	try:
 		cf.DisableAll("all")
-	except dbus.DBusException, e:
-		print "Unable to delete all conditional - Bad"
+	except dbus.DBusException as e:
+		print("Unable to delete all conditional - Bad")
 =

-	print properties["VoiceUnconditional"]
+	print(properties["VoiceUnconditional"])
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
diff --git a/test/test-call-settings b/test/test-call-settings
index 60fe3ba..0d5fb8c 100755
--- a/test/test-call-settings
+++ b/test/test-call-settings
@@ -7,15 +7,15 @@ import dbus.mainloop.glib
 import sys
 =

 def property_changed(name, value):
-	print "CallSettings property: '%s' changed to '%s'" % (name, value)
+	print("CallSettings property: '%s' changed to '%s'" % (name, value))
 =

 	if canexit:
 		mainloop.quit();
 =

 if __name__ =3D=3D "__main__":
 	if len(sys.argv) < 3:
-		print "Usage: %s <property> <newvalue>" % (sys.argv[0])
-		print "Properties can be: VoiceCallWaiting, HideCallerId"
+		print("Usage: %s <property> <newvalue>" % (sys.argv[0]))
+		print("Properties can be: VoiceCallWaiting, HideCallerId")
 		sys.exit(1)
 =

 	canexit =3D False
@@ -39,26 +39,26 @@ if __name__ =3D=3D "__main__":
 =

 	properties =3D cs.GetProperties()
 =

-	print "Current Property values:"
-	print "Network Status of Call Waiting - Voice: %s" %\
-		(properties['VoiceCallWaiting'])
-	print "Network Status of Called Line Restriction: %s" %\
-		(properties['CalledLineRestriction'])
-	print "Network Status of Calling Line Restriction: %s" %\
-		(properties['CallingLineRestriction'])
-	print "Network Status of Calling Line Presentation: %s" %\
-		(properties['CallingLinePresentation'])
-	print "Network Status of Called Line Presentation: %s" %\
-		(properties['CalledLinePresentation'])
-	print "Hide my Caller Id: %s" % (properties['HideCallerId'])
+	print("Current Property values:")
+	print("Network Status of Call Waiting - Voice: %s" %\
+		(properties['VoiceCallWaiting']))
+	print("Network Status of Called Line Restriction: %s" %\
+		(properties['CalledLineRestriction']))
+	print("Network Status of Calling Line Restriction: %s" %\
+		(properties['CallingLineRestriction']))
+	print("Network Status of Calling Line Presentation: %s" %\
+		(properties['CallingLinePresentation']))
+	print("Network Status of Called Line Presentation: %s" %\
+		(properties['CalledLinePresentation']))
+	print("Hide my Caller Id: %s" % (properties['HideCallerId']))
 =

 	try:
 		cs.SetProperty(property, newvalue)
-	except dbus.DBusException, e:
-		print "Unable to set property: ", e
+	except dbus.DBusException as e:
+		print("Unable to set property: ", e)
 		sys.exit(1);
 =

-	print "Setting successful"
+	print("Setting successful")
 =

 	canexit =3D True
 =

diff --git a/test/test-modem b/test/test-modem
index 5859ae3..e045f34 100755
--- a/test/test-modem
+++ b/test/test-modem
@@ -6,7 +6,7 @@ import dbus
 import dbus.mainloop.glib
 =

 def property_changed(name, value):
-	print "Modem property %s changed to %s" % (name, value)
+	print("Modem property %s changed to %s" % (name, value))
 =

 if __name__ =3D=3D "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -24,17 +24,17 @@ if __name__ =3D=3D "__main__":
 =

 	properties =3D modem.GetProperties()
 =

-	if properties.has_key('Manufacturer'):
-		print "Manufacturer: %s" % (properties['Manufacturer'])
+	if 'Manufacturer' in properties:
+		print("Manufacturer: %s" % (properties['Manufacturer']))
 =

-	if properties.has_key('Model'):
-		print "Model: %s" % (properties['Model'])
+	if 'Model' in properties:
+		print("Model: %s" % (properties['Model']))
 =

-	if properties.has_key('Revision'):
-		print "Revision: %s" % (properties['Revision'])
+	if 'Revision' in properties:
+		print("Revision: %s" % (properties['Revision']))
 =

-	if properties.has_key('Serial'):
-		print "Serial: %s" % (properties['Serial'])
+	if 'Serial' in properties:
+		print("Serial: %s" % (properties['Serial']))
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
diff --git a/test/test-network-registration b/test/test-network-registration
index a8bd141..8cfd2d8 100755
--- a/test/test-network-registration
+++ b/test/test-network-registration
@@ -6,20 +6,20 @@ import dbus
 import dbus.mainloop.glib
 =

 def network_property_changed(name, value):
-	print "Network Registration property '%s' changed to '%s'" %\
-		(name, value)
+	print("Network Registration property '%s' changed to '%s'" %\
+		(name, value))
 =

 	if name =3D=3D 'Name' and canexit:
 		mainloop.quit()
 =

 if __name__ =3D=3D "__main__":
 	if len(sys.argv) !=3D 2:
-		print "Usage: %s <path> - Register to PLMN on <path>" %\
-			(sys.argv[0])
-		print "Usage: %s default - Register to default PLMN" %\
-			(sys.argv[0])
-		print "Usage: %s unregister - Unregister from all PLMNs" %\
-			(sys.argv[0])
+		print("Usage: %s <path> - Register to PLMN on <path>" %\
+			(sys.argv[0]))
+		print("Usage: %s default - Register to default PLMN" %\
+			(sys.argv[0]))
+		print("Usage: %s unregister - Unregister from all PLMNs" %\
+			(sys.argv[0]))
 		sys.exit(1)
 =

 	canexit =3D False
@@ -40,15 +40,15 @@ if __name__ =3D=3D "__main__":
 =

 	props =3D netreg.GetProperties()
 =

-	print "Status is: '%s', Operator Name is: '%s'" %\
-		(props['Status'], props['Name'])
+	print("Status is: '%s', Operator Name is: '%s'" %\
+		(props['Status'], props['Name']))
 =

-	if props.has_key('LocationAreaCode') and props.has_key('CellId'):
-		print "Location: '%d', Cell: '%d'" %\
-			(props['LocationAreaCode'], props['CellId'])
+	if 'LocationAreaCode' in props and 'CellId' in props:
+		print("Location: '%d', Cell: '%d'" %\
+			(props['LocationAreaCode'], props['CellId']))
 =

-	if props.has_key('Technology'):
-		print "Technology: '%s'" % (props['Technology'])
+	if 'Technology' in props:
+		print("Technology: '%s'" % (props['Technology']))
 =

 	try:
 		if sys.argv[1] =3D=3D 'default':
@@ -59,8 +59,8 @@ if __name__ =3D=3D "__main__":
 			obj =3D bus.get_object('org.ofono', sys.argv[1]);
 			op =3D dbus.Interface(obj, 'org.ofono.NetworkOperator')
 			op.Register()
-	except dbus.DBusException, e:
-		print "Unable to register/deregister: ", e
+	except dbus.DBusException as e:
+		print("Unable to register/deregister: ", e)
 		sys.exit(1)
 =

 	canexit =3D True
diff --git a/test/test-phonebook b/test/test-phonebook
index 183394c..fa42b60 100755
--- a/test/test-phonebook
+++ b/test/test-phonebook
@@ -12,4 +12,4 @@ if __name__ =3D=3D "__main__":
 	phonebook =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
 				'org.ofono.Phonebook')
 =

-	print phonebook.Import(timeout=3D100)
+	print(phonebook.Import(timeout=3D100))
diff --git a/test/test-push-notification b/test/test-push-notification
index 4dca0d4..9c3b837 100755
--- a/test/test-push-notification
+++ b/test/test-push-notification
@@ -11,16 +11,16 @@ class PushNotificationAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.PushNotificationAgent",
 					in_signature=3D"", out_signature=3D"")
 	def Release(self):
-		print "Release"
+		print("Release")
 		mainloop.quit()
 =

 	@dbus.service.method("org.ofono.PushNotificationAgent",
 				in_signature=3D"aya{sv}", out_signature=3D"")
 	def ReceiveNotification(self, data, props):
-		for key in props.keys():
-			print "Key: %s, Value: %s" % (key, props[key])
+		for key in list(props.keys()):
+			print("Key: %s, Value: %s" % (key, props[key]))
 =

-		print "Received notification of size: %d" % len(data)
+		print("Received notification of size: %d" % len(data))
 =

 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -41,7 +41,7 @@ if __name__ =3D=3D '__main__':
 	path =3D "/test/agent"
 	agent =3D PushNotificationAgent(bus, path)
 	pn.RegisterAgent(path)
-	print "Agent registered"
+	print("Agent registered")
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
diff --git a/test/test-smart-messaging b/test/test-smart-messaging
index b263edd..6d25a1e 100755
--- a/test/test-smart-messaging
+++ b/test/test-smart-messaging
@@ -11,34 +11,34 @@ class SmartMessagingAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SmartMessagingAgent",
 					in_signature=3D"", out_signature=3D"")
 	def Release(self):
-		print "Release"
+		print("Release")
 		mainloop.quit()
 =

 	@dbus.service.method("org.ofono.SmartMessagingAgent",
 				in_signature=3D"aya{sv}", out_signature=3D"")
 	def ReceiveBusinessCard(self, data, props):
-		for key in props.keys():
-			print "Key: %s, Value: %s" % (key, props[key])
+		for key in list(props.keys()):
+			print("Key: %s, Value: %s" % (key, props[key]))
 =

 		string =3D ""
 		for byte in data:
 			string +=3D str(byte)
 =

-		print "Received Business Card:"
-		print string
+		print("Received Business Card:")
+		print(string)
 =

 	@dbus.service.method("org.ofono.SmartMessagingAgent",
 				in_signature=3D"aya{sv}", out_signature=3D"")
 	def ReceiveAppointment(self, data, props):
-		for key in props.keys():
-			print "Key: %s, Value: %s" % (key, props[key])
+		for key in list(props.keys()):
+			print("Key: %s, Value: %s" % (key, props[key]))
 =

 		string =3D ""
 		for byte in data:
 			string +=3D str(byte)
 =

-		print "Received Appointment:"
-		print string
+		print("Received Appointment:")
+		print(string)
 =

 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -59,7 +59,7 @@ if __name__ =3D=3D '__main__':
 	path =3D "/test/agent"
 	agent =3D SmartMessagingAgent(bus, path)
 	pn.RegisterAgent(path)
-	print "Agent registered"
+	print("Agent registered")
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
diff --git a/test/test-ss-control-cb b/test/test-ss-control-cb
index f855635..d972097 100755
--- a/test/test-ss-control-cb
+++ b/test/test-ss-control-cb
@@ -6,13 +6,13 @@ import dbus
 import dbus.mainloop.glib
 =

 def property_changed(property, value):
-	print "CallBarring property %s changed to %s" % (property, value)
+	print("CallBarring property %s changed to %s" % (property, value))
 =

 def print_properties(cb):
         properties =3D cb.GetProperties()
 =

 	for p in properties:
-		print "property %s, value: %s" % (p, properties[p])
+		print("property %s, value: %s" % (p, properties[p]))
 =

 if __name__ =3D=3D "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -34,61 +34,61 @@ if __name__ =3D=3D "__main__":
 =

 	print_properties(cb)
 =

-	print "Trying invalid SS request for CB"
+	print("Trying invalid SS request for CB")
 	try:
-		print ss.Initiate("*33#456666")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*33#456666"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CB"
+	print("Trying invalid SS request for CB")
 	try:
-		print ss.Initiate("*33*ABC#")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*33*ABC#"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CB"
+	print("Trying invalid SS request for CB")
 	try:
-		print ss.Initiate("*33**ABC#")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*33**ABC#"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CB"
+	print("Trying invalid SS request for CB")
 	try:
-		print ss.Initiate("*33***12#")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*33***12#"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Query Outgoing All"
-	print ss.Initiate("*#33#")
+	print("Query Outgoing All")
+	print(ss.Initiate("*#33#"))
 =

-	print "Query Outgoing International"
-	print ss.Initiate("*#331#")
+	print("Query Outgoing International")
+	print(ss.Initiate("*#331#"))
 =

-	print "Query Outgoing except home country"
-	print ss.Initiate("*#332#")
+	print("Query Outgoing except home country")
+	print(ss.Initiate("*#332#"))
 =

-	print "Query Incoming All"
-	print ss.Initiate("*#35#")
+	print("Query Incoming All")
+	print(ss.Initiate("*#35#"))
 =

-	print "Query Incoming while Roaming"
-	print ss.Initiate("*#351#")
+	print("Query Incoming while Roaming")
+	print(ss.Initiate("*#351#"))
 =

-	print "Query All Outgoing"
-	print ss.Initiate("*#333#")
+	print("Query All Outgoing")
+	print(ss.Initiate("*#333#"))
 =

-	print "Query All Incoming"
-	print ss.Initiate("*#353#")
+	print("Query All Incoming")
+	print(ss.Initiate("*#353#"))
 =

-	print "Query All"
-	print ss.Initiate("*#330#")
+	print("Query All")
+	print(ss.Initiate("*#330#"))
 =

-	print "Enable Barring for Outgoing International calls for Voice"
-	print ss.Initiate("*33*3579*11#")
+	print("Enable Barring for Outgoing International calls for Voice")
+	print(ss.Initiate("*33*3579*11#"))
 =

 	print_properties(cb)
 =

-	print "Disable All Barrings"
-	print ss.Initiate("#330*3579#")
+	print("Disable All Barrings")
+	print(ss.Initiate("#330*3579#"))
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
diff --git a/test/test-ss-control-cf b/test/test-ss-control-cf
index 6391bdd..1ba9512 100755
--- a/test/test-ss-control-cf
+++ b/test/test-ss-control-cf
@@ -6,7 +6,7 @@ import dbus
 import dbus.mainloop.glib
 =

 def property_changed(property, value):
-	print "CallForwarding property %s changed to %s" % (property, value)
+	print("CallForwarding property %s changed to %s" % (property, value))
 =

 def print_properties(cf):
 	properties =3D cf.GetProperties()
@@ -17,7 +17,7 @@ def print_properties(cf):
 		else:
 			value =3D "disabled"
 =

-		print "%s call forwarding rule: %s" % (p, value)
+		print("%s call forwarding rule: %s" % (p, value))
 =

 if __name__ =3D=3D "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -42,33 +42,33 @@ if __name__ =3D=3D "__main__":
 	print_properties(cf)
 =

 	# Busy To +155542, for Voice
-	print "Setting Busy Voice rule to +155542"
-	print ss.Initiate("*67*+155542*11#")
+	print("Setting Busy Voice rule to +155542")
+	print(ss.Initiate("*67*+155542*11#"))
 	print_properties(cf)
 =

 	# Not Reachable to +155543, Voice
-	print "Setting Voice Not Reachable rule to +155543"
-	print ss.Initiate("**62*+155543*11#")
+	print("Setting Voice Not Reachable rule to +155543")
+	print(ss.Initiate("**62*+155543*11#"))
 =

 	# Not Reachable to +155544, Voice service
-	print "Setting Voice No Reply rule to +155544, timeout=3D30"
-	print ss.Initiate("**61*+155544*11*30#")
+	print("Setting Voice No Reply rule to +155544, timeout=3D30")
+	print(ss.Initiate("**61*+155544*11*30#"))
 =

 	# Unconditional to +155547, Voice
-	print "Setting Unconditional for Voice to +155545"
-	print ss.Initiate("*21*+155545*10#")
+	print("Setting Unconditional for Voice to +155545")
+	print(ss.Initiate("*21*+155545*10#"))
 =

 	print_properties(cf)
 =

-	print "Query all voice forwardings"
-	print ss.Initiate("*#002**11#")
+	print("Query all voice forwardings")
+	print(ss.Initiate("*#002**11#"))
 =

-	print "Query no reply voice forwardings"
-	print ss.Initiate("*#61**11#")
+	print("Query no reply voice forwardings")
+	print(ss.Initiate("*#61**11#"))
 =

 	# Deactivate everything
-	print "Deactivating everything"
-	print ss.Initiate("##002#")
+	print("Deactivating everything")
+	print(ss.Initiate("##002#"))
 	print_properties(cf)
 =

 	mainloop =3D gobject.MainLoop()
diff --git a/test/test-ss-control-cs b/test/test-ss-control-cs
index bf59789..e02d20f 100755
--- a/test/test-ss-control-cs
+++ b/test/test-ss-control-cs
@@ -6,13 +6,13 @@ import dbus
 import dbus.mainloop.glib
 =

 def property_changed(property, value):
-	print "CallSettings property %s changed to %s" % (property, value)
+	print("CallSettings property %s changed to %s" % (property, value))
 =

 def print_properties(cs):
         properties =3D cs.GetProperties()
 =

 	for p in properties:
-		print "property %s, value: %s" % (p, properties[p])
+		print("property %s, value: %s" % (p, properties[p]))
 =

 if __name__ =3D=3D "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -34,77 +34,77 @@ if __name__ =3D=3D "__main__":
 =

 	print_properties(cs)
 =

-	print "Trying invalid SS request for CLIR"
+	print("Trying invalid SS request for CLIR")
 	try:
-		print ss.Initiate("*31#456666")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*31#456666"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CLIR"
+	print("Trying invalid SS request for CLIR")
 	try:
-		print ss.Initiate("*31*455*4#")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*31*455*4#"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CLIR"
+	print("Trying invalid SS request for CLIR")
 	try:
-		print ss.Initiate("*31**44435#")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*31**44435#"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Query CLIP"
-	print ss.Initiate("*#30#")
+	print("Query CLIP")
+	print(ss.Initiate("*#30#"))
 =

-	print "Query COLP"
-	print ss.Initiate("*#76#")
+	print("Query COLP")
+	print(ss.Initiate("*#76#"))
 =

-	print "Query CLIR"
-	print ss.Initiate("*#31#")
+	print("Query CLIR")
+	print(ss.Initiate("*#31#"))
 =

-	print "Activate CLIR"
-	print ss.Initiate("*31#")
+	print("Activate CLIR")
+	print(ss.Initiate("*31#"))
 =

 	print_properties(cs)
 =

-	print "Deactivate CLIR"
-	print ss.Initiate("#31#")
+	print("Deactivate CLIR")
+	print(ss.Initiate("#31#"))
 =

 	print_properties(cs)
 =

-	print "Trying invalid SS request for CW"
+	print("Trying invalid SS request for CW")
 	try:
-		print ss.Initiate("*43#456666")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*43#456666"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CW"
+	print("Trying invalid SS request for CW")
 	try:
-		print ss.Initiate("*43*455*4#")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*43*455*4#"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CW"
+	print("Trying invalid SS request for CW")
 	try:
-		print ss.Initiate("*43**44435#")
-	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print(ss.Initiate("*43**44435#"))
+	except dbus.DBusException as e:
+		print("Failed with %s - Good" % e)
 =

-	print "Query CW"
-	print ss.Initiate("*#43#")
+	print("Query CW")
+	print(ss.Initiate("*#43#"))
 =

-	print "Query CW, only Voice"
-	print ss.Initiate("*#43*11#")
+	print("Query CW, only Voice")
+	print(ss.Initiate("*#43*11#"))
 =

-	print "Query CW, only Fax"
-	print ss.Initiate("*#43*13#")
+	print("Query CW, only Fax")
+	print(ss.Initiate("*#43*13#"))
 =

-	print "Disable CW for everything"
-	print ss.Initiate("#43#");
+	print("Disable CW for everything")
+	print(ss.Initiate("#43#"));
 =

 	print_properties(cs)
 =

-	print "Enable CW for Voice"
-	print ss.Initiate("*43*11#")
+	print("Enable CW for Voice")
+	print(ss.Initiate("*43*11#"))
 =

 	print_properties(cs)
 =

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 916a527..7108542 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -22,20 +22,20 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"", out_signature=3D"")
 	def Release(self):
-		print "Release"
+		print("Release")
 		if self.exit_on_release:
 			mainloop.quit()
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sya(sy)n", out_signature=3D"y")
 	def RequestSelection(self, title, icon, items, default):
-		print "Title: (%s)" % (title)
+		print("Title: (%s)" % (title))
 		index =3D 0;
 		for item in items:
-			print "%d. %s" % (index, item[0])
+			print("%d. %s" % (index, item[0]))
 			index +=3D 1
 =

-		print "\nDefault: %d" % (default)
+		print("\nDefault: %d" % (default))
 		select =3D raw_input("Enter Selection (t, b):")
 =

 		if select =3D=3D 'b':
@@ -48,16 +48,16 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"syb", out_signature=3D"")
 	def DisplayText(self, title, icon, urgent):
-		print "DisplayText (%s, %s)" % (title, urgent)
+		print("DisplayText (%s, %s)" % (title, urgent))
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sysyyb", out_signature=3D"s")
 	def RequestInput(self, title, icon, default, min_chars, max_chars,
 				hide_typing):
-		print "Title: (%s)" % (title)
-		print "Default: (%s)" % (default)
-		print "Enter characters, min: %d, max: %d:" % (min_chars,
-								max_chars)
+		print("Title: (%s)" % (title))
+		print("Default: (%s)" % (default))
+		print("Enter characters, min: %d, max: %d:" % (min_chars,
+								max_chars))
 		userin =3D raw_input("");
 =

 		return userin
@@ -66,10 +66,10 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sysyyb", out_signature=3D"s")
 	def RequestDigits(self, title, icon, default, min_chars, max_chars,
 				hide_typing):
-		print "Title: (%s)" % (title)
-		print "Default: (%s)" % (default)
-		print "Enter digits, min: %d, max: %d:" % (min_chars,
-								max_chars)
+		print("Title: (%s)" % (title))
+		print("Default: (%s)" % (default))
+		print("Enter digits, min: %d, max: %d:" % (min_chars,
+								max_chars))
 		userin =3D raw_input("'t' terminates, 'b' goes back:");
 =

 		if userin =3D=3D 'b':
@@ -82,7 +82,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"s")
 	def RequestKey(self, title, icon):
-		print "Title: (%s)" % (title)
+		print("Title: (%s)" % (title))
 		key =3D raw_input("Enter Key (t, b):")
 =

 		if key =3D=3D 'b':
@@ -95,7 +95,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"s")
 	def RequestDigit(self, title, icon):
-		print "Title: (%s)" % (title)
+		print("Title: (%s)" % (title))
 		key =3D raw_input("Enter Digit (t, b):")
 =

 		if key =3D=3D 'b':
@@ -108,7 +108,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"b")
 	def RequestConfirmation(self, title, icon):
-		print "Title: (%s)" % (title)
+		print("Title: (%s)" % (title))
 		key =3D raw_input("Enter Confirmation (t, b, y, n):")
 =

 		if key =3D=3D 'b':
@@ -123,7 +123,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"b")
 	def ConfirmCallSetup(self, info, icon):
-		print "Information: (%s)" % (info)
+		print("Information: (%s)" % (info))
 		key =3D raw_input("Enter Confirmation (t, y, n):")
 =

 		if key =3D=3D 't':
@@ -136,7 +136,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"", out_signature=3D"")
 	def Cancel(self):
-		print "Cancel"
+		print("Cancel")
 =

 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -157,15 +157,15 @@ if __name__ =3D=3D '__main__':
 	properties =3D stk.GetProperties()
 =

 	if "MainMenuTitle" in properties:
-		print "Main Menu:"
-		print "%s" % (properties["MainMenuTitle"])
-		print "\n"
+		print("Main Menu:")
+		print("%s" % (properties["MainMenuTitle"]))
+		print("\n")
 =

 	if "MainMenu" in properties:
-		print "Items:"
+		print("Items:")
 		index =3D 0
 		for item in properties["MainMenu"]:
-			print "%d. %s" % (index, item[0])
+			print("%d. %s" % (index, item[0]))
 			index +=3D 1
 =

 	path =3D "/test/agent"
@@ -173,7 +173,7 @@ if __name__ =3D=3D '__main__':
 =

 	select =3D int(raw_input("Enter Selection: "))
 	stk.SelectItem(select, path)
-	print "Agent registered for session"
+	print("Agent registered for session")
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
diff --git a/test/test-ussd b/test/test-ussd
index d4c1e27..d62cb62 100755
--- a/test/test-ussd
+++ b/test/test-ussd
@@ -10,17 +10,17 @@ import dbus.mainloop.glib
 state =3D None
 =

 def ussd_notification_received(content):
-	print("Network sent a Notification: " + content)
+	print(("Network sent a Notification: " + content))
 =

 def ussd_request_received(content):
-	print("Network sent a Request: " + content)
+	print(("Network sent a Request: " + content))
 	ss.Cancel()
 =

 def ussd_property_changed(name, value):
 	global state
 	if name !=3D "State":
 		return
-	print("USSD session state is " + value)
+	print(("USSD session state is " + value))
 	state =3D str(value)
 =

 def stdin_handler(fd, condition):
@@ -28,16 +28,16 @@ def stdin_handler(fd, condition):
 	if not s:
 		ss.Cancel()
 	elif state =3D=3D "user-response":
-		print ss.Respond(s, timeout =3D 100)
+		print(ss.Respond(s, timeout =3D 100))
 	elif state =3D=3D "idle":
-		print ss.Initiate(s, timeout =3D 100)
+		print(ss.Initiate(s, timeout =3D 100))
 	else:
-		print "Invalid state", state
+		print("Invalid state", state)
 	return True
 =

 if __name__ =3D=3D "__main__":
 	if (len(sys.argv) < 2):
-		print "Usage: %s <ussd-string>" % (sys.argv[0])
+		print("Usage: %s <ussd-string>" % (sys.argv[0]))
 		sys.exit(1)
 =

 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -59,7 +59,7 @@ if __name__ =3D=3D "__main__":
 	ss.connect_to_signal("RequestReceived", ussd_request_received)
 	ss.connect_to_signal("PropertyChanged", ussd_property_changed)
 =

-	print ss.Initiate(sys.argv[1], timeout=3D100)
+	print(ss.Initiate(sys.argv[1], timeout=3D100))
 =

 	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler)
 =

diff --git a/test/test-voicecall b/test/test-voicecall
index 3b0d432..beb80de 100755
--- a/test/test-voicecall
+++ b/test/test-voicecall
@@ -7,44 +7,44 @@ import dbus.mainloop.glib
 import sys
 =

 def hangup_all():
-	print "Hanging up"
+	print("Hanging up")
 	vcmanager.HangupAll()
 =

 def print_calls():
 	calls =3D vcmanager.GetCalls()
 	if (len(calls) !=3D 0):
-		print "No calls available"
+		print("No calls available")
 	else:
 		for path, properties in calls:
-			print "    [ %s ]" % (path)
+			print("    [ %s ]" % (path))
 =

-			for key in properties.keys():
+			for key in list(properties.keys()):
 				val =3D str(properties[key])
-				print "        %s =3D %s" % (key, val)
-			print
+				print("        %s =3D %s" % (key, val))
+			print()
 =

 def voicecalls_call_added(path, properties):
-	print "    Voice Call [ %s ] Added" % (path)
+	print("    Voice Call [ %s ] Added" % (path))
 =

-	for key in properties.keys():
+	for key in list(properties.keys()):
 		val =3D str(properties[key])
-		print "        %s =3D %s" % (key, val)
-	print
+		print("        %s =3D %s" % (key, val))
+	print()
 =

 def voicecalls_call_removed(path):
-	print "    Voice Call [ %s ] Removed" % (path)
+	print("    Voice Call [ %s ] Removed" % (path))
 =

 def voicecall_property_changed(name, value):
-	print "Voicecall property: '%s' changed to '%s'" % (name, value)
+	print("Voicecall property: '%s' changed to '%s'" % (name, value))
 =

 def voicecall_disconnect_reason(reason):
-	print "Voicecall disconnect reason: '%s'" % (reason)
+	print("Voicecall disconnect reason: '%s'" % (reason))
 =

 if __name__ =3D=3D "__main__":
 	global vcmanager
 =

 	if (len(sys.argv) < 2):
-		print "Usage: %s [modem] <number>" % (sys.argv[0])
+		print("Usage: %s [modem] <number>" % (sys.argv[0]))
 		sys.exit(1)
 =

 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -62,7 +62,7 @@ if __name__ =3D=3D "__main__":
 		number =3D sys.argv[2]
 	else:
 		number =3D sys.argv[1]
-	print "Using modem %s" % modem
+	print("Using modem %s" % modem)
 =

 	vcmanager =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.VoiceCallManager')
@@ -73,17 +73,17 @@ if __name__ =3D=3D "__main__":
 =

 	print_calls()
 =

-	print "Dialing %s..." % number
+	print("Dialing %s..." % number)
 	obj =3D vcmanager.Dial(number, "")
-	print "Dialing in progress, got obj: %s" % (obj)
+	print("Dialing in progress, got obj: %s" % (obj))
 =

 	call =3D dbus.Interface(bus.get_object('org.ofono', obj),
 						'org.ofono.VoiceCall')
 =

 	properties =3D call.GetProperties()
 =

-	print "State: %s, Number: %s" %\
-		(properties['State'], properties['LineIdentification'])
+	print("State: %s, Number: %s" %\
+		(properties['State'], properties['LineIdentification']))
 =

 	call.connect_to_signal("PropertyChanged", voicecall_property_changed)
 	call.connect_to_signal("DisconnectReason", voicecall_disconnect_reason)
diff --git a/test/unlock-pin b/test/unlock-pin
index d77841a..10b6626 100755
--- a/test/unlock-pin
+++ b/test/unlock-pin
@@ -17,10 +17,10 @@ elif len(sys.argv) =3D=3D 3:
 	pin_type =3D sys.argv[1]
 	pin =3D sys.argv[2]
 else:
-	print "%s [PATH] pin_type pin" % (sys.argv[0])
+	print("%s [PATH] pin_type pin" % (sys.argv[0]))
 	sys.exit(0)
 =

-print "Unlock %s %s for modem %s..." % (pin_type, pin, path)
+print("Unlock %s %s for modem %s..." % (pin_type, pin, path))
 =

 simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.SimManager')
-- =

1.7.3.2


--===============0421970140927610723==--

