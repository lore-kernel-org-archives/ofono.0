Content-Type: multipart/mixed; boundary="===============0411602748332802988=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim v2 5/8] configure.ac: fix checking for host_bins
 variable
Date: Sun, 27 Oct 2019 17:30:06 +0100
Message-ID: <20191027163009.13406-6-jbb.prv@gmx.de>
In-Reply-To: <20191027163009.13406-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0411602748332802988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Jansa <Martin.Jansa@gmail.com>

$PKG_CONFIG --variable=3Dhost_bins Qt5Core
returns absolute path without the prefix to sysroot when cross compiling

Before https://github.com/meta-qt5/meta-qt5/commit/b716195f609de6547cfdfadf=
d4fd25292a6bbf09
this will return:

pkg-config --variable=3Dhost_bins Qt5Core
/usr/bin/qt5

which is bad, but is replaced with ${OE_QMAKE_PATH_EXTERNAL_HOST_BINS}
in the generated Makefile after configure as in:
https://github.com/webOS-ports/meta-webos-ports/blob/e4283e7906e3fbd2e0bcff=
cd317d2d1a9e2ebcd5/meta-luneos/recipes-connectivity/ofono/phonesim_1.20.bb#=
L22

but with empty QT_DIR_NAME the returned value is:
pkg-config --variable=3Dhost_bins Qt5Core
/usr/bin

and these 2 replaces fail, causing
make: /usr/bin/uic: Command not found

Use PKG_CHECK_VAR for host_bins which we can override with
OE_QMAKE_PATH_EXTERNAL_HOST_BINS from the environment and
the generated Mafile will be correct right away.

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 configure.ac | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4eb969a..e339691 100644
--- a/configure.ac
+++ b/configure.ac
@@ -31,13 +31,18 @@ CXXFLAGS=3D"$CXXFLAGS --std=3Dgnu++11"
 AC_SUBST(QT_CFLAGS)
 AC_SUBST(QT_LIBS)

+AC_MSG_CHECKING(for Qt5 host_bins)
+PKG_CHECK_VAR(QMAKE_PATH_HOST_BINS, Qt5Core, host_bins)
+AC_SUBST(QMAKE_PATH_HOST_BINS)
+AC_MSG_RESULT($QMAKE_PATH_HOST_BINS)
+
 AC_MSG_CHECKING(for moc)
-MOC=3D"`$PKG_CONFIG --variable=3Dhost_bins Qt5Core`/moc"
+MOC=3D"$QMAKE_PATH_HOST_BINS/moc"
 AC_SUBST(MOC)
 AC_MSG_RESULT($MOC)

 AC_MSG_CHECKING(for uic)
-UIC=3D"`$PKG_CONFIG --variable=3Dhost_bins Qt5Core`/uic"
+UIC=3D"$QMAKE_PATH_HOST_BINS/uic"
 AC_SUBST(UIC)
 AC_MSG_RESULT($UIC)

--
2.23.0

--===============0411602748332802988==--

