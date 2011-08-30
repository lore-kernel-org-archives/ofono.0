Content-Type: multipart/mixed; boundary="===============8662491720953395124=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [VPATH PATCH 1/2] Fix generating links in Makefile.am
Date: Tue, 30 Aug 2011 15:20:17 +0300
Message-ID: <1314706818-9720-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1314706818-9720-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8662491720953395124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

In case relative dependency is in $(srcdir), $< already includes path to
$(srcdir).
---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 5019b7d..832c8ac 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -666,9 +666,9 @@ include/ofono/version.h: include/version.h
 	$(AM_V_at)$(MKDIR_P) include/ofono
 	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
 =

-include/ofono/%.h: include/%.h
+include/ofono/%.h: $(abs_top_srcdir)/include/%.h
 	$(AM_V_at)$(MKDIR_P) include/ofono
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+	$(AM_V_GEN)$(LN_S) $< $@
 =

 clean-local:
 	@$(RM) -rf include/ofono
-- =

1.7.4.1


--===============8662491720953395124==--

