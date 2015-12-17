Content-Type: multipart/mixed; boundary="===============4561404786868194571=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH v2] build: untangle ATMODEM and BLUETOOTH conditionals
Date: Wed, 16 Dec 2015 20:11:20 -0500
Message-ID: <1450314680-19347-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4561404786868194571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b22c04b..8bbe25c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -478,9 +478,6 @@ builtin_sources +=3D plugins/ublox.c
 =

 if BLUETOOTH
 if BLUEZ4
-builtin_modules +=3D bluez4
-builtin_sources +=3D plugins/bluez4.c plugins/bluez4.h
-
 builtin_modules +=3D telit
 builtin_sources +=3D plugins/telit.c plugins/bluez4.h
 =

@@ -490,11 +487,25 @@ builtin_sources +=3D plugins/sap.c plugins/bluez4.h
 builtin_modules +=3D hfp_bluez4
 builtin_sources +=3D plugins/hfp_hf_bluez4.c plugins/bluez4.h
 =

-builtin_modules +=3D hfp_ag_bluez4
-builtin_sources +=3D plugins/hfp_ag_bluez4.c plugins/bluez4.h
-
 builtin_modules +=3D dun_gw_bluez4
 builtin_sources +=3D plugins/dun_gw_bluez4.c plugins/bluez4.h
+else
+builtin_modules +=3D hfp_bluez5
+builtin_sources +=3D plugins/hfp_hf_bluez5.c plugins/bluez5.h
+
+builtin_modules +=3D dun_gw_bluez5
+builtin_sources +=3D plugins/dun_gw_bluez5.c plugins/bluez5.h
+endif
+endif
+endif
+
+if BLUETOOTH
+if BLUEZ4
+builtin_modules +=3D bluez4
+builtin_sources +=3D plugins/bluez4.c plugins/bluez4.h
+
+builtin_modules +=3D hfp_ag_bluez4
+builtin_sources +=3D plugins/hfp_ag_bluez4.c plugins/bluez4.h
 =

 builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
@@ -503,15 +514,8 @@ else
 builtin_modules +=3D bluez5
 builtin_sources +=3D plugins/bluez5.c plugins/bluez5.h
 =

-builtin_modules +=3D hfp_bluez5
-builtin_sources +=3D plugins/hfp_hf_bluez5.c plugins/bluez5.h
-
 builtin_modules +=3D hfp_ag_bluez5
 builtin_sources +=3D plugins/hfp_ag_bluez5.c plugins/bluez5.h
-
-builtin_modules +=3D dun_gw_bluez5
-builtin_sources +=3D plugins/dun_gw_bluez5.c plugins/bluez5.h
-endif
 endif
 endif
 =

-- =

2.1.4


--===============4561404786868194571==--

