Content-Type: multipart/mixed; boundary="===============8591894183188008963=="
MIME-Version: 1.0
From: Miia Leinonen <miia.leinonen@tieto.com>
Subject: [PATCH 1/2] test: Restructure CBS tests
Date: Mon, 07 Mar 2011 13:33:02 +0200
Message-ID: <1299497583-29072-1-git-send-email-miia.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8591894183188008963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add new centralised and reinforced CBS test script.

---
 Makefile.am   |    1 +
 test/test-cbs |  189 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 190 insertions(+), 0 deletions(-)
 create mode 100755 test/test-cbs

diff --git a/Makefile.am b/Makefile.am
index 3f20717..029b87f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -468,6 +468,7 @@ test_scripts =3D test/backtrace \
 		test/test-modem \
 		test/test-network-registration \
 		test/test-phonebook \
+		test/test-cbs \
 		test/test-ss-control-cb \
 		test/test-ss-control-cf \
 		test/test-ss-control-cs \
diff --git a/test/test-cbs b/test/test-cbs
new file mode 100755
index 0000000..5851754
--- /dev/null
+++ b/test/test-cbs
@@ -0,0 +1,189 @@
+#!/usr/bin/python
+
+import dbus
+import dbus.mainloop.glib
+import sys
+import gobject
+import os
+
+def print_menu():
+	print "Select test case"
+	print "----------------------------------------------------------------"
+	print "[0] Activate cbs"
+	print "[1] Deactivate cbs"
+	print "[2] Get cbs properties"
+	print "[3] Set/Register topics"
+	print "        If several - give topics separated with comma. \
+		\n        E.g. 20,50-51,60"
+	print "[4] Clear/Unregister topics"
+	print "[5] NetReg Base Station - Get current serving cell"
+	print "[x] Exit"
+	print "----------------------------------------------------------------"
+
+def property_changed(property, value):
+	if value =3D=3D "" and property =3D=3D "Topics":
+		print "User selected Topics have been cleared. \
+			\nRegistered for emergency topics only."
+	else:
+		print "Cell Broadcast property %s is changed to %s" % (property, value)
+	print "\nPress ENTER to continue"
+
+def incoming_broadcast(text, topic):
+	print "Broadcast msg: %s \n Topic channel: %s" % (text, topic)
+	print "\nPress ENTER to continue"
+
+def emergency_broadcast(text, properties):
+	emergType =3D properties["EmergencyType"]
+	emergAlert =3D properties["EmergencyAlert"]
+
+	print "Broadcast msg: %s \n\t Type: %s \n\t Alert: %s \n\t Popup: %s" \
+		% (text, emergType, emergAlert, popup)
+
+	if properties["Popup"] =3D=3D True:
+		print "Popup required."
+
+	print "\nPress ENTER to continue"
+
+def set_cbs_state(cbs, state):
+	if state =3D=3D True:
+		print "Activating cell broadcast..."
+		cbs.SetProperty("Powered", dbus.Boolean(1))
+	else:
+		print "Deactivating cell broadcast..."
+		cbs.SetProperty("Powered", dbus.Boolean(0))
+	print "-----------------------------------------------------------"
+
+def print_cbs_properties(cbs):
+	properties =3D cbs.GetProperties()
+	print "---------------------PROPERTIES----------------------------"
+	for p in properties:
+		if len(properties[p].__str__()) > 0:
+			if p =3D=3D "Powered":
+				if properties[p] =3D=3D True:
+					print "Cell Broadcast is Activated."
+				else:
+					print "Cell Broadcast is Deactivated."
+			elif p =3D=3D "Topics":
+				print "Currently set CBS %s are: %s" \
+					% (p, properties[p])
+				topics_available =3D True
+		else:
+			print "Cell Broadcast %s value empty" % (p)
+	print "-----------------------------------------------------------"
+
+def set_topics(cbs):
+	print_cbs_properties(cbs)
+
+	topicTemp =3D ""
+	invalidData =3D False;
+	index =3D 0
+
+	topics =3D raw_input('Enter the topic ID(s) you want to register to: ')
+
+	while index < len(topics):
+		if topics[index] =3D=3D ',' or topics[index] =3D=3D '-':
+			topicTemp =3D ""
+		elif topics[index] >=3D '0' and topics[index] <=3D '9':
+			topicTemp =3D topicTemp + topics[index]
+		else:
+			print "Invalid char. \"%s\" entered. Topic not set." \
+				% (topics[index])
+			invalidData =3D True
+			break
+
+		if topicTemp:
+			if int(topicTemp) > 999:
+				invalidData =3D True
+				print "Invalid Topic ID %s (range 0-999). \
+					\nCould not register." % topicTemp
+
+		index =3D index + 1
+
+	if invalidData =3D=3D False:
+		try:
+			print "Setting Cell Broadcast topics..."
+			cbs.SetProperty("Topics", topics);
+		except dbus.DBusException, e:
+			print "Unable to set topic: ", e
+
+	print "-----------------------------------------------------------"
+
+def get_serving_cell_name(netReg):
+	wasFound =3D False;
+	properties =3D netReg.GetProperties()
+
+	for p in properties:
+		if p =3D=3D "BaseStation":
+			if len(properties[p].__str__()) > 0:
+				print "Current serving cell name: %s" \
+					% (properties["BaseStation"])
+				wasFound =3D True;
+			else:
+				print "Current Serving cell name empty. \
+					Base Station CBS not available."
+
+	if wasFound =3D=3D False:
+		print "Base Station parameter not found. \
+			\nBase Station CBS not available."
+	print "-----------------------------------------------------------"
+
+def stdin_handler(fd, condition, cbs, netReg):
+	in_key =3D os.read(fd.fileno(), 160).rstrip()
+
+	if in_key =3D=3D '0':
+		set_cbs_state(cbs, True)
+
+	elif in_key =3D=3D '1':
+		set_cbs_state(cbs, False)
+
+	elif in_key =3D=3D '2':
+		print_cbs_properties(cbs)
+
+	elif in_key =3D=3D '3':
+		set_topics(cbs)
+
+	elif in_key =3D=3D '4':
+		cbs.SetProperty("Topics", "")
+
+	elif in_key =3D=3D '5':
+		get_serving_cell_name(netReg)
+
+	elif in_key =3D=3D 'x':
+		sys.exit(1)
+
+	print '\n' * 2
+	print_menu()
+
+	return True
+
+if __name__ =3D=3D "__main__":
+
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+	bus =3D dbus.SystemBus()
+
+	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+						'org.ofono.Manager')
+
+	modems =3D manager.GetModems()
+	path =3D modems[0][0]
+
+	cbs =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.CellBroadcast')
+
+	netReg =3D dbus.Interface(bus.get_object('org.ofono', path),
+				'org.ofono.NetworkRegistration')
+
+	cbs.connect_to_signal("PropertyChanged", property_changed)
+	cbs.connect_to_signal("IncomingBroadcast", incoming_broadcast)
+	cbs.connect_to_signal("EmergencyBroadcast", emergency_broadcast)
+
+	print '\n' * 2
+
+	print_menu()
+
+	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler, cbs, \
+				netReg)
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
+
-- =

1.7.1


--===============8591894183188008963==--

