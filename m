Content-Type: multipart/mixed; boundary="===============4172253584197649572=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 16/19] automake: fix generation of symlinks for headers
Date: Tue, 03 Aug 2010 16:51:05 -0700
Message-ID: <f294a3cc4ef52bcddf24ebe88e0f52f1717186f8.1280879410.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4172253584197649572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

When running 'make distcheck' from a vpath build directory (ie: one
that is not where the source lives), the target headers in
include/ofono are not generated properly due to a typo in the
Makefile.am, that is using _srcdir where _buildir should be being
used.
---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e256841..313c555 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -444,7 +444,7 @@ include/ofono/version.h: include/version.h
 =

 include/ofono/%.h: include/%.h
 	$(AM_V_at)$(MKDIR_P) include/ofono
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
 =

 clean-local:
 	@$(RM) -rf include/ofono
-- =

1.6.6.1


--===============4172253584197649572==--

