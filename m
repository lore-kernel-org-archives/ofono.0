Content-Type: multipart/mixed; boundary="===============5161318763043341595=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 1/1] Install default.xml file to /usr/share/phonesim
Date: Mon, 15 Mar 2010 13:41:28 +0800
Message-ID: <1268631688-4946-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5161318763043341595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index fcee5e6..34198a5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -45,7 +45,9 @@ INCLUDES =3D -I$(top_srcdir)/src -I$(top_builddir)/src
 =

 CLEANFILES =3D src/control.moc $(nodist_src_phonesim_SOURCES)
 =

-EXTRA_DIST =3D src/controlbase.ui src/default.xml src/GSMSpecification.xml
+dist_pkgdata_DATA =3D src/default.xml
+
+EXTRA_DIST =3D src/controlbase.ui src/GSMSpecification.xml
 =

 MAINTAINERCLEANFILES =3D Makefile.in \
 	aclocal.m4 configure depcomp missing install-sh
-- =

1.6.1.3


--===============5161318763043341595==--

