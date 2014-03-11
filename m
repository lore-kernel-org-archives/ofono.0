Content-Type: multipart/mixed; boundary="===============0540333358561099184=="
MIME-Version: 1.0
From: Martin Pitt <martin.pitt@ubuntu.com>
Subject: [PATCH 1/5] test: Make print calls compatible with Python 3
Date: Tue, 11 Mar 2014 17:39:18 +0100
Message-ID: <1394555962-21661-1-git-send-email-martin.pitt@ubuntu.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0540333358561099184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Turn print calls into print() function calls and avoid using comma-separated
arguments, so that they work and look the same with both Python 2 and 3.
---
 test/activate-context          |   4 +-
 test/answer-calls              |   4 +-
 test/backtrace                 |   8 +--
 test/cancel-ussd               |   2 +-
 test/cdma-connman-disable      |   2 +-
 test/cdma-connman-enable       |   2 +-
 test/cdma-dial-number          |   2 +-
 test/cdma-list-call            |   4 +-
 test/cdma-set-credentials      |   6 +--
 test/change-pin                |   4 +-
 test/create-internet-context   |  10 ++--
 test/create-mms-context        |  10 ++--
 test/create-multiparty         |   2 +-
 test/deactivate-context        |   4 +-
 test/dial-number               |   6 +--
 test/disable-call-forwarding   |  12 ++---
 test/disable-gprs              |   2 +-
 test/disable-modem             |   2 +-
 test/display-icon              |   4 +-
 test/dundee-connect            |   2 +-
 test/dundee-disconnect         |   2 +-
 test/enable-cbs                |   2 +-
 test/enable-gprs               |   2 +-
 test/enable-modem              |   2 +-
 test/enter-pin                 |   4 +-
 test/get-icon                  |   4 +-
 test/get-operators             |   6 +--
 test/get-tech-preference       |   2 +-
 test/hangup-active             |   2 +-
 test/hangup-call               |   2 +-
 test/initiate-ussd             |  12 ++---
 test/list-calls                |   8 +--
 test/list-contexts             |   8 +--
 test/list-messages             |   8 +--
 test/list-modems               |  10 ++--
 test/list-operators            |   8 +--
 test/lock-pin                  |   4 +-
 test/lockdown-modem            |   4 +-
 test/monitor-dundee            |  16 +++---
 test/monitor-ofono             |  16 +++---
 test/offline-modem             |   2 +-
 test/online-modem              |   2 +-
 test/private-chat              |   2 +-
 test/process-context-settings  |  14 ++---
 test/receive-sms               |   4 +-
 test/reject-calls              |   4 +-
 test/release-and-answer        |   2 +-
 test/release-and-swap          |   2 +-
 test/remove-contexts           |   2 +-
 test/reset-pin                 |   4 +-
 test/scan-for-operators        |   8 +--
 test/send-sms                  |   8 +--
 test/send-ussd                 |  14 ++---
 test/send-vcal                 |   6 +--
 test/send-vcard                |   6 +--
 test/set-call-forwarding       |  18 +++----
 test/set-cbs-topics            |   4 +-
 test/set-context-property      |   8 +--
 test/set-fast-dormancy         |   4 +-
 test/set-gsm-band              |   4 +-
 test/set-mms-details           |   8 +--
 test/set-msisdn                |   4 +-
 test/set-roaming-allowed       |   2 +-
 test/set-tech-preference       |   4 +-
 test/set-tty                   |   4 +-
 test/set-umts-band             |   4 +-
 test/set-use-sms-reports       |   4 +-
 test/test-advice-of-charge     |  32 ++++++------
 test/test-call-barring         |  26 ++++-----
 test/test-call-forwarding      |  44 ++++++++--------
 test/test-call-settings        |  48 ++++++++---------
 test/test-cbs                  |  96 +++++++++++++++++-----------------
 test/test-gnss                 |  32 ++++++------
 test/test-message-waiting      |  18 +++----
 test/test-modem                |  28 +++++-----
 test/test-network-registration |  24 ++++-----
 test/test-phonebook            |   2 +-
 test/test-push-notification    |   8 +--
 test/test-smart-messaging      |  16 +++---
 test/test-sms                  |  96 +++++++++++++++++-----------------
 test/test-ss                   |  16 +++---
 test/test-ss-control-cb        |  68 ++++++++++++------------
 test/test-ss-control-cf        |  32 ++++++------
 test/test-ss-control-cs        |  84 ++++++++++++++---------------
 test/test-stk-menu             | 116 ++++++++++++++++++++-----------------=
----
 test/unlock-pin                |   4 +-
 86 files changed, 576 insertions(+), 576 deletions(-)

diff --git a/test/activate-context b/test/activate-context
index 01565ad..1c4a105 100755
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
@@ -36,5 +36,5 @@ for path, properties in modems:
 	try:
 		context.SetProperty("Active", dbus.Boolean(1), timeout =3D 100)
 	except dbus.DBusException, e:
-		print "Error activating %s: %s" % (path, str(e))
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
index 5246591..1797f26 100755
--- a/test/cancel-ussd
+++ b/test/cancel-ussd
@@ -21,7 +21,7 @@ ussd =3D dbus.Interface(bus.get_object('org.ofono', path),
 properties =3D ussd.GetProperties()
 state =3D properties["State"]
 =

-print "State: %s" % (state)
+print("State: %s" % (state))
 =

 if state !=3D "idle":
 	ussd.Cancel()
diff --git a/test/cdma-connman-disable b/test/cdma-connman-disable
index a1c9568..0ddc0cd 100755
--- a/test/cdma-connman-disable
+++ b/test/cdma-connman-disable
@@ -13,7 +13,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Disconnecting CDMA Packet Data Service on modem %s..." % path
+print("Disconnecting CDMA Packet Data Service on modem %s..." % path)
 cm =3D dbus.Interface(bus.get_object('org.ofono', path),
 		'org.ofono.cdma.ConnectionManager')
 =

diff --git a/test/cdma-connman-enable b/test/cdma-connman-enable
index 699240d..a3cca01 100755
--- a/test/cdma-connman-enable
+++ b/test/cdma-connman-enable
@@ -13,7 +13,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Connecting CDMA Packet Data Service on modem %s..." % path
+print("Connecting CDMA Packet Data Service on modem %s..." % path)
 cm =3D dbus.Interface(bus.get_object('org.ofono', path),
 		'org.ofono.cdma.ConnectionManager')
 =

diff --git a/test/cdma-dial-number b/test/cdma-dial-number
index d6dc0c4..9cdfb24 100755
--- a/test/cdma-dial-number
+++ b/test/cdma-dial-number
@@ -16,7 +16,7 @@ else:
 	path, properties =3D modems[0]
 	number =3D sys.argv[1]
 =

-print "Using modem %s" % path
+print("Using modem %s" % path)
 =

 manager =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.cdma.VoiceCallManager')
diff --git a/test/cdma-list-call b/test/cdma-list-call
index c941383..5d36a69 100755
--- a/test/cdma-list-call
+++ b/test/cdma-list-call
@@ -10,7 +10,7 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '/=
'),
 modems =3D manager.GetModems()
 =

 for path, properties in modems:
-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

 	if "org.ofono.cdma.VoiceCallManager" not in properties["Interfaces"]:
 		continue
@@ -22,4 +22,4 @@ for path, properties in modems:
 =

 	for key in properties.keys():
 		val =3D str(properties[key])
-		print "    %s =3D %s" % (key, val)
+		print("    %s =3D %s" % (key, val))
diff --git a/test/cdma-set-credentials b/test/cdma-set-credentials
index 249ac11..a286b0e 100755
--- a/test/cdma-set-credentials
+++ b/test/cdma-set-credentials
@@ -17,12 +17,12 @@ for path, properties in modems:
 	cm =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.cdma.ConnectionManager')
 =

-	print "Connecting CDMA Packet Data Service on modem %s..." % path
+	print("Connecting CDMA Packet Data Service on modem %s..." % path)
 =

 	if len(sys.argv) > 1:
 		cm.SetProperty("Username", (sys.argv[1]))
-		print "Setting Username to %s" % (sys.argv[1])
+		print("Setting Username to %s" % (sys.argv[1]))
 =

 	if len(sys.argv) > 2:
 		cm.SetProperty("Password", (sys.argv[2]))
-		print "Setting Password to %s" % (sys.argv[2])
+		print("Setting Password to %s" % (sys.argv[2]))
diff --git a/test/change-pin b/test/change-pin
index eee5ebc..000ce53 100755
--- a/test/change-pin
+++ b/test/change-pin
@@ -19,10 +19,10 @@ elif len(sys.argv) =3D=3D 3:
 	old_pin =3D sys.argv[2]
 	new_pin =3D sys.argv[3]
 else:
-	print "%s [PATH] pin_type old_pin new_pin" % (sys.argv[0])
+	print("%s [PATH] pin_type old_pin new_pin" % (sys.argv[0]))
 	sys.exit(0)
 =

-print "Change %s for modem %s..." % (pin_type, path)
+print("Change %s for modem %s..." % (pin_type, path))
 =

 simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.SimManager')
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
index 692489d..44a78f7 100755
--- a/test/create-multiparty
+++ b/test/create-multiparty
@@ -21,4 +21,4 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', pa=
th),
 mpty =3D manager.CreateMultiparty()
 =

 for path in mpty:
-	print path
+	print(path)
diff --git a/test/deactivate-context b/test/deactivate-context
index e3754c2..9544c19 100755
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
@@ -34,5 +34,5 @@ for path, properties in modems:
 	try:
 		context.SetProperty("Active", dbus.Boolean(0))
 	except dbus.DBusException, e:
-		print "Error activating %s: %s" % (path, str(e))
+		print("Error activating %s: %s" % (path, str(e)))
 		exit(2)
