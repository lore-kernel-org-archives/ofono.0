Content-Type: multipart/mixed; boundary="===============4409229916683343176=="
MIME-Version: 1.0
From: Konrad Slowinski <konrad.slowinski@tieto.com>
Subject: [PATCH] test: test-sms test script added
Date: Wed, 02 Feb 2011 12:44:41 +0200
Message-ID: <1296643481-2516-1-git-send-email-konrad.slowinski@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4409229916683343176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am   |    3 +-
 test/test-sms |  213 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 215 insertions(+), 1 deletions(-)
 create mode 100755 test/test-sms

diff --git a/Makefile.am b/Makefile.am
index a38fcb9..758fb10 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -478,7 +478,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-dial-number \
 		test/cdma-hangup \
 		test/disable-call-forwarding \
-		test/list-messages
+		test/list-messages \
+		test/test-sms
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/test-sms b/test/test-sms
new file mode 100755
index 0000000..7bc6fbc
--- /dev/null
+++ b/test/test-sms
@@ -0,0 +1,213 @@
+#!/usr/bin/python
+# -*- coding: utf-8 -*-
+
+import gobject
+import sys
+
+import dbus
+import dbus.mainloop.glib
+
+SCA =3D ""
+
+def clear_screen(numlines=3D100):
+	import os
+	if os.name =3D=3D "posix":
+		os.system('clear')
+
+	elif os.name in ("nt", "dos", "ce"):
+		os.system('CLS')
+
+	else:
+		print '\n' * numlines
+
+def print_menu():
+	print "Select test case"
+	print "-----------------------------------------------------------"
+	print "[0] Send SMS"
+	print "[1] Enable delivery reports"
+	print "[2] Disable delivery reports"
+	print "[3] Set Service Center Address"
+	print "[4] Set PS-only Bearer"
+	print "[5] Set CS-only Bearer"
+	print "[6] Set PS-preferred Bearer"
+	print "[7] Set CS-preferred Bearer"
+	print "[x] Exit"
+	print "-----------------------------------------------------------"
+
+def print_send_sms_menu():
+	print "Select SMS type"
+	print "-----------------------------------------------------------"
+	print "[1] Default SMS"
+	print "[2] Long SMS > 160 characters"
+	print "[3] SMS with national characters"
+	print "-----------------------------------------------------------"
+
+def message_delivery_report(sms, value):
+	try:
+		sms.SetProperty("UseDeliveryReports", dbus.Boolean(value))
+
+	except dbus.DBusException, e:
+		if value =3D=3D 1:
+		      print "Unable to activate Delivery Reports - FAIL"
+
+		if value =3D=3D 0:
+		      print "Unable to deactivate Delivery Reports - FAIL"
+
+def message_service_center_address(sms, value):
+	try:
+		sms.SetProperty("ServiceCenterAddress",dbus.String(value))
+	except dbus.DBusException, e:
+		print "Unable to set correct Service Center Address - FAIL"
+
+def message_bearer(sms, value):
+	try:
+		sms.SetProperty("Bearer", dbus.String(value))
+	except dbus.DBusException, e:
+		print "Unable to set Bearer[%s] - FAIL" % (value)
+
+
+def message_send(sms, number, value):
+	sms.SendMessage(dbus.String(number), value)
+
+def property_changed(property, value):
+	print "[1]:Message Manager property %s changed to %s" % (property, value)
+
+def immediate_message(property, value):
+	print "[2]:Message Manager immediate message"
+	print "[2]:Text::%s" % (property)
+	for key in value.keys():
+		val =3D str(value[key])
+		print "[2]:%s =3D %s" % (key, val)
+
+def incoming_message(property, value):
+	print "[3]:Message Manager incoming message"
+	print "[3]:Text::%s" % (property)
+	for key in value.keys():
+		val =3D str(value[key])
+		print "[3]:%s =3D %s" % (key, val)
+
+def message_added(property, value):
+	print "[4]:Message Manager[Added]"
+	print "[4]:%s"% (property)
+
+	for key in value.keys():
+		val =3D str(value[key])
+		print "[4]:%s =3D %s" % (key, val)
+
+def message_removed(property):
+	print "[5]:Message Manager [removed]"
+	print "[5]: %s" % (property)
+
+def print_sms_properties(sms):
+	global SCA
+	properties =3D sms.GetProperties()
+	print "---------------------PROPERTIES----------------------------"
+	for p in properties:
+		if len(properties[p].__str__()) > 0:
+			print "%s Message Manager rule is: %s" % (p, properties[p])
+			print "-----------------------------------------------------------"
+			if p =3D=3D "ServiceCenterAddress":
+			    SCA =3D properties[p]
+		else:
+			print "%s Message Manager rule disabled" % (p)
+
+
+
+if __name__ =3D=3D "__main__":
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
+	if (len(sys.argv) < 3):
+		print "Usage: %s <phone_number> <test_message>" % (sys.argv[0])
+		sys.exit(1)
+
+	number =3D sys.argv[1]
+	value  =3D sys.argv[2]
+
+	clear_screen()
+	print_sms_properties(sms)
+	print_menu()
+	in_key =3D 'ok'
+
+	while in_key !=3D 'x':
+		in_key =3D raw_input('Select any option: ')
+
+		if in_key =3D=3D '0':
+			print_send_sms_menu()
+			sms_type =3D raw_input('Select SMS type: ')
+
+			if sms_type =3D=3D '1':
+				message_send(sms, number, value)
+
+			if sms_type =3D=3D '2':
+				val =3D "abcde12345"
+				for i in range(30):
+					value =3D value + val
+
+				message_send(sms, number, value)
+
+			if sms_type =3D=3D '3':
+				value =3D "=C3=96=C3=84=C3=85=C3=B6=C3=A4=C3=A5=C2=B5=CA=92=C3=97cvcvb=
=C5=8B"
+				message_send(sms, number, value)
+
+		if in_key =3D=3D '1':
+			message_delivery_report(sms, 1)
+			send_msg =3D raw_input('Send test message[y/n]?: ')
+			if send_msg =3D=3D 'y':
+				message_send(sms, number, ("(1)"+value+": UseDeliveryReports[TRUE]"))
+
+		if in_key =3D=3D '2':
+			message_delivery_report(sms, 0)
+			send_msg =3D raw_input('Send test message[y/n]?: ')
+			if send_msg =3D=3D 'y':
+				message_send(sms, number, ("(2) "+value+": UseDeliveryReports[FALSE]"))
+
+		if in_key =3D=3D '3':
+			message_service_center_address(sms, SCA)
+			send_msg =3D raw_input('Send test message[y/n]?: ')
+			if send_msg =3D=3D 'y':
+				message_send(sms, number, ("(3) "+value+": ServiceCenterAddress"))
+
+		if in_key =3D=3D '4':
+			message_bearer(sms, "ps-only")
+			send_msg =3D raw_input('Send test message[y/n]?: ')
+			if send_msg =3D=3D 'y':
+				message_send(sms, number, ("(4) "+value+": Bearer[ps-only]"))
+
+		if in_key =3D=3D '5':
+			message_bearer(sms, "cs-only")
+			send_msg =3D raw_input('Send test message[y/n]?: ')
+			if send_msg =3D=3D 'y':
+				message_send(sms, number, ("(5) "+value+": Bearer[cs-only]"))
+
+		if in_key =3D=3D '6':
+			message_bearer(sms, "ps-preferred")
+			send_msg =3D raw_input('Send test message[y/n]?: ')
+			if send_msg =3D=3D 'y':
+				message_send(sms, number, ("(6) "+value+": Bearer[ps-preferred]"))
+
+		if in_key =3D=3D '7':
+			message_bearer(sms, "cs-preferred")
+			send_msg =3D raw_input('Send test message[y/n]?: ')
+			if send_msg =3D=3D 'y':
+				message_send(sms,number, ("(7) "+value+": Bearer[cs-preferred]"))
+
+		clear_screen()
+		print_sms_properties(sms)
+		print_menu()
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
-- =

1.7.1


--===============4409229916683343176==--

