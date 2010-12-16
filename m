Content-Type: multipart/mixed; boundary="===============4705554936437223632=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] test: add a script for STK conformance tests
Date: Thu, 16 Dec 2010 16:04:12 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188136EF0453@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4705554936437223632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

To be able to run STK conformance tests at ofono
level, we need to have a STK agent registered. The
test-stk-conformance script provided here do that.
This script is for conformance so all the data input
of the agent are displayed to be able to check them.
The existing test-stk-menu is usable only when there
is a STK menu provided by the (U)SIM card.
---
 test/test-stk-conformance |  226 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 226 insertions(+), 0 deletions(-)
 create mode 100755 test/test-stk-conformance

diff --git a/test/test-stk-conformance b/test/test-stk-conformance
new file mode 100755
index 0000000..bb28e40
--- /dev/null
+++ b/test/test-stk-conformance
@@ -0,0 +1,226 @@
+#!/usr/bin/python
+
+import gobject
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+import os
+
+class GoBack(dbus.DBusException):
+	_dbus_error_name =3D "org.ofono.Error.GoBack"
+
+class EndSession(dbus.DBusException):
+	_dbus_error_name =3D "org.ofono.Error.EndSession"
+
+class Busy(dbus.DBusException):
+	_dbus_error_name =3D "org.ofono.Error.Busy"
+
+class StkAgent(dbus.service.Object):
+	exit_on_release =3D True
+
+	def set_exit_on_release(self, exit_on_release):
+		self.exit_on_release =3D exit_on_release
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"", out_signature=3D"")
+	def Release(self):
+		print "Release"
+		if self.exit_on_release:
+			mainloop.quit()
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sya(sy)n", out_signature=3D"y")
+	def RequestSelection(self, title, icon, items, default):
+		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		index =3D 0;
+		for item in items:
+			print "%d. %s (icon: %d)" % (index, item[0], item[1])
+			index +=3D 1
+
+		print "\nDefault: %d" % (default)
+		select =3D raw_input("Enter Selection (t, b):")
+
+		if select =3D=3D 'b':
+			raise GoBack("User wishes to go back")
+		elif select =3D=3D 't':
+			raise EndSession("User wishes to terminate session")
+		else:
+			return int(select);
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"syb", out_signature=3D"")
+	def DisplayText(self, title, icon, urgent):
+		print "DisplayText (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		print "Urgent: (%d)" % (urgent)
+		userin =3D raw_input("Press return to clear ('t' terminates, "
+								"'b' goest back, 'n' busy):")
+
+		if userin =3D=3D 'b':
+			raise GoBack("User wishes to go back")
+		elif userin =3D=3D 't':
+			raise EndSession("User wishes to terminate session")
+		elif userin =3D=3D 'n':
+			raise Busy("User wishes to simulate busy screen")
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sysyyb", out_signature=3D"s")
+	def RequestInput(self, title, icon, default, min_chars, max_chars,
+				hide_typing):
+		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		print "Default: (%s)" % (default)
+		print "Hide typing: (%s)" % (hide_typing)
+		print "Enter characters, min: %d, max: %d:" % (min_chars,
+								max_chars)
+		userin =3D raw_input("")
+
+		return userin
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sysyyb", out_signature=3D"s")
+	def RequestDigits(self, title, icon, default, min_chars, max_chars,
+				hide_typing):
+		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		print "Default: (%s)" % (default)
+		print "Hide typing: (%s)" % (hide_typing)
+		print "Enter digits, min: %d, max: %d:" % (min_chars,
+								max_chars)
+		userin =3D raw_input("'t' terminates, 'b' goes back:");
+
+		if userin =3D=3D 'b':
+			raise GoBack("User wishes to go back")
+		elif userin =3D=3D 't':
+			raise EndSession("User wishes to terminate session")
+		else:
+			return userin
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sy", out_signature=3D"s")
+	def RequestKey(self, title, icon):
+		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		key =3D raw_input("Enter Key (t, b):")
+
+		if key =3D=3D 'b':
+			raise GoBack("User wishes to go back");
+		elif key =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+		else:
+			return key
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sy", out_signature=3D"s")
+	def RequestDigit(self, title, icon):
+		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		key =3D raw_input("Enter Digit (t, b):")
+
+		if key =3D=3D 'b':
+			raise GoBack("User wishes to go back");
+		elif key =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+		else:
+			return key
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sy", out_signature=3D"b")
+	def RequestConfirmation(self, title, icon):
+		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		key =3D raw_input("Enter Confirmation (t, b, y, n):")
+
+		if key =3D=3D 'b':
+			raise GoBack("User wishes to go back");
+		elif key =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+		elif key =3D=3D 'y':
+			return True
+		else:
+			return False
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sy", out_signature=3D"b")
+	def ConfirmCallSetup(self, info, icon):
+		print "Information: (%s)" % (info)
+		print "Icon: (%d)" % (icon)
+		key =3D raw_input("Enter Confirmation (t, y, n):")
+
+		if key =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+		elif key =3D=3D 'y':
+			return True
+		else:
+			return False
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"ssy", out_signature=3D"")
+	def PlayTone(self, tone, title, icon):
+		print "PlayTone: (%s, %s, %d)" % (tone, title, icon)
+		userin =3D raw_input("Press enter to end playing (t):")
+
+		if userin =3D=3D 't':
+			raise EndSession("User wishes to terminate session")
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"ssy", out_signature=3D"")
+	def LoopTone(self, tone, title, icon):
+		print "LoopTone: (%s, %s, %d)" % (tone, title, icon)
+		userin =3D raw_input("Press enter to end playing (t):")
+
+		if userin =3D=3D 't':
+			raise EndSession("User wishes to terminate session")
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
+					in_signature=3D"", out_signature=3D"")
+	def Cancel(self):
+		print "Cancel"
+
+def property_changed(name, value):
+	print "SimToolkit property: '%s' changed to '%s'" % (name, value)
+
+def stdin_handler(fd, condition):
+	s =3D os.read(fd.fileno(), 160).rstrip()
+
+	if s =3D=3D 't':
+		stk.UnregisterAgent(path)
+		mainloop.quit()
+
+	return True
+
+if __name__ =3D=3D '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+	bus =3D dbus.SystemBus()
+	manager =3D dbus.Interface(bus.get_object("org.ofono", "/"),
+							"org.ofono.Manager")
+
+	modems =3D manager.GetModems()
+
+	for path, properties in modems:
+		if "org.ofono.SimToolkit" not in properties["Interfaces"]:
+			continue
+
+		stk =3D dbus.Interface(bus.get_object('org.ofono', path),
+					'org.ofono.SimToolkit')
+
+	stk.connect_to_signal("PropertyChanged", property_changed)
+
+	properties =3D stk.GetProperties()
+
+	path =3D "/test/agent"
+	agent =3D StkAgent(bus, path)
+
+	stk.RegisterAgent(path)
+
+	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler)
+
+	print "STK Agent is now registered"
+	print "Use t + <return> to quit the program when there is no session on g=
oing"
+
+	mainloop =3D gobject.MainLoop()
+	mainloop.run()
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


--===============4705554936437223632==--

