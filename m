Content-Type: multipart/mixed; boundary="===============2642360338279237661=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] Mark ofono/*.h symbolink links as built sources
Date: Mon, 06 Dec 2010 17:49:56 +0200
Message-ID: <1291650596-5554-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2642360338279237661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This forces automake/make to build them first if needed (as before).
But it avoids marking every single header as a dependency of every
single object. Thus we do not need a bogus full rebuild of the tree
everytime a header is added.
---
 Makefile.am |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a4c47e8..cdb3166 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -326,7 +326,9 @@ src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBU=
S_LIBS@ @CAPNG_LIBS@ -ldl
 src_ofonod_LDFLAGS =3D -Wl,--export-dynamic \
 				-Wl,--version-script=3D$(srcdir)/src/ofono.ver
 =

-CLEANFILES =3D src/builtin.h $(local_headers) $(rules_DATA)
+BUILT_SOURCES =3D $(local_headers)
+
+CLEANFILES =3D src/builtin.h $(BUILT_SOURCES) $(rules_DATA)
 =

 plugindir =3D $(libdir)/ofono/plugins
 =

@@ -512,8 +514,6 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
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


--===============2642360338279237661==--

