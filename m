Content-Type: multipart/mixed; boundary="===============6974251499882826697=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] phonesim: Add +CUAD command and EFdir EF.
Date: Wed, 12 Jan 2011 09:00:07 +0100
Message-ID: <1294819208-9287-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6974251499882826697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add +PTTY in +CLAC output too.
---
 src/default.xml       |   23 +++++++++++++++++++++++
 src/simfilesystem.cpp |    5 +++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/src/default.xml b/src/default.xml
index ab1ed06..803c539 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -3165,6 +3165,7 @@
 +CMEE
 +CMGF
 +CMGS
++CUAD
 +DR
 +DS
 +GCAP
@@ -3179,6 +3180,7 @@
 +ILRR
 +IPR
 +FCLASS
++PTTY
 +VBT
 +VCID
 +VGR
@@ -3234,6 +3236,20 @@ OK</response>
     <response>+PTTY: ${PTTY}\n\nOK</response>
 </chat>
 =

+<chat>
+    <!-- Discover UICC applications -->
+    <!-- the response is in sync with the EFdir contents in the filesystem
+	 definition below -->
+    <command>AT+CUAD</command>
+    <response>+CUAD: "611B4F10A0000000871002FFFFFFFF8905080000FFFFFFFFFFFF=
FFFFFFFFFFFFFF611F4F0CA000000063504B43532D313550094D49445066696C657351043F0=
07F80"\n\nOK</response>
+</chat>
+
+<chat>
+    <!-- Query "Discover UICC applications" support -->
+    <command>AT+CUAD=3D?</command>
+    <response>OK</response>
+</chat>
+
 <!-- SIM filesystem definition, based on standard test strings
      presented in GSM 11.10-4.  This is primarily intended for
      testing icon definitions within SIM toolkit applications -->
@@ -3476,6 +3492,13 @@ OK</response>
     5A 55
 </file>
 =

+<file name=3D"EFdir" recordsize=3D"33">
+    61 1B 4F 10 A0 00 00 00 87 10 02 FF FF FF FF 89 05 08 00 00 FF FF
+    FF FF FF FF FF FF FF FF FF FF FF
+    61 1F 4F 0C A0 00 00 00 63 50 4B 43 53 2D 31 35 50 09 4D 49 44 50
+    66 69 6C 65 73 51 04 3F 00 7F 80"
+</file>
+
 </filesystem>
 =

 </simulator>
diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index 6e05039..46f3b1f 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -121,6 +121,11 @@ static SimFileInfo const knownFiles[] =3D
     {"6F16",        "7F20",     "EFcphs_info", 0x14ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"6F17",        "7F20",     "EFcphs_mbdn", 0x11ff44,  FILE_TYPE_LINEAR=
_FIXED},
     {"6F11",        "7F20",     "EFcphs_mwis", 0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
+
+    // TS 102.221
+    {"2F00",        "3F00",     "EFdir",       0x04ff44,  FILE_TYPE_LINEAR=
_FIXED},
+    {"2F06",        "3F00",     "EFarr",       0x04ff44,  FILE_TYPE_LINEAR=
_FIXED},
+
     {0,             0,          0,             0,         FILE_TYPE_TRANSP=
ARENT}
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============6974251499882826697==--

