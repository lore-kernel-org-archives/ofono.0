Content-Type: multipart/mixed; boundary="===============6030160366878005370=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 2/3] build: Do not use deprecated AM_CONFIG_HEADER
Date: Thu, 14 Feb 2013 12:18:12 -0200
Message-ID: <1360851493-31131-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1360851493-31131-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6030160366878005370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
Use AC_CONFIG_HEADERS instead.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6b5e1b1..dd8e93a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,7 +2,7 @@ AC_PREREQ(2.60)
 AC_INIT(mmsd, 0.0)
 =

 AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
-AM_CONFIG_HEADER(config.h)
+AC_CONFIG_HEADERS(config.h)
 =

 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 =

-- =

1.8.1.3


--===============6030160366878005370==--

