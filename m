Content-Type: multipart/mixed; boundary="===============5789409071817286148=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 4/4] Makefile: add connman plugin build
Date: Fri, 22 Apr 2011 12:02:43 +0200
Message-ID: <1303466563-3111-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1303466563-3111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5789409071817286148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2886b5d..86f5662 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -339,6 +339,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetooth=
.h
 builtin_modules +=3D dun_gw
 builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
 =

+builtin_modules +=3D connman
+builtin_sources +=3D plugins/connman.c
+
 builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
-- =

1.7.1


--===============5789409071817286148==--

