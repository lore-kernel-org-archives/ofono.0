Content-Type: multipart/mixed; boundary="===============4010179670666867858=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isimodem-ussd PATCH 3/5] test-ussd: read stdin for Response()s
Date: Thu, 16 Sep 2010 20:32:47 +0300
Message-ID: <1284658369-1988-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284658369-1988-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4010179670666867858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 test/test-ussd |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/test/test-ussd b/test/test-ussd
index 6e24de8..d4c1e27 100755
--- a/test/test-ussd
+++ b/test/test-ussd
@@ -2,10 +2,13 @@
 =

 import sys
 import gobject
+import os
 =

 import dbus
 import dbus.mainloop.glib
 =

+state =3D None
+
 def ussd_notification_received(content):
 	print("Network sent a Notification: " + content)
 =

@@ -14,9 +17,23 @@ def ussd_request_received(content):
 	ss.Cancel()
 =

 def ussd_property_changed(name, value):
+	global state
 	if name !=3D "State":
 		return
 	print("USSD session state is " + value)
+	state =3D str(value)
+
+def stdin_handler(fd, condition):
+	s =3D os.read(fd.fileno(), 160).rstrip()
+	if not s:
+		ss.Cancel()
+	elif state =3D=3D "user-response":
+		print ss.Respond(s, timeout =3D 100)
+	elif state =3D=3D "idle":
+		print ss.Initiate(s, timeout =3D 100)
+	else:
+		print "Invalid state", state
+	return True
 =

 if __name__ =3D=3D "__main__":
 	if (len(sys.argv) < 2):
@@ -44,5 +61,7 @@ if __name__ =3D=3D "__main__":
 =

 	print ss.Initiate(sys.argv[1], timeout=3D100)
 =

+	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler)
+
 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
-- =

1.7.0.4


--===============4010179670666867858==--

