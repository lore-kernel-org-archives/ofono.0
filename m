Content-Type: multipart/mixed; boundary="===============2627588032131241241=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim v2 3/8] configure.ac: use gnu++11 to fix build with
 Qt 5.7
Date: Sun, 27 Oct 2019 17:30:04 +0100
Message-ID: <20191027163009.13406-4-jbb.prv@gmx.de>
In-Reply-To: <20191027163009.13406-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2627588032131241241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Jansa <Martin.Jansa@gmail.com>

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 configure.ac | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index 253aa27..4eb969a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -24,6 +24,10 @@ AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-op=
timization],

 PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Script Qt5DBus Q=
t5Widgets, dummy=3Dyes,
 						AC_MSG_ERROR(Qt is required))
+
+# Needed for Qt 5.7
+CXXFLAGS=3D"$CXXFLAGS --std=3Dgnu++11"
+
 AC_SUBST(QT_CFLAGS)
 AC_SUBST(QT_LIBS)

--
2.23.0

--===============2627588032131241241==--

