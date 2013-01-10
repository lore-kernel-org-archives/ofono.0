Content-Type: multipart/mixed; boundary="===============3265867138281572978=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 3/3] build: Use AM_CPPFLAGS instead of INCLUDES
Date: Thu, 10 Jan 2013 13:11:11 -0200
Message-ID: <1357830671-10783-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1357830671-10783-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3265867138281572978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Makefile.am:49: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '=
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

1.8.1


--===============3265867138281572978==--

