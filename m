Content-Type: multipart/mixed; boundary="===============0952206863412356549=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] phonesim: Fix access bits for EFiccid, EFpl.
Date: Wed, 12 Jan 2011 09:00:08 +0100
Message-ID: <1294819208-9287-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1294819208-9287-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0952206863412356549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfilesystem.cpp |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index 46f3b1f..2264c44 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -106,8 +106,8 @@ static SimFileInfo const knownFiles[] =3D
     {"6FDE",        "7F20",     "EFspni",      0x04ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"6FDF",        "7F20",     "EFpnni",      0x04ff44,  FILE_TYPE_LINEAR=
_FIXED},
 =

-    {"2FE2",        "3F00",     "EFiccid",     0x04ff44,  FILE_TYPE_TRANSP=
ARENT},
-    {"2F05",        "3F00",     "EFpl",        0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
+    {"2FE2",        "3F00",     "EFiccid",     0x0fff44,  FILE_TYPE_TRANSP=
ARENT},
+    {"2F05",        "3F00",     "EFpl",        0x01ff44,  FILE_TYPE_TRANSP=
ARENT},
 =

     {"5F50",        "7F10",     "DFgraphics",  0,         FILE_TYPE_TRANSP=
ARENT},
     {"4F20",        "5F50",     "EFimg",       0x14ff44,  FILE_TYPE_LINEAR=
_FIXED},
-- =

1.7.1.86.g0e460.dirty


--===============0952206863412356549==--

