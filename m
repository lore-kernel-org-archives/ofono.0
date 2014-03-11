Content-Type: multipart/mixed; boundary="===============5175688074592015406=="
MIME-Version: 1.0
From: Martin Pitt <martin.pitt@ubuntu.com>
Subject: [PATCH 2/5] test: Make exception catching compatible with Python 3
Date: Tue, 11 Mar 2014 17:39:19 +0100
Message-ID: <1394555962-21661-2-git-send-email-martin.pitt@ubuntu.com>
In-Reply-To: <1394555962-21661-1-git-send-email-martin.pitt@ubuntu.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5175688074592015406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use "except Type as var" syntax to work with both Python >=3D 2.6 and Pytho=
n 3.
---
 test/activate-context          |  2 +-
 test/deactivate-context        |  2 +-
 test/disable-call-forwarding   |  2 +-
 test/set-call-forwarding       |  4 ++--
 test/set-context-property      |  2 +-
 test/test-advice-of-charge     |  4 ++--
 test/test-call-barring         |  6 +++---
 test/test-call-forwarding      | 26 +++++++++++++-------------
 test/test-call-settings        |  2 +-
 test/test-cbs                  |  2 +-
 test/test-gnss                 |  6 +++---
 test/test-network-registration |  2 +-
 test/test-sms                  |  6 +++---
 test/test-ss                   |  2 +-
 test/test-ss-control-cb        |  8 ++++----
 test/test-ss-control-cs        | 12 ++++++------
 test/test-stk-menu             |  2 +-
 17 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/test/activate-context b/test/activate-context
index 1c4a105..937b7db 100755
--- a/test/activate-context
+++ b/test/activate-context
@@ -35,6 +35,6 @@ for path, properties in modems:
 =

 	try:
 		context.SetProperty("Active", dbus.Boolean(1), timeout =3D 100)
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Error activating %s: %s" % (path, str(e)))
 		exit(2)
diff --git a/test/deactivate-context b/test/deactivate-context
index 9544c19..848bcbd 100755
--- a/test/deactivate-context
+++ b/test/deactivate-context
@@ -33,6 +33,6 @@ for path, properties in modems:
 =

 	try:
 		context.SetProperty("Active", dbus.Boolean(0))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Error activating %s: %s" % (path, str(e)))
 		exit(2)
diff --git a/test/disable-call-forwarding b/test/disable-call-forwarding
index a88821d..1e6ec20 100755
--- a/test/disable-call-forwarding
+++ b/test/disable-call-forwarding
@@ -41,7 +41,7 @@ if __name__ =3D=3D "__main__":
 =

 	try:
 		cf.DisableAll(type, timeout =3D 100)
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to DisableAll %s" % e)
 		sys.exit(1);
 =

diff --git a/test/set-call-forwarding b/test/set-call-forwarding
index a22a673..8f0722e 100755
--- a/test/set-call-forwarding
+++ b/test/set-call-forwarding
@@ -46,13 +46,13 @@ if __name__ =3D=3D "__main__":
 		try:
 			cf.SetProperty(property, dbus.UInt16(value),
 							timeout =3D 100)
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable SetProperty %s" % e)
 			sys.exit(1);
 	else:
 		try:
 			cf.SetProperty(property, value, timeout =3D 100)
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable SetProperty %s" % e)
 			sys.exit(1);
 =

diff --git a/test/set-context-property b/test/set-context-property
index c18e55a..64a6fb8 100755
--- a/test/set-context-property
+++ b/test/set-context-property
@@ -33,7 +33,7 @@ for path, properties in modems:
 =

 	try:
 		context.SetProperty(sys.argv[2], sys.argv[3])
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Error setting context %s property %s: %s" %\
 				(path, sys.argv[2], str(e)))
 		exit(2)
diff --git a/test/test-advice-of-charge b/test/test-advice-of-charge
index bb52f5b..6fa3a7c 100755
--- a/test/test-advice-of-charge
+++ b/test/test-advice-of-charge
@@ -67,7 +67,7 @@ if __name__ =3D=3D "__main__":
 		print("Resetting Accumulated Call Meter")
 		try:
 			cm.Reset(pin)
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable to reset ACM: %s" % e)
 			sys.exit(1)
 	else:
