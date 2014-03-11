Content-Type: multipart/mixed; boundary="===============1194875550080321490=="
MIME-Version: 1.0
From: Martin Pitt <martin.pitt@ubuntu.com>
Subject: [PATCH 4/5] test: Move from static gobject bindings to GI
Date: Tue, 11 Mar 2014 17:39:21 +0100
Message-ID: <1394555962-21661-4-git-send-email-martin.pitt@ubuntu.com>
In-Reply-To: <1394555962-21661-1-git-send-email-martin.pitt@ubuntu.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1194875550080321490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use GLib gobject-introspection bindings so that we can also use the scripts
with Python 3.
---
 test/disable-call-forwarding   |  4 ++--
 test/monitor-dundee            |  4 ++--
 test/monitor-ofono             |  4 ++--
 test/receive-sms               |  4 ++--
 test/set-call-forwarding       |  4 ++--
 test/test-advice-of-charge     |  4 ++--
 test/test-call-barring         |  4 ++--
 test/test-call-forwarding      |  4 ++--
 test/test-call-settings        |  4 ++--
 test/test-cbs                  | 13 +++++++------
 test/test-gnss                 | 13 +++++++------
 test/test-message-waiting      |  4 ++--
 test/test-modem                |  4 ++--
 test/test-network-registration |  4 ++--
 test/test-push-notification    |  4 ++--
 test/test-smart-messaging      |  4 ++--
 test/test-sms                  | 13 +++++++------
 test/test-ss-control-cb        |  4 ++--
 test/test-ss-control-cf        |  4 ++--
 test/test-ss-control-cs        |  4 ++--
 test/test-stk-menu             | 10 +++++-----
 21 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/test/disable-call-forwarding b/test/disable-call-forwarding
index 1e6ec20..3609816 100755
--- a/test/disable-call-forwarding
+++ b/test/disable-call-forwarding
@@ -1,7 +1,7 @@
 #!/usr/bin/python
 =

 import sys
-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -49,5 +49,5 @@ if __name__ =3D=3D "__main__":
 =

 	canexit =3D True
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/monitor-dundee b/test/monitor-dundee
index 025a345..e68488a 100755
--- a/test/monitor-dundee
+++ b/test/monitor-dundee
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -105,5 +105,5 @@ if __name__ =3D=3D '__main__':
 						interface_keyword=3D"interface")
 =

 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/monitor-ofono b/test/monitor-ofono
index f69ae79..bd31617 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -150,5 +150,5 @@ if __name__ =3D=3D '__main__':
 					path_keyword=3D"path",
 					interface_keyword=3D"interface")
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/receive-sms b/test/receive-sms
index b40ce3c..c23eb14 100755
--- a/test/receive-sms
+++ b/test/receive-sms
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -29,5 +29,5 @@ if __name__ =3D=3D '__main__':
 						path_keyword=3D"path",
 						interface_keyword=3D"interface")
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/set-call-forwarding b/test/set-call-forwarding
index 8f0722e..9fd358b 100755
--- a/test/set-call-forwarding
+++ b/test/set-call-forwarding
@@ -1,7 +1,7 @@
 #!/usr/bin/python
 =

 import sys
-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -60,5 +60,5 @@ if __name__ =3D=3D "__main__":
 =

 	canexit =3D True
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-advice-of-charge b/test/test-advice-of-charge
index 6fa3a7c..0f1f57f 100755
--- a/test/test-advice-of-charge
+++ b/test/test-advice-of-charge
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 import sys
 import dbus
 import dbus.mainloop.glib
@@ -83,5 +83,5 @@ if __name__ =3D=3D "__main__":
 =

 	canexit =3D True
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-call-barring b/test/test-call-barring
index bc11de0..be4ab57 100755
--- a/test/test-call-barring
+++ b/test/test-call-barring
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 import sys
 import dbus
 import dbus.mainloop.glib
