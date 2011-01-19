Content-Type: multipart/mixed; boundary="===============2328189460453776700=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 6/6] test: Remove deregister support from test script
Date: Wed, 19 Jan 2011 23:53:55 +0200
Message-ID: <1295474035-7142-7-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1295474035-7142-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2328189460453776700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-network-registration |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/test/test-network-registration b/test/test-network-registration
index a8bd141..0c25885 100755
--- a/test/test-network-registration
+++ b/test/test-network-registration
@@ -18,8 +18,6 @@ if __name__ =3D=3D "__main__":
 			(sys.argv[0])
 		print "Usage: %s default - Register to default PLMN" %\
 			(sys.argv[0])
-		print "Usage: %s unregister - Unregister from all PLMNs" %\
-			(sys.argv[0])
 		sys.exit(1)
 =

 	canexit =3D False
@@ -53,14 +51,12 @@ if __name__ =3D=3D "__main__":
 	try:
 		if sys.argv[1] =3D=3D 'default':
 			netreg.Register()
-		elif sys.argv[1] =3D=3D 'unregister':
-			netreg.Deregister()
 		else:
 			obj =3D bus.get_object('org.ofono', sys.argv[1]);
 			op =3D dbus.Interface(obj, 'org.ofono.NetworkOperator')
 			op.Register()
 	except dbus.DBusException, e:
-		print "Unable to register/deregister: ", e
+		print "Unable to register: ", e
 		sys.exit(1)
 =

 	canexit =3D True
-- =

1.7.1


--===============2328189460453776700==--

