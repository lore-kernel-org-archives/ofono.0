Content-Type: multipart/mixed; boundary="===============3416728593260138270=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 2/2] simfilesystem: Indicate EFcphs_spns
Date: Wed, 28 Dec 2011 15:19:01 +0200
Message-ID: <1325078341-30592-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1325078341-30592-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3416728593260138270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Turn on EFcphs_spns (Operator Name Shortform) activated
and allocated bits (byte 2, bits 7, 8) in EFcphs_info.
---
 src/default.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/default.xml b/src/default.xml
index deb2fa8..7eabfbe 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -3574,7 +3574,7 @@ OK</response>
 </file>
 =

 <file name=3D"EFcphs_info">
-    02 3F 03 00
+    02 FF 03 00
 </file>
 =

 <file name=3D"EFcphs_cff">
-- =

1.7.5.4


--===============3416728593260138270==--

