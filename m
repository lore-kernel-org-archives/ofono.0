Content-Type: multipart/mixed; boundary="===============8960739921301082205=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/2] Support option --disable-optimization
Date: Thu, 08 Jul 2010 18:57:18 +0800
Message-ID: <1278586639-6329-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8960739921301082205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 887c91a..a85fda3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -14,6 +14,13 @@ PKG_PROG_PKG_CONFIG
 AC_PROG_CXX
 AC_PROG_INSTALL
 =

+AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
+			[disable code optimization through compiler]), [
+	if (test "${enableval}" =3D "no"); then
+		CXXFLAGS=3D"$CXXFLAGS -O0"
+	fi
+])
+
 PKG_CHECK_MODULES(QT, QtCore QtGui QtXml QtNetwork, dummy=3Dyes,
 						AC_MSG_ERROR(Qt is required))
 AC_SUBST(QT_CFLAGS)
-- =

1.7.0.4


--===============8960739921301082205==--

