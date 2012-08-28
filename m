Content-Type: multipart/mixed; boundary="===============5388648532630792720=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 4/4] test: Update with RequestQuickDigit API
Date: Tue, 28 Aug 2012 15:21:22 +0200
Message-ID: <1346160082-11077-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346160082-11077-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5388648532630792720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-stk-menu |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index a9f92e8..476d949 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -7,6 +7,27 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 =

+
+
+class _GetchUnix:
+    def __init__(self):
+        import tty, sys
+
+    def __call__(self):
+        import sys, tty, termios
+        fd =3D sys.stdin.fileno()
+        old_settings =3D termios.tcgetattr(fd)
+        try:
+            tty.setraw(sys.stdin.fileno())
+            ch =3D sys.stdin.read(1)
+        finally:
+            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
+        return ch
+
+
+getch =3D _GetchUnix()
+
+
 class GoBack(dbus.DBusException):
 	_dbus_error_name =3D "org.ofono.Error.GoBack"
 =

@@ -127,6 +148,22 @@ class StkAgent(dbus.service.Object):
 			return key
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
+				in_signature=3D"sy", out_signature=3D"s")
+	def RequestQuickDigit(self, title, icon):
+		print "Title: (%s)" % (title)
+		print "Icon: (%d)" % (icon)
+		print "Single key press (t, b, 0-9,*,#)" =

+		key =3D getch();
+
+		if key =3D=3D 'b':
+			raise GoBack("User wishes to go back");
+		elif key =3D=3D 't':
+			raise EndSession("User wishes to terminate session");
+		else:
+			print "."			=

+			return key
+
+	@dbus.service.method("org.ofono.SimToolkitAgent",
 				in_signature=3D"sy", out_signature=3D"b")
 	def RequestConfirmation(self, title, icon):
 		print "Title: (%s)" % (title)
-- =

1.7.9.5


--===============5388648532630792720==--

