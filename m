Content-Type: multipart/mixed; boundary="===============6447181699868326228=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Fix build outside of tree after linker script change
Date: Tue, 21 Sep 2010 13:40:54 -0300
Message-ID: <1285087254-28185-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6447181699868326228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let configure generate connman.ver file and copy it to the build
directory.
---
 .gitignore       |    1 +
 configure.ac     |    2 +-
 src/ofono.ver    |    7 -------
 src/ofono.ver.in |    7 +++++++
 4 files changed, 9 insertions(+), 8 deletions(-)
 delete mode 100644 src/ofono.ver
 create mode 100644 src/ofono.ver.in

diff --git a/.gitignore b/.gitignore
index 472522b..6902d1a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -27,6 +27,7 @@ include/ofono
 include/version.h
 src/builtin.h
 src/ofonod
+src/ofono.ver
 =

 unit/test-common
 unit/test-util
diff --git a/configure.ac b/configure.ac
index fb78a8e..571b198 100644
--- a/configure.ac
+++ b/configure.ac
@@ -175,4 +175,4 @@ fi
 AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 			[Directory for the configuration files])
 =

-AC_OUTPUT(Makefile include/version.h)
+AC_OUTPUT(Makefile include/version.h src/ofono.ver)
diff --git a/src/ofono.ver b/src/ofono.ver
deleted file mode 100644
index 3dce6f3..0000000
--- a/src/ofono.ver
+++ /dev/null
@@ -1,7 +0,0 @@
-{
-	global:
-		ofono_*;
-		g_dbus_*;
-	local:
-		*;
-};
diff --git a/src/ofono.ver.in b/src/ofono.ver.in
new file mode 100644
index 0000000..3dce6f3
--- /dev/null
+++ b/src/ofono.ver.in
@@ -0,0 +1,7 @@
+{
+	global:
+		ofono_*;
+		g_dbus_*;
+	local:
+		*;
+};
-- =

1.7.2.3


--===============6447181699868326228==--

