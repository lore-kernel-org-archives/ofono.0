Content-Type: multipart/mixed; boundary="===============0847964060234978320=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: [PATCH 1/2] Added rules to disable SQLite history plugin
Date: Tue, 06 Apr 2010 12:37:08 +0200
Message-ID: <4BBB0ED4.7030300@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0847964060234978320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am  |   10 ++++++++++
 configure.ac |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ee10095..adff96f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -222,6 +222,16 @@ builtin_modules +=3D example_history
 builtin_sources +=3D plugins/example_history.c
 endif
 =

+if SQLITEHISTORY
+builtin_modules +=3D sqlite_history
+builtin_sources +=3D plugins/sqlite_history.c
+builtin_cflags +=3D @SQLITE3_CFLAGS@
+builtin_libadd +=3D @SQLITE3_LIBS@
+
+sqlitescriptsdir =3D $(localstatedir)/lib/ofono
+sqlitescripts_DATA =3D plugins/*.sql
+endif
+
 sbin_PROGRAMS =3D src/ofonod
 =

 src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sources) \
diff --git a/configure.ac b/configure.ac
index d2f921f..997ee9f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -151,6 +151,15 @@ AC_ARG_ENABLE(datafiles, =

AC_HELP_STRING([--disable-datafiles],
 =

 AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" !=3D "no")
 =

+AC_ARG_ENABLE(sqlitehistory, AC_HELP_STRING([--disable-sqlitehistory],
+            [don't install sqlite history plugin]),
+                    [enable_sqlitehistory=3D${enableval}])
+
+AM_CONDITIONAL(SQLITEHISTORY, test "${enable_sqlitehistory}" !=3D "no")
+if (test "${enable_sqlitehistory}" !=3D "no"); then
+    PKG_CHECK_MODULES(SQLITE3, sqlite3)
+fi
+
 if (test "${prefix}" =3D "NONE"); then
     dnl no prefix and no localstatedir, so default to /var
     if (test "$localstatedir" =3D '${prefix}/var'); then
-- =

1.6.3.3


--===============0847964060234978320==--

