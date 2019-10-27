Content-Type: multipart/mixed; boundary="===============6915959646913891551=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim v2 1/8] Port to qt5
Date: Sun, 27 Oct 2019 17:30:02 +0100
Message-ID: <20191027163009.13406-2-jbb.prv@gmx.de>
In-Reply-To: <20191027163009.13406-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6915959646913891551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Simon Busch <morphis@gravedo.de>

Signed-off-by: Simon Busch <morphis@gravedo.de>
Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 Makefile.am         | 2 +-
 configure.ac        | 6 +++---
 src/control.cpp     | 4 ++--
 src/qsimcommand.cpp | 2 +-
 src/qsmsmessage.cpp | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2a6fccf..8c99b04 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -46,7 +46,7 @@ nodist_src_phonesim_SOURCES =3D src/ui_controlbase.h \

 src_phonesim_LDADD =3D $(QT_LIBS)

-AM_CXXFLAGS =3D -Wall $(QT_CFLAGS)
+AM_CXXFLAGS =3D -Wall $(QT_CFLAGS) -fPIC -fPIE

 AM_CPPFLAGS =3D -I$(top_srcdir)/src -I$(top_builddir)/src

diff --git a/configure.ac b/configure.ac
index e0152f0..253aa27 100644
--- a/configure.ac
+++ b/configure.ac
@@ -22,18 +22,18 @@ AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-o=
ptimization],
 	fi
 ])

-PKG_CHECK_MODULES(QT, QtCore QtGui QtXml QtNetwork QtScript QtDBus, dummy=
=3Dyes,
+PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Script Qt5DBus Q=
t5Widgets, dummy=3Dyes,
 						AC_MSG_ERROR(Qt is required))
 AC_SUBST(QT_CFLAGS)
 AC_SUBST(QT_LIBS)

 AC_MSG_CHECKING(for moc)
-MOC=3D"`$PKG_CONFIG --variable=3Dmoc_location QtCore`"
+MOC=3D"`$PKG_CONFIG --variable=3Dhost_bins Qt5Core`/moc"
 AC_SUBST(MOC)
 AC_MSG_RESULT($MOC)

 AC_MSG_CHECKING(for uic)
-UIC=3D"`$PKG_CONFIG --variable=3Duic_location QtCore`"
+UIC=3D"`$PKG_CONFIG --variable=3Dhost_bins Qt5Core`/uic"
 AC_SUBST(UIC)
 AC_MSG_RESULT($UIC)

diff --git a/src/control.cpp b/src/control.cpp
index e1838a6..5eb82f1 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -22,7 +22,7 @@
 #include <qslider.h>
 #include <qcheckbox.h>
 #include <qcombobox.h>
-#include <QtGui/qmessagebox.h>
+#include <qmessagebox.h>
 #include <qfiledialog.h>
 #include <Qt>
 #include <qbuffer.h>
@@ -31,7 +31,7 @@
 #include <QFileInfo>
 #include <QFile>
 #include <QDir>
-#include <QtGui/QHeaderView>
+#include <QHeaderView>

 #define TWO_BYTE_MAX 65535
 #define FOUR_CHAR 4
diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index 97e0b28..672ffb9 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -3764,7 +3764,7 @@ void QSimCommand::addExtensionField( int tag, const Q=
ByteArray& value )
 QSimCommandPrivate *QSimCommand::dwrite()
 {
     // If we are the only user of the private object, return it as-is.
-    if ( d->ref =3D=3D 1 )
+    if ( d->ref.load() =3D=3D 1 )
         return d;

     // Create a new private object and copy the current contents into it.
diff --git a/src/qsmsmessage.cpp b/src/qsmsmessage.cpp
index c2eeb29..54885bd 100644
--- a/src/qsmsmessage.cpp
+++ b/src/qsmsmessage.cpp
@@ -365,7 +365,7 @@ QSMSMessage::~QSMSMessage()
 QSMSMessagePrivate *QSMSMessage::dwrite()
 {
     // If we are the only user of the private object, return it as-is.
-    if ( d->ref =3D=3D 1 )
+    if ( d->ref.load() =3D=3D 1 )
         return d;

     // Create a new private object and copy the current contents into it.
--
2.23.0

--===============6915959646913891551==--