diff --git a/test/dial-number b/test/dial-number
index 8e250ea..ee674d9 100755
--- a/test/dial-number
+++ b/test/dial-number
@@ -4,7 +4,7 @@ import sys
 import dbus
 =

 if (len(sys.argv) < 2):
-	print "Usage: %s [modem] <number> [hide_callerid]" % (sys.argv[0])
+	print("Usage: %s [modem] <number> [hide_callerid]" % (sys.argv[0]))
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -32,11 +32,11 @@ else:
 	number =3D sys.argv[2]
 	hide_callerid =3D sys.argv[3]
 =

-print "Using modem %s" % modem
+print("Using modem %s" % modem)
 =

 vcm =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.VoiceCallManager')
 =

 path =3D vcm.Dial(number, hide_callerid)
 =

-print path
+print(path)
diff --git a/test/disable-call-forwarding b/test/disable-call-forwarding
index ca0ba90..a88821d 100755
--- a/test/disable-call-forwarding
+++ b/test/disable-call-forwarding
@@ -8,17 +8,17 @@ import dbus.mainloop.glib
 =

 def property_changed(property, value):
 	if len(value.__str__()) > 0:
-		print "CF property %s changed to %s" % (property, value)
+		print("CF property %s changed to %s" % (property, value))
 	else:
-		print "CF property %s changed to disabled" % (property)
+		print("CF property %s changed to disabled" % (property))
 =

 	if canexit:
 		mainloop.quit();
 =

 if __name__ =3D=3D "__main__":
 	if len(sys.argv) < 2:
-		print "Usage: %s <type>" % (sys.argv[0])
-		print "Type can be: all, conditional"
+		print("Usage: %s <type>" % (sys.argv[0]))
+		print("Type can be: all, conditional")
 		sys.exit(1)
 =

 	canexit =3D False
@@ -42,10 +42,10 @@ if __name__ =3D=3D "__main__":
 	try:
 		cf.DisableAll(type, timeout =3D 100)
 	except dbus.DBusException, e:
-		print "Unable to DisableAll", e
+		print("Unable to DisableAll %s" % e)
 		sys.exit(1);
 =

-	print "DisableAll successful"
+	print("DisableAll successful")
 =

 	canexit =3D True
 =

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
index 945359b..ca8c8d8 100755
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

diff --git a/test/display-icon b/test/display-icon
index 0be30d5..753d14d 100755
--- a/test/display-icon
+++ b/test/display-icon
@@ -4,7 +4,7 @@ import sys
 import dbus
 =

 if (len(sys.argv) < 2):
-	print "Usage: %s [modem] icon_id" % (sys.argv[0])
+	print("Usage: %s [modem] icon_id" % (sys.argv[0]))
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -21,7 +21,7 @@ elif (len(sys.argv) =3D=3D 3):
 	modem =3D sys.argv[1]
 	icon =3D sys.argv[2]
 =

-print "Using modem %s" % modem
+print("Using modem %s" % modem)
 =

 sim =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.SimManager')
diff --git a/test/dundee-connect b/test/dundee-connect
index 0e1ae40..a23ce5f 100755
--- a/test/dundee-connect
+++ b/test/dundee-connect
@@ -13,7 +13,7 @@ else:
 	devices =3D manager.GetDevices()
 	path =3D devices[0][0]
 =

-print "Connect device %s..." % path
+print("Connect device %s..." % path)
 device =3D dbus.Interface(bus.get_object('org.ofono.dundee', path),
 						'org.ofono.dundee.Device')
 =

diff --git a/test/dundee-disconnect b/test/dundee-disconnect
index a285dc8..05403dd 100755
--- a/test/dundee-disconnect
+++ b/test/dundee-disconnect
@@ -13,7 +13,7 @@ else:
 	devices =3D manager.GetDevices()
 	path =3D devices[0][0]
 =

-print "Disconnect device %s..." % path
+print("Disconnect device %s..." % path)
 device =3D dbus.Interface(bus.get_object('org.ofono.dundee', path),
 						'org.ofono.dundee.Device')
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
index 665ced2..dfaaaa8 100755
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
index fea15e0..c6ee669 100755
--- a/test/enter-pin
+++ b/test/enter-pin
@@ -17,10 +17,10 @@ elif len(sys.argv) =3D=3D 3:
 	pin_type =3D sys.argv[1]
 	pin =3D sys.argv[2]
 else:
-	print "%s [PATH] pin_type pin" % (sys.argv[0])
+	print("%s [PATH] pin_type pin" % (sys.argv[0]))
 	sys.exit(0)
 =

-print "Enter Pin for modem %s..." % path
+print("Enter Pin for modem %s..." % path)
 simmanager =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.SimManager')
 =

diff --git a/test/get-icon b/test/get-icon
index ea46cd6..fdaaee7 100755
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
index f5bac12..ddbc194 100755
--- a/test/get-operators
+++ b/test/get-operators
@@ -22,7 +22,7 @@ for entry in operators:
 	path =3D entry[0]
 	properties =3D entry[1]
 =

-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

 	for key in properties.keys():
 		if key in ["Technologies"]:
@@ -31,7 +31,7 @@ for entry in operators:
 				val +=3D i + " "
 		else:
 			val =3D str(properties[key])
-		print "    %s =3D %s" % (key, val)
+		print("    %s =3D %s" % (key, val))
 =

-	print
+	print('')
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
diff --git a/test/hangup-active b/test/hangup-active
index 6444b23..1dd85a6 100755
--- a/test/hangup-active
+++ b/test/hangup-active
@@ -18,7 +18,7 @@ calls =3D manager.GetCalls()
 =

 for path, properties in calls:
 		state =3D properties["State"]
-		print "[ %s ] %s" % (path, state)
+		print("[ %s ] %s" % (path, state))
 =

 		if state !=3D "active":
 			continue
diff --git a/test/hangup-call b/test/hangup-call
index 4c46ec0..447020c 100755
--- a/test/hangup-call
+++ b/test/hangup-call
@@ -6,7 +6,7 @@ import dbus
 bus =3D dbus.SystemBus()
 =

 if (len(sys.argv) < 2):
