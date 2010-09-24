Content-Type: multipart/mixed; boundary="===============5374009457719686946=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 1/1] Enable Qt Script
Date: Fri, 24 Sep 2010 23:49:29 +0800
Message-ID: <1285343369-10418-2-git-send-email-gyagp0@gmail.com>
In-Reply-To: <1285343369-10418-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5374009457719686946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Yang Gu <yang.gu@intel.com>

---
 configure.ac    |    2 +-
 src/control.cpp |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4d10494..d5d674e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -21,7 +21,7 @@ AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-opt=
imization],
 	fi
 ])
 =

-PKG_CHECK_MODULES(QT, QtCore QtGui QtXml QtNetwork, dummy=3Dyes,
+PKG_CHECK_MODULES(QT, QtCore QtGui QtXml QtNetwork  QtScript, dummy=3Dyes,
 						AC_MSG_ERROR(Qt is required))
 AC_SUBST(QT_CFLAGS)
 AC_SUBST(QT_LIBS)
diff --git a/src/control.cpp b/src/control.cpp
index 34a228f..9de4ef7 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -33,6 +33,8 @@
 #include <QFile>
 #include <QDir>
 #include <QtGui/QHeaderView>
+#include <QtScript>
+#include <qfilesystemwatcher.h>
 #include "attranslator.h"
 =

 #define TWO_BYTE_MAX 65535
@@ -74,6 +76,7 @@ private slots:
     void simInsertRemove();
     void simAppStart();
     void simAppAbort();
+    void handleDirChanged(const QString &path);
 =

 signals:
     void unsolicitedCommand(const QString &);
@@ -105,6 +108,10 @@ private:
         static int nextId;
     };
     QList<VoicemailItem> mailbox;
+    QScriptEngine engine;
+    QString dirPath;
+    QStringList fileList;
+    QFileSystemWatcher fileSystemWatcher;
 };
 #include "control.moc"
 =

@@ -149,9 +156,62 @@ ControlWidget::ControlWidget(const QString &ruleFile, =
Control *parent)
 =

     handleNewApp();
 =

+    /* Export tabs to be accessed by script */
+    QScriptValue qsTab =3D engine.newQObject(ui->tab);
+    engine.globalObject().setProperty("tabRegistration", qsTab);
+
+    QScriptValue qsTab2 =3D engine.newQObject(ui->tab_2);
+    engine.globalObject().setProperty("tabCBM", qsTab2);
+
+    QScriptValue qsTab3 =3D engine.newQObject(ui->tab_3);
+    engine.globalObject().setProperty("tabSMS", qsTab3);
+
+    QScriptValue qsTab4 =3D engine.newQObject(ui->tab_4);
+    engine.globalObject().setProperty("tabVoiceMail", qsTab4);
+
+    QScriptValue qsTab5 =3D engine.newQObject(ui->tab_5);
+    engine.globalObject().setProperty("tabUSSD", qsTab5);
+
+    QScriptValue qsTab6 =3D engine.newQObject(ui->tab_6);
+    engine.globalObject().setProperty("tabSIM", qsTab6);
+
+    dirPath =3D "/tmp/scripts/";
+
+    QDir *dir =3D new QDir(dirPath);
+    dir->mkpath(dirPath);
+
+    fileList =3D dir->entryList(QDir::Files);
+
+    fileSystemWatcher.addPath(dirPath);
+    connect(&fileSystemWatcher, SIGNAL(directoryChanged(const QString &)),=
 this, SLOT(handleDirChanged(const QString &)));
+
     show();
 }
 =

+void ControlWidget::handleDirChanged(const QString &path)
+{
+    QDir *dir =3D new QDir(dirPath);
+    QStringList newFileList =3D dir->entryList(QDir::Files);
+
+    for (int i =3D 0; i < newFileList.size(); ++i)
+        if (!fileList.contains(newFileList.at(i))) {
+            QString fileName(dirPath + newFileList.at(i));
+            qDebug() << fileName << "was added to observed directory.";
+            QFile scriptFile(fileName);
+            scriptFile.open(QIODevice::ReadOnly);
+            QTextStream stream(&scriptFile);
+            QString contents =3D stream.readAll();
+            scriptFile.close();
+
+            QScriptValue qsScript =3D engine.evaluate(contents, fileName);
+            if (qsScript.isError())
+                qDebug() << fileName << qsScript.property("lineNumber").to=
Int32() << qsScript.toString();
+        }
+
+    fileList.clear();
+    fileList =3D newFileList;
+}
+
 void ControlWidget::closeEvent(QCloseEvent *event)
 {
     event->ignore();
-- =

1.7.0.4


--===============5374009457719686946==--

