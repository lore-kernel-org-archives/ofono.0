Content-Type: multipart/mixed; boundary="===============1882354572316375030=="
MIME-Version: 1.0
From: Adrian Bunk <bunk@kernel.org>
Subject: [PATCH] Makefile.am: Fix a race condition where ell/ell.h was written
 before ell/ existed
Date: Thu, 09 May 2019 12:19:51 +0300
Message-ID: <20190509091952.17075-1-bunk@kernel.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1882354572316375030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index a569c4a3..d2e310d5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1107,6 +1107,7 @@ ell/internal: Makefile
 	done > $@
 =

 ell/ell.h: Makefile
+	$(AM_V_at)$(MKDIR_P) ell
 	$(AM_V_at)echo -n > $@
 	$(AM_V_GEN)for f in $(ell_headers) ; do \
 		echo "#include <$$f>" >> $@ ; \
-- =

2.20.1


--===============1882354572316375030==--

