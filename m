Content-Type: multipart/mixed; boundary="===============7183403798223655875=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 2/7] Use quotes to include local header files
Date: Mon, 18 Jan 2021 17:46:16 +0100
Message-ID: <20210118164621.52831-3-jbb.prv@gmx.de>
In-Reply-To: <20210118164621.52831-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7183403798223655875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Co-authored-by: Alexander Akulich <akulichalexander@gmail.com>
---
 src/aidapplication.cpp            |  4 ++--
 src/callmanager.cpp               |  4 ++--
 src/conformancesimapplication.cpp |  2 +-
 src/control.h                     |  2 +-
 src/hardwaremanipulator.cpp       | 14 +++++++-------
 src/main.cpp                      |  3 ++-
 src/phonesim.cpp                  |  2 +-
 src/phonesim.h                    |  2 +-
 src/qatresult.cpp                 |  2 +-
 src/qatresultparser.cpp           |  6 +++---
 src/qatutils.cpp                  |  6 +++---
 src/qcbsmessage.cpp               |  4 ++--
 src/qgsmcodec.cpp                 |  2 +-
 src/qsimcommand.cpp               |  8 ++++----
 src/qsimcontrolevent.cpp          |  4 ++--
 src/qsimenvelope.cpp              |  2 +-
 src/qsimenvelope.h                |  2 +-
 src/qsimterminalresponse.cpp      |  4 ++--
 src/qsimterminalresponse.h        |  2 +-
 src/qsmsmessage.cpp               |  8 ++++----
 src/qsmsmessage_p.h               |  4 ++--
 src/qwsppdu.cpp                   |  2 +-
 src/simapplication.cpp            |  2 +-
 src/simapplication.h              |  8 ++++----
 src/simauth.cpp                   |  4 ++--
 src/simfilesystem.cpp             |  2 +-
 26 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/src/aidapplication.cpp b/src/aidapplication.cpp
index 807d7f9..e20b028 100644
--- a/src/aidapplication.cpp
+++ b/src/aidapplication.cpp
@@ -2,8 +2,8 @@
 #include "simfilesystem.h"
 #include "simauth.h"

-#include <qatutils.h>
-#include <qsimcontrolevent.h>
+#include "qatutils.h"
+#include "qsimcontrolevent.h"

 AidApplication::AidApplication( QObject *parent, SimXmlNode& n )
     : QObject( parent )
diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index 1fa13cf..40f9b3b 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -18,8 +18,8 @@
 **************************************************************************=
**/

 #include "callmanager.h"
-#include <qatutils.h>
-#include <qsimcontrolevent.h>
+#include "qatutils.h"
+#include "qsimcontrolevent.h"

 CallManager::CallManager( QObject *parent )
     : QObject( parent )
diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
index 2817b0c..ae2f1a9 100644
--- a/src/conformancesimapplication.cpp
+++ b/src/conformancesimapplication.cpp
@@ -17,7 +17,7 @@
 **************************************************************************=
**/

 #include "simapplication.h"
-#include <qatutils.h>
+#include "qatutils.h"
 #include <qdebug.h>
 #include <QTextCodec>
 #include "qsmsmessage.h"
diff --git a/src/control.h b/src/control.h
index 79cd417..be4a366 100644
--- a/src/control.h
+++ b/src/control.h
@@ -20,12 +20,12 @@
 #ifndef CONTROL_H
 #define CONTROL_H

-#include <hardwaremanipulator.h>
 #include <QtDBus/QtDBus>
 #include <QJSEngine>
 #include "ui_controlbase.h"
 #include "attranslator.h"
 #include "callmanager.h"
+#include "hardwaremanipulator.h"

 class Control;

diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index 7a61c0e..a8a9bfe 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -22,13 +22,13 @@
 #include <qdebug.h>
 #include <qbuffer.h>
 #include <qtimer.h>
-#include <qsmsmessage.h>
-#include <qcbsmessage.h>
-#include <qgsmcodec.h>
-#include <qwsppdu.h>
-#include <qatutils.h>
-#include <phonesim.h>
-#include <simapplication.h>
+#include "qsmsmessage.h"
+#include "qcbsmessage.h"
+#include "qgsmcodec.h"
+#include "qwsppdu.h"
+#include "qatutils.h"
+#include "phonesim.h"
+#include "simapplication.h"

 #define NIBBLE_MAX 15
 #define TWO_BYTE_MAX 65535
diff --git a/src/main.cpp b/src/main.cpp
index 712e767..4892142 100644
--- a/src/main.cpp
+++ b/src/main.cpp
@@ -17,8 +17,9 @@
 **
 **************************************************************************=
**/

-#include <server.h>
+#include "server.h"
 #include "control.h"
