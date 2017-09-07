Content-Type: multipart/mixed; boundary="===============1045482790223449773=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/5] autotools: enable maintainer mode by default
Date: Thu, 07 Sep 2017 14:11:32 +0200
Message-ID: <20170907121136.13520-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1045482790223449773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Disabling "maintainer mode" is not particularly useful as it really only
saves people who accidentally touch a build system file in an
unrealistically constrained system where the build tools are uninstalled
and unavailable.

This patch just changes the default to 'enabled' so that the changes to
build system files have the desired effect.

Passing --disable-maintainer-mode to ./configure restores the previous
behaviour for the (likely non-existant) users who actually require to do
so.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 29a01c2..ecd2165 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,7 +6,7 @@ AC_CONFIG_HEADERS(config.h)
 =

 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 =

-AM_MAINTAINER_MODE
+AM_MAINTAINER_MODE([enable])
 =

 AC_PREFIX_DEFAULT(/usr/local)
 =

-- =

2.9.3


--===============1045482790223449773==--

