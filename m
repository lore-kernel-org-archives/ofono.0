Content-Type: multipart/mixed; boundary="===============2565872738398723487=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] phonesim: Add cfis and cphs file
Date: Mon, 20 Dec 2010 11:49:01 -0800
Message-ID: <1292874541-10288-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2565872738398723487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/default.xml       |    8 ++++++++
 src/simfilesystem.cpp |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/default.xml b/src/default.xml
index 54c7191..4491705 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -3352,6 +3352,10 @@ OK</response>
     00 32 00 32 FF FF FF FF FF FF FF FF FF FF FF FF
 </file>
 =

+<file name=3D"EFcfis" recordsize=3D"16">
+    01 1E FF FF FF FF FF FF FF FF FF FF FF FF FF FF
+</file>
+
 <!-- Record 1
      Length of alpha identifier: 32 chars
      Alpha Identifier: "ABC"
@@ -3491,6 +3495,10 @@ OK</response>
     02 3C 03 00
 </file>
 =

+<file name=3D"EFcphs_cff">
+    55 55
+</file>
+
 <file name=3D"EFcphs_mbdn" recordsize=3D"48">
     FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
     FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index 6e05039..5312a82 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -118,6 +118,7 @@ static SimFileInfo const knownFiles[] =3D
     {"4F05",        "5F50",     "EFimg5",      0x14ff44,  FILE_TYPE_TRANSP=
ARENT},
 =

     // CPHS 4.2
+    {"6F13",        "7F20",     "EFcphs_cff",  0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"6F16",        "7F20",     "EFcphs_info", 0x14ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"6F17",        "7F20",     "EFcphs_mbdn", 0x11ff44,  FILE_TYPE_LINEAR=
_FIXED},
     {"6F11",        "7F20",     "EFcphs_mwis", 0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
-- =

1.7.0.4


--===============2565872738398723487==--