+
 #include <qapplication.h>
 #include <qstring.h>
 #include <qdebug.h>
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 58bce2e..89d5e9d 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -25,7 +25,7 @@
 #include "callmanager.h"
 #include "simauth.h"
 #include "aidapplication.h"
-#include <qatutils.h>
+#include "qatutils.h"

 #include <qstring.h>
 #include <qbytearray.h>
diff --git a/src/phonesim.h b/src/phonesim.h
index 362a6a8..b72c62e 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -31,7 +31,6 @@
 #include <qmap.h>
 #include <qtimer.h>
 #include <qpointer.h>
-#include <qsimcontrolevent.h>

 #include <cstring>
 #include <cstdlib>
@@ -45,6 +44,7 @@
 #include <arpa/inet.h>
 #include <netinet/in.h>

+#include "qsimcontrolevent.h"

 class SimState;
 class SimItem;
diff --git a/src/qatresult.cpp b/src/qatresult.cpp
index 9a29503..8be80b5 100644
--- a/src/qatresult.cpp
+++ b/src/qatresult.cpp
@@ -17,7 +17,7 @@
 **
 **************************************************************************=
**/

-#include <qatresult.h>
+#include "qatresult.h"

 /*!
     \class QAtResult
diff --git a/src/qatresultparser.cpp b/src/qatresultparser.cpp
index cba41ad..b2a82de 100644
--- a/src/qatresultparser.cpp
+++ b/src/qatresultparser.cpp
@@ -17,9 +17,9 @@
 **
 **************************************************************************=
**/

-#include <qatresultparser.h>
-#include <qatresult.h>
-#include <qatutils.h>
+#include "qatresultparser.h"
+#include "qatresult.h"
+#include "qatutils.h"

 /*!
     \class QAtResultParser
diff --git a/src/qatutils.cpp b/src/qatutils.cpp
index 2479c31..2bfad5d 100644
--- a/src/qatutils.cpp
+++ b/src/qatutils.cpp
@@ -17,9 +17,9 @@
 **
 **************************************************************************=
**/

-#include <qatutils.h>
-#include <qatresultparser.h>
-#include <qgsmcodec.h>
+#include "qatutils.h"
+#include "qatresultparser.h"
+#include "qgsmcodec.h"
 #include <qtextcodec.h>

 /*!
diff --git a/src/qcbsmessage.cpp b/src/qcbsmessage.cpp
index b56a761..cdb549c 100644
--- a/src/qcbsmessage.cpp
+++ b/src/qcbsmessage.cpp
@@ -17,8 +17,8 @@
 **
 **************************************************************************=
**/

-#include <qcbsmessage.h>
-#include <qatutils.h>
+#include "qcbsmessage.h"
+#include "qatutils.h"
 #include "qsmsmessage_p.h"
 #ifdef Q_WS_QWS
 #include <qtopialog.h>
diff --git a/src/qgsmcodec.cpp b/src/qgsmcodec.cpp
index 4120226..ccae98d 100644
--- a/src/qgsmcodec.cpp
+++ b/src/qgsmcodec.cpp
@@ -17,7 +17,7 @@
 **
 **************************************************************************=
**/

-#include <qgsmcodec.h>
+#include "qgsmcodec.h"

 const unsigned short GUC =3D 0x10;     // GSM Undefined character

diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index fb200ed..105cffe 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -17,10 +17,10 @@
 **
 **************************************************************************=
**/

-#include <qsimcommand.h>
-#include <qatutils.h>
-#include <qsmsmessage.h>
-#include <qgsmcodec.h>
+#include "qsimcommand.h"
+#include "qatutils.h"
+#include "qsmsmessage.h"
+#include "qgsmcodec.h"
 #include <qvarlengtharray.h>

 static QString textToHtml(const QString& text, const QByteArray& attrs);
diff --git a/src/qsimcontrolevent.cpp b/src/qsimcontrolevent.cpp
index 4502d78..6a44748 100644
--- a/src/qsimcontrolevent.cpp
+++ b/src/qsimcontrolevent.cpp
@@ -17,8 +17,8 @@
 **
 **************************************************************************=
**/

-#include <qsimcontrolevent.h>
-#include <qsimcommand.h>
+#include "qsimcontrolevent.h"
+#include "qsimcommand.h"

 /*!
     \class QSimControlEvent
diff --git a/src/qsimenvelope.cpp b/src/qsimenvelope.cpp
index 3942dad..44c4ff2 100644
--- a/src/qsimenvelope.cpp
+++ b/src/qsimenvelope.cpp
@@ -17,7 +17,7 @@
 **
 **************************************************************************=
**/