@@ -80,5 +80,5 @@ if __name__ =3D=3D "__main__":
 =

 	canexit =3D True
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-call-forwarding b/test/test-call-forwarding
index a7ec1e4..01a7294 100755
--- a/test/test-call-forwarding
+++ b/test/test-call-forwarding
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -115,5 +115,5 @@ if __name__ =3D=3D "__main__":
 =

 	print(properties["VoiceUnconditional"])
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-call-settings b/test/test-call-settings
index 187ce06..5d7ee49 100755
--- a/test/test-call-settings
+++ b/test/test-call-settings
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -79,5 +79,5 @@ if __name__ =3D=3D "__main__":
 =

 	canexit =3D True
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-cbs b/test/test-cbs
index 8d8438f..13cdd80 100755
--- a/test/test-cbs
+++ b/test/test-cbs
@@ -3,7 +3,7 @@
 import dbus
 import dbus.mainloop.glib
 import sys
-import gobject
+from gi.repository import GLib
 import os
 =

 def print_menu():
@@ -127,8 +127,8 @@ def get_serving_cell_name(netReg):
 			\nBase Station CBS not available.")
 	print("-----------------------------------------------------------")
 =

-def stdin_handler(fd, condition, cbs, netReg):
-	in_key =3D os.read(fd.fileno(), 160).rstrip()
+def stdin_handler(channel, condition, cbs, netReg):
+	in_key =3D os.read(channel.unix_get_fd(), 160).rstrip().decode('UTF-8')
 =

 	if in_key =3D=3D '0':
 		set_cbs_state(cbs, True)
@@ -181,8 +181,9 @@ if __name__ =3D=3D "__main__":
 =

 	print_menu()
 =

-	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler, cbs, \
-				netReg)
+	GLib.io_add_watch(GLib.IOChannel(filedes=3Dsys.stdin.fileno()),
+		   GLib.PRIORITY_DEFAULT, GLib.IO_IN, stdin_handler, cbs, \
+		   netReg)
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-gnss b/test/test-gnss
index 62b56f9..aa0b160 100755
--- a/test/test-gnss
+++ b/test/test-gnss
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 import sys
 import os
 =

@@ -37,8 +37,8 @@ def print_menu():
 	print("[x] Exit")
 	print("-----------------------------------------------------------")
 =

-def stdin_handler(fd, condition, gnss, path):
-	in_key =3D os.read(fd.fileno(), 8).rstrip()
+def stdin_handler(channel, condition, gnss, path):
+	in_key =3D os.read(channel.unix_get_fd(), 160).rstrip().decode('UTF-8')
 	if in_key =3D=3D '0':
 		xml =3D raw_input('type the element and press enter: ')
 		try:
@@ -87,7 +87,8 @@ if __name__ =3D=3D "__main__":
 =

 	print_menu()
 =

-	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler,
-				gnss, path)
-	mainloop =3D gobject.MainLoop()
+	GLib.io_add_watch(GLib.IOChannel(filedes=3Dsys.stdin.fileno()),
+		   GLib.PRIORITY_DEFAULT, GLib.IO_IN, stdin_handler,
+		   gnss, path)
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-message-waiting b/test/test-message-waiting
index b737ee4..b93fbf3 100755
--- a/test/test-message-waiting
+++ b/test/test-message-waiting
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 import sys
 import dbus
 import dbus.mainloop.glib
@@ -36,5 +36,5 @@ if __name__ =3D=3D "__main__":
 	print("Voicemail mailbox number: %s" %\
 		(properties['VoicemailMailboxNumber']))
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-modem b/test/test-modem
index 7681094..29dbf14 100755
--- a/test/test-modem
+++ b/test/test-modem
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -61,5 +61,5 @@ if __name__ =3D=3D "__main__":
 		for interface in properties["Interfaces"]:
 			print("    [ %s ]" % (interface))
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-network-registration b/test/test-network-registration
index 9410ae6..c5ad586 100755
--- a/test/test-network-registration
+++ b/test/test-network-registration
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 import sys
 import dbus
 import dbus.mainloop.glib
@@ -67,5 +67,5 @@ if __name__ =3D=3D "__main__":
 =

 	canexit =3D True
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-push-notification b/test/test-push-notification
index d05ec35..ecc6afb 100755
--- a/test/test-push-notification
+++ b/test/test-push-notification
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import sys
 import dbus
@@ -43,7 +43,7 @@ if __name__ =3D=3D '__main__':
 	pn.RegisterAgent(path)
 	print("Agent registered")
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 =

 	try:
 		mainloop.run()
diff --git a/test/test-smart-messaging b/test/test-smart-messaging
index 6d5d44b..188ac1e 100755
--- a/test/test-smart-messaging
+++ b/test/test-smart-messaging
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import sys
 import dbus
