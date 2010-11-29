Content-Type: multipart/mixed; boundary="===============0867458169371648134=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] Mark ofono/*.h symbolink links as built sources
Date: Mon, 29 Nov 2010 11:02:16 +0200
Message-ID: <1291021336-32666-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0867458169371648134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This forces automake/make to build them first if needed (as before).
But it avoids marking every single header as a dependency of every
single object. Thus we do not need a bogus full rebuild of the tree
everytime a header is added.
---
 Makefile.am |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a4c47e8..ee7949d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -326,7 +326,8 @@ src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBU=
S_LIBS@ @CAPNG_LIBS@ -ldl
 src_ofonod_LDFLAGS =3D -Wl,--export-dynamic \
 				-Wl,--version-script=3D$(srcdir)/src/ofono.ver
 =

-CLEANFILES =3D src/builtin.h $(local_headers) $(rules_DATA)
+BUILT_SOURCES =3D $(local_headers)
+CLEANFILES =3D src/builtin.h $(BUILT_SOURCES) $(rules_DATA)
 =

 plugindir =3D $(libdir)/ofono/plugins
 =

@@ -512,8 +513,6 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 plugins/%.rules:
 	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
 =

-$(src_ofonod_OBJECTS) $(unit_objects): $(local_headers)
-
 include/ofono/version.h: include/version.h
 	$(AM_V_at)$(MKDIR_P) include/ofono
 	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
-- =

1.7.1


--===============0867458169371648134==--

