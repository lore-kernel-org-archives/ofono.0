Content-Type: multipart/mixed; boundary="===============8315861680863824384=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] Make VPATH build work
Date: Thu, 18 Mar 2010 18:40:11 +0800
Message-ID: <1268908811-15532-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8315861680863824384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes, you may need to distinguish the source tree and the build tree, =
when
you want to keep the source tree uncluttered, or you need to build the sour=
ce
with several different configurations, or even your source tree is read onl=
y.
This feature is called VPATH build and the patch is to make this work.
A typical example is as below (Note that the "build" directory can be any n=
ame
and in any place):
> cd ofono && mkdir build && cd build
> ../configure XXX
> make
Then everything you got from the make will reside in "build" directory.
---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index eca8eee..bd74fb7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -374,11 +374,11 @@ $(src_ofonod_OBJECTS) $(unit_objects): $(local_header=
s)
 =

 include/ofono/version.h: include/version.h
 	$(AM_V_at)$(MKDIR_P) include/ofono
-	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
+	$(AM_V_GEN)$(LN_S) $(abs_builddir)/$< $@
 =

 include/ofono/%.h: include/%.h
 	$(AM_V_at)$(MKDIR_P) include/ofono
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+	$(AM_V_GEN)$(LN_S) $(abs_builddir)/$< $@
 =

 clean-local: include/ofono
 	@$(RM) -r $<
-- =

1.6.3.3


--===============8315861680863824384==--

