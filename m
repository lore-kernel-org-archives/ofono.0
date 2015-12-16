Content-Type: multipart/mixed; boundary="===============2475677924197879006=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH] build: untangle ATMODEM and BLUETOOTH conditionals
Date: Wed, 16 Dec 2015 16:14:44 -0500
Message-ID: <1450300484-10635-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2475677924197879006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b22c04b..270590b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -477,6 +477,14 @@ builtin_modules +=3D ublox
 builtin_sources +=3D plugins/ublox.c
 =

 if BLUETOOTH
+if !BLUEZ4
+builtin_modules +=3D hfp_bluez5
+builtin_sources +=3D plugins/hfp_hf_bluez5.c plugins/bluez5.h
+endif
+endif
+endif
+
+if BLUETOOTH
 if BLUEZ4
 builtin_modules +=3D bluez4
 builtin_sources +=3D plugins/bluez4.c plugins/bluez4.h
@@ -503,9 +511,6 @@ else
 builtin_modules +=3D bluez5
 builtin_sources +=3D plugins/bluez5.c plugins/bluez5.h
 =

-builtin_modules +=3D hfp_bluez5
-builtin_sources +=3D plugins/hfp_hf_bluez5.c plugins/bluez5.h
-
 builtin_modules +=3D hfp_ag_bluez5
 builtin_sources +=3D plugins/hfp_ag_bluez5.c plugins/bluez5.h
 =

@@ -513,7 +518,6 @@ builtin_modules +=3D dun_gw_bluez5
 builtin_sources +=3D plugins/dun_gw_bluez5.c plugins/bluez5.h
 endif
 endif
-endif
 =

 if PROVISION
 builtin_sources +=3D plugins/mbpi.h plugins/mbpi.c
-- =

2.1.4


--===============2475677924197879006==--

