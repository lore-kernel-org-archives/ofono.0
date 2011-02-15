Content-Type: multipart/mixed; boundary="===============2864789062690383433=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Makefile: rerun genbuiltin on reconfigure.
Date: Tue, 15 Feb 2011 09:55:52 +0100
Message-ID: <1297760152-19815-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1297760152-19815-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2864789062690383433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make builtin.h depend on config.status to force regeneration when
plugins may have been enabled or disabled.  There may be a better
way to do that.  The dependency on builtin_sources is not needed.
---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 42ad86f..3182fbb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -571,7 +571,7 @@ MAINTAINERCLEANFILES =3D Makefile.in \
 =

 src/plugin.$(OBJEXT): src/builtin.h
 =

-src/builtin.h: src/genbuiltin $(builtin_sources)
+src/builtin.h: src/genbuiltin config.status
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 =

 plugins/%.rules:
-- =

1.7.1.86.g0e460.dirty


--===============2864789062690383433==--

