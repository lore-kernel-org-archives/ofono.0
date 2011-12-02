Content-Type: multipart/mixed; boundary="===============7461385245827569922=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 1/1] simfilesystem: Add support for CPHS SPN, short-SPN
Date: Fri, 02 Dec 2011 13:10:58 +0200
Message-ID: <1322824258-10089-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322824258-10089-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7461385245827569922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/default.xml       |    8 ++++++++
 src/simfilesystem.cpp |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/src/default.xml b/src/default.xml
index 5f5f1ab..63474f3 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -3602,6 +3602,14 @@ OK</response>
 	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 C0 80
 </file>
 =

+<file name=3D"EFcphs_spn">
+	63 70 68 73 11 73 70 6E
+</file>
+
+<file name=3D"EFcphs_spns">
+	63 70 68 73 11 73 70 6E 73 FF
+</file>
+
 </filesystem>
 =

 </simulator>
diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index 71cdd53..b1194a9 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -119,9 +119,11 @@ static SimFileInfo const knownFiles[] =3D
 =

     // CPHS 4.2
     {"6F13",        "7F20",     "EFcphs_cff",  0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
+    {"6F14",        "7F20",     "EFcphs_spn",  0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"6F15",        "7F20",     "EFcphs_csp",  0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"6F16",        "7F20",     "EFcphs_info", 0x14ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"6F17",        "7F20",     "EFcphs_mbdn", 0x11ff44,  FILE_TYPE_LINEAR=
_FIXED},
+    {"6F18",        "7F20",     "EFcphs_spns", 0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
     {"6F11",        "7F20",     "EFcphs_mwis", 0x11ff44,  FILE_TYPE_TRANSP=
ARENT},
 =

     // TS 102.221
-- =

1.7.5.4


--===============7461385245827569922==--

