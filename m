Content-Type: multipart/mixed; boundary="===============7297112594672857222=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 4/5] make: add simauth/aes/comp128 to build
Date: Tue, 03 Oct 2017 09:32:38 -0700
Message-ID: <1507048360-15441-5-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507048360-15441-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7297112594672857222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am  | 4 ++++
 configure.ac | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 8d12c46..7feceba 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -16,6 +16,9 @@ src_phonesim_SOURCES =3D src/main.cpp \
 			src/qsmsmessage.h src/qsmsmessage.cpp \
 			src/qcbsmessage.h src/qcbsmessage.cpp \
 			src/callmanager.h src/callmanager.cpp \
+			src/simauth.h src/simauth.cpp \
+			src/comp128.h src/comp128.c \
+			src/aes.h src/aes.c \
 			src/simfilesystem.h src/simfilesystem.cpp \
 			src/simapplication.h src/simapplication.cpp \
 			src/qgsmcodec.h src/qgsmcodec.cpp \
@@ -34,6 +37,7 @@ nodist_src_phonesim_SOURCES =3D src/ui_controlbase.h \
 				src/moc_phonesim.cpp \
 				src/moc_hardwaremanipulator.cpp \
 				src/moc_callmanager.cpp \
+				src/moc_simauth.cpp \
 				src/moc_simfilesystem.cpp \
 				src/moc_simapplication.cpp \
 				src/moc_qwsppdu.cpp
diff --git a/configure.ac b/configure.ac
index fb3c3a7..e97c573 100644
--- a/configure.ac
+++ b/configure.ac
@@ -11,6 +11,7 @@ AC_PREFIX_DEFAULT(/usr/local)
 =

 PKG_PROG_PKG_CONFIG
 =

+AC_PROG_CC
 AC_PROG_CXX
 AC_PROG_INSTALL
 =

-- =

2.7.4


--===============7297112594672857222==--

