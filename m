Content-Type: multipart/mixed; boundary="===============3635107037452031220=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/2] Allow distcheck to work without bluetooth
Date: Wed, 19 Jan 2011 12:31:05 +0200
Message-ID: <1295433065-26502-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3635107037452031220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index c1c34ca..e93076a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -550,6 +550,9 @@ gatchat_test_qcdm_LDADD =3D @GLIB_LIBS@
 =

 =

 DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles
+if !BLUETOOTH
+DISTCHECK_CONFIGURE_FLAGS +=3D --disable-bluetooth
+endif
 =

 MAINTAINERCLEANFILES =3D Makefile.in \
 	aclocal.m4 configure config.h.in config.sub config.guess \
-- =

1.7.1


--===============3635107037452031220==--

