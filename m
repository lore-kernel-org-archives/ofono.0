Content-Type: multipart/mixed; boundary="===============7412849522326477190=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] test: add Retries property to list-modems
Date: Mon, 17 Jan 2011 09:49:53 -0800
Message-ID: <1295286593-19448-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7412849522326477190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/list-modems |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/test/list-modems b/test/list-modems
index 8c075ac..249ae15 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -57,6 +57,11 @@ for path, properties in modems:
 			elif key in ["MainMenu"]:
 				val =3D ", ".join([ text + " (" + str(int(icon)) +
 					")" for text, icon in properties[key] ])
+			elif key in ["Retries"]:
+				val =3D ""
+				for i in properties[key]:
+					val +=3D  "[" + i + " =3D "
+					val +=3D str(int(properties[key][i])) + "] "
 			else:
 				val =3D str(properties[key])
 			print "        %s =3D %s" % (key, val)
-- =

1.7.0.4


--===============7412849522326477190==--