@@ -61,7 +61,7 @@ if __name__ =3D=3D '__main__':
 	pn.RegisterAgent(path)
 	print("Agent registered")
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 =

 	try:
 		mainloop.run()
diff --git a/test/test-sms b/test/test-sms
index 33d4ccd..49935e1 100755
--- a/test/test-sms
+++ b/test/test-sms
@@ -1,7 +1,7 @@
 #!/usr/bin/python
 # -*- coding: utf-8 -*-
 =

-import gobject
+from gi.repository import GLib
 import sys
 import os
 =

@@ -124,9 +124,9 @@ def print_sms_properties(sms):
 		else:
 			print("%s Message Manager rule disabled" % (p))
 =

-def stdin_handler(fd, condition, sms, value, number):
+def stdin_handler(channel, condition, sms, value, number):
 	global lock
-	in_key =3D os.read(fd.fileno(), 160).rstrip()
+	in_key =3D os.read(channel.unix_get_fd(), 160).rstrip().decode('UTF-8')
 =

 	if lock =3D=3D "off":
 		lock =3D "on"
@@ -241,7 +241,8 @@ if __name__ =3D=3D "__main__":
 	print_sms_properties(sms)
 	print_menu()
 =

-	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler,
-				sms, value, number)
-	mainloop =3D gobject.MainLoop()
+	GLib.io_add_watch(GLib.IOChannel(filedes=3Dsys.stdin.fileno()),
+		   GLib.PRIORITY_DEFAULT, GLib.IOCondition.IN, stdin_handler,
+		   sms, value, number)
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-ss-control-cb b/test/test-ss-control-cb
index d972097..86bac9b 100755
--- a/test/test-ss-control-cb
+++ b/test/test-ss-control-cb
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -90,6 +90,6 @@ if __name__ =3D=3D "__main__":
 	print("Disable All Barrings")
 	print(ss.Initiate("#330*3579#"))
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
 =

diff --git a/test/test-ss-control-cf b/test/test-ss-control-cf
index 1ba9512..d30bf4f 100755
--- a/test/test-ss-control-cf
+++ b/test/test-ss-control-cf
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -71,5 +71,5 @@ if __name__ =3D=3D "__main__":
 	print(ss.Initiate("##002#"))
 	print_properties(cf)
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
diff --git a/test/test-ss-control-cs b/test/test-ss-control-cs
index 2d5442f..e0ed1d1 100755
--- a/test/test-ss-control-cs
+++ b/test/test-ss-control-cs
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import dbus
 import dbus.mainloop.glib
@@ -111,6 +111,6 @@ if __name__ =3D=3D "__main__":
 =

 	print_properties(cs)
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
 =

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 7952abd..e76f292 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 =

-import gobject
+from gi.repository import GLib
 =

 import sys
 import dbus
@@ -36,7 +36,7 @@ class StkAgent(dbus.service.Object):
 	def call_added(self, path, properties):
 		print("call added %s" % (path))
 		if (self.timeout_id > 0):
-			gobject.source_remove(self.timeout_id)
+			GLib.source_remove(self.timeout_id)
 			self.timeout_callback()
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
@@ -94,7 +94,7 @@ class StkAgent(dbus.service.Object):
 			print("Waiting for %d seconds" % (seconds))
 =

 		self.timeout_reply_handler =3D reply_func
-		self.timeout_id =3D gobject.timeout_add_seconds(seconds,
+		self.timeout_id =3D GLib.timeout_add_seconds(seconds,
 							self.timeout_callback)
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
@@ -264,7 +264,7 @@ class StkAgent(dbus.service.Object):
 			print("Waiting for %d seconds" % (seconds))
 =

 		self.timeout_reply_handler =3D reply_func
-		self.timeout_id =3D gobject.timeout_add_seconds(seconds,
+		self.timeout_id =3D GLib.timeout_add_seconds(seconds,
 							self.timeout_callback)
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
@@ -413,5 +413,5 @@ if __name__ =3D=3D '__main__':
 		print("%s [menu|agent]" % (sys.argv[0]))
 		exit(0)
 =

-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GLib.MainLoop()
 	mainloop.run()
-- =

1.9.0


--===============1194875550080321490==--

