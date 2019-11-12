Content-Type: multipart/mixed; boundary="===============9118854150108339060=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 04/13] Replace QtScript with QtQml
Date: Tue, 12 Nov 2019 22:37:10 +0100
Message-ID: <20191112213719.9309-5-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9118854150108339060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac    |  2 +-
 src/control.cpp | 18 +++++++++---------
 src/control.h   |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5cc4545..0587f9f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -22,7 +22,7 @@ AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-opt=
imization],
 	fi
 ])

-PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Script Qt5DBus Q=
t5Widgets, dummy=3Dyes,
+PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Qml Qt5DBus Qt5W=
idgets, dummy=3Dyes,
 						AC_MSG_ERROR(Qt is required))

 # Needed for qOverload
diff --git a/src/control.cpp b/src/control.cpp
index d4732b7..8c1e412 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -641,28 +641,28 @@ void ControlWidget::modemSilentReset()
 Script::Script(QObject *obj, Ui_ControlBase *ui) : QDBusAbstractAdaptor(ob=
j)
 {
     /* Export tabs to be accessed by script */
-    QScriptValue qsTab =3D engine.newQObject(ui->tab);
+    QJSValue qsTab =3D engine.newQObject(ui->tab);
     engine.globalObject().setProperty("tabRegistration", qsTab);

-    QScriptValue qsTab2 =3D engine.newQObject(ui->tab_2);
+    QJSValue qsTab2 =3D engine.newQObject(ui->tab_2);
     engine.globalObject().setProperty("tabCBM", qsTab2);

-    QScriptValue qsTab3 =3D engine.newQObject(ui->tab_3);
+    QJSValue qsTab3 =3D engine.newQObject(ui->tab_3);
     engine.globalObject().setProperty("tabSMS", qsTab3);

-    QScriptValue qsTab4 =3D engine.newQObject(ui->tab_4);
+    QJSValue qsTab4 =3D engine.newQObject(ui->tab_4);
     engine.globalObject().setProperty("tabVoiceMail", qsTab4);

-    QScriptValue qsTab5 =3D engine.newQObject(ui->tab_5);
+    QJSValue qsTab5 =3D engine.newQObject(ui->tab_5);
     engine.globalObject().setProperty("tabUSSD", qsTab5);

-    QScriptValue qsTab6 =3D engine.newQObject(ui->tab_6);
+    QJSValue qsTab6 =3D engine.newQObject(ui->tab_6);
     engine.globalObject().setProperty("tabSIM", qsTab6);

-    QScriptValue qsTab8 =3D engine.newQObject(ui->tab_8);
+    QJSValue qsTab8 =3D engine.newQObject(ui->tab_8);
     engine.globalObject().setProperty("tabPosition", qsTab8);

-    QScriptValue qsTab9 =3D engine.newQObject(ui->tab_9);
+    QJSValue qsTab9 =3D engine.newQObject(ui->tab_9);
     engine.globalObject().setProperty("tabCall", qsTab9);
 }

@@ -705,7 +705,7 @@ QString Script::Run(const QString &name, const QDBusMes=
sage &msg)
     QString contents =3D stream.readAll();
     scriptFile.close();

-    QScriptValue qsScript =3D engine.evaluate(contents);
+    QJSValue qsScript =3D engine.evaluate(contents);
     if (qsScript.isError()) {
         QString info =3D fileName + ", line " + qsScript.property("lineNum=
ber").toString() + ", " + qsScript.toString();
         QDBusMessage reply =3D msg.createErrorReply(SERVICE ".Error.Script=
ExecError", info);
diff --git a/src/control.h b/src/control.h
index 6514bf4..a7c0ff3 100644
--- a/src/control.h
+++ b/src/control.h
@@ -22,7 +22,7 @@

 #include <hardwaremanipulator.h>
 #include <QtDBus/QtDBus>
-#include <QtScript>
+#include <QJSEngine>
 #include "ui_controlbase.h"
 #include "attranslator.h"
 #include "callmanager.h"
@@ -58,7 +58,7 @@ public slots:

 private:
     QString dirPath;
-    QScriptEngine engine;
+    QJSEngine engine;
 };

 class ControlWidget : public QWidget
--
2.24.0

--===============9118854150108339060==--

