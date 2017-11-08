Content-Type: multipart/mixed; boundary="===============2352616926178190379=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 3/4] make: added aidapplication module to build
Date: Wed, 08 Nov 2017 09:23:52 -0800
Message-ID: <1510161833-8867-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1510161833-8867-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2352616926178190379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 7feceba..c8814f1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -17,6 +17,7 @@ src_phonesim_SOURCES =3D src/main.cpp \
 			src/qcbsmessage.h src/qcbsmessage.cpp \
 			src/callmanager.h src/callmanager.cpp \
 			src/simauth.h src/simauth.cpp \
+			src/aidapplication.h src/aidapplication.cpp \
 			src/comp128.h src/comp128.c \
 			src/aes.h src/aes.c \
 			src/simfilesystem.h src/simfilesystem.cpp \
@@ -38,6 +39,7 @@ nodist_src_phonesim_SOURCES =3D src/ui_controlbase.h \
 				src/moc_hardwaremanipulator.cpp \
 				src/moc_callmanager.cpp \
 				src/moc_simauth.cpp \
+				src/moc_aidapplication.cpp \
 				src/moc_simfilesystem.cpp \
 				src/moc_simapplication.cpp \
 				src/moc_qwsppdu.cpp
-- =

2.7.4


--===============2352616926178190379==--

