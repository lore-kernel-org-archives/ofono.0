Content-Type: multipart/mixed; boundary="===============0250730496258609327=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 1/1] install data file
Date: Wed, 10 Mar 2010 11:51:09 +0800
Message-ID: <1268193069-15830-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0250730496258609327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index fcee5e6..007d5b9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -45,7 +45,7 @@ INCLUDES =3D -I$(top_srcdir)/src -I$(top_builddir)/src
 =

 CLEANFILES =3D src/control.moc $(nodist_src_phonesim_SOURCES)
 =

-EXTRA_DIST =3D src/controlbase.ui src/default.xml src/GSMSpecification.xml
+dist_pkgdata_DATA =3D src/controlbase.ui src/moblin.xml src/GSMSpecificati=
on.xml
 =

 MAINTAINERCLEANFILES =3D Makefile.in \
 	aclocal.m4 configure depcomp missing install-sh
-- =

1.6.1.3


--===============0250730496258609327==--

