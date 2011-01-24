Content-Type: multipart/mixed; boundary="===============2578188463517098859=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/3] Use pkglibdir where applicable
Date: Mon, 24 Jan 2011 14:50:37 +0200
Message-ID: <1295873437-5859-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2578188463517098859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9933e32..f941a19 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -366,7 +366,7 @@ BUILT_SOURCES =3D $(local_headers)
 =

 CLEANFILES =3D src/builtin.h $(BUILT_SOURCES) $(rules_DATA)
 =

-plugindir =3D $(libdir)/ofono/plugins
+plugindir =3D $(pkglibdir)/plugins
 =

 if MAINTAINER_MODE
 build_plugindir =3D $(abs_top_srcdir)/plugins/.libs
-- =

1.7.1


--===============2578188463517098859==--

