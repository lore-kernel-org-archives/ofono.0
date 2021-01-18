Content-Type: multipart/mixed; boundary="===============1002553165216619652=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 6/7] Port to Qt 6
Date: Mon, 18 Jan 2021 17:46:20 +0100
Message-ID: <20210118164621.52831-7-jbb.prv@gmx.de>
In-Reply-To: <20210118164621.52831-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1002553165216619652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 CMakeLists.txt              | 10 +++++++---
 src/CMakeLists.txt          |  6 +++++-
 src/control.cpp             |  8 +++-----
 src/hardwaremanipulator.cpp |  1 -
 src/phonesim.cpp            |  2 +-
 src/qsimcommand.cpp         |  2 +-
 src/qwsppdu.cpp             | 12 ++++++------
 7 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9de202a..edff85d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -5,14 +5,18 @@ set(PHONESIM_VERSION 1.21)
 include(FeatureSummary)
 include(GNUInstallDirs)

-find_package(Qt5 "5.10.0" REQUIRED NO_MODULE COMPONENTS Core Widgets Qml N=
etwork DBus)
+find_package(Qt6 "6.0.0" NO_MODULE COMPONENTS Core Widgets Qml Network DBu=
s Core5Compat)
+
+if(NOT Qt6_FOUND)
+    find_package(Qt5 "5.10.0" REQUIRED NO_MODULE COMPONENTS Core Widgets Q=
ml Network DBus)
+endif()

 set(CMAKE_AUTOMOC ON)
 set(CMAKE_AUTOUIC ON)

-################# Enable C++14 #################
+################# Enable C++17 #################

-set(CMAKE_CXX_STANDARD 14)
+set(CMAKE_CXX_STANDARD 17)

 ################# build and install #################
 add_subdirectory(src)
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 6d7ebf5..d17459a 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -34,7 +34,11 @@ set(CMAKE_INCLUDE_CURRENT_DIR ON)

 add_executable(phonesim ${PHONESIM_SRCS})
 target_compile_definitions(phonesim PRIVATE -DVERSION=3D${PHONESIM_VERSION=
} -DQT_NO_FOREACH)
-target_link_libraries(phonesim Qt5::Core Qt5::Widgets Qt5::Qml Qt5::Networ=
k Qt5::DBus)
+if(Qt6_FOUND)
+    target_link_libraries(phonesim Qt6::Core Qt6::Widgets Qt6::Qml Qt6::Ne=
twork Qt6::DBus Qt6::Core5Compat)
+else()
+    target_link_libraries(phonesim Qt5::Core Qt5::Widgets Qt5::Qml Qt5::Ne=
twork Qt5::DBus)
+endif()

 install(TARGETS phonesim RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
 install(FILES default.xml DESTINATION ${CMAKE_INSTALL_DATADIR}/phonesim/)
diff --git a/src/control.cpp b/src/control.cpp
index 817a0b2..d45ff91 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -24,7 +24,6 @@
 #include <qcombobox.h>
 #include <qmessagebox.h>
 #include <qfiledialog.h>
-#include <Qt>
 #include <qbuffer.h>
 #include <qtimer.h>
 #include <qevent.h>
@@ -337,7 +336,7 @@ void ControlWidget::sendSMSMessage()
         return;
     }