-#include <qsimenvelope.h>
+#include "qsimenvelope.h"

 /*!
     \class QSimEnvelope
diff --git a/src/qsimenvelope.h b/src/qsimenvelope.h
index 0bd3fe5..71b340d 100644
--- a/src/qsimenvelope.h
+++ b/src/qsimenvelope.h
@@ -19,7 +19,7 @@
 #ifndef QSIMENVELOPE_H
 #define QSIMENVELOPE_H

-#include <qsimcommand.h>
+#include "qsimcommand.h"

 class QSimEnvelopePrivate;

diff --git a/src/qsimterminalresponse.cpp b/src/qsimterminalresponse.cpp
index bd600dd..3ec468c 100644
--- a/src/qsimterminalresponse.cpp
+++ b/src/qsimterminalresponse.cpp
@@ -17,8 +17,8 @@
 **
 **************************************************************************=
**/

-#include <qsimterminalresponse.h>
-#include <qsmsmessage.h>
+#include "qsimterminalresponse.h"
+#include "qsmsmessage.h"

 /*!
     \class QSimTerminalResponse
diff --git a/src/qsimterminalresponse.h b/src/qsimterminalresponse.h
index 24427f2..156bd26 100644
--- a/src/qsimterminalresponse.h
+++ b/src/qsimterminalresponse.h
@@ -19,7 +19,7 @@
 #ifndef QSIMTERMINALRESPONSE_H
 #define QSIMTERMINALRESPONSE_H

-#include <qsimcommand.h>
+#include "qsimcommand.h"

 class QSimTerminalResponsePrivate;

diff --git a/src/qsmsmessage.cpp b/src/qsmsmessage.cpp
index b255287..8665096 100644
--- a/src/qsmsmessage.cpp
+++ b/src/qsmsmessage.cpp
@@ -19,11 +19,11 @@

 #include <cstdlib>

-#include <qsmsmessage.h>
-#include <qcbsmessage.h>
+#include "qsmsmessage.h"
+#include "qcbsmessage.h"
 #include "qsmsmessage_p.h"
-#include <qatutils.h>
-#include <qgsmcodec.h>
+#include "qatutils.h"
+#include "qgsmcodec.h"
 #ifdef Q_WS_QWS
 #include <qtopialog.h>
 #else
diff --git a/src/qsmsmessage_p.h b/src/qsmsmessage_p.h
index 49060c7..55397b0 100644
--- a/src/qsmsmessage_p.h
+++ b/src/qsmsmessage_p.h
@@ -31,8 +31,8 @@
 // We mean it.
 //

-#include <qsmsmessage.h>
-#include <qcbsmessage.h>
+#include "qsmsmessage.h"
+#include "qcbsmessage.h"

 // Values are their bit reprensentation (defined in GSM-03.40 Section 9)
 // bits 6 5 4 ( shl 4 )
diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index 1069d2f..897bac8 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -17,7 +17,7 @@
 **
 **************************************************************************=
**/

-#include <qwsppdu.h>
+#include "qwsppdu.h"

 #include <cstdlib>
 #include <netinet/in.h>
diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 84058af..da0385d 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -18,7 +18,7 @@
 **************************************************************************=
**/

 #include "simapplication.h"
-#include <qatutils.h>
+#include "qatutils.h"
 #include <qdebug.h>
 #include <QTextCodec>
 #include "qsmsmessage.h"
diff --git a/src/simapplication.h b/src/simapplication.h
index 5f427ed..3422b91 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -21,10 +21,10 @@
 #define SIMAPPLICATION_H

 #include "phonesim.h"
-#include <qsimcommand.h>
-#include <qsimterminalresponse.h>
-#include <qsimenvelope.h>
-#include <qsimcontrolevent.h>
+#include "qsimcommand.h"
+#include "qsimterminalresponse.h"
+#include "qsimenvelope.h"
+#include "qsimcontrolevent.h"

 class SimApplicationPrivate;

diff --git a/src/simauth.cpp b/src/simauth.cpp
index 93b8826..62d78a6 100644
--- a/src/simauth.cpp
+++ b/src/simauth.cpp
@@ -16,8 +16,8 @@
 **************************************************************************=
**/

 #include "simauth.h"
-#include <qatutils.h>
-#include <qsimcontrolevent.h>
+#include "qatutils.h"
+#include "qsimcontrolevent.h"

 extern "C" {
 #include "comp128.h"
diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index b3ea8a4..aa93698 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -18,7 +18,7 @@
 **************************************************************************=
**/

 #include "simfilesystem.h"
-#include <qatutils.h>
+#include "qatutils.h"
 #include <qdebug.h>

 // Known files, their parent directories, and names.
--
2.29.2

--===============7183403798223655875==--

