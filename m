Content-Type: multipart/mixed; boundary="===============4410940088020663197=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Fix NetworkRegistration test by fixing indentation.
Date: Thu, 18 Jun 2009 05:44:06 +0200
Message-ID: <1245296646-15186-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4410940088020663197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[Sorry if you get this mail or some of the other mails a second time,
I sent a copy from an unsubscribed address yesterday].
---
 test/test-network-registration |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/test-network-registration b/test/test-network-registration
index 8d2176b..b21d06a 100755
--- a/test/test-network-registration
+++ b/test/test-network-registration
@@ -78,7 +78,7 @@ if __name__ =3D=3D "__main__":
 		else:
 			obj =3D bus.get_object('org.ofono', sys.argv[1]);
 			op =3D dbus.Interface(obj, 'org.ofono.NetworkOperator')
-		op.Register()
+			op.Register()
 	except dbus.DBusException, e:
 		print "Unable to register/deregister: ", e
 		sys.exit(1)
-- =

1.6.0


--===============4410940088020663197==--