-	print "Usage: %s [ Call Path ]" % (sys.argv[0])
+	print("Usage: %s [ Call Path ]" % (sys.argv[0]))
 	sys.exit(1)
 =

 call =3D dbus.Interface(bus.get_object('org.ofono', sys.argv[1]),
diff --git a/test/initiate-ussd b/test/initiate-ussd
index 098ec87..d7022f1 100755
--- a/test/initiate-ussd
+++ b/test/initiate-ussd
@@ -4,7 +4,7 @@ import sys
 import dbus
 =

 if (len(sys.argv) < 2):
-	print "Usage: %s [modem] <ussd-string>" % (sys.argv[0])
+	print("Usage: %s [modem] <ussd-string>" % (sys.argv[0]))
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -27,7 +27,7 @@ ussd =3D dbus.Interface(bus.get_object('org.ofono', path),
 properties =3D ussd.GetProperties()
 state =3D properties["State"]
 =

-print "State: %s" % (state)
+print("State: %s" % (state))
 =

 if state !=3D "idle":
 	sys.exit(1);
@@ -37,12 +37,12 @@ result =3D ussd.Initiate(ussdstring, timeout=3D100)
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
@@ -52,7 +52,7 @@ while state =3D=3D "user-response":
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
index 2332b50..08668c6 100755
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
@@ -21,11 +21,11 @@ for path, properties in modems:
 	calls =3D mgr.GetCalls()
 =

 	for path, properties in calls:
-		print "    [ %s ]" % (path)
+		print("    [ %s ]" % (path))
 =

 		for key in properties.keys():
 			if key =3D=3D 'Icon':
-				print "        %s =3D %d" % (key, properties[key])
+				print("        %s =3D %d" % (key, properties[key]))
 			else:
 				val =3D str(properties[key])
-				print "        %s =3D %s" % (key, val)
+				print("        %s =3D %s" % (key, val))
diff --git a/test/list-contexts b/test/list-contexts
index ed4af88..221108c 100755
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
@@ -21,7 +21,7 @@ for path, properties in modems:
 	contexts =3D connman.GetContexts()
 =

 	for path, properties in contexts:
-		print "    [ %s ]" % (path)
+		print("    [ %s ]" % (path))
 =

 		for key in properties.keys():
 			if key in ["Settings"] or key in ["IPv6.Settings"]:
@@ -39,6 +39,6 @@ for path, properties in modems:
 				val +=3D " }"
 			else:
 				val =3D str(properties[key])
-			print "        %s =3D %s" % (key, val)
+			print("        %s =3D %s" % (key, val))
 =

-		print
+		print('')
diff --git a/test/list-messages b/test/list-messages
index d3e95e6..3b53d93 100755
--- a/test/list-messages
+++ b/test/list-messages
@@ -10,7 +10,7 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '/=
'),
 modems =3D manager.GetModems()
 =

 for path, properties in modems:
-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

 	if "org.ofono.MessageManager" not in properties["Interfaces"]:
 		continue
@@ -21,10 +21,10 @@ for path, properties in modems:
 	contexts =3D connman.GetMessages()
 =

 	for path, properties in contexts:
-		print "    [ %s ]" % (path)
+		print("    [ %s ]" % (path))
 =

 		for key in properties.keys():
 			val =3D str(properties[key])
-			print "        %s =3D %s" % (key, val)
+			print("        %s =3D %s" % (key, val))
 =

-		print
+		print('')
diff --git a/test/list-modems b/test/list-modems
index d859dbf..3dd8ce4 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -10,7 +10,7 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '/=
'),
 modems =3D manager.GetModems()
 =

 for path, properties in modems:
-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

 	for key in properties.keys():
 		if key in ["Interfaces", "Features"]:
@@ -19,13 +19,13 @@ for path, properties in modems:
 				val +=3D i + " "
 		else:
 			val =3D properties[key]
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
@@ -77,6 +77,6 @@ for path, properties in modems:
 				val +=3D " }"
 			else:
 				val =3D properties[key]
-			print "        %s =3D %s" % (key, val)
+			print("        %s =3D %s" % (key, val))
 =

-	print
+	print('')
diff --git a/test/list-operators b/test/list-operators
index be00c5b..39cd978 100755
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
@@ -25,7 +25,7 @@ for path, properties in modems:
 		operators =3D netreg.GetOperators()
 =

 	for path, properties in operators:
-		print "    [ %s ]" % (path)
+		print("    [ %s ]" % (path))
 =

 		for key in properties.keys():
 			if key in ["Technologies"]:
@@ -34,6 +34,6 @@ for path, properties in modems:
 					val +=3D i + " "
 			else:
 				val =3D str(properties[key])
-			print "        %s =3D %s" % (key, val)
+			print("        %s =3D %s" % (key, val))
 =

-		print
+		print('')
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
diff --git a/test/lockdown-modem b/test/lockdown-modem
index 5d98154..781abb6 100755
--- a/test/lockdown-modem
+++ b/test/lockdown-modem
@@ -13,13 +13,13 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Locking and disconnecting modem %s..." % path
+print("Locking and disconnecting modem %s..." % path)
 modem =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.Modem')
 =

 modem.SetProperty("Lockdown", dbus.Boolean(1))
 =

-print "press ENTER to unlock the modem %s" % path
+print("press ENTER to unlock the modem %s" % path)
 sys.stdin.readline()
 =

 modem.SetProperty("Lockdown", dbus.Boolean(0))
diff --git a/test/monitor-dundee b/test/monitor-dundee
index cf96ceb..025a345 100755
--- a/test/monitor-dundee
+++ b/test/monitor-dundee
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
-	print "{%s} [%s] %s" % (iface, member, name)
+	print("{%s} [%s] %s" % (iface, member, name))
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
diff --git a/test/monitor-ofono b/test/monitor-ofono
index 85c0d4a..f69ae79 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -55,32 +55,32 @@ def pretty(d):
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
-					msg, pretty(args))
+	print("{%s} [%s] %s %s (%s)" % (iface, path, member,
+					msg, pretty(args)))
 =

 def ussd(msg, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s %s" % (iface, path, member, msg)
+	print("{%s} [%s] %s %s" % (iface, path, member, msg))
 =

 def value(value, member, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
-	print "{%s} [%s] %s %s" % (iface, path, member, str(value))
+	print("{%s} [%s] %s %s" % (iface, path, member, str(value)))
 =

 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
diff --git a/test/offline-modem b/test/offline-modem
index aa9c692..ea1f522 100755
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
 modem.SetProperty("Online", dbus.Boolean(0), timeout =3D 120)
diff --git a/test/online-modem b/test/online-modem
index 813b176..310ed7d 100755
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
 modem.SetProperty("Online", dbus.Boolean(1), timeout =3D 120)
diff --git a/test/private-chat b/test/private-chat
index 2fe0797..254522e 100755
--- a/test/private-chat
+++ b/test/private-chat
@@ -23,4 +23,4 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', pa=
th),
 mpty =3D manager.PrivateChat(callid, timeout=3D100)
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
+		print('')
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
diff --git a/test/reject-calls b/test/reject-calls
index 405eb44..9edf1ff 100755
--- a/test/reject-calls
+++ b/test/reject-calls
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
diff --git a/test/release-and-answer b/test/release-and-answer
index 10570ce..ef860fc 100755
--- a/test/release-and-answer
+++ b/test/release-and-answer
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
diff --git a/test/release-and-swap b/test/release-and-swap
index 396e39d..2748f20 100755
--- a/test/release-and-swap
+++ b/test/release-and-swap
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
index 82fe3f4..69051b0 100755
--- a/test/scan-for-operators
+++ b/test/scan-for-operators
@@ -13,7 +13,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Scanning operators on modem %s..." % path
+print("Scanning operators on modem %s..." % path)
 netreg =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.NetworkRegistration')
 =

@@ -23,7 +23,7 @@ for entry in operators:
 	path =3D entry[0]
 	properties =3D entry[1]
 =

-	print "[ %s ]" % (path)
+	print("[ %s ]" % (path))
 =

 	for key in properties.keys():
 		if key in ["Technologies"]:
@@ -32,7 +32,7 @@ for entry in operators:
 				val +=3D i + " "
 		else:
 			val =3D str(properties[key])
-		print "    %s =3D %s" % (key, val)
+		print("    %s =3D %s" % (key, val))
 =

-	print
+	print('')
 =

diff --git a/test/send-sms b/test/send-sms
index 93e72b8..e06444d 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -4,8 +4,8 @@ import sys
 import dbus
 =

 if len(sys.argv) < 4:
-	print "Usage: %s [modem] <to> <message> <delivery report>" %\
-					(sys.argv[0])
+	print("Usage: %s [modem] <to> <message> <delivery report>" %\
+					(sys.argv[0]))
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -18,7 +18,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Send message using modem %s ..." % path
+print("Send message using modem %s ..." % path)
 =

 =

 mm =3D dbus.Interface(bus.get_object('org.ofono', path),
@@ -31,4 +31,4 @@ else:
 	mm.SetProperty("UseDeliveryReports", dbus.Boolean(int(sys.argv[3])))
 	path =3D mm.SendMessage(sys.argv[1], sys.argv[2])
 =

-print path
+print(path)
diff --git a/test/send-ussd b/test/send-ussd
index fcabd21..e585883 100755
--- a/test/send-ussd
+++ b/test/send-ussd
@@ -4,7 +4,7 @@ import sys
 import dbus
 =

 if (len(sys.argv) < 2):
-	print "Usage: %s [modem] <ussd-string>" % (sys.argv[0])
+	print("Usage: %s [modem] <ussd-string>" % (sys.argv[0]))
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -27,13 +27,13 @@ ussd =3D dbus.Interface(bus.get_object('org.ofono', pat=
h),
 properties =3D ussd.GetProperties()
 state =3D properties["State"]
 =

-print "State: %s" % (state)
+print("State: %s" % (state))
 =

 if state =3D=3D "idle":
 	result =3D ussd.Initiate(ussdstring, timeout=3D100)
-	print result[0] + ": " + result[1]
+	print(result[0] + ": " + result[1])
 elif state =3D=3D "user-response":
-	print ussd.Respond(ussdstring, timeout=3D100)
+	print(ussd.Respond(ussdstring, timeout=3D100))
 else:
 	sys.exit(1);
 =

@@ -43,15 +43,15 @@ state =3D properties["State"]
 if state =3D=3D "idle":
 	sys.exit(0)
 =

-print "State: %s" % (state)
+print("State: %s" % (state))
 =

 while state =3D=3D "user-response":
 	response =3D raw_input("Enter response: ")
 =

-	print ussd.Respond(response, timeout=3D100)
+	print(ussd.Respond(response, timeout=3D100))
 =

 	properties =3D ussd.GetProperties()
 	state =3D properties["State"]
 =

 	if state !=3D "idle":
-		print "State: %s" % (state)
+		print("State: %s" % (state))
diff --git a/test/send-vcal b/test/send-vcal
index 7ccd2f6..7f8272b 100755
--- a/test/send-vcal
+++ b/test/send-vcal
@@ -4,7 +4,7 @@ import sys
 import dbus
 =

 if len(sys.argv) < 3:
-	print "Usage: %s [modem] <to> <vcal file>" % (sys.argv[0])
+	print("Usage: %s [modem] <to> <vcal file>" % (sys.argv[0]))
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -17,7 +17,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Send vcal using modem %s ..." % path
+print("Send vcal using modem %s ..." % path)
 =

 sm =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.SmartMessaging')
@@ -29,4 +29,4 @@ else:
 	vcal =3D file(sys.argv[2]).read()
 	path =3D sm.SendAppointment(sys.argv[1], vcal)
 =

-print path
+print(path)
diff --git a/test/send-vcard b/test/send-vcard
index 3955990..250b36f 100755
--- a/test/send-vcard
+++ b/test/send-vcard
@@ -4,7 +4,7 @@ import sys
 import dbus
 =

 if len(sys.argv) < 3:
-	print "Usage: %s [modem] <to> <vcard file>" % (sys.argv[0])
+	print("Usage: %s [modem] <to> <vcard file>" % (sys.argv[0]))
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -17,7 +17,7 @@ else:
 	modems =3D manager.GetModems()
 	path =3D modems[0][0]
 =

-print "Send vcard using modem %s ..." % path
+print("Send vcard using modem %s ..." % path)
 =

 sm =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.SmartMessaging')
@@ -29,4 +29,4 @@ else:
 	vcard =3D file(sys.argv[2]).read()
 	path =3D sm.SendBusinessCard(sys.argv[1], vcard)
 =

-print path
+print(path)
diff --git a/test/set-call-forwarding b/test/set-call-forwarding
index 1c06b68..a22a673 100755
--- a/test/set-call-forwarding
+++ b/test/set-call-forwarding
@@ -8,19 +8,19 @@ import dbus.mainloop.glib
 =

 def property_changed(property, value):
 	if len(value.__str__()) > 0:
-		print "CF property %s changed to %s" % (property, value)
+		print("CF property %s changed to %s" % (property, value))
 	else:
-		print "CF property %s changed to disabled" % (property)
+		print("CF property %s changed to disabled" % (property))
 =

 	if canexit:
 		mainloop.quit();
 =

 if __name__ =3D=3D "__main__":
 	if len(sys.argv) < 3:
-		print "Usage: %s <property> <value>" % (sys.argv[0])
-		print "Properties can be: VoiceUnconditional, VoiceBusy,"
-		print "	VoiceNoReply, VoiceNoReplyTimeout, VoiceNotReachable"
-		print "Value: number to or the timeout"
+		print("Usage: %s <property> <value>" % (sys.argv[0]))
+		print("Properties can be: VoiceUnconditional, VoiceBusy,")
+		print("	VoiceNoReply, VoiceNoReplyTimeout, VoiceNotReachable")
+		print("Value: number to or the timeout")
 		sys.exit(1)
 =

 	property =3D sys.argv[1]
@@ -47,16 +47,16 @@ if __name__ =3D=3D "__main__":
 			cf.SetProperty(property, dbus.UInt16(value),
 							timeout =3D 100)
 		except dbus.DBusException, e:
-			print "Unable SetProperty", e
+			print("Unable SetProperty %s" % e)
 			sys.exit(1);
 	else:
 		try:
 			cf.SetProperty(property, value, timeout =3D 100)
 		except dbus.DBusException, e:
-			print "Unable SetProperty", e
+			print("Unable SetProperty %s" % e)
 			sys.exit(1);
 =

-	print "Set Property successful"
+	print("Set Property successful")
 =

 	canexit =3D True
 =

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

diff --git a/test/set-context-property b/test/set-context-property
index cfd6c68..c18e55a 100755
--- a/test/set-context-property
+++ b/test/set-context-property
@@ -4,7 +4,7 @@ import sys
 import dbus
 =

 if len(sys.argv) < 4:
-	print "Usage: set-context-property <context> <name> <value>"
+	print("Usage: set-context-property <context> <name> <value>")
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
@@ -24,7 +24,7 @@ for path, properties in modems:
 	contexts =3D connman.GetContexts()
 =

 	if (len(contexts) =3D=3D 0):
-		print "No context available"
+		print("No context available")
 		sys.exit(1)
 =

 	path =3D contexts[int(sys.argv[1])][0]
@@ -34,6 +34,6 @@ for path, properties in modems:
 	try:
 		context.SetProperty(sys.argv[2], sys.argv[3])
 	except dbus.DBusException, e:
-		print "Error setting context %s property %s: %s" %\
-				(path, sys.argv[2], str(e))
+		print("Error setting context %s property %s: %s" %\
+				(path, sys.argv[2], str(e)))
 		exit(2)
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

diff --git a/test/set-gsm-band b/test/set-gsm-band
index 9586d81..3c17c10 100755
--- a/test/set-gsm-band
+++ b/test/set-gsm-band
@@ -15,10 +15,10 @@ elif len(sys.argv) =3D=3D 2:
 	path =3D modems[0][0]
 	band =3D sys.argv[1]
 else:
-	print "%s [PATH] band" % (sys.argv[0])
+	print("%s [PATH] band" % (sys.argv[0]))
 	exit(1)
 =

-print "Setting gsm band for modem %s..." % path
+print("Setting gsm band for modem %s..." % path)
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
diff --git a/test/set-msisdn b/test/set-msisdn
index 5984899..01f284d 100755
--- a/test/set-msisdn
+++ b/test/set-msisdn
@@ -15,10 +15,10 @@ elif len(sys.argv) =3D=3D 2:
 	path =3D modems[0][0]
 	number =3D sys.argv[1]
 else:
-	print "%s [PATH] <number>" % (sys.argv[0])
+	print("%s [PATH] <number>" % (sys.argv[0]))
 	exit(1)
 =

-print "Setting MSISDN for modem %s..." % path
+print("Setting MSISDN for modem %s..." % path)
 sim =3D dbus.Interface(bus.get_object('org.ofono', path), 'org.ofono.SimMa=
nager')
 =

 sim.SetProperty("SubscriberNumbers", [number]);
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

diff --git a/test/set-umts-band b/test/set-umts-band
index 510a40b..c1e6448 100755
--- a/test/set-umts-band
+++ b/test/set-umts-band
@@ -15,10 +15,10 @@ elif len(sys.argv) =3D=3D 2:
 	path =3D modems[0][0]
 	band =3D sys.argv[1]
 else:
-	print "%s [PATH] band" % (sys.argv[0])
+	print("%s [PATH] band" % (sys.argv[0]))
 	exit(1)
 =

-print "Setting umts band for modem %s..." % path
+print("Setting umts band for modem %s..." % path)
 radiosettings =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.RadioSettings')
 =

diff --git a/test/set-use-sms-reports b/test/set-use-sms-reports
index 41ad59e..a4efe4f 100755
--- a/test/set-use-sms-reports
+++ b/test/set-use-sms-reports
@@ -19,10 +19,10 @@ elif len(sys.argv) =3D=3D 2:
 	if sys.argv[1] =3D=3D "off":
 		enabled =3D 0
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
index 9f3f655..bb52f5b 100755
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
 		except dbus.DBusException, e:
-			print "Unable to reset ACM: ", e
+			print("Unable to reset ACM: %s" % e)
 			sys.exit(1)
 	else:
 		try:
@@ -78,7 +78,7 @@ if __name__ =3D=3D "__main__":
 				newvalue =3D float(newvalue)
 			cm.SetProperty(property, newvalue, pin)
 		except dbus.DBusException, e:
-			print "Unable to set property: ", e
+			print("Unable to set property: %s" % e)
 			sys.exit(1)
 =

 	canexit =3D True
diff --git a/test/test-call-barring b/test/test-call-barring
index 5dd566e..51b3778 100755
--- a/test/test-call-barring
+++ b/test/test-call-barring
@@ -7,14 +7,14 @@ import dbus.mainloop.glib
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
-	print "Usage: %s passwd <old_password> <new_password>" % (s)
+	print("Usage: %s <property> <newvalue> <password>" % (s))
+	print("Usage: %s disableall <password>" % (s))
+	print("Usage: %s passwd <old_password> <new_password>" % (s))
 	sys.exit(1);
 =

 if __name__ =3D=3D "__main__":
@@ -51,31 +51,31 @@ if __name__ =3D=3D "__main__":
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
 		except dbus.DBusException, e:
-			print "Unable to Disable All barrings: ", e
+			print("Unable to Disable All barrings: ", e)
 			sys.exit(1)
 	elif (sys.argv[1] =3D=3D 'passwd'):
 		try:
 			cb.ChangePassword(old_password, new_password)
 		except dbus.DBusException, e:
-			print "Unable to change password: ", e
+			print("Unable to change password: ", e)
 			sys.exit(1)
-		print "Password changed"
+		print("Password changed")
 		sys.exit(0)
 	else:
 		try:
 			cb.SetProperty(property, newvalue, pin)
 		except dbus.DBusException, e:
-			print "Unable to set property: ", e
+			print("Unable to set property: ", e)
 			sys.exit(1)
 =

 	canexit =3D True
diff --git a/test/test-call-forwarding b/test/test-call-forwarding
index 85aca23..772948b 100755
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
@@ -37,83 +37,83 @@ if __name__ =3D=3D "__main__":
 	try:
 		cf.SetProperty("FoobarNoReplyTimeout", dbus.UInt16(19))
 	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("VoiceNotReachableTimeout", dbus.UInt16(19))
 	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("VoiceNoReplyTimeout", dbus.UInt16(19))
 	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("DataNoReplyTimeout", dbus.UInt16(19))
 	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("FaxNoReplyTimeout", dbus.UInt16(19))
 	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("SmsNoReplyTimeout", dbus.UInt16(19))
 	except dbus.DBusException, e:
-		print "Unable to set timeout - Good"
+		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("VoiceNoReply", "")
 	except dbus.DBusException, e:
-		print "Unable to erase voice no reply rule - Bad"
+		print("Unable to erase voice no reply rule - Bad")
 =

 	try:
 		cf.SetProperty("VoiceNoReply", "+134444")
 	except dbus.DBusException, e:
-		print "Unable to register voice no reply rule - Bad"
+		print("Unable to register voice no reply rule - Bad")
 =

 	try:
 		cf.SetProperty("VoiceNoReplyTimeout", dbus.UInt16(30))
 	except dbus.DBusException, e:
-		print "Unable to set voice no reply timeout - Bad"
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
 	except dbus.DBusException, e:
-		print "Unable to set Voice Unconditional - Bad"
+		print("Unable to set Voice Unconditional - Bad")
 =

 	properties =3D cf.GetProperties()
 =

-	print properties["VoiceUnconditional"]
+	print(properties["VoiceUnconditional"])
 =

 	try:
 		cf.DisableAll("foobar")
 	except dbus.DBusException, e:
-		print "Unable to delete invalids - Good"
+		print("Unable to delete invalids - Good")
 =

 	try:
 		cf.DisableAll("conditional")
 	except dbus.DBusException, e:
-		print "Unable to delete all conditional - Bad"
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
 	except dbus.DBusException, e:
-		print "Unable to delete all conditional - Bad"
+		print("Unable to delete all conditional - Bad")
 =

-	print properties["VoiceUnconditional"]
+	print(properties["VoiceUnconditional"])
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
diff --git a/test/test-call-settings b/test/test-call-settings
index 9008614..f30756e 100755
--- a/test/test-call-settings
+++ b/test/test-call-settings
@@ -7,18 +7,18 @@ import dbus.mainloop.glib
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
-		print "Usage: %s [modem] <property> <newvalue>" % (sys.argv[0])
-		print "Properties can be: VoiceCallWaiting,"
-		print "	ConnectedLineRestriction, CallingLineRestriction,"
-		print "	CallingLinePresentation, CalledLinePresentation,"
-		print "	ConnectedLinePresentation, HideCallerId"
+		print("Usage: %s [modem] <property> <newvalue>" % (sys.argv[0]))
+		print("Properties can be: VoiceCallWaiting,")
+		print("	ConnectedLineRestriction, CallingLineRestriction,")
+		print("	CallingLinePresentation, CalledLinePresentation,")
+		print("	ConnectedLinePresentation, HideCallerId")
 		sys.exit(1)
 =

 	canexit =3D False
@@ -41,7 +41,7 @@ if __name__ =3D=3D "__main__":
 		property =3D sys.argv[1]
 		newvalue =3D sys.argv[2]
 =

-	print "Using modem %s" % modem
+	print("Using modem %s" % modem)
 =

 	cs =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.CallSettings')
@@ -50,31 +50,31 @@ if __name__ =3D=3D "__main__":
 =

 	properties =3D cs.GetProperties()
 =

-	print "Current Property values:"
-	print "Network Status of Call Waiting - Voice: %s" %\
-		(properties['VoiceCallWaiting'])
-	print "Network Status of Connected Line Restriction: %s" %\
-		(properties['ConnectedLineRestriction'])
-	print "Network Status of Calling Line Restriction: %s" %\
-		(properties['CallingLineRestriction'])
-	print "Network Status of Calling Line Presentation: %s" %\
-		(properties['CallingLinePresentation'])
-	print "Network Status of Called Line Presentation: %s" %\
-		(properties['CalledLinePresentation'])
-	print "Network Status of Connected Line Presentation: %s" %\
-		(properties['ConnectedLinePresentation'])
-	print "Hide my Caller Id: %s" % (properties['HideCallerId'])
+	print("Current Property values:")
+	print("Network Status of Call Waiting - Voice: %s" %\
+		(properties['VoiceCallWaiting']))
+	print("Network Status of Connected Line Restriction: %s" %\
+		(properties['ConnectedLineRestriction']))
+	print("Network Status of Calling Line Restriction: %s" %\
+		(properties['CallingLineRestriction']))
+	print("Network Status of Calling Line Presentation: %s" %\
+		(properties['CallingLinePresentation']))
+	print("Network Status of Called Line Presentation: %s" %\
+		(properties['CalledLinePresentation']))
+	print("Network Status of Connected Line Presentation: %s" %\
+		(properties['ConnectedLinePresentation']))
+	print("Hide my Caller Id: %s" % (properties['HideCallerId']))
 =

 	try:
 		cs.SetProperty(property, newvalue)
 	except dbus.DBusException, e:
-		print "Unable to set property: ", e
+		print("Unable to set property: %s" % e)
 		sys.exit(1);
 =

-	print "Setting successful"
+	print("Setting successful")
 =

 	if (properties[property] =3D=3D newvalue):
-		print "Setting was already set to this value"
+		print("Setting was already set to this value")
 		sys.exit(1);
 =

 	canexit =3D True
diff --git a/test/test-cbs b/test/test-cbs
index af25b89..2e7884b 100755
--- a/test/test-cbs
+++ b/test/test-cbs
@@ -7,69 +7,69 @@ import gobject
 import os
 =

 def print_menu():
-	print "Select test case"
-	print "----------------------------------------------------------------"
-	print "[0] Activate cbs"
-	print "[1] Deactivate cbs"
-	print "[2] Get cbs properties"
-	print "[3] Set/Register topics"
-	print "        If several - give topics separated with comma. \
-		\n        E.g. 20,50-51,60"
-	print "[4] Clear/Unregister topics"
-	print "[5] NetReg Base Station - Get current serving cell"
-	print "[x] Exit"
-	print "----------------------------------------------------------------"
+	print("Select test case")
+	print("----------------------------------------------------------------")
+	print("[0] Activate cbs")
+	print("[1] Deactivate cbs")
+	print("[2] Get cbs properties")
+	print("[3] Set/Register topics")
+	print("        If several - give topics separated with comma. \
+		\n        E.g. 20,50-51,60")
+	print("[4] Clear/Unregister topics")
+	print("[5] NetReg Base Station - Get current serving cell")
+	print("[x] Exit")
+	print("----------------------------------------------------------------")
 =

 def property_changed(property, value):
 	if value =3D=3D "" and property =3D=3D "Topics":
-		print "User selected Topics have been cleared. \
-			\nRegistered for emergency topics only."
+		print("User selected Topics have been cleared. \
+			\nRegistered for emergency topics only.")
 	else:
-		print "Cell Broadcast property %s is changed to %s" % (property, value)
-	print "\nPress ENTER to continue"
+		print("Cell Broadcast property %s is changed to %s" % (property, value))
+	print("\nPress ENTER to continue")
 =

 def incoming_broadcast(text, topic):
-	print "Broadcast msg: %s \n Topic channel: %s" % (text, topic)
-	print "\nPress ENTER to continue"
+	print("Broadcast msg: %s \n Topic channel: %s" % (text, topic))
+	print("\nPress ENTER to continue")
 =

 def emergency_broadcast(text, properties):
 	emergType =3D properties["EmergencyType"]
 	emergAlert =3D properties["EmergencyAlert"]
 =

-	print "Broadcast msg: %s \n\t Type: %s \n\t Alert: %s \n\t Popup: %s" \
-		% (text, emergType, emergAlert, popup)
+	print("Broadcast msg: %s \n\t Type: %s \n\t Alert: %s \n\t Popup: %s" \
+		% (text, emergType, emergAlert, popup))
 =

 	if properties["Popup"] =3D=3D True:
-		print "Popup required."
+		print("Popup required.")
 =

-	print "\nPress ENTER to continue"
+	print("\nPress ENTER to continue")
 =

 def set_cbs_state(cbs, state):
 	if state =3D=3D True:
-		print "Activating cell broadcast..."
+		print("Activating cell broadcast...")
 		cbs.SetProperty("Powered", dbus.Boolean(1))
 	else:
-		print "Deactivating cell broadcast..."
+		print("Deactivating cell broadcast...")
 		cbs.SetProperty("Powered", dbus.Boolean(0))
-	print "-----------------------------------------------------------"
+	print("-----------------------------------------------------------")
 =

 def print_cbs_properties(cbs):
 	properties =3D cbs.GetProperties()
-	print "---------------------PROPERTIES----------------------------"
+	print("---------------------PROPERTIES----------------------------")
 	for p in properties:
 		if len(properties[p].__str__()) > 0:
 			if p =3D=3D "Powered":
 				if properties[p] =3D=3D True:
-					print "Cell Broadcast is Activated."
+					print("Cell Broadcast is Activated.")
 				else:
-					print "Cell Broadcast is Deactivated."
+					print("Cell Broadcast is Deactivated.")
 			elif p =3D=3D "Topics":
-				print "Currently set CBS %s are: %s" \
-					% (p, properties[p])
+				print("Currently set CBS %s are: %s" \
+					% (p, properties[p]))
 				topics_available =3D True
 		else:
-			print "Cell Broadcast %s value empty" % (p)
-	print "-----------------------------------------------------------"
+			print("Cell Broadcast %s value empty" % (p))
+	print("-----------------------------------------------------------")
 =

 def set_topics(cbs):
 	print_cbs_properties(cbs)
@@ -86,27 +86,27 @@ def set_topics(cbs):
 		elif topics[index] >=3D '0' and topics[index] <=3D '9':
 			topicTemp =3D topicTemp + topics[index]
 		else:
-			print "Invalid char. \"%s\" entered. Topic not set." \
-				% (topics[index])
+			print("Invalid char. \"%s\" entered. Topic not set." \
+				% (topics[index]))
 			invalidData =3D True
 			break
 =

 		if topicTemp:
 			if int(topicTemp) > 999:
 				invalidData =3D True
-				print "Invalid Topic ID %s (range 0-999). \
-					\nCould not register." % topicTemp
+				print("Invalid Topic ID %s (range 0-999). \
+					\nCould not register." % topicTemp)
 =

 		index =3D index + 1
 =

 	if invalidData =3D=3D False:
 		try:
-			print "Setting Cell Broadcast topics..."
+			print("Setting Cell Broadcast topics...")
 			cbs.SetProperty("Topics", topics);
 		except dbus.DBusException, e:
-			print "Unable to set topic: ", e
+			print("Unable to set topic: %s" % e)
 =

-	print "-----------------------------------------------------------"
+	print("-----------------------------------------------------------")
 =

 def get_serving_cell_name(netReg):
 	wasFound =3D False;
@@ -115,17 +115,17 @@ def get_serving_cell_name(netReg):
 	for p in properties:
 		if p =3D=3D "BaseStation":
 			if len(properties[p].__str__()) > 0:
-				print "Current serving cell name: %s" \
-					% (properties["BaseStation"])
+				print("Current serving cell name: %s" \
+					% (properties["BaseStation"]))
 				wasFound =3D True;
 			else:
-				print "Current Serving cell name empty. \
-					Base Station CBS not available."
+				print("Current Serving cell name empty. \
+					Base Station CBS not available.")
 =

 	if wasFound =3D=3D False:
-		print "Base Station parameter not found. \
-			\nBase Station CBS not available."
-	print "-----------------------------------------------------------"
+		print("Base Station parameter not found. \
+			\nBase Station CBS not available.")
+	print("-----------------------------------------------------------")
 =

 def stdin_handler(fd, condition, cbs, netReg):
 	in_key =3D os.read(fd.fileno(), 160).rstrip()
@@ -151,7 +151,7 @@ def stdin_handler(fd, condition, cbs, netReg):
 	elif in_key =3D=3D 'x':
 		sys.exit(1)
 =

-	print '\n' * 2
+	print('\n' * 2)
 	print_menu()
 =

 	return True
@@ -177,7 +177,7 @@ if __name__ =3D=3D "__main__":
 	cbs.connect_to_signal("IncomingBroadcast", incoming_broadcast)
 	cbs.connect_to_signal("EmergencyBroadcast", emergency_broadcast)
 =

-	print '\n' * 2
+	print('\n' * 2)
 =

 	print_menu()
 =

diff --git a/test/test-gnss b/test/test-gnss
index aff7554..9824627 100755
--- a/test/test-gnss
+++ b/test/test-gnss
@@ -15,27 +15,27 @@ class PositioningAgent(dbus.service.Object):
 	@dbus.service.method(AGENT_INTERFACE,
 					in_signature=3D"", out_signature=3D"")
 	def Release(self):
-		print "Release"
+		print("Release")
 		mainloop.quit()
 =

 	@dbus.service.method(AGENT_INTERFACE,
 					in_signature=3D"s", out_signature=3D"")
 	def Request(self, xml):
-		print "positioning data: %s" % (xml)
+		print("positioning data: %s" % (xml))
 =

 	@dbus.service.method(AGENT_INTERFACE,
 					in_signature=3D"", out_signature=3D"")
 	def ResetAssistanceData(self):
-		print "Reset Assistance Data request received"
+		print("Reset Assistance Data request received")
 =

 def print_menu():
-	print "Select test case"
-	print "-----------------------------------------------------------"
-	print "[0] SendPositioningElement"
-	print "[1] RegisterPositioningRequestAgent"
-	print "[2] UnregisterPositioningRequestAgent"
-	print "[x] Exit"
-	print "-----------------------------------------------------------"
+	print("Select test case")
+	print("-----------------------------------------------------------")
+	print("[0] SendPositioningElement")
+	print("[1] RegisterPositioningRequestAgent")
+	print("[2] UnregisterPositioningRequestAgent")
+	print("[x] Exit")
+	print("-----------------------------------------------------------")
 =

 def stdin_handler(fd, condition, gnss, path):
 	in_key =3D os.read(fd.fileno(), 8).rstrip()
@@ -43,23 +43,23 @@ def stdin_handler(fd, condition, gnss, path):
 		xml =3D raw_input('type the element and press enter: ')
 		try:
 			gnss.SendPositioningElement(dbus.String(xml))
-			print "ok"
+			print("ok")
 		except dbus.DBusException, e:
-			print "Unable to send positioning element"
+			print("Unable to send positioning element")
 =

 	elif in_key =3D=3D '1':
 		try:
 			gnss.RegisterPositioningRequestAgent("/test/posagent")
-			print "ok"
+			print("ok")
 		except dbus.DBusException, e:
-			print "Unable to register positioning agent"
+			print("Unable to register positioning agent")
 =

 	elif in_key =3D=3D '2':
 		try:
 			gnss.UnregisterPositioningRequestAgent(path)
-			print "ok"
+			print("ok")
 		except dbus.DBusException, e:
-			print "Unable to unregister positioning agent"
+			print("Unable to unregister positioning agent")
 	elif in_key =3D=3D 'x':
 		sys.exit(1)
 =

diff --git a/test/test-message-waiting b/test/test-message-waiting
index 3abe0ba..b737ee4 100755
--- a/test/test-message-waiting
+++ b/test/test-message-waiting
@@ -7,11 +7,11 @@ import dbus.mainloop.glib
 =

 def mw_property_changed(name, value):
 	if name =3D=3D 'VoicemailMessageCount':
-		print "MessageWaiting property: '%s' changed to '%d'" %\
-			(name,value)
+		print("MessageWaiting property: '%s' changed to '%d'" %\
+			(name,value))
 	else:
-		print "MessageWaiting property: '%s' changed to '%s'" %\
-			(name,value)
+		print("MessageWaiting property: '%s' changed to '%s'" %\
+			(name,value))
 =

 if __name__ =3D=3D "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -30,11 +30,11 @@ if __name__ =3D=3D "__main__":
 =

 	properties =3D mw.GetProperties()
 =

-	print "Voicemail waiting: %s" % (properties['VoicemailWaiting'])
-	print "Voicemail message count: %d" %\
-		(properties['VoicemailMessageCount'])
-	print "Voicemail mailbox number: %s" %\
-		(properties['VoicemailMailboxNumber'])
+	print("Voicemail waiting: %s" % (properties['VoicemailWaiting']))
+	print("Voicemail message count: %d" %\
+		(properties['VoicemailMessageCount']))
+	print("Voicemail mailbox number: %s" %\
+		(properties['VoicemailMailboxNumber']))
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
diff --git a/test/test-modem b/test/test-modem
index c91caa3..e4dd6bd 100755
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
@@ -25,41 +25,41 @@ if __name__ =3D=3D "__main__":
 	properties =3D modem.GetProperties()
 =

 	if properties.has_key('Name'):
-		print "Name: %s" % (properties['Name'])
+		print("Name: %s" % (properties['Name']))
 =

 	if properties.has_key('Manufacturer'):
-		print "Manufacturer: %s" % (properties['Manufacturer'])
+		print("Manufacturer: %s" % (properties['Manufacturer']))
 =

 	if properties.has_key('Model'):
-		print "Model: %s" % (properties['Model'])
+		print("Model: %s" % (properties['Model']))
 =

 	if properties.has_key('Revision'):
-		print "Revision: %s" % (properties['Revision'])
+		print("Revision: %s" % (properties['Revision']))
 =

 	if properties.has_key('Serial'):
-		print "Serial: %s" % (properties['Serial'])
+		print("Serial: %s" % (properties['Serial']))
 =

 	if properties.has_key('Powered'):
-		print "Powered: %s" % (properties['Powered'])
+		print("Powered: %s" % (properties['Powered']))
 =

 	if properties.has_key('Online'):
-		print "Online: %s" % (properties['Online'])
+		print("Online: %s" % (properties['Online']))
 =

 	if properties.has_key('Lockdown'):
-		print "Lockdown: %s" % (properties['Lockdown'])
+		print("Lockdown: %s" % (properties['Lockdown']))
 =

 	if properties.has_key('Emergency'):
-		print "Emergency: %s" % (properties['Emergency'])
+		print("Emergency: %s" % (properties['Emergency']))
 =

 	if properties.has_key('Features'):
-		print "Features:"
+		print("Features:")
 		for feature in properties["Features"]:
-			print "    [ %s ]" % (feature)
+			print("    [ %s ]" % (feature))
 =

 	if properties.has_key('Interfaces'):
-		print "Interfaces:"
+		print("Interfaces:")
 		for interface in properties["Interfaces"]:
-			print "    [ %s ]" % (interface)
+			print("    [ %s ]" % (interface))
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
diff --git a/test/test-network-registration b/test/test-network-registration
index cfc1a43..f692efa 100755
--- a/test/test-network-registration
+++ b/test/test-network-registration
@@ -6,18 +6,18 @@ import dbus
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
 	if len(sys.argv) < 2:
-		print "Usage: %s [modem] <path> - Register to PLMN on <path>" %\
-			(sys.argv[0])
-		print "Usage: %s [modem] default - Register to default PLMN" %\
-			(sys.argv[0])
+		print("Usage: %s [modem] <path> - Register to PLMN on <path>" %\
+			(sys.argv[0]))
+		print("Usage: %s [modem] default - Register to default PLMN" %\
+			(sys.argv[0]))
 		sys.exit(1)
 =

 	canexit =3D False
@@ -44,15 +44,15 @@ if __name__ =3D=3D "__main__":
 =

 	props =3D netreg.GetProperties()
 =

-	print "Status is: '%s', Operator Name is: '%s'" %\
-		(props['Status'], props['Name'])
+	print("Status is: '%s', Operator Name is: '%s'" %\
+		(props['Status'], props['Name']))
 =

 	if props.has_key('LocationAreaCode') and props.has_key('CellId'):
-		print "Location: '%d', Cell: '%d'" %\
-			(props['LocationAreaCode'], props['CellId'])
+		print("Location: '%d', Cell: '%d'" %\
+			(props['LocationAreaCode'], props['CellId']))
 =

 	if props.has_key('Technology'):
-		print "Technology: '%s'" % (props['Technology'])
+		print("Technology: '%s'" % (props['Technology']))
 =

 	try:
 		if plmn =3D=3D 'default':
@@ -62,7 +62,7 @@ if __name__ =3D=3D "__main__":
 			op =3D dbus.Interface(obj, 'org.ofono.NetworkOperator')
 			op.Register()
 	except dbus.DBusException, e:
-		print "Unable to register: ", e
+		print("Unable to register: %s" % e)
 		sys.exit(1)
 =

 	canexit =3D True
diff --git a/test/test-phonebook b/test/test-phonebook
index 345ba67..116fd4f 100755
--- a/test/test-phonebook
+++ b/test/test-phonebook
@@ -20,4 +20,4 @@ if __name__ =3D=3D "__main__":
 	phonebook =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.Phonebook')
 =

-	print phonebook.Import(timeout=3D100)
+	print(phonebook.Import(timeout=3D100))
diff --git a/test/test-push-notification b/test/test-push-notification
index 11d384c..d05ec35 100755
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
 		for key in props.keys():
-			print "Key: %s, Value: %s" % (key, props[key])
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
 =

diff --git a/test/test-smart-messaging b/test/test-smart-messaging
index 0a37ba1..6d5d44b 100755
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
 		for key in props.keys():
-			print "Key: %s, Value: %s" % (key, props[key])
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
 		for key in props.keys():
-			print "Key: %s, Value: %s" % (key, props[key])
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
 =

diff --git a/test/test-sms b/test/test-sms
index 794d46a..5c0bfbb 100755
--- a/test/test-sms
+++ b/test/test-sms
@@ -20,29 +20,29 @@ def clear_screen(numlines=3D100):
 		os.system('CLS')
 =

 	else:
-		print '\n' * numlines
+		print('\n' * numlines)
 =

 def print_menu():
-	print "Select test case"
-	print "-----------------------------------------------------------"
-	print "[0] Send SMS"
-	print "[1] Enable delivery reports"
-	print "[2] Disable delivery reports"
-	print "[3] Set Service Center Address"
-	print "[4] Set PS-only Bearer"
-	print "[5] Set CS-only Bearer"
-	print "[6] Set PS-preferred Bearer"
-	print "[7] Set CS-preferred Bearer"
-	print "[x] Exit"
-	print "-----------------------------------------------------------"
+	print("Select test case")
+	print("-----------------------------------------------------------")
+	print("[0] Send SMS")
+	print("[1] Enable delivery reports")
+	print("[2] Disable delivery reports")
+	print("[3] Set Service Center Address")
+	print("[4] Set PS-only Bearer")
+	print("[5] Set CS-only Bearer")
+	print("[6] Set PS-preferred Bearer")
+	print("[7] Set CS-preferred Bearer")
+	print("[x] Exit")
+	print("-----------------------------------------------------------")
 =

 def print_send_sms_menu():
-	print "Select SMS type"
-	print "-----------------------------------------------------------"
-	print "[1] Default SMS"
-	print "[2] Long SMS > 160 characters"
-	print "[3] SMS with national characters"
-	print "-----------------------------------------------------------"
+	print("Select SMS type")
+	print("-----------------------------------------------------------")
+	print("[1] Default SMS")
+	print("[2] Long SMS > 160 characters")
+	print("[3] SMS with national characters")
+	print("-----------------------------------------------------------")
 =

 def message_delivery_report(sms, value):
 	try:
@@ -50,79 +50,79 @@ def message_delivery_report(sms, value):
 =

 	except dbus.DBusException, e:
 		if value =3D=3D 1:
-			print "Unable to activate Delivery Reports - FAIL"
+			print("Unable to activate Delivery Reports - FAIL")
 =

 		if value =3D=3D 0:
-			print "Unable to deactivate Delivery Reports - FAIL"
+			print("Unable to deactivate Delivery Reports - FAIL")
 =

 def message_service_center_address(sms, value):
 	try:
 		sms.SetProperty("ServiceCenterAddress",dbus.String(value))
 	except dbus.DBusException, e:
-		print "Unable to set correct Service Center Address - FAIL"
+		print("Unable to set correct Service Center Address - FAIL")
 =

 def message_bearer(sms, value):
 	try:
 		sms.SetProperty("Bearer", dbus.String(value))
 	except dbus.DBusException, e:
-		print "Unable to set Bearer[%s] - FAIL" % (value)
+		print("Unable to set Bearer[%s] - FAIL" % (value))
 =

 =

 def message_send(sms, number, value):
 	sms.SendMessage(dbus.String(number), value)
 =

 def property_changed(property, value):
-	print "[1]:Message Manager property %s changed to %s" %\
-			(property, value)
-	print "[1]:press ENTER"
+	print("[1]:Message Manager property %s changed to %s" %\
+			(property, value))
+	print("[1]:press ENTER")
 =

 def immediate_message(property, value):
-	print "[2]:Message Manager immediate message"
-	print "[2]:Text::%s" % (property)
+	print("[2]:Message Manager immediate message")
+	print("[2]:Text::%s" % (property))
 	for key in value.keys():
 		val =3D str(value[key])
-		print "[2]:%s =3D %s" % (key, val)
+		print("[2]:%s =3D %s" % (key, val))
 =

-	print "[2]:press ENTER"
+	print("[2]:press ENTER")
 =

 def incoming_message(property, value):
-	print "[3]:Message Manager incoming message"
-	print "[3]:Text::%s" % (property)
+	print("[3]:Message Manager incoming message")
+	print("[3]:Text::%s" % (property))
 	for key in value.keys():
 		val =3D str(value[key])
-		print "[3]:%s =3D %s" % (key, val)
+		print("[3]:%s =3D %s" % (key, val))
 =

-	print "[3]:press ENTER"
+	print("[3]:press ENTER")
 =

 def message_added(property, value):
-	print "[4]:Message Manager[Added]"
-	print "[4]:%s"% (property)
+	print("[4]:Message Manager[Added]")
+	print("[4]:%s"% (property))
 =

 	for key in value.keys():
 		val =3D str(value[key])
-		print "[4]:%s =3D %s" % (key, val)
+		print("[4]:%s =3D %s" % (key, val))
 =

-	print "[4]:press ENTER"
+	print("[4]:press ENTER")
 =

 def message_removed(property):
-	print "[5]:Message Manager [removed]"
-	print "[5]: %s" % (property)
-	print "[5]:press ENTER"
+	print("[5]:Message Manager [removed]")
+	print("[5]: %s" % (property))
+	print("[5]:press ENTER")
 =

 def print_sms_properties(sms):
 	global SCA
 	properties =3D sms.GetProperties()
-	print "---------------------PROPERTIES----------------------------"
+	print("---------------------PROPERTIES----------------------------")
 	for p in properties:
 		if len(properties[p].__str__()) > 0:
-			print "%s Message Manager rule is: %s" %\
-					(p, properties[p])
-			print "------------------------------------------" \
-				"-----------------"
+			print("%s Message Manager rule is: %s" %\
+					(p, properties[p]))
+			print("------------------------------------------" \
+				"-----------------")
 			if p =3D=3D "ServiceCenterAddress":
 				SCA =3D properties[p]
 		else:
-			print "%s Message Manager rule disabled" % (p)
+			print("%s Message Manager rule disabled" % (p))
 =

 def stdin_handler(fd, condition, sms, value, number):
 	global lock
@@ -210,7 +210,7 @@ def stdin_handler(fd, condition, sms, value, number):
 if __name__ =3D=3D "__main__":
 =

 	if (len(sys.argv) < 3):
-		print "Usage: %s  [modem] <phone_number> <test_message>" % (sys.argv[0])
+		print("Usage: %s  [modem] <phone_number> <test_message>" % (sys.argv[0]))
 		sys.exit(1)
 =

 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
diff --git a/test/test-ss b/test/test-ss
index d5488d7..7bd18af 100755
--- a/test/test-ss
+++ b/test/test-ss
@@ -23,20 +23,20 @@ ss =3D dbus.Interface(bus.get_object('org.ofono', modem=
),
 try:
 	ss_type, properties =3D ss.Initiate(ss_code, timeout=3D100)
 except dbus.DBusException, e:
-	print "Unable to perform operation: ", e
+	print("Unable to perform operation: %s" % e)
 	sys.exit(1);
 =

 if (ss_type =3D=3D "CallBarring"):
-	print "%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properties[=
0], properties[1])
+	print("%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properties[=
0], properties[1]))
 	for key in properties[2]:
-		print "%s : %s" % (key, properties[2][key])
+		print("%s : %s" % (key, properties[2][key]))
 elif (ss_type =3D=3D "CallForwarding"):
-	print "%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properties[=
0], properties[1])
+	print("%s : Operation [ %s ] Service Type [ %s ]" % (ss_type, properties[=
0], properties[1]))
 	for key in properties[2]:
