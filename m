Content-Type: multipart/mixed; boundary="===============4397797537972799392=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] simfilesystem: make EFimg a linear fixed file type
Date: Thu, 05 Aug 2010 14:33:37 -0700
Message-ID: <1281044017-9663-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4397797537972799392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfilesystem.cpp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index 6781ac9..d193328 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -110,7 +110,7 @@ static SimFileInfo const knownFiles[] =3D
     {"2F05",        "3F00",     "EFpl",        0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
 =

     {"5F50",        "7F10",     "DFgraphics",  0,         FILE_TYPE_TRANSP=
ARENT},
-    {"4F20",        "5F50",     "EFimg",       0x14ff44,  FILE_TYPE_TRANSP=
ARENT},
+    {"4F20",        "5F50",     "EFimg",       0x14ff44,  FILE_TYPE_LINEAR=
_FIXED},
     {"4F01",        "5F50",     "EFimg1",      0x14ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"4F02",        "5F50",     "EFimg2",      0x14ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"4F03",        "5F50",     "EFimg3",      0x14ff44,  FILE_TYPE_TRANSP=
ARENT},
-- =

1.7.1.1


--===============4397797537972799392==--

