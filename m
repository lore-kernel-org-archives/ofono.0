Content-Type: multipart/mixed; boundary="===============0190346737694494076=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RFC 4/5] test: modify test scripts for IPv6
Date: Wed, 26 Jan 2011 18:22:49 +0200
Message-ID: <1296058970-11815-5-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1296058970-11815-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0190346737694494076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    3 ++-
 test/list-contexts |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 71365d7..6c53215 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -470,7 +470,8 @@ test_scripts =3D test/backtrace \
 		test/cdma-list-call \
 		test/cdma-dial-number \
 		test/cdma-hangup \
-		test/disable-call-forwarding
+		test/disable-call-forwarding \
+		test/set-context-property
 =

 if TEST
 testdir =3D $(pkglibdir)/test
diff --git a/test/list-contexts b/test/list-contexts
index 68dae6a..9519ade 100755
--- a/test/list-contexts
+++ b/test/list-contexts
@@ -24,15 +24,15 @@ for path, properties in modems:
 		print "    [ %s ]" % (path)
 =

 		for key in properties.keys():
-			if key in ["Settings"]:
+			if key in ["Settings"] or key in ["IPv6Settings"]:
 				val =3D "{"
 				for i in properties[key].keys():
 					val +=3D " " + i + "=3D"
 					if i in ["DomainNameServers"]:
 						for n in properties[key][i]:
-							val +=3D n + ","
+							val +=3D str(n) + ","
 					else:
-						val +=3D properties[key][i]
+						val +=3D str(properties[key][i])
 				val +=3D " }"
 			else:
 				val =3D str(properties[key])
-- =

1.7.1


--===============0190346737694494076==--

