Content-Type: multipart/mixed; boundary="===============6494615240332684487=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 1/3] build: Don't use deprecated INCLUDES variable
Date: Fri, 19 Jul 2013 16:33:05 -0300
Message-ID: <1374262387-27803-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6494615240332684487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lucas De Marchi <lucas.demarchi@intel.com>

Makefile.am:53: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '=
*_CPPFLAGS')
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index f802388..ee2c715 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -46,7 +46,7 @@ AM_CFLAGS =3D @GLIB_CFLAGS@ @DBUS_CFLAGS@ $(builtin_cflag=
s) \
 					-DPLUGINDIR=3D\""$(plugindir)"\" \
 					-DPUSHCONFDIR=3D\""$(pushconfdir)"\"
 =

-INCLUDES =3D -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/gdbus
+AM_CPPFLAGS =3D -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/gdbus
 =

 CLEANFILES =3D src/builtin.h
 =

-- =

1.8.3.3


--===============6494615240332684487==--

