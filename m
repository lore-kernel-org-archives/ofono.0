Content-Type: multipart/mixed; boundary="===============2320389898639369755=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/3] Use dist_ prefix as applicable
Date: Mon, 24 Jan 2011 14:50:49 +0200
Message-ID: <1295873450-5891-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2320389898639369755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f941a19..1f09c11 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -25,17 +25,17 @@ local_headers =3D $(foreach file,$(pkginclude_HEADERS) \
 if DATAFILES
 dbusconfdir =3D @DBUS_CONFDIR@
 =

-dbusconf_DATA =3D src/ofono.conf
+dist_dbusconf_DATA =3D src/ofono.conf
 =

 if SYSTEMD
 systemdunitdir =3D @SYSTEMD_UNITDIR@
 =

-systemdunit_DATA =3D src/ofono.service
+dist_systemdunit_DATA =3D src/ofono.service
 endif
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

@@ -477,9 +477,7 @@ testdir =3D $(pkglibdir)/test
 test_SCRIPTS =3D $(test_scripts)
 endif
 =

-conf_files =3D src/ofono.conf plugins/phonesim.conf
-
-EXTRA_DIST =3D src/genbuiltin $(conf_files) $(udev_files) \
+EXTRA_DIST =3D src/genbuiltin $(udev_files) \
 					$(doc_files) $(test_scripts)
 =

 dist_man_MANS =3D doc/ofonod.8
-- =

1.7.1


--===============2320389898639369755==--

