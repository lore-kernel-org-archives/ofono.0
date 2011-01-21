Content-Type: multipart/mixed; boundary="===============8508422231670895097=="
MIME-Version: 1.0
From: christian.lam@nokia.com
Subject: [PATCH 7/7] test: add Settings dict parsing for CDMA ConnMan
Date: Fri, 21 Jan 2011 15:06:50 -0800
Message-ID: <1295651210-22922-8-git-send-email-christian.lam@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8508422231670895097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christian Lam <christian.lam@nokia.com>

---
 test/list-modems |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/test/list-modems b/test/list-modems
index 249ae15..662a3c7 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -62,6 +62,16 @@ for path, properties in modems:
 				for i in properties[key]:
 					val +=3D  "[" + i + " =3D "
 					val +=3D str(int(properties[key][i])) + "] "
+			elif key in ["Settings"]:
+				val =3D "{"
+				for i in properties[key].keys():
+					val +=3D " " + i + "=3D"
+					if i in ["DomainNameServers"]:
+						for n in properties[key][i]:
+							val +=3D n + ","
+					else:
+						val +=3D properties[key][i]
+				val +=3D " }"
 			else:
 				val =3D str(properties[key])
 			print "        %s =3D %s" % (key, val)
-- =

1.7.0.4


--===============8508422231670895097==--

