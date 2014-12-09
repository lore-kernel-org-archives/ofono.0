Content-Type: multipart/mixed; boundary="===============4496755519307355845=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 4/4] test: Add AvailableTechnologies to list-modems
Date: Tue, 09 Dec 2014 13:34:39 +0100
Message-ID: <1418128479-5491-5-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1418128479-5491-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4496755519307355845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/list-modems | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/list-modems b/test/list-modems
index b9f510a..a163791 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -40,7 +40,8 @@ for path, properties in modems:
 					"PreferredLanguages",
 					"PrimaryContexts",
 					"LockedPins",
-					"Features"]:
+					"Features",
+					"AvailableTechnologies"]:
 				val =3D ""
 				for i in properties[key]:
 					val +=3D i + " "
-- =

2.1.0


--===============4496755519307355845==--

