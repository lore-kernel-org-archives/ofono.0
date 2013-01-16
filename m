Content-Type: multipart/mixed; boundary="===============7904631653203407022=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/3] build: Use AM_CPPFLAGS instead of INCLUDES
Date: Wed, 16 Jan 2013 19:11:23 -0200
Message-ID: <1358370684-22649-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1358370684-22649-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7904631653203407022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Makefile.am:518: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or =
'*_CPPFLAGS')
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index ad12c0f..f24cac7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -528,7 +528,7 @@ AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ @USB_CFLAGS@ \
 					-DOFONO_PLUGIN_BUILTIN \
 					-DPLUGINDIR=3D\""$(build_plugindir)"\"
 =

-INCLUDES =3D -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
+AM_CPPFLAGS =3D -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/gdbus -I$(srcdir)/gisi -I$(srcdir)/gatchat \
 			-I$(srcdir)/btio
 =

-- =

1.8.1.1


--===============7904631653203407022==--

