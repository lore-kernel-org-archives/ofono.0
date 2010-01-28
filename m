Content-Type: multipart/mixed; boundary="===============4914699667012900533=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] Add ability to select modem on test-voicecall
Date: Thu, 28 Jan 2010 19:56:22 -0200
Message-ID: <1264715782-29716-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4914699667012900533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-voicecall |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/test/test-voicecall b/test/test-voicecall
index 13f371a..2da7703 100755
--- a/test/test-voicecall
+++ b/test/test-voicecall
@@ -39,11 +39,9 @@ if __name__ =3D=3D "__main__":
 	global vcmanager
 =

 	if (len(sys.argv) < 2):
-		print "Useage: %s <number>" % (sys.argv[0])
+		print "Useage: %s [modem] <number>" % (sys.argv[0])
 		sys.exit(1)
 =

-	number =3D sys.argv[1]
-
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

 	bus =3D dbus.SystemBus()
@@ -52,9 +50,17 @@ if __name__ =3D=3D "__main__":
 							'org.ofono.Manager')
 =

 	modems =3D manager.GetProperties()['Modems']
+	modem =3D modems[0]
 	print modems
 =

-	vcmanager =3D dbus.Interface(bus.get_object('org.ofono', modems[0]),
+	if (len(sys.argv) =3D=3D 3):
+		modem =3D sys.argv[1]
+		number =3D sys.argv[2]
+	else:
+		number =3D sys.argv[1]
+	print "Using modem %s" % modem
+
+	vcmanager =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.VoiceCallManager')
 =

 	vcmanager.connect_to_signal("PropertyChanged",
-- =

1.6.3.3


--===============4914699667012900533==--

