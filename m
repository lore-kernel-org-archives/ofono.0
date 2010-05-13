Content-Type: multipart/mixed; boundary="===============2506678047355068533=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 13/16] emulator: Add Emulators in list-modems script
Date: Thu, 13 May 2010 18:02:36 +0800
Message-ID: <1273744959-3711-14-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-13-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2506678047355068533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/list-modems |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/test/list-modems b/test/list-modems
index 7425c8d..a159282 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -45,7 +45,8 @@ for path in properties["Modems"]:
 						"ServiceDiallingNumbers",
 						"PreferredLanguages",
 						"PrimaryContexts",
-						"LockedPins"]:
+						"LockedPins",
+						"Emulators"]:
 				val =3D ""
 				for i in properties[key]:
 					val +=3D i + " "
-- =

1.6.3.3


--===============2506678047355068533==--

