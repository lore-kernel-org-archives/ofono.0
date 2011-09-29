Content-Type: multipart/mixed; boundary="===============3279919981392871267=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 4/6] test: add support to select modem
Date: Thu, 29 Sep 2011 14:54:24 -0300
Message-ID: <1317318866-9027-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317318866-9027-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3279919981392871267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 test/test-sms |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/test/test-sms b/test/test-sms
index 6200733..794d46a 100755
--- a/test/test-sms
+++ b/test/test-sms
@@ -210,7 +210,7 @@ def stdin_handler(fd, condition, sms, value, number):
 if __name__ =3D=3D "__main__":
 =

 	if (len(sys.argv) < 3):
-		print "Usage: %s <phone_number> <test_message>" % (sys.argv[0])
+		print "Usage: %s  [modem] <phone_number> <test_message>" % (sys.argv[0])
 		sys.exit(1)
 =

 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -218,8 +218,16 @@ if __name__ =3D=3D "__main__":
 	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 							'org.ofono.Manager')
 =

-	modems =3D manager.GetModems()
-	path =3D modems[0][0]
+	if (len(sys.argv) =3D=3D 4):
+		path =3D sys.argv[1]
+		number =3D sys.argv[2]
+		value  =3D sys.argv[3]
+	else:
+		modems =3D manager.GetModems()
+		path =3D modems[0][0]
+		number =3D sys.argv[1]
+		value  =3D sys.argv[2]
+
 	sms =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.MessageManager')
 =

@@ -229,9 +237,6 @@ if __name__ =3D=3D "__main__":
 	sms.connect_to_signal("MessageAdded", message_added)
 	sms.connect_to_signal("MessageRemoved", message_removed)
 =

-	number =3D sys.argv[1]
-	value  =3D sys.argv[2]
-
 	clear_screen()
 	print_sms_properties(sms)
 	print_menu()
-- =

1.7.6.2


--===============3279919981392871267==--