-		print "%s : %s" % (key, properties[2][key])
+		print("%s : %s" % (key, properties[2][key]))
 elif (ss_type =3D=3D "CallWaiting"):
-	print "%s : Operation [ %s ]" % (ss_type, properties[0])
+	print("%s : Operation [ %s ]" % (ss_type, properties[0]))
 	for key in properties[1]:
-		print "%s : %s" % (key, properties[1][key])
+		print("%s : %s" % (key, properties[1][key]))
 else:
-	print "%s : Operation [ %s ] Status [ %s ]" % (ss_type, properties[0], pr=
operties[1])
+	print("%s : Operation [ %s ] Status [ %s ]" % (ss_type, properties[0], pr=
operties[1]))
diff --git a/test/test-ss-control-cb b/test/test-ss-control-cb
index f855635..505bcd7 100755
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
+		print(ss.Initiate("*33#456666"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CB"
+	print("Trying invalid SS request for CB")
 	try:
-		print ss.Initiate("*33*ABC#")
+		print(ss.Initiate("*33*ABC#"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CB"
+	print("Trying invalid SS request for CB")
 	try:
-		print ss.Initiate("*33**ABC#")
+		print(ss.Initiate("*33**ABC#"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CB"
+	print("Trying invalid SS request for CB")
 	try:
-		print ss.Initiate("*33***12#")
+		print(ss.Initiate("*33***12#"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
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
index 35db591..6ce022f 100755
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
@@ -34,80 +34,80 @@ if __name__ =3D=3D "__main__":
 =

 	print_properties(cs)
 =

-	print "Trying invalid SS request for CLIR"
+	print("Trying invalid SS request for CLIR")
 	try:
-		print ss.Initiate("*31#456666")
+		print(ss.Initiate("*31#456666"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CLIR"
+	print("Trying invalid SS request for CLIR")
 	try:
-		print ss.Initiate("*31*455*4#")
+		print(ss.Initiate("*31*455*4#"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CLIR"
+	print("Trying invalid SS request for CLIR")
 	try:
-		print ss.Initiate("*31**44435#")
+		print(ss.Initiate("*31**44435#"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print("Failed with %s - Good" % e)
 =

-	print "Query CLIP"
-	print ss.Initiate("*#30#")
+	print("Query CLIP")
+	print(ss.Initiate("*#30#"))
 =

-	print "Query CNAP"
-	print ss.Initiate("*#300#")
+	print("Query CNAP")
+	print(ss.Initiate("*#300#"))
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
+		print(ss.Initiate("*43#456666"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CW"
+	print("Trying invalid SS request for CW")
 	try:
-		print ss.Initiate("*43*455*4#")
+		print(ss.Initiate("*43*455*4#"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
+		print("Failed with %s - Good" % e)
 =

-	print "Trying invalid SS request for CW"
+	print("Trying invalid SS request for CW")
 	try:
-		print ss.Initiate("*43**44435#")
+		print(ss.Initiate("*43**44435#"))
 	except dbus.DBusException, e:
-		print "Failed with %s - Good" % e
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
index ae6dbcb..eaba994 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -34,7 +34,7 @@ class StkAgent(dbus.service.Object):
 		return False
 =

 	def call_added(self, path, properties):
-		print "call added %s" % (path)
+		print("call added %s" % (path))
 		if (self.timeout_id > 0):
 			gobject.source_remove(self.timeout_id)
 			self.timeout_callback()
@@ -42,21 +42,21 @@ class StkAgent(dbus.service.Object):
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
-		print "Icon: (%d)" % (icon)
+		print("Title: (%s)" % (title))
+		print("Icon: (%d)" % (icon))
 		index =3D 0
 		for item in items:
-			print "%d. %s (icon: %d)" % (index, item[0], item[1])
+			print("%d. %s (icon: %d)" % (index, item[0], item[1]))
 			index +=3D 1
 =

-		print "\nDefault: %d" % (default)
+		print("\nDefault: %d" % (default))
 		select =3D raw_input("Enter Selection (t, b):")
 =

 		if select =3D=3D 'b':
@@ -71,9 +71,9 @@ class StkAgent(dbus.service.Object):
 					async_callbacks=3D("reply_func",
 								"error_func"))
 	def DisplayText(self, title, icon, urgent, reply_func, error_func):
-		print "DisplayText (%s)" % (title)
-		print "Icon: (%d)" % (icon)
-		print "Urgent: (%d)" % (urgent)
+		print("DisplayText (%s)" % (title))
+		print("Icon: (%d)" % (icon))
+		print("Urgent: (%d)" % (urgent))
 		key =3D raw_input("Press return to clear ('t' terminates, "
 						"'b' goes back, 'n' busy, "
 						"'w' return and wait):")
@@ -91,7 +91,7 @@ class StkAgent(dbus.service.Object):
 			raise Busy("User wishes to simulate busy screen")
 =

 		if (seconds > 0):
-			print "Waiting for %d seconds" % (seconds)
+			print("Waiting for %d seconds" % (seconds))
 =

 		self.timeout_reply_handler =3D reply_func
 		self.timeout_id =3D gobject.timeout_add_seconds(seconds,
@@ -101,12 +101,12 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sysyyb", out_signature=3D"s")
 	def RequestInput(self, title, icon, default, min_chars, max_chars,
 				hide_typing):
-		print "Title: (%s)" % (title)
-		print "Icon: (%d)" % (icon)
-		print "Default: (%s)" % (default)
-		print "Hide typing: (%s)" % (hide_typing)
-		print "Enter characters, min: %d, max: %d:" % (min_chars,
-								max_chars)
+		print("Title: (%s)" % (title))
+		print("Icon: (%d)" % (icon))
+		print("Default: (%s)" % (default))
+		print("Hide typing: (%s)" % (hide_typing))
+		print("Enter characters, min: %d, max: %d:" % (min_chars,
+								max_chars))
 		userin =3D raw_input("")
 =

 		return userin
@@ -115,12 +115,12 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sysyyb", out_signature=3D"s")
 	def RequestDigits(self, title, icon, default, min_chars, max_chars,
 				hide_typing):
-		print "Title: (%s)" % (title)
-		print "Icon: (%d)" % (icon)
-		print "Default: (%s)" % (default)
-		print "Hide typing: (%s)" % (hide_typing)
-		print "Enter digits, min: %d, max: %d:" % (min_chars,
-								max_chars)
+		print("Title: (%s)" % (title))
+		print("Icon: (%d)" % (icon))
+		print("Default: (%s)" % (default))
+		print("Hide typing: (%s)" % (hide_typing))
+		print("Enter digits, min: %d, max: %d:" % (min_chars,
+								max_chars))
 		userin =3D raw_input("'t' terminates, 'b' goes back:")
 =

 		if userin =3D=3D 'b':
@@ -133,8 +133,8 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"s")
 	def RequestKey(self, title, icon):
-		print "Title: (%s)" % (title)
-		print "Icon: (%d)" % (icon)
+		print("Title: (%s)" % (title))
+		print("Icon: (%d)" % (icon))
 		key =3D raw_input("Enter Key (t, b):")
 =

 		if key =3D=3D 'b':
@@ -147,8 +147,8 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"s")
 	def RequestDigit(self, title, icon):
-		print "Title: (%s)" % (title)
-		print "Icon: (%d)" % (icon)
+		print("Title: (%s)" % (title))
+		print("Icon: (%d)" % (icon))
 		key =3D raw_input("Enter Digit (t, b):")
 =

 		if key =3D=3D 'b':
@@ -161,8 +161,8 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"s")
 	def RequestQuickDigit(self, title, icon):
-		print "Title: (%s)" % (title)
-		print "Icon: (%d)" % (icon)
+		print("Title: (%s)" % (title))
+		print("Icon: (%d)" % (icon))
 		key =3D raw_input("Quick digit (0-9, *, #, t, b):")
 =

 		if key =3D=3D 'b':
@@ -175,8 +175,8 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"b")
 	def RequestConfirmation(self, title, icon):
-		print "Title: (%s)" % (title)
-		print "Icon: (%d)" % (icon)
+		print("Title: (%s)" % (title))
+		print("Icon: (%d)" % (icon))
 		key =3D raw_input("Enter Confirmation (t, b, y, n):")
 =

 		if key =3D=3D 'b':
@@ -191,8 +191,8 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"b")
 	def ConfirmCallSetup(self, info, icon):
-		print "Information: (%s)" % (info)
-		print "Icon: (%d)" % (icon)
+		print("Information: (%s)" % (info))
+		print("Icon: (%d)" % (icon))
 		key =3D raw_input("Enter Confirmation (t, y, n):")
 =

 		if key =3D=3D 't':
@@ -205,9 +205,9 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sys", out_signature=3D"b")
 	def ConfirmLaunchBrowser(self, info, icon, url):
-		print "Information: (%s)" % (info)
-		print "Icon: (%d)" % (icon)
-		print "URL (%s)" % (url)
+		print("Information: (%s)" % (info))
+		print("Icon: (%d)" % (icon))
+		print("URL (%s)" % (url))
 		key =3D raw_input("Enter Confirmation (y, n):")
 =

 		if key =3D=3D 'y':
@@ -218,14 +218,14 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"", out_signature=3D"")
 	def Cancel(self):
-		print "Cancel"
+		print("Cancel")
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"ssy", out_signature=3D"")
 	def PlayTone(self, tone, text, icon):
-		print "PlayTone: %s" % (tone)
-		print "Text: %s" % (text)
-		print "Icon: %d" % (icon)
+		print("PlayTone: %s" % (tone))
+		print("Text: %s" % (text))
+		print("Icon: %d" % (icon))
 =

 		signal.signal(signal.SIGALRM, handler)
 		signal.alarm(5)
@@ -239,16 +239,16 @@ class StkAgent(dbus.service.Object):
 				raise EndSession("User wishes to terminate"
 								 " session")
 		except Exception, exc:
-			print exc
+			print(exc)
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"ssy", out_signature=3D"",
 					async_callbacks=3D("reply_func",
 								"error_func"))
 	def LoopTone(self, tone, text, icon, reply_func, error_func):
-		print "LoopTone: %s" % (tone)
-		print "Text: %s" % (text)
-		print "Icon: %d" % (icon)
+		print("LoopTone: %s" % (tone))
+		print("Text: %s" % (text))
+		print("Icon: %d" % (icon))
 		key =3D raw_input("Press return to end before timeout "
 				"('t' terminates, 'w' return and wait):")
 =

@@ -261,7 +261,7 @@ class StkAgent(dbus.service.Object):
 			raise EndSession("User wishes to terminate session")
 =

 		if (seconds > 0):
-			print "Waiting for %d seconds" % (seconds)
+			print("Waiting for %d seconds" % (seconds))
 =

 		self.timeout_reply_handler =3D reply_func
 		self.timeout_id =3D gobject.timeout_add_seconds(seconds,
@@ -270,14 +270,14 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"sy", out_signature=3D"")
 	def DisplayActionInformation(self, text, icon):
-		print "Text: %s" % (text)
-		print "Icon: %d" % (icon)
+		print("Text: %s" % (text))
+		print("Icon: %d" % (icon))
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"sy", out_signature=3D"")
 	def DisplayAction(self, text, icon):
-		print "Text: (%s)" % (text)
-		print "Icon: (%d)" % (icon)
+		print("Text: (%s)" % (text))
+		print("Icon: (%d)" % (icon))
 		key =3D raw_input("Press 't' to terminate the session ")
 =

 		if key =3D=3D 't':
@@ -286,8 +286,8 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"sy", out_signature=3D"b")
 	def ConfirmOpenChannel(self, info, icon):
-		print "Open channel confirmation: (%s)" % (info)
-		print "Icon: (%d)" % (icon)
+		print("Open channel confirmation: (%s)" % (info))
+		print("Icon: (%d)" % (icon))
 		key =3D raw_input("Enter Confirmation (t, y, n):")
 =

 		if key =3D=3D 't':
@@ -346,7 +346,7 @@ def pretty(d):
 	return str(d)
 =

 def property_changed(name, value):
-	print "SimToolKit property: %s changed to '%s'" % (name, pretty(value))
+	print("SimToolKit property: %s changed to '%s'" % (name, pretty(value)))
 =

 if __name__ =3D=3D '__main__':
 	if len(sys.argv) =3D=3D 2:
@@ -376,15 +376,15 @@ if __name__ =3D=3D '__main__':
 =

 	if mode =3D=3D 'menu':
 		if "MainMenuTitle" in properties:
-			print "Main Menu:"
-			print "%s" % (properties["MainMenuTitle"])
-			print "\n"
+			print("Main Menu:")
+			print("%s" % (properties["MainMenuTitle"]))
+			print("\n")
 =

 		if "MainMenu" in properties:
-			print "Items:"
+			print("Items:")
 			index =3D 0
 			for item in properties["MainMenu"]:
-				print "%d. %s" % (index, item[0])
+				print("%d. %s" % (index, item[0]))
 				index +=3D 1
 =

 		path =3D "/test/agent"
@@ -408,9 +408,9 @@ if __name__ =3D=3D '__main__':
 =

 		stk.RegisterAgent(path)
 =

-		print "Default Agent registered - Waiting for STK command..."
+		print("Default Agent registered - Waiting for STK command...")
 	else:
-		print "%s [menu|agent]" % (sys.argv[0])
+		print("%s [menu|agent]" % (sys.argv[0]))
 		exit(0)
 =

 	mainloop =3D gobject.MainLoop()
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

1.9.0


--===============0540333358561099184==--

