Content-Type: multipart/mixed; boundary="===============0847841338768617078=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/2] Change sw2 only when cmd is not empty
Date: Thu, 08 Jul 2010 18:57:19 +0800
Message-ID: <1278586639-6329-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1278586639-6329-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0847841338768617078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/phonesim.cpp |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index d5d7d87..8210f51 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -923,9 +923,10 @@ bool SimRules::simCsimOk( const QByteArray& payload )
 =

     if ( toolkitApp ) {
         QByteArray cmd =3D toolkitApp->fetch();
-        if ( !cmd.isEmpty() )
+        if ( !cmd.isEmpty() ) {
             sw1 =3D 0x91;
             sw2 =3D cmd.size();
+        }
     }
 =

     resp +=3D sw1;
-- =

1.7.0.4


--===============0847841338768617078==--

