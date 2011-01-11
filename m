Content-Type: multipart/mixed; boundary="===============6957505114349267426=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/6] phonesim: Add conformance sim application
Date: Tue, 11 Jan 2011 16:16:06 +0200
Message-ID: <1294755370-12442-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294755370-12442-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6957505114349267426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                       |    3 +-
 src/conformancesimapplication.cpp |   63 +++++++++++++++++++++++++++++++++=
++++
 src/phonesim.cpp                  |    5 ++-
 src/phonesim.h                    |    1 +
 src/simapplication.h              |   14 ++++++++
 5 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 src/conformancesimapplication.cpp

diff --git a/Makefile.am b/Makefile.am
index f124b08..992c1d1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -26,7 +26,8 @@ src_phonesim_SOURCES =3D src/main.cpp \
 			src/qsimcommand.h src/qsimcommand.cpp \
 			src/qsimenvelope.h src/qsimenvelope.cpp \
 			src/qsimterminalresponse.h src/qsimterminalresponse.cpp \
-			src/qsimcontrolevent.h src/qsimcontrolevent.cpp
+			src/qsimcontrolevent.h src/qsimcontrolevent.cpp \
+			src/conformancesimapplication.cpp
 =

 nodist_src_phonesim_SOURCES =3D src/ui_controlbase.h \
 				src/moc_control.cpp \
diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
new file mode 100644
index 0000000..ecc47fb
--- /dev/null
+++ b/src/conformancesimapplication.cpp
@@ -0,0 +1,63 @@
+/*************************************************************************=
***
+**
+** This file contains the SAT conformance test cases
+**
+** Copyright 2011 EB(Elektrobit).
+**
+**
+** This file may be used under the terms of the GNU General Public License
+** version 2.0 as published by the Free Software Foundation and appearing
+** in the file LICENSE.GPL included in the packaging of this file.
+**
+** Please review the following information to ensure GNU General Public
+** Licensing requirements will be met:
+**     http://www.fsf.org/licensing/licenses/info/GPLv2.html.
+**
+**
+**************************************************************************=
**/
+
+#include "simapplication.h"
+#include <qatutils.h>
+#include <qdebug.h>
+#include <QTextCodec>
+#include "qsmsmessage.h"
+
+ConformanceSimApplication::ConformanceSimApplication( SimRules *rules,
+                                                        QObject *parent )
+    : SimApplication( rules, parent )
+{
+}
+
+ConformanceSimApplication::~ConformanceSimApplication()
+{
+}
+
+const QString ConformanceSimApplication::getName()
+{
+    return "Conformance SIM Application";
+}
+
+void ConformanceSimApplication::mainMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SetupMenu );
+
+    cmd.setMenuItems( items );
+
+    command( cmd, 0, 0 );
+}
+
+void ConformanceSimApplication::mainMenuSelection( int id )
+{
+    switch ( id ) {
+        default:
+        {
+            // Don't know what this item is, so just re-display the main m=
enu.
+            endSession();
+        }
+        break;
+    }
+}
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index f0c93f1..47425bc 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -546,10 +546,12 @@ SimRules::SimRules( int fd, QObject *p,  const QStrin=
g& filename, HardwareManipu
     incomingUsed =3D 0;
     lineUsed =3D 0;
     defaultToolkitApp =3D toolkitApp =3D new DemoSimApplication( this, thi=
s );
+    conformanceApp =3D new ConformanceSimApplication( this, this );
     connect( _callManager, SIGNAL(controlEvent(QSimControlEvent)),
              toolkitApp, SLOT(controlEvent(QSimControlEvent)) );
 =

     simApps.append( toolkitApp );
+    simApps.append( conformanceApp );
 =

     if ( machine )
         machine->handleNewApp();
@@ -842,8 +844,7 @@ void SimRules::tryReadCommand()
 =

 void SimRules::destruct()
 {
-    if ( toolkitApp !=3D defaultToolkitApp )
-        delete toolkitApp;
+    delete conformanceApp;
     delete defaultToolkitApp;
     toolkitApp =3D NULL;
 =

diff --git a/src/phonesim.h b/src/phonesim.h
index 33b0b31..d8fd293 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -334,6 +334,7 @@ private:
     SimFileSystem *fileSystem;
     SimApplication *defaultToolkitApp;
     SimApplication *toolkitApp;
+    SimApplication *conformanceApp;
     QList<SimApplication *> simApps;
 =

     // Get a particular state object.
diff --git a/src/simapplication.h b/src/simapplication.h
index cd93f7e..925baeb 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -138,4 +138,18 @@ private:
     QString timerStatus;
 };
 =

+class ConformanceSimApplication : public SimApplication
+{
+    Q_OBJECT
+public:
+    ConformanceSimApplication( SimRules *rules, QObject *parent =3D 0 );
+    ~ConformanceSimApplication();
+
+    const QString getName();
+
+protected slots:
+    void mainMenu();
+    void mainMenuSelection( int id );
+};
+
 #endif
-- =

1.7.0.4


--===============6957505114349267426==--

