Content-Type: multipart/mixed; boundary="===============3260727294289427018=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH] Fix: clean-local target
Date: Thu, 22 Apr 2010 14:26:16 +0300
Message-ID: <1271935576-8472-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3260727294289427018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 86ccf1b..db7e33e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -426,5 +426,5 @@ include/ofono/%.h: include/%.h
 	$(AM_V_at)$(MKDIR_P) include/ofono
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 =

-clean-local: include/ofono
-	@$(RM) -r $<
+clean-local:
+	$(RM) -rf include/ofono
-- =

1.6.3.3


--===============3260727294289427018==--

