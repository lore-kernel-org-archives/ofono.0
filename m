Content-Type: multipart/mixed; boundary="===============5509069578061990501=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim v3 1/2] Port to qt5
Date: Wed, 30 Oct 2019 21:37:19 +0100
Message-ID: <20191030203720.10302-1-jbb.prv@gmx.de>
In-Reply-To: <e57bde4b-b8ef-8beb-78b3-a8f702271153@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5509069578061990501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Simon Busch <morphis@gravedo.de>

Co-authored-by: Martin Jansa <Martin.Jansa@gmail.com>
Co-authored-by: Jonah Br=C3=BCchert <jbb.prv@gmx.de>
Co-authored-by: Alexander Akulich <akulichalexander@gmail.com>
---
 Makefile.am         |  4 +++-
 configure.ac        | 15 ++++++++++++---
 src/control.cpp     |  4 ++--
 src/phonesim.cpp    |  2 +-
 src/phonesim.h      |  2 +-
 src/qsimcommand.cpp |  2 +-
 src/qsmsmessage.cpp |  6 +++---
 src/server.cpp      |  2 +-
 src/server.h        |  2 +-
 9 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2a6fccf..74cf657 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -46,7 +46,7 @@ nodist_src_phonesim_SOURCES =3D src/ui_controlbase.h \

 src_phonesim_LDADD =3D $(QT_LIBS)

-AM_CXXFLAGS =3D -Wall $(QT_CFLAGS)
+AM_CXXFLAGS =3D -Wall $(QT_CFLAGS) -fPIC

 AM_CPPFLAGS =3D -I$(top_srcdir)/src -I$(top_builddir)/src

@@ -67,6 +67,7 @@ QT_V_MOC_  =3D $(QT_V_MOC_$(AM_DEFAULT_VERBOSITY))
 QT_V_MOC_0 =3D @echo "  MOC     " $@;

 src/moc_%.cpp: src/%.h
+	$(MKDIR_P) src
 	$(QT_V_MOC)$(MOC) $< -o $@

 QT_V_UIC   =3D $(QT_V_UIC_$(V))
@@ -74,4 +75,5 @@ QT_V_UIC_  =3D $(QT_V_UIC_$(AM_DEFAULT_VERBOSITY))
 QT_V_UIC_0 =3D @echo "  UIC     " $@;

 src/ui_%.h: src/%.ui
+	$(MKDIR_P) src
 	$(QT_V_UIC)$(UIC) $< -o $@
diff --git a/configure.ac b/configure.ac
index e0152f0..e339691 100644
--- a/configure.ac
+++ b/configure.ac
@@ -22,18 +22,27 @@ AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-o=
ptimization],
 	fi
 ])

-PKG_CHECK_MODULES(QT, QtCore QtGui QtXml QtNetwork QtScript QtDBus, dummy=
=3Dyes,
+PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Script Qt5DBus Q=
t5Widgets, dummy=3Dyes,
 						AC_MSG_ERROR(Qt is required))
+
+# Needed for Qt 5.7
+CXXFLAGS=3D"$CXXFLAGS --std=3Dgnu++11"
+
 AC_SUBST(QT_CFLAGS)
 AC_SUBST(QT_LIBS)

+AC_MSG_CHECKING(for Qt5 host_bins)
+PKG_CHECK_VAR(QMAKE_PATH_HOST_BINS, Qt5Core, host_bins)
+AC_SUBST(QMAKE_PATH_HOST_BINS)
+AC_MSG_RESULT($QMAKE_PATH_HOST_BINS)
+
 AC_MSG_CHECKING(for moc)
-MOC=3D"`$PKG_CONFIG --variable=3Dmoc_location QtCore`"
+MOC=3D"$QMAKE_PATH_HOST_BINS/moc"
 AC_SUBST(MOC)
 AC_MSG_RESULT($MOC)

 AC_MSG_CHECKING(for uic)
-UIC=3D"`$PKG_CONFIG --variable=3Duic_location QtCore`"
+UIC=3D"$QMAKE_PATH_HOST_BINS/uic"
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
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 0e446f6..f14281b 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -516,7 +516,7 @@ static bool readXmlFile( SimXmlHandler *handler, const =
QString& filename )
     return !reader.hasError();
 }

-SimRules::SimRules( int fd, QObject *p,  const QString& filename, Hardware=
ManipulatorFactory *hmf )
+SimRules::SimRules(qintptr fd, QObject *p,  const QString& filename, Hardw=
areManipulatorFactory *hmf )
     : QTcpSocket(p)
 {
     setSocketDescriptor(fd);
diff --git a/src/phonesim.h b/src/phonesim.h
index c8bcaad..466f88d 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -247,7 +247,7 @@ class SimRules : public QTcpSocket
 {
     Q_OBJECT
 public:
-    SimRules(int fd, QObject *parent, const QString& filename, HardwareMan=
ipulatorFactory *hmf );
+    SimRules(qintptr fd, QObject *parent, const QString& filename, Hardwar=
eManipulatorFactory *hmf );
     ~SimRules() {}

     // get the variable value for.
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
index c2eeb29..63d6952 100644
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
@@ -2594,8 +2594,8 @@ QCBSMessage QCBSDeliverMessage::unpack(QTextCodec *co=
dec)
     QString text =3D userData
         ( (QSMSDataCodingScheme)scheme, codec, headers, false, true );
     len =3D text.length();
-    while ( len > 0 && ( text[len - 1] =3D=3D '\r' || text[len - 1] =3D=3D=
 '\n' ||
-                         text[len - 1] =3D=3D '\0' ) ) {
+    while ( len > 0 && ( text.at(len - 1) =3D=3D QChar ('\r') || text.at(l=
en - 1) =3D=3D QChar ('\n') ||
+                         text.at(len - 1) =3D=3D QChar ('\0') ) ) {
         --len;
     }
     m.setText( text.left( len ) );
diff --git a/src/server.cpp b/src/server.cpp
index cd68969..62487ee 100644
--- a/src/server.cpp
+++ b/src/server.cpp
@@ -44,7 +44,7 @@ void PhoneSimServer::setHardwareManipulator(HardwareManip=
ulatorFactory *f)
         f->setRuleFile(filename);
 }

-void PhoneSimServer::incomingConnection(int s)
+void PhoneSimServer::incomingConnection(qintptr s)
 {
   SimRules *sr =3D new SimRules(s, this, filename, fact);
     sr->setPhoneNumber(QString::number(phonenumber));
diff --git a/src/server.h b/src/server.h
index 5915cc1..3342a90 100644
--- a/src/server.h
+++ b/src/server.h
@@ -40,7 +40,7 @@ public:
     SimRules *rules() const { return currentRules; }

 protected:
-    void incomingConnection(int s);
+    void incomingConnection(qintptr s);

 private:
     QString filename;
--
2.23.0

--===============5509069578061990501==--