@@ -77,7 +77,7 @@ if __name__ =3D=3D "__main__":
 			elif property =3D=3D 'PricePerUnit':
 				newvalue =3D float(newvalue)
 			cm.SetProperty(property, newvalue, pin)
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable to set property: %s" % e)
 			sys.exit(1)
 =

diff --git a/test/test-call-barring b/test/test-call-barring
index 51b3778..bc11de0 100755
--- a/test/test-call-barring
+++ b/test/test-call-barring
@@ -60,13 +60,13 @@ if __name__ =3D=3D "__main__":
 		print("Disabling all barrings")
 		try:
 			cb.DisableAll(pin)
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable to Disable All barrings: ", e)
 			sys.exit(1)
 	elif (sys.argv[1] =3D=3D 'passwd'):
 		try:
 			cb.ChangePassword(old_password, new_password)
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable to change password: ", e)
 			sys.exit(1)
 		print("Password changed")
@@ -74,7 +74,7 @@ if __name__ =3D=3D "__main__":
 	else:
 		try:
 			cb.SetProperty(property, newvalue, pin)
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable to set property: ", e)
 			sys.exit(1)
 =

diff --git a/test/test-call-forwarding b/test/test-call-forwarding
index 772948b..a7ec1e4 100755
--- a/test/test-call-forwarding
+++ b/test/test-call-forwarding
@@ -36,47 +36,47 @@ if __name__ =3D=3D "__main__":
 =

 	try:
 		cf.SetProperty("FoobarNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("VoiceNotReachableTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("VoiceNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("DataNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("FaxNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("SmsNoReplyTimeout", dbus.UInt16(19))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set timeout - Good")
 =

 	try:
 		cf.SetProperty("VoiceNoReply", "")
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to erase voice no reply rule - Bad")
 =

 	try:
 		cf.SetProperty("VoiceNoReply", "+134444")
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to register voice no reply rule - Bad")
 =

 	try:
 		cf.SetProperty("VoiceNoReplyTimeout", dbus.UInt16(30))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set voice no reply timeout - Bad")
 =

 	properties =3D cf.GetProperties()
@@ -86,7 +86,7 @@ if __name__ =3D=3D "__main__":
 =

 	try:
 		cf.SetProperty("VoiceUnconditional", "+155555")
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set Voice Unconditional - Bad")
 =

 	properties =3D cf.GetProperties()
@@ -95,12 +95,12 @@ if __name__ =3D=3D "__main__":
 =

 	try:
 		cf.DisableAll("foobar")
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to delete invalids - Good")
 =

 	try:
 		cf.DisableAll("conditional")
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to delete all conditional - Bad")
 =

 	properties =3D cf.GetProperties()
@@ -110,7 +110,7 @@ if __name__ =3D=3D "__main__":
 =

 	try:
 		cf.DisableAll("all")
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to delete all conditional - Bad")
 =

 	print(properties["VoiceUnconditional"])
diff --git a/test/test-call-settings b/test/test-call-settings
index f30756e..187ce06 100755
--- a/test/test-call-settings
+++ b/test/test-call-settings
@@ -67,7 +67,7 @@ if __name__ =3D=3D "__main__":
 =

 	try:
 		cs.SetProperty(property, newvalue)
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set property: %s" % e)
 		sys.exit(1);
 =

diff --git a/test/test-cbs b/test/test-cbs
index 2e7884b..8d8438f 100755
--- a/test/test-cbs
+++ b/test/test-cbs
@@ -103,7 +103,7 @@ def set_topics(cbs):
 		try:
 			print("Setting Cell Broadcast topics...")
 			cbs.SetProperty("Topics", topics);
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable to set topic: %s" % e)
 =

 	print("-----------------------------------------------------------")
diff --git a/test/test-gnss b/test/test-gnss
index 9824627..62b56f9 100755
--- a/test/test-gnss
+++ b/test/test-gnss
@@ -44,21 +44,21 @@ def stdin_handler(fd, condition, gnss, path):
 		try:
 			gnss.SendPositioningElement(dbus.String(xml))
 			print("ok")
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable to send positioning element")
 =

 	elif in_key =3D=3D '1':
 		try:
 			gnss.RegisterPositioningRequestAgent("/test/posagent")
 			print("ok")
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable to register positioning agent")
 =

 	elif in_key =3D=3D '2':
 		try:
 			gnss.UnregisterPositioningRequestAgent(path)
 			print("ok")
-		except dbus.DBusException, e:
+		except dbus.DBusException as e:
 			print("Unable to unregister positioning agent")
 	elif in_key =3D=3D 'x':
 		sys.exit(1)
diff --git a/test/test-network-registration b/test/test-network-registration
index f692efa..5d3f75e 100755
--- a/test/test-network-registration
+++ b/test/test-network-registration
@@ -61,7 +61,7 @@ if __name__ =3D=3D "__main__":
 			obj =3D bus.get_object('org.ofono', plmn);
 			op =3D dbus.Interface(obj, 'org.ofono.NetworkOperator')
 			op.Register()
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to register: %s" % e)
 		sys.exit(1)
 =

diff --git a/test/test-sms b/test/test-sms
index 5c0bfbb..33d4ccd 100755
--- a/test/test-sms
+++ b/test/test-sms
@@ -48,7 +48,7 @@ def message_delivery_report(sms, value):
 	try:
 		sms.SetProperty("UseDeliveryReports", dbus.Boolean(value))
 =

-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		if value =3D=3D 1:
 			print("Unable to activate Delivery Reports - FAIL")
 =

@@ -58,13 +58,13 @@ def message_delivery_report(sms, value):
 def message_service_center_address(sms, value):
 	try:
 		sms.SetProperty("ServiceCenterAddress",dbus.String(value))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set correct Service Center Address - FAIL")
 =

 def message_bearer(sms, value):
 	try:
 		sms.SetProperty("Bearer", dbus.String(value))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Unable to set Bearer[%s] - FAIL" % (value))
 =

 =

diff --git a/test/test-ss b/test/test-ss
index 7bd18af..2c80806 100755
--- a/test/test-ss
+++ b/test/test-ss
@@ -22,7 +22,7 @@ ss =3D dbus.Interface(bus.get_object('org.ofono', modem),
 =

 try:
 	ss_type, properties =3D ss.Initiate(ss_code, timeout=3D100)
-except dbus.DBusException, e:
+except dbus.DBusException as e:
 	print("Unable to perform operation: %s" % e)
 	sys.exit(1);
 =

diff --git a/test/test-ss-control-cb b/test/test-ss-control-cb
index 505bcd7..d972097 100755
--- a/test/test-ss-control-cb
+++ b/test/test-ss-control-cb
@@ -37,25 +37,25 @@ if __name__ =3D=3D "__main__":
 	print("Trying invalid SS request for CB")
 	try:
 		print(ss.Initiate("*33#456666"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Trying invalid SS request for CB")
 	try:
 		print(ss.Initiate("*33*ABC#"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Trying invalid SS request for CB")
 	try:
 		print(ss.Initiate("*33**ABC#"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Trying invalid SS request for CB")
 	try:
 		print(ss.Initiate("*33***12#"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Query Outgoing All")
diff --git a/test/test-ss-control-cs b/test/test-ss-control-cs
index 6ce022f..2d5442f 100755
--- a/test/test-ss-control-cs
+++ b/test/test-ss-control-cs
@@ -37,19 +37,19 @@ if __name__ =3D=3D "__main__":
 	print("Trying invalid SS request for CLIR")
 	try:
 		print(ss.Initiate("*31#456666"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Trying invalid SS request for CLIR")
 	try:
 		print(ss.Initiate("*31*455*4#"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Trying invalid SS request for CLIR")
 	try:
 		print(ss.Initiate("*31**44435#"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Query CLIP")
@@ -77,19 +77,19 @@ if __name__ =3D=3D "__main__":
 	print("Trying invalid SS request for CW")
 	try:
 		print(ss.Initiate("*43#456666"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Trying invalid SS request for CW")
 	try:
 		print(ss.Initiate("*43*455*4#"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Trying invalid SS request for CW")
 	try:
 		print(ss.Initiate("*43**44435#"))
-	except dbus.DBusException, e:
+	except dbus.DBusException as e:
 		print("Failed with %s - Good" % e)
 =

 	print("Query CW")
diff --git a/test/test-stk-menu b/test/test-stk-menu
index eaba994..7952abd 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -238,7 +238,7 @@ class StkAgent(dbus.service.Object):
 			if key =3D=3D 't':
 				raise EndSession("User wishes to terminate"
 								 " session")
-		except Exception, exc:
+		except Exception as exc:
 			print(exc)
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
-- =

1.9.0


--===============5175688074592015406==--

