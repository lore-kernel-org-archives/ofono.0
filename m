Content-Type: multipart/mixed; boundary="===============8349843434684676621=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH v2 3/3] Enable Qt Script
Date: Fri, 01 Oct 2010 01:52:26 +0800
Message-ID: <1285869146-30183-4-git-send-email-gyagp0@gmail.com>
In-Reply-To: <1285869146-30183-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8349843434684676621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch is to enable Qt script so that GUI can be controlled using
JavaScript. In the meantime, D-Bus support is added for the sake of test
automation.
---
 configure.ac    |    2 +-
 src/control.cpp |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/control.h   |   35 +++++++++++++++++++++
 3 files changed, 126 insertions(+), 1 deletions(-)

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
index 9e2c1f0..c01705b 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -51,6 +51,15 @@ ControlWidget::ControlWidget(const QString &ruleFile, Co=
ntrol *parent)
     ui =3D new Ui_ControlBase;
     ui->setupUi(this);
 =

+    script =3D new Script(this, ui);
+
+    if (!QDBusConnection::systemBus().registerService("org.phonesim")) {
+        qWarning() << QDBusConnection::systemBus().lastError().message();
+        exit(-1);
+    }
+
+    QDBusConnection::systemBus().registerObject("/", script, QDBusConnecti=
on::ExportAllSlots);
+
     connect(ui->hsSignalQuality, SIGNAL(valueChanged(int)), this, SLOT(sen=
dSQ()));
     connect(ui->hsBatteryCharge, SIGNAL(valueChanged(int)), this, SLOT(sen=
dBC()));
     connect(ui->hsBatteryCharging, SIGNAL(stateChanged(int)), this, SLOT(c=
hargingChanged(int)));
@@ -91,6 +100,7 @@ void ControlWidget::closeEvent(QCloseEvent *event)
 =

 ControlWidget::~ControlWidget()
 {
+    delete script;
     delete ui;
     delete translator;
 }
@@ -445,3 +455,83 @@ void ControlWidget::simAppAbort()
 {
     p->simAppAbort();
 }
+
+Script::Script(QObject *obj, Ui_ControlBase *ui) : QDBusAbstractAdaptor(ob=
j)
+{
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
+}
+
+void Script::SetPath(const QString &path, const QDBusMessage &msg)
+{
+    QDir dir(path);
+    if (!dir.exists()) {
+        QDBusMessage reply =3D msg.createErrorReply("org.phonesim.Error.Pa=
thNotFound", "Path doesn't exist");
+        QDBusConnection::systemBus().send(reply);
+        return;
+    }
+
+    dirPath =3D path;
+}
+
+QString Script::GetPath()
+{
+    return dirPath;
+}
+
+QString Script::Run(const QString &name, const QDBusMessage &msg)
+{
+    QString fileName;
+
+    if (dirPath.endsWith('/'))
+        fileName =3D dirPath + name;
+    else
+        fileName =3D dirPath + "/" + name;
+
+    QFile scriptFile(fileName);
+
+    if (!scriptFile.open(QIODevice::ReadOnly)) {
+        QDBusMessage reply =3D msg.createErrorReply("org.phonesim.Error.Fi=
leNotFound", "Script file doesn't exist");
+        QDBusConnection::systemBus().send(reply);
+        return QString();
+    }
+
+    QTextStream stream(&scriptFile);
+    stream.setCodec("UTF-8");
+    QString contents =3D stream.readAll();
+    scriptFile.close();
+
+    QScriptValue qsScript =3D engine.evaluate(contents);
+    if (qsScript.isError()) {
+        QString info =3D fileName + ", line " + qsScript.property("lineNum=
ber").toString() + ", " + qsScript.toString();
+        QDBusMessage reply =3D msg.createErrorReply("org.phonesim.Error.Sc=
riptExecError", info);
+        QDBusConnection::systemBus().send(reply);
+        return QString();
+    }
+
+    /*
+     * If this QScriptValue is an object, calling this function has side e=
ffects on the script engine,
+     * since the engine will call the object's toString() function (and po=
ssibly valueOf()) in an attempt
+     * to convert the object to a primitive value (possibly resulting in a=
n uncaught script exception).
+     */
+    if (qsScript.isObject() || qsScript.isUndefined())
+        return QString();
+
+    return qsScript.toString();
+}
diff --git a/src/control.h b/src/control.h
index 95536dc..e455437 100644
--- a/src/control.h
+++ b/src/control.h
@@ -21,11 +21,45 @@
 #define CONTROL_H
 =

 #include <hardwaremanipulator.h>
+#include <QtDBus/QtDBus>
+#include <QtScript>
 #include "ui_controlbase.h"
 #include "attranslator.h"
 =

 class Control;
 =

+class Script: public QDBusAbstractAdaptor
+{
+Q_OBJECT
+    Q_CLASSINFO("D-Bus Interface", "org.phonesim.Script")
+    Q_CLASSINFO("D-Bus Introspection", ""
+"  <interface name=3D\"org.phonesim.Script\">\n"
+"    <method name=3D\"SetPath\">\n"
+"      <arg direction=3D\"in\" type=3D\"s\" name=3D\"path\"/>\n"
+"    </method>\n"
+"    <method name=3D\"GetPath\">\n"
+"      <arg direction=3D\"out\" type=3D\"s\" name=3D\"path\"/>\n"
+"    </method>\n"
+"    <method name=3D\"Run\">\n"
+"      <arg direction=3D\"in\" type=3D\"s\" name=3D\"name\"/>\n"
+"      <arg direction=3D\"out\" type=3D\"s\" name=3D\"result\"/>\n"
+"    </method>\n"
+"  </interface>\n"
+        "")
+
+public:
+    Script(QObject *obj, Ui_ControlBase *ui);
+
+public slots:
+    void SetPath(const QString &path, const QDBusMessage &msg);
+    QString GetPath();
+    QString Run(const QString &name, const QDBusMessage &msg);
+
+private:
+    QString dirPath;
+    QScriptEngine engine;
+};
+
 class ControlWidget : public QWidget
 {
 Q_OBJECT
@@ -73,6 +107,7 @@ protected:
 =

 private:
     Ui_ControlBase *ui;
+    Script *script;
     Control *p;
     AtTranslator *translator;
 =

-- =

1.7.0.4


--===============8349843434684676621==--