-    if (ui->leSMSServiceCenter->text().isEmpty() || ui->leSMSServiceCenter=
->text().contains(QRegExp("\\D"))) {
+    if (ui->leSMSServiceCenter->text().isEmpty() || ui->leSMSServiceCenter=
->text().contains(QRegularExpression(R"(\D)"))) {
         p->warning(tr("Invalid Service Center"),
                 tr("Service Center must not be empty and contain "
                    "only digits"));
@@ -386,14 +385,14 @@ void ControlWidget::selectFile()
 void ControlWidget::sendSMSDatagram()
 {
     QString dstPortStr =3D ui->leDstPort->text();
-    if ( dstPortStr.contains(QRegExp("\\D")) ) {
+    if ( dstPortStr.contains(QRegularExpression(R"(\D)")) ) {
         p->warning(tr("Invalid Port"), tr("Port number can contain only di=
gits" ));
         return;
     }
     int dst =3D dstPortStr.toInt();

     QString srcPortStr =3D ui->leSrcPort->text();
-    if ( srcPortStr.contains(QRegExp("\\D")) ) {
+    if ( srcPortStr.contains(QRegularExpression(R"(\D)")) ) {
         p->warning(tr("Invalid Port"), tr("Port number can contain only di=
gits" ));
         return;
     }
@@ -700,7 +699,6 @@ QString Script::Run(const QString &name, const QDBusMes=
sage &msg)
     }

     QTextStream stream(&scriptFile);
-    stream.setCodec("UTF-8");
     QString contents =3D stream.readAll();
     scriptFile.close();

diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index a8a9bfe..7a5d30b 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -18,7 +18,6 @@
 **************************************************************************=
**/

 #include "hardwaremanipulator.h"
-#include <Qt>
 #include <qdebug.h>
 #include <qbuffer.h>
 #include <qtimer.h>
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 89d5e9d..1b826ed 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -346,7 +346,7 @@ bool SimChat::command( const QString& cmd )
         else {
             int index =3D value.indexOf( "${*}" );
             if ( index !=3D -1 ) {
-                if ( wild.length() > 0 && wild[wild.length() - 1] =3D=3D 0=
x1A ) {
+                if ( wild.length() > 0 && wild[wild.length() - 1] =3D=3D Q=
Char(0x1A) ) {
                     // Strip the terminating ^Z from SMS PDU's.
                     wild =3D wild.left( wild.length() - 1 );
                 }
diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index 105cffe..45bde63 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -3626,7 +3626,7 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpti=
ons options ) const
             if ( !language().isEmpty() && language().length() =3D=3D 2 ) {
                 data +=3D (char)0xAD;
                 data +=3D (char)0x02;
-                data +=3D language();
+                data +=3D language().toUtf8();
             }
         }
         break;
diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index d636b5c..9798374 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -707,7 +707,7 @@ QString QWspPduDecoder::decodeTextString()
     if (o =3D=3D '\"')
         o =3D decodeOctet();
     while (o !=3D 0 && !dev->atEnd()) {
-        str +=3D o;
+        str +=3D QChar(o);
         o =3D decodeOctet();
     }

@@ -722,7 +722,7 @@ QString QWspPduDecoder::decodeTextBlock(int length)
 {
     QString result;
     for(int i =3D 0; i < length; ++i)
-        result +=3D decodeOctet();
+        result +=3D QChar(decodeOctet());
     return result;
 }

@@ -815,7 +815,7 @@ QString QWspPduDecoder::decodeContentType()
             // Extension-Media
             o =3D decodeOctet();
             while (o !=3D 0) {
-                type +=3D o;
+                type +=3D QChar(o);
                 o =3D decodeOctet();
             }
         }
@@ -838,7 +838,7 @@ QString QWspPduDecoder::decodeContentType()
         // Constrained-encoding =3D Extension-Media
         o =3D decodeOctet();
         while (o !=3D 0) {
-            type +=3D o;
+            type +=3D QChar(o);
             o =3D decodeOctet();
         }
     }
@@ -988,13 +988,13 @@ QString QWspPduDecoder::decodeParameter()
         p =3D decodeTokenText() + "=3D";
         octet =3D peekOctet();
         if (octet <=3D 31 || octet & 0x80) {
-            p +=3D decodeInteger();
+            p +=3D QChar(decodeInteger());
         } else {
             // Extension-Media
             p +=3D '\"';
             octet =3D decodeOctet();
             while (octet !=3D 0 && !dev->atEnd()) {
-                p +=3D octet;
+                p +=3D QChar(octet);
                 octet =3D decodeOctet();
             }
             p +=3D '\"';
--
2.29.2

--===============1002553165216619652==--

