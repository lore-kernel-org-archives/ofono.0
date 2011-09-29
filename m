Content-Type: multipart/mixed; boundary="===============3563561501705486490=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 5/6] test: add support to select modem
Date: Thu, 29 Sep 2011 14:54:25 -0300
Message-ID: <1317318866-9027-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317318866-9027-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3563561501705486490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 test/test-network-registration |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/test/test-network-registration b/test/test-network-registration
index 0c25885..cfc1a43 100755
--- a/test/test-network-registration
+++ b/test/test-network-registration
@@ -13,10 +13,10 @@ def network_property_changed(name, value):
 		mainloop.quit()
 =

 if __name__ =3D=3D "__main__":
-	if len(sys.argv) !=3D 2:
-		print "Usage: %s <path> - Register to PLMN on <path>" %\
+	if len(sys.argv) < 2:
+		print "Usage: %s [modem] <path> - Register to PLMN on <path>" %\
 			(sys.argv[0])
-		print "Usage: %s default - Register to default PLMN" %\
+		print "Usage: %s [modem] default - Register to default PLMN" %\
 			(sys.argv[0])
 		sys.exit(1)
 =

@@ -29,9 +29,15 @@ if __name__ =3D=3D "__main__":
 	manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
 							'org.ofono.Manager')
 =

-	modems =3D manager.GetModems()
+	if len(sys.argv) =3D=3D 3:
+		path =3D sys.argv[1]
+		plmn =3D sys.argv[2]
+	else:
+		modems =3D manager.GetModems()
+		path =3D modems[0][0]
+		plmn =3D sys.argv[1]
 =

-	netreg =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
+	netreg =3D dbus.Interface(bus.get_object('org.ofono', path),
 				'org.ofono.NetworkRegistration')
 =

 	netreg.connect_to_signal("PropertyChanged", network_property_changed)
@@ -49,10 +55,10 @@ if __name__ =3D=3D "__main__":
 		print "Technology: '%s'" % (props['Technology'])
 =

 	try:
-		if sys.argv[1] =3D=3D 'default':
+		if plmn =3D=3D 'default':
 			netreg.Register()
 		else:
-			obj =3D bus.get_object('org.ofono', sys.argv[1]);
+			obj =3D bus.get_object('org.ofono', plmn);
 			op =3D dbus.Interface(obj, 'org.ofono.NetworkOperator')
 			op.Register()
 	except dbus.DBusException, e:
-- =

1.7.6.2


--===============3563561501705486490==--

