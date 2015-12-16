Content-Type: multipart/mixed; boundary="===============5088712402439129783=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 2/2 v2] build: add support for upower plugin
Date: Wed, 16 Dec 2015 14:50:50 -0500
Message-ID: <1450295450-2565-2-git-send-email-espy@canonical.com>
In-Reply-To: <1450295450-2565-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5088712402439129783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index b22c04b..fa2d5cb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -512,6 +512,8 @@ builtin_sources +=3D plugins/hfp_ag_bluez5.c plugins/bl=
uez5.h
 builtin_modules +=3D dun_gw_bluez5
 builtin_sources +=3D plugins/dun_gw_bluez5.c plugins/bluez5.h
 endif
+builtin_modules +=3D upower
+builtin_sources +=3D plugins/upower.c
 endif
 endif
 =

-- =

2.1.4


--===============5088712402439129783==--

