Content-Type: multipart/mixed; boundary="===============5953762237197981661=="
MIME-Version: 1.0
From: Konrad Slowinski <konrad.slowinski@tieto.com>
Subject: [PATCH] test: test-sms - input and signals outputs together
Date: Fri, 04 Feb 2011 10:38:42 +0200
Message-ID: <1296808722-8962-1-git-send-email-konrad.slowinski@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5953762237197981661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-sms |  102 +++++++++++++++++++++++++++++++++--------------------=
---
 1 files changed, 60 insertions(+), 42 deletions(-)

diff --git a/test/test-sms b/test/test-sms
index 7bc6fbc..7d02066 100755
--- a/test/test-sms
+++ b/test/test-sms
@@ -3,11 +3,13 @@
 =

 import gobject
 import sys
+import os
 =

 import dbus
 import dbus.mainloop.glib
 =

 SCA =3D ""
+lock =3D "off"
 =

 def clear_screen(numlines=3D100):
 	import os
@@ -71,6 +73,7 @@ def message_send(sms, number, value):
 =

 def property_changed(property, value):
 	print "[1]:Message Manager property %s changed to %s" % (property, value)
+	print "[1]:press ENTER"
 =

 def immediate_message(property, value):
 	print "[2]:Message Manager immediate message"
@@ -79,6 +82,8 @@ def immediate_message(property, value):
 		val =3D str(value[key])
 		print "[2]:%s =3D %s" % (key, val)
 =

+	print "[2]:press ENTER"
+
 def incoming_message(property, value):
 	print "[3]:Message Manager incoming message"
 	print "[3]:Text::%s" % (property)
@@ -86,6 +91,8 @@ def incoming_message(property, value):
 		val =3D str(value[key])
 		print "[3]:%s =3D %s" % (key, val)
 =

+	print "[3]:press ENTER"
+
 def message_added(property, value):
 	print "[4]:Message Manager[Added]"
 	print "[4]:%s"% (property)
@@ -94,9 +101,12 @@ def message_added(property, value):
 		val =3D str(value[key])
 		print "[4]:%s =3D %s" % (key, val)
 =

+	print "[4]:press ENTER"
+
 def message_removed(property):
 	print "[5]:Message Manager [removed]"
 	print "[5]: %s" % (property)
+	print "[5]:press ENTER"
 =

 def print_sms_properties(sms):
 	global SCA
@@ -111,40 +121,12 @@ def print_sms_properties(sms):
 		else:
 			print "%s Message Manager rule disabled" % (p)
 =

+def stdin_handler(fd, condition, sms, value, number):
+	global lock
+	in_key =3D os.read(fd.fileno(), 160).rstrip()
 =

-
-if __name__ =3D=3D "__main__":
-	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
-	bus =3D dbus.SystemBus()
-	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
-							'org.ofono.Manager')
-
-	modems =3D manager.GetModems()
-	path =3D modems[0][0]
-	sms =3D dbus.Interface(bus.get_object('org.ofono', path),
-				'org.ofono.MessageManager')
-
-	sms.connect_to_signal("PropertyChanged", property_changed)
-	sms.connect_to_signal("ImmediateMessage", immediate_message)
-	sms.connect_to_signal("IncomingMessage", incoming_message)
-	sms.connect_to_signal("MessageAdded", message_added)
-	sms.connect_to_signal("MessageRemoved", message_removed)
-
-	if (len(sys.argv) < 3):
-		print "Usage: %s <phone_number> <test_message>" % (sys.argv[0])
-		sys.exit(1)
-
-	number =3D sys.argv[1]
-	value  =3D sys.argv[2]
-
-	clear_screen()
-	print_sms_properties(sms)
-	print_menu()
-	in_key =3D 'ok'
-
-	while in_key !=3D 'x':
-		in_key =3D raw_input('Select any option: ')
-
+	if lock =3D=3D "off":
+		lock =3D "on"
 		if in_key =3D=3D '0':
 			print_send_sms_menu()
 			sms_type =3D raw_input('Select SMS type: ')
@@ -152,62 +134,98 @@ if __name__ =3D=3D "__main__":
 			if sms_type =3D=3D '1':
 				message_send(sms, number, value)
 =

-			if sms_type =3D=3D '2':
+			elif sms_type =3D=3D '2':
 				val =3D "abcde12345"
 				for i in range(30):
 					value =3D value + val
 =

 				message_send(sms, number, value)
 =

-			if sms_type =3D=3D '3':
+			elif sms_type =3D=3D '3':
 				value =3D "=C3=96=C3=84=C3=85=C3=B6=C3=A4=C3=A5=C2=B5=CA=92=C3=97cvcvb=
=C5=8B"
 				message_send(sms, number, value)
 =

-		if in_key =3D=3D '1':
+		elif in_key =3D=3D '1':
 			message_delivery_report(sms, 1)
 			send_msg =3D raw_input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(1)"+value+": UseDeliveryReports[TRUE]"))
 =

-		if in_key =3D=3D '2':
+		elif in_key =3D=3D '2':
 			message_delivery_report(sms, 0)
 			send_msg =3D raw_input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(2) "+value+": UseDeliveryReports[FALSE]"))
 =

-		if in_key =3D=3D '3':
+		elif in_key =3D=3D '3':
 			message_service_center_address(sms, SCA)
 			send_msg =3D raw_input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(3) "+value+": ServiceCenterAddress"))
 =

-		if in_key =3D=3D '4':
+		elif in_key =3D=3D '4':
 			message_bearer(sms, "ps-only")
 			send_msg =3D raw_input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(4) "+value+": Bearer[ps-only]"))
 =

-		if in_key =3D=3D '5':
+		elif in_key =3D=3D '5':
 			message_bearer(sms, "cs-only")
 			send_msg =3D raw_input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(5) "+value+": Bearer[cs-only]"))
 =

-		if in_key =3D=3D '6':
+		elif in_key =3D=3D '6':
 			message_bearer(sms, "ps-preferred")
 			send_msg =3D raw_input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(6) "+value+": Bearer[ps-preferred]"))
 =

-		if in_key =3D=3D '7':
+		elif in_key =3D=3D '7':
 			message_bearer(sms, "cs-preferred")
 			send_msg =3D raw_input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms,number, ("(7) "+value+": Bearer[cs-preferred]"))
 =

+		elif in_key =3D=3D 'x':
+			sys.exit(1)
+
 		clear_screen()
 		print_sms_properties(sms)
 		print_menu()
+		lock =3D "off"
+
+	return True
+
+if __name__ =3D=3D "__main__":
+
+	if (len(sys.argv) < 3):
+		print "Usage: %s <phone_number> <test_message>" % (sys.argv[0])
+		sys.exit(1)
+
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+	bus =3D dbus.SystemBus()
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+							'org.ofono.Manager')
+
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+	sms =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.MessageManager')
+
+	sms.connect_to_signal("PropertyChanged", property_changed)
+	sms.connect_to_signal("ImmediateMessage", immediate_message)
+	sms.connect_to_signal("IncomingMessage", incoming_message)
+	sms.connect_to_signal("MessageAdded", message_added)
+	sms.connect_to_signal("MessageRemoved", message_removed)
+
+	number =3D sys.argv[1]
+	value  =3D sys.argv[2]
+
+	clear_screen()
+	print_sms_properties(sms)
+	print_menu()
 =

+	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler, sms, value,=
 number)
 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
-- =

1.7.1


--===============5953762237197981661==--

