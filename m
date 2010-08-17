Content-Type: multipart/mixed; boundary="===============5882222372217748734=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] list-modems: Pretty-print main menu.
Date: Tue, 17 Aug 2010 17:36:59 +0200
Message-ID: <1282059423-28864-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5882222372217748734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/list-modems |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/test/list-modems b/test/list-modems
index 191743b..eee00b0 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -58,6 +58,9 @@ for path in properties["Modems"]:
 						"MicrophoneVolume",
 						"SpeakerVolume"]:
 				val =3D int(properties[key])
+			elif key in ["MainMenu"]:
+				val =3D ", ".join([ text + " (" + str(int(icon)) +
+					")" for text, icon in properties[key] ])
 			else:
 				val =3D str(properties[key])
 			print "        %s =3D %s" % (key, val)
-- =

1.7.1.86.g0e460.dirty


--===============5882222372217748734==--

