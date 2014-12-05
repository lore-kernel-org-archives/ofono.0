Content-Type: multipart/mixed; boundary="===============8533975346424633816=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 4/4] test: Add ModemTechnologies to list-modems
Date: Fri, 05 Dec 2014 17:46:31 +0100
Message-ID: <1417797991-19700-5-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1417797991-19700-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8533975346424633816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/list-modems | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/list-modems b/test/list-modems
index b9f510a..cc150f6 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -40,7 +40,8 @@ for path, properties in modems:
 					"PreferredLanguages",
 					"PrimaryContexts",
 					"LockedPins",
-					"Features"]:
+					"Features",
+					"ModemTechnologies"]:
 				val =3D ""
 				for i in properties[key]:
 					val +=3D i + " "
-- =

2.1.0


--===============8533975346424633816==--

