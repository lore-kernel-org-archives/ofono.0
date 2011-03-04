Content-Type: multipart/mixed; boundary="===============1209467030795450324=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Add the possibility to specify the modem in
 test/test-call-settings
Date: Fri, 04 Mar 2011 11:22:53 +0100
Message-ID: <1299234173-4688-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1209467030795450324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-call-settings |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/test/test-call-settings b/test/test-call-settings
index f31fd1a..187b405 100755
--- a/test/test-call-settings
+++ b/test/test-call-settings
@@ -14,15 +14,12 @@ def property_changed(name, value):
 =

 if __name__ =3D=3D "__main__":
 	if len(sys.argv) < 3:
-		print "Usage: %s <property> <newvalue>" % (sys.argv[0])
+		print "Usage: %s [modem] <property> <newvalue>" % (sys.argv[0])
 		print "Properties can be: VoiceCallWaiting, HideCallerId"
 		sys.exit(1)
 =

 	canexit =3D False
 =

-	property =3D sys.argv[1]
-	newvalue =3D sys.argv[2]
-
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 =

 	bus =3D dbus.SystemBus()
@@ -31,8 +28,18 @@ if __name__ =3D=3D "__main__":
 							'org.ofono.Manager')
 =

 	modems =3D manager.GetModems()
-
-	cs =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
+	modem =3D modems[0][0]
+
+	if (len(sys.argv) =3D=3D 4):
+		modem =3D sys.argv[1]
+		property =3D sys.argv[2]
+		newvalue =3D sys.argv[3]
+	else:
+		property =3D sys.argv[1]
+		newvalue =3D sys.argv[2]
+	print "Using modem %s" % modem
+
+	cs =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.CallSettings')
 =

 	cs.connect_to_signal("PropertyChanged", property_changed)
-- =

1.7.1

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

--===============1209467030795450324==--

