Content-Type: multipart/mixed; boundary="===============4419121355071501929=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] sim: fix typo
Date: Mon, 29 Nov 2010 16:51:46 -0200
Message-ID: <1291056706-29493-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4419121355071501929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 05ae21f..71bb81d 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -1111,7 +1111,7 @@ void DemoSimApplication::sendSendSSMenu()
     items +=3D item;
 =

     item.setIdentifier( SendSSMenu_CLIP );
-    item.setLabel( "CLIP (Calling Line Idnetification Presentation)" );
+    item.setLabel( "CLIP (Calling Line Identification Presentation)" );
     items +=3D item;
 =

     item.setIdentifier( SendSSMenu_CLIR );
-- =

1.7.3.2


--===============4419121355071501929==--

