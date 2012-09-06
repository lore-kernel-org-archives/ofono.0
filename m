Content-Type: multipart/mixed; boundary="===============3722209670962971258=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/3] test: iconId value is not a printable character
Date: Thu, 06 Sep 2012 16:38:47 +0200
Message-ID: <1346942327-4448-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346942327-4448-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3722209670962971258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/list-calls |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/list-calls b/test/list-calls
index 53124dc..2332b50 100755
--- a/test/list-calls
+++ b/test/list-calls
@@ -24,7 +24,8 @@ for path, properties in modems:
 		print "    [ %s ]" % (path)
 =

 		for key in properties.keys():
-			val =3D str(properties[key])
-			print "        %s =3D %s" % (key, val)
-
-		print
+			if key =3D=3D 'Icon':
+				print "        %s =3D %d" % (key, properties[key])
+			else:
+				val =3D str(properties[key])
+				print "        %s =3D %s" % (key, val)
-- =

1.7.9.5


--===============3722209670962971258==--

