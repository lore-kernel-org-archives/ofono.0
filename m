Content-Type: multipart/mixed; boundary="===============2544177743501419578=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] test: Update test-voicecall to reflect DBus types
Date: Sat, 04 Sep 2010 05:35:12 -0700
Message-ID: <1283603712-21043-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2544177743501419578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-voicecall |   55 ++++++++++++++++++++++++++---------------------=
---
 1 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/test/test-voicecall b/test/test-voicecall
index e13da3f..2e3ed9e 100755
--- a/test/test-voicecall
+++ b/test/test-voicecall
@@ -10,31 +10,36 @@ def hangup_all():
 	print "Hanging up"
 	vcmanager.HangupAll()
 =

-def print_calls(value):
-	for p in value:
-		call =3D dbus.Interface(bus.get_object('org.ofono', p),
-						'org.ofono.VoiceCall')
-		properties =3D call.GetProperties()
-		status =3D properties['State']
-		lineid =3D properties['LineIdentification']
-
-		print "Call %s, Status: %s, LineId: %s" %\
-			(p, status, lineid)
-
-def voicecalls_property_changed(name, value):
-	if name =3D=3D 'Calls':
-		print "Call list modification>"
-		if len(value) =3D=3D 0:
-			print "No calls in systems"
-		else:
-			print_calls(value)
+def print_calls():
+	calls =3D vcmanager.GetCalls()
+	if (len(calls) !=3D 0):
+		print "No calls available"
 	else:
-		print "VoiceCallManager property: '%s' changed to '%s'" %\
-			(name, value)
+		for path, properties in calls:
+			print "    [ %s ]" % (path)
+
+			for key in properties.keys():
+				val =3D str(properties[key])
+				print "        %s =3D %s" % (key, val)
+			print
+
+def voicecalls_call_added(path, properties):
+	print "    Voice Call [ %s ] Added" % (path)
+
+	for key in properties.keys():
+		val =3D str(properties[key])
+		print "        %s =3D %s" % (key, val)
+	print
+
+def voicecalls_call_removed(path):
+	print "    Voice Call [ %s ] Removed" % (path)
 =

 def voicecall_property_changed(name, value):
 	print "Voicecall property: '%s' changed to '%s'" % (name, value)
 =

+def voicecall_disconnect_reason(reason):
+	print "Voicecall disconnect reason: '%s'" % (reason)
+
 if __name__ =3D=3D "__main__":
 	global vcmanager
 =

@@ -63,14 +68,11 @@ if __name__ =3D=3D "__main__":
 	vcmanager =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.VoiceCallManager')
 =

-	vcmanager.connect_to_signal("PropertyChanged",
-					voicecalls_property_changed)
-
-	properties =3D vcmanager.GetProperties()
+	vcmanager.connect_to_signal("CallAdded", voicecalls_call_added)
 =

-	print properties['Calls']
+	vcmanager.connect_to_signal("CallRemoved", voicecalls_call_removed)
 =

-	voicecalls_property_changed('Calls', properties['Calls'])
+	print_calls()
 =

 	print "Dialing %s..." % number
 	obj =3D vcmanager.Dial(number, "")
@@ -85,6 +87,7 @@ if __name__ =3D=3D "__main__":
 		(properties['State'], properties['LineIdentification'])
 =

 	call.connect_to_signal("PropertyChanged", voicecall_property_changed)
+	call.connect_to_signal("DisconnectReason", voicecall_disconnect_reason)
 =

 	gobject.timeout_add(1000000, hangup_all)
 =

-- =

1.7.0.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============2544177743501419578==--

