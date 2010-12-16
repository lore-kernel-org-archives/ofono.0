Content-Type: multipart/mixed; boundary="===============7115055998107889299=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH] test: test case for changing Call Barring password
Date: Thu, 16 Dec 2010 14:12:55 +0100
Message-ID: <1292505175-23135-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7115055998107889299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>

---
 test/test-call-barring |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/test/test-call-barring b/test/test-call-barring
index 5385a10..0756011 100755
--- a/test/test-call-barring
+++ b/test/test-call-barring
@@ -14,6 +14,7 @@ def property_changed(name, value):
 def print_useage(s):
 	print "Usage: %s <property> <newvalue> <password>" % (s)
 	print "Usage: %s disableall <password>" % (s)
+	print "Usage: %s passwd <old_password> <new_password>" % (s)
 	sys.exit(1);
 =

 if __name__ =3D=3D "__main__":
@@ -22,6 +23,9 @@ if __name__ =3D=3D "__main__":
 =

 	if (sys.argv[1] =3D=3D 'disableall'):
 		pin =3D sys.argv[2]
+	elif (sys.argv[1] =3D=3D 'passwd'):
+		old_password =3D sys.argv[2]
+		new_password =3D sys.argv[3]
 	else:
 		if (len(sys.argv) !=3D 4):
 			print_useage(sys.argv[0])
@@ -59,6 +63,14 @@ if __name__ =3D=3D "__main__":
 		except dbus.DBusException, e:
 			print "Unable to Disable All barrings: ", e
 			sys.exit(1)
+	elif (sys.argv[1] =3D=3D 'passwd'):
+		try:
+			cb.ChangePassword(old_password, new_password)
+		except dbus.DBusException, e:
+			print "Unable to change password: ", e
+			sys.exit(1)
+		print "Password changed"
+		sys.exit(0)
 	else:
 		try:
 			cb.SetProperty(property, newvalue, pin)
-- =

1.7.0.4


--===============7115055998107889299==--

