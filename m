Content-Type: multipart/mixed; boundary="===============7733723231676440521=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/3] test: playtone waits for single tone playback
Date: Thu, 06 Sep 2012 16:38:46 +0200
Message-ID: <1346942327-4448-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346942327-4448-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7733723231676440521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To simulate the single tone playback (avoiding the stkagent method
to return immediately), a timeout is started (5 seconds).
During this time, the user can terminate the session.
---
 test/test-stk-menu |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/test/test-stk-menu b/test/test-stk-menu
index 6e7f7b7..f4553d1 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -6,6 +6,10 @@ import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
+import signal
+
+def handler(signum, frame):
+	raise Exception("\nSingle tone is finished!")
 =

 class GoBack(dbus.DBusException):
 	_dbus_error_name =3D "org.ofono.Error.GoBack"
@@ -195,6 +199,20 @@ class StkAgent(dbus.service.Object):
 		print "Text: %s" % (text)
 		print "Icon: %d" % (icon)
 =

+		signal.signal(signal.SIGALRM, handler)
+		signal.alarm(5)
+
+		try:
+			key =3D raw_input("Press return to end before end of"
+							 " single tone (t):")
+			signal.alarm(0)
+
+			if key =3D=3D 't':
+				raise EndSession("User wishes to terminate"
+								 " session");
+		except Exception, exc:
+			print exc
+
 	@dbus.service.method("org.ofono.SimToolkitAgent",
 					in_signature=3D"ssy", out_signature=3D"")
 	def LoopTone(self, tone, text, icon):
-- =

1.7.9.5


--===============7733723231676440521==--

