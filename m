Content-Type: multipart/mixed; boundary="===============9220246802420092166=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/4] build: Do not use the deprecated AM_PROG_MKDIR_P
Date: Thu, 10 Jan 2013 13:28:07 -0200
Message-ID: <1357831689-28679-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1357831689-28679-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9220246802420092166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

configure.ac:25: warning: The 'AM_PROG_MKDIR_P' macro is deprecated, and wi=
ll soon be removed.
configure.ac:25: You should use the Autoconf-provided 'AC_PROG_MKDIR_P' mac=
ro instead,
configure.ac:25: and use '$(MKDIR_P)' instead of '$(mkdir_p)'in your Makefi=
le.am files.

We were already using MKDIR_P everywhere.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index badbf9b..e4561b9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -22,7 +22,7 @@ AC_PROG_CC
 AM_PROG_CC_C_O
 AC_PROG_CC_PIE
 AC_PROG_INSTALL
-AM_PROG_MKDIR_P
+AC_PROG_MKDIR_P
 =

 m4_define([_LT_AC_TAGCONFIG], [])
 m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
-- =

1.8.1


--===============9220246802420092166==--

