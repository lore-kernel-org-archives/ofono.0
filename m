Content-Type: multipart/mixed; boundary="===============6345240694615062133=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/2] Use dist_ prefix as applicable
Date: Wed, 26 Jan 2011 13:09:31 +0200
Message-ID: <1296040172-19180-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6345240694615062133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f941a19..71365d7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -25,7 +25,7 @@ local_headers =3D $(foreach file,$(pkginclude_HEADERS) \
 if DATAFILES
 dbusconfdir =3D @DBUS_CONFDIR@
 =

-dbusconf_DATA =3D src/ofono.conf
+dist_dbusconf_DATA =3D src/ofono.conf
 =

 if SYSTEMD
 systemdunitdir =3D @SYSTEMD_UNITDIR@
@@ -35,7 +35,7 @@ endif
 =

 confdir =3D $(sysconfdir)/ofono
 =

-conf_DATA =3D
+dist_conf_DATA =3D
 =

 statedir =3D $(localstatedir)/lib/ofono
 =

@@ -244,7 +244,7 @@ builtin_modules +=3D phonesim
 builtin_sources +=3D plugins/phonesim.c
 =

 if DATAFILES
-conf_DATA +=3D plugins/phonesim.conf
+dist_conf_DATA +=3D plugins/phonesim.conf
 endif
 endif
 =

@@ -477,10 +477,7 @@ testdir =3D $(pkglibdir)/test
 test_SCRIPTS =3D $(test_scripts)
 endif
 =

-conf_files =3D src/ofono.conf plugins/phonesim.conf
-
-EXTRA_DIST =3D src/genbuiltin $(conf_files) $(udev_files) \
-					$(doc_files) $(test_scripts)
+EXTRA_DIST =3D src/genbuiltin $(udev_files) $(doc_files) $(test_scripts)
 =

 dist_man_MANS =3D doc/ofonod.8
 =

-- =

1.7.1


--===============6345240694615062133==--

