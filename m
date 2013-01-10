Content-Type: multipart/mixed; boundary="===============3351831961689676285=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/4] build: Do not use deprecated AM_CONFIG_HEADER
Date: Thu, 10 Jan 2013 13:28:06 -0200
Message-ID: <1357831689-28679-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3351831961689676285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
Use AC_CONFIG_HEADERS instead.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 2d6247d..badbf9b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,7 +2,7 @@ AC_PREREQ(2.60)
 AC_INIT(ofono, 1.11)
 =

 AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
-AM_CONFIG_HEADER(config.h)
+AC_CONFIG_HEADERS(config.h)
 =

 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 =

-- =

1.8.1


--===============3351831961689676285==--

