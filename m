Content-Type: multipart/mixed; boundary="===============7492463633875540588=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/4] build: Use AM_CPPFLAGS instead of INCLUDES
Date: Thu, 10 Jan 2013 13:28:08 -0200
Message-ID: <1357831689-28679-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1357831689-28679-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7492463633875540588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Makefile.am:518: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or =
'*_CPPFLAGS')
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 40a83dc..86a1f30 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -515,7 +515,7 @@ AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ @USB_CFLAGS@ \
 					-DOFONO_PLUGIN_BUILTIN \
 					-DPLUGINDIR=3D\""$(build_plugindir)"\"
 =

-INCLUDES =3D -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
+AM_CPPFLAGS =3D -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/gdbus -I$(srcdir)/gisi -I$(srcdir)/gatchat \
 			-I$(srcdir)/btio
 =

-- =

1.8.1


--===============7492463633875540588==--

