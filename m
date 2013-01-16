Content-Type: multipart/mixed; boundary="===============6616756909046988545=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/3] build: Do not use deprecated AM_CONFIG_HEADER
Date: Wed, 16 Jan 2013 19:11:22 -0200
Message-ID: <1358370684-22649-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6616756909046988545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
Use AC_CONFIG_HEADERS instead.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 7db4198..a4a350f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,7 +2,7 @@ AC_PREREQ(2.60)
 AC_INIT(ofono, 1.12)
 =

 AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
-AM_CONFIG_HEADER(config.h)
+AC_CONFIG_HEADERS(config.h)
 =

 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 =

-- =

1.8.1.1


--===============6616756909046988545==--

