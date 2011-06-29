Content-Type: multipart/mixed; boundary="===============6072627472514058822=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] test: According the current locale,
 replace non-codable character with '?'
Date: Wed, 29 Jun 2011 15:07:09 +0200
Message-ID: <1309352829-14399-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6072627472514058822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index a9f92e8..0341385 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -1,5 +1,4 @@
 #!/usr/bin/python
-
 import gobject
 =

 import sys
@@ -7,6 +6,8 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 =

+locale =3D sys.stdout.encoding
+
 class GoBack(dbus.DBusException):
 	_dbus_error_name =3D "org.ofono.Error.GoBack"
 =

@@ -32,11 +33,12 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sya(sy)n", out_signature=3D"y")
 	def RequestSelection(self, title, icon, items, default):
-		print "Title: (%s)" % (title)
+		print "Title: (%s)" % (title.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
 		index =3D 0;
 		for item in items:
-			print "%d. %s (icon: %d)" % (index, item[0], item[1])
+			print "%d. %s (icon: %d)" % (index,
+				item[0].encode(locale, 'replace'), item[1])
 			index +=3D 1
 =

 		print "\nDefault: %d" % (default)
@@ -52,7 +54,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"syb", out_signature=3D"")
 	def DisplayText(self, title, icon, urgent):
-		print "DisplayText (%s)" % (title)
+		print "DisplayText (%s)" % (title.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
 		print "Urgent: (%d)" % (urgent)
 		key =3D raw_input("Press return to clear ('t' terminates, "
@@ -69,7 +71,7 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sysyyb", out_signature=3D"s")
 	def RequestInput(self, title, icon, default, min_chars, max_chars,
 				hide_typing):
-		print "Title: (%s)" % (title)
+		print "Title: (%s)" % (title.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
 		print "Default: (%s)" % (default)
 		print "Hide typing: (%s)" % (hide_typing)
@@ -83,7 +85,7 @@ class StkAgent(dbus.service.Object):
 				in_signature=3D"sysyyb", out_signature=3D"s")
 	def RequestDigits(self, title, icon, default, min_chars, max_chars,
 				hide_typing):
-		print "Title: (%s)" % (title)
+		print "Title: (%s)" % (title.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
 		print "Default: (%s)" % (default)
 		print "Hide typing: (%s)" % (hide_typing)
@@ -101,7 +103,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"s")
 	def RequestKey(self, title, icon):
-		print "Title: (%s)" % (title)
+		print "Title: (%s)" % (title.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Enter Key (t, b):")
 =

@@ -115,7 +117,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"s")
 	def RequestDigit(self, title, icon):
-		print "Title: (%s)" % (title)
+		print "Title: (%s)" % (title.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Enter Digit (t, b):")
 =

@@ -129,7 +131,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"b")
 	def RequestConfirmation(self, title, icon):
-		print "Title: (%s)" % (title)
+		print "Title: (%s)" % (title.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Enter Confirmation (t, b, y, n):")
 =

@@ -145,7 +147,7 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"b")
 	def ConfirmCallSetup(self, info, icon):
-		print "Information: (%s)" % (info)
+		print "Information: (%s)" % (info.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Enter Confirmation (t, y, n):")
 =

@@ -159,9 +161,9 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sys", out_signature=3D"b")
 	def ConfirmLaunchBrowser(self, info, icon, url):
-		print "Information: (%s)" % (info)
+		print "Information: (%s)" % (info.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
-		print "URL (%s)" % (url)
+		print "URL (%s)" % (url.encode(locale, 'replace'))
 		key =3D raw_input("Enter Confirmation (y, n):")
 =

 		if key =3D=3D 'y':
@@ -177,15 +179,15 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"ssy", out_signature=3D"")
 	def PlayTone(self, tone, text, icon):
-		print "PlayTone: %s" % (tone)
-		print "Text: %s" % (text)
+		print "PlayTone: %s" % (tone.encode(locale, 'replace'))
+		print "Text: %s" % (text.encode(locale, 'replace'))
 		print "Icon: %d" % (icon)
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"ssy", out_signature=3D"")
 	def LoopTone(self, tone, text, icon):
 		print "LoopTone: %s" % (tone)
-		print "Text: %s" % (text)
+		print "Text: %s" % (text.encode(locale, 'replace'))
 		print "Icon: %d" % (icon)
 		key =3D raw_input("Press return to end before timeout (t):")
 =

@@ -195,13 +197,13 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"sy", out_signature=3D"")
 	def DisplayActionInformation(self, text, icon):
-		print "Text: %s" % (text)
+		print "Text: %s" % (text.encode(locale, 'replace'))
 		print "Icon: %d" % (icon)
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"sy", out_signature=3D"")
 	def DisplayAction(self, text, icon):
-		print "Text: (%s)" % (text)
+		print "Text: (%s)" % (text.encode(locale, 'replace'))
 		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Press 't' to terminate the session ")
 =

@@ -211,7 +213,8 @@ class StkAgent(dbus.service.Object):
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"sy", out_signature=3D"b")
 	def ConfirmOpenChannel(self, info, icon):
-		print "Open channel confirmation: (%s)" % (info)
+		print "Open channel confirmation: (%s)" % (info.encode(locale,
+								'replace'))
 		print "Icon: (%d)" % (icon)
 		key =3D raw_input("Enter Confirmation (t, y, n):")
 =

@@ -253,14 +256,16 @@ if __name__ =3D=3D '__main__':
 	if mode =3D=3D 'menu':
 		if "MainMenuTitle" in properties:
 			print "Main Menu:"
-			print "%s" % (properties["MainMenuTitle"])
+			menu =3D properties["MainMenuTitle"]
+			print "%s" % (menu.encode(locale, 'replace'))
 			print "\n"
 =

 		if "MainMenu" in properties:
 			print "Items:"
 			index =3D 0
 			for item in properties["MainMenu"]:
-				print "%d. %s" % (index, item[0])
+				print "%d. %s" % (index, item[0].encode(locale,
+							'replace'))
 				index +=3D 1
 =

 		path =3D "/test/agent"
-- =

1.7.1


--===============6072627472514058822==--

