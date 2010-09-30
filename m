Content-Type: multipart/mixed; boundary="===============3062820293882048607=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH v2 1/3] Move def of class ControlWidget to header file
Date: Fri, 01 Oct 2010 01:52:24 +0800
Message-ID: <1285869146-30183-2-git-send-email-gyagp0@gmail.com>
In-Reply-To: <1285869146-30183-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3062820293882048607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently any modification on control.cpp will result in some unrelated
obj to be regenerated, because the definition of class ControlWidget is
in this .cpp file. This patch wants to fix this problem.
---
 Makefile.am     |    5 +---
 src/control.cpp |   69 ---------------------------------------------------=
---
 src/control.h   |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 3 files changed, 70 insertions(+), 74 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 34198a5..f124b08 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -53,15 +53,12 @@ MAINTAINERCLEANFILES =3D Makefile.in \
 	aclocal.m4 configure depcomp missing install-sh
 =

 =

-$(src_phonesim_OBJECTS): src/control.moc src/ui_controlbase.h
+$(src_phonesim_OBJECTS): src/ui_controlbase.h
 =

 QT_V_MOC   =3D $(QT_V_MOC_$(V))
 QT_V_MOC_  =3D $(QT_V_MOC_$(AM_DEFAULT_VERBOSITY))
 QT_V_MOC_0 =3D @echo "  MOC   " $@;
 =

-src/control.moc: src/control.cpp
-	$(QT_V_MOC)$(MOC) $(QT_CFLAGS) $(INCLUDES) $< -o $@
-
 src/moc_%.cpp: src/%.h
 	$(QT_V_MOC)$(MOC) $< -o $@
 =

diff --git a/src/control.cpp b/src/control.cpp
index 34a228f..458ee43 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -18,7 +18,6 @@
 **************************************************************************=
**/
 =

 #include "control.h"
-#include "ui_controlbase.h"
 #include <qpushbutton.h>
 #include <qslider.h>
 #include <qcheckbox.h>
@@ -33,7 +32,6 @@
 #include <QFile>
 #include <QDir>
 #include <QtGui/QHeaderView>
-#include "attranslator.h"
 =

 #define TWO_BYTE_MAX 65535
 #define FOUR_CHAR 4
@@ -41,73 +39,6 @@
 #define EIGHT_CHAR 8
 #define HEX_BASE 16
 =

-class ControlWidget : public QWidget
-{
-Q_OBJECT
-public:
-    ControlWidget( const QString&, Control*);
-
-    void handleFromData( const QString& );
-    void handleToData( const QString& );
-    void handleNewApp();
-
-private slots:
-    void sendSQ();
-    void sendBC();
-    void chargingChanged(int state);
-    void sendOPS();
-    void sendREG();
-    void sendCBM();
-    void sendSMSMessage();
-    void sendMGD();
-    void selectFile();
-    void sendSMSDatagram();
-    void sendCall();
-    void atChanged();
-    void resetTranslator();
-    void addVoicemail();
-    void delVoicemail();
-    void sendVMNotify( int type =3D 0 );
-    void sendEVMNotify();
-    void sendUSSD();
-    void cancelUSSD();
-    void simInsertRemove();
-    void simAppStart();
-    void simAppAbort();
-
-signals:
-    void unsolicitedCommand(const QString &);
-    void command(const QString &);
-    void variableChanged(const QString &, const QString &);
-    void switchTo(const QString &);
-    void startIncomingCall(const QString &);
-
-protected:
-    void closeEvent(QCloseEvent *event);
-
-private:
-    Ui_ControlBase *ui;
-    Control *p;
-    AtTranslator *translator;
-
-    class VoicemailItem {
-    public:
-        VoicemailItem( const QString &sender, bool urgent );
-
-        QTableWidgetItem sender;
-        QTableWidgetItem priority;
-        QTableWidgetItem pending;
-
-        bool notifyReceived;
-        bool notifyDeleted;
-        int id;
-
-        static int nextId;
-    };
-    QList<VoicemailItem> mailbox;
-};
-#include "control.moc"
-
 ControlWidget::ControlWidget(const QString &ruleFile, Control *parent)
     : QWidget(), p(parent)
 {
diff --git a/src/control.h b/src/control.h
index 32db57e..3577e8d 100644
--- a/src/control.h
+++ b/src/control.h
@@ -21,8 +21,76 @@
 #define CONTROL_H
 =

 #include <hardwaremanipulator.h>
+#include "ui_controlbase.h"
+#include "attranslator.h"
 =

-class ControlWidget;
+class Control;
+
+class ControlWidget : public QWidget
+{
+Q_OBJECT
+public:
+    ControlWidget( const QString&, Control*);
+
+    void handleFromData( const QString& );
+    void handleToData( const QString& );
+    void handleNewApp();
+
+private slots:
+    void sendSQ();
+    void sendBC();
+    void chargingChanged(int state);
+    void sendOPS();
+    void sendREG();
+    void sendCBM();
+    void sendSMSMessage();
+    void sendMGD();
+    void selectFile();
+    void sendSMSDatagram();
+    void sendCall();
+    void atChanged();
+    void resetTranslator();
+    void addVoicemail();
+    void delVoicemail();
+    void sendVMNotify( int type =3D 0 );
+    void sendEVMNotify();
+    void sendUSSD();
+    void cancelUSSD();
+    void simInsertRemove();
+    void simAppStart();
+    void simAppAbort();
+
+signals:
+    void unsolicitedCommand(const QString &);
+    void command(const QString &);
+    void variableChanged(const QString &, const QString &);
+    void switchTo(const QString &);
+    void startIncomingCall(const QString &);
+
+protected:
+    void closeEvent(QCloseEvent *event);
+
+private:
+    Ui_ControlBase *ui;
+    Control *p;
+    AtTranslator *translator;
+
+    class VoicemailItem {
+    public:
+        VoicemailItem( const QString &sender, bool urgent );
+
+        QTableWidgetItem sender;
+        QTableWidgetItem priority;
+        QTableWidgetItem pending;
+
+        bool notifyReceived;
+        bool notifyDeleted;
+        int id;
+
+        static int nextId;
+    };
+    QList<VoicemailItem> mailbox;
+};
 =

 class Control: public HardwareManipulator
 {
-- =

1.7.0.4


--===============3062820293882048607==--

