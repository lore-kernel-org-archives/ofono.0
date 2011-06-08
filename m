Content-Type: multipart/mixed; boundary="===============3971638501793358244=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Add the possibility to specify the modem to use
Date: Wed, 08 Jun 2011 15:50:39 +0200
Message-ID: <1307541039-16872-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3971638501793358244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-ussd |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/test/test-ussd b/test/test-ussd
index d4c1e27..c21f5e3 100755
--- a/test/test-ussd
+++ b/test/test-ussd
@@ -37,7 +37,7 @@ def stdin_handler(fd, condition):
 =

 if __name__ =3D=3D "__main__":
 	if (len(sys.argv) < 2):
-		print "Usage: %s <ussd-string>" % (sys.argv[0])
+		print "Usage: %s [modem] <ussd-string>" % (sys.argv[0])
 		sys.exit(1)
 =

 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -48,8 +48,16 @@ if __name__ =3D=3D "__main__":
 							'org.ofono.Manager')
 =

 	modems =3D manager.GetModems()
-	ss =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
-							'org.ofono.SupplementaryServices')
+	modem =3D modems[0][0]
+
+	if (len(sys.argv) =3D=3D 2):
+		ussd =3D sys.argv[1]
+	else:
+		modem =3D sys.argv[1]
+		ussd =3D sys.argv[2]
+
+	ss =3D dbus.Interface(bus.get_object('org.ofono', modem),
+					'org.ofono.SupplementaryServices')
 =

 	props =3D ss.GetProperties()
 	for p in props:
@@ -59,7 +67,7 @@ if __name__ =3D=3D "__main__":
 	ss.connect_to_signal("RequestReceived", ussd_request_received)
 	ss.connect_to_signal("PropertyChanged", ussd_property_changed)
 =

-	print ss.Initiate(sys.argv[1], timeout=3D100)
+	print ss.Initiate(ussd, timeout=3D100)
 =

 	gobject.io_add_watch(sys.stdin, gobject.IO_IN, stdin_handler)
 =

-- =

1.7.4.1

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

--===============3971638501793358244==--

