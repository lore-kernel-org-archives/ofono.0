Content-Type: multipart/mixed; boundary="===============2898976099741555875=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] test-stk: update STK test script for conformance
Date: Tue, 21 Dec 2010 14:24:56 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188136F59D21@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2898976099741555875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

Update the STK test script to be able to use it for
conformance test. Using 'agent' as parameter the
script will now register a STK agent to be able to
handle unsolicited proactive command. Without any
parameter or with 'menu' the script will try to
display the STK main menu of the (U)SIM.
---
 test/test-stk-menu |  101 +++++++++++++++++++++++++++++++++++++++---------=
----
 1 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 94d2d6b..b396452 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -13,6 +13,9 @@ class GoBack(dbus.DBusException):
 class EndSession(dbus.DBusException):
 	_dbus_error_name =3D "org.ofono.Error.EndSession"
 =

+class Busy(dbus.DBusException):
+	_dbus_error_name =3D "org.ofono.Error.Busy"
+
 class StkAgent(dbus.service.Object):
 	exit_on_release =3D True
 =

@@ -30,9 +33,10 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sya(sy)n", out_signature=3D"y")
 	def RequestSelection(self, title, icon, items, default):
 		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
 		index =3D 0;
 		for item in items:
-			print "%d. %s" % (index, item[0])
+			print "%d. %s (icon: %d)" % (index, item[0], item[1])
 			index +=3D 1
 =

 		print "\nDefault: %d" % (default)
@@ -48,14 +52,27 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"syb", out_signature=3D"")
 	def DisplayText(self, title, icon, urgent):
-		print "DisplayText (%s, %s)" % (title, urgent)
+		print "DisplayText (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		print "Urgent: (%d)" % (urgent)
+		key =3D raw_input("Press return to clear ('t' terminates, "
+								"'b' goest back, 'n' busy):")
+
+		if key =3D=3D 'b':
+			raise GoBack("User wishes to go back")
+		elif key =3D=3D 't':
+			raise EndSession("User wishes to terminate session")
+		elif key =3D=3D 'n':
+			raise Busy("User wishes to simulate busy screen")
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sysyyb", out_signature=3D"s")
 	def RequestInput(self, title, icon, default, min_chars, max_chars,
 				hide_typing):
 		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
 		print "Default: (%s)" % (default)
+		print "Hide typing: (%s)" % (hide_typing)
 		print "Enter characters, min: %d, max: %d:" % (min_chars,
 								max_chars)
 		userin =3D raw_input("");
@@ -67,7 +84,9 @@ class StkAgent(dbus.service.Object):
 	def RequestDigits(self, title, icon, default, min_chars, max_chars,
 				hide_typing):
 		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
 		print "Default: (%s)" % (default)
+		print "Hide typing: (%s)" % (hide_typing)
 		print "Enter digits, min: %d, max: %d:" % (min_chars,
 								max_chars)
 		userin =3D raw_input("'t' terminates, 'b' goes back:");
@@ -83,6 +102,7 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sy", out_signature=3D"s")
 	def RequestKey(self, title, icon):
 		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Enter Key (t, b):")
 =

 		if key =3D=3D 'b':
@@ -96,6 +116,7 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sy", out_signature=3D"s")
 	def RequestDigit(self, title, icon):
 		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Enter Digit (t, b):")
 =

 		if key =3D=3D 'b':
@@ -109,6 +130,7 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sy", out_signature=3D"b")
 	def RequestConfirmation(self, title, icon):
 		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Enter Confirmation (t, b, y, n):")
 =

 		if key =3D=3D 'b':
@@ -124,6 +146,7 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sy", out_signature=3D"b")
 	def ConfirmCallSetup(self, info, icon):
 		print "Information: (%s)" % (info)
+		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Enter Confirmation (t, y, n):")
 =

 		if key =3D=3D 't':
@@ -141,14 +164,30 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"ssy", out_signature=3D"")
 	def PlayTone(self, tone, text, icon):
-		print "playtone is %s" % (tone)
+		print "PlayTone: %s" % (tone)
+		print "Text: %s" % (text)
+		print "Icon: %d" % (icon)
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"ssy", out_signature=3D"")
+	def LoopTone(self, tone, text, icon):
+		print "LoopTone: %s" % (tone)
+		print "Text: %s" % (text)
+		print "Icon: %d" % (icon)
+		key =3D raw_input("Press return to end before timeout (t):")
 =

-        @dbus.service.method("org.ofono.SimToolkitAgent",
-                                in_signature=3D"ssy", out_signature=3D"")
-        def LoopTone(self, tone, text, icon):
-                print "the loop tone is %s" % (tone)
+		if key =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+
+def property_changed(name, value):
+	print "SimToolKit property: %s changed to '%s'" % (name, value)
 =

 if __name__ =3D=3D '__main__':
+	if len(sys.argv) =3D=3D 2:
+		mode =3D sys.argv[1]
+	else:
+		mode =3D 'menu'
+
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

 	bus =3D dbus.SystemBus()
@@ -164,26 +203,38 @@ if __name__ =3D=3D '__main__':
 		stk =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.SimToolkit')
 =

-	properties =3D stk.GetProperties()
+	stk.connect_to_signal("PropertyChanged", property_changed)
 =

-	if "MainMenuTitle" in properties:
-		print "Main Menu:"
-		print "%s" % (properties["MainMenuTitle"])
-		print "\n"
-
-	if "MainMenu" in properties:
-		print "Items:"
-		index =3D 0
-		for item in properties["MainMenu"]:
-			print "%d. %s" % (index, item[0])
-			index +=3D 1
-
-	path =3D "/test/agent"
-	agent =3D StkAgent(bus, path)
+	properties =3D stk.GetProperties()
 =

-	select =3D int(raw_input("Enter Selection: "))
-	stk.SelectItem(select, path)
-	print "Agent registered for session"
+	if mode =3D=3D 'menu':
+		if "MainMenuTitle" in properties:
+			print "Main Menu:"
+			print "%s" % (properties["MainMenuTitle"])
+			print "\n"
+
+		if "MainMenu" in properties:
+			print "Items:"
+			index =3D 0
+			for item in properties["MainMenu"]:
+				print "%d. %s" % (index, item[0])
+				index +=3D 1
+
+		path =3D "/test/agent"
+		agent =3D StkAgent(bus, path)
+
+		select =3D int(raw_input("Enter Selection: "))
+		stk.SelectItem(select, path)
+	elif mode =3D=3D 'agent':
+		path =3D "/test/agent"
+		agent =3D StkAgent(bus, path)
+
+		stk.RegisterAgent(path)
+
+		print "Agent registered for session - Wait SIM ToolKit command..."
+	else:
+		print "%s [menu|agent]" % (sys.argv[0])
+		exit(0)
 =

 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
-- =

1.7.0.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============2898976099741555875==--

