Content-Type: multipart/mixed; boundary="===============8774237227918108027=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] phonesim: Add a simple USSD UI.
Date: Fri, 09 Apr 2010 08:43:50 +0200
Message-ID: <1270795430-7037-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8774237227918108027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is not the best UI in the world...
---
 src/control.cpp             |   40 +++++++++++++++++++++++-
 src/control.h               |    6 ++--
 src/controlbase.ui          |   70 +++++++++++++++++++++++++++++++++++++++=
++++
 src/hardwaremanipulator.cpp |   19 ++++++++++-
 src/hardwaremanipulator.h   |    9 ++++--
 src/phonesim.cpp            |    2 +-
 6 files changed, 135 insertions(+), 11 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index b897b9e..c14909f 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -68,6 +68,8 @@ private slots:
     void delVoicemail();
     void sendVMNotify( int type =3D 0 );
     void sendEVMNotify();
+    void sendUSSD();
+    void cancelUSSD();
 =

 signals:
     void unsolicitedCommand(const QString &);
@@ -130,6 +132,8 @@ ControlWidget::ControlWidget(const QString &ruleFile, C=
ontrol *parent)
     connect(ui->pbRemoveMessage, SIGNAL(clicked()), this, SLOT(delVoicemai=
l()));
     connect(ui->pbNotifyUDH, SIGNAL(clicked()), this, SLOT(sendVMNotify())=
);
     connect(ui->pbNotifyUDHEnhanced, SIGNAL(clicked()), this, SLOT(sendEVM=
Notify()));
+    connect(ui->pbSendUSSD, SIGNAL(clicked()), this, SLOT(sendUSSD()));
+    connect(ui->pbCancelUSSD, SIGNAL(clicked()), this, SLOT(cancelUSSD()));
 =

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
@@ -145,8 +149,9 @@ void ControlWidget::closeEvent(QCloseEvent *event)
     hide();
 }
 =

-Control::Control(const QString& ruleFile, QObject *parent)
-        : HardwareManipulator(parent), widget(new ControlWidget(ruleFile, =
this))
+Control::Control(const QString& ruleFile, SimRules *sr, QObject *parent)
+        : HardwareManipulator(sr, parent),
+        widget(new ControlWidget(ruleFile, this))
 {
     QList<QByteArray> proxySignals;
     proxySignals
@@ -339,6 +344,18 @@ void ControlWidget::handleToData( const QString& cmd )
             ui->atViewer->append( dataItem + " : " + translator->translate=
Command(dataItem) );
         }
     }
+
+    if ( cmd.startsWith("AT+CUSD=3D") ) {
+        int comma =3D cmd.indexOf( QChar(',') );
+        if ( comma >=3D 0 ) {
+            QString content =3D cmd.mid(comma + 1);
+            content.remove( QChar('"') );
+            ui->lblResponse->setText( content );
+        }
+
+        if ( cmd.startsWith("AT+CUSD=3D2") )
+            ui->lblResponse->setText( "" );
+    }
 }
 =

 void Control::handleToData( const QString& cmd )
@@ -437,3 +454,22 @@ ControlWidget::VoicemailItem::VoicemailItem( const QSt=
ring &from, bool urgent )
 =

     id =3D nextId++;
 }
+
+void ControlWidget::sendUSSD()
+{
+    bool ask =3D ui->chkAskResponse->isChecked();
+    QString text =3D ui->leUSSDString->text();
+
+    p->sendUSSD( false, ask, text );
+
+    ui->lblResponse->setText( "" );
+    ui->leUSSDString->setText( "" );
+}
+
+void ControlWidget::cancelUSSD()
+{
+    p->sendUSSD( true, false, "" );
+
+    ui->lblResponse->setText( "" );
+    ui->leUSSDString->setText( "" );
+}
diff --git a/src/control.h b/src/control.h
index 8d712fc..e8b20a9 100644
--- a/src/control.h
+++ b/src/control.h
@@ -29,7 +29,7 @@ class Control: public HardwareManipulator
 Q_OBJECT
 =

 public:
-    Control(const QString& ruleFile, QObject *parent=3D0);
+    Control(const QString& ruleFile, SimRules *sr, QObject *parent=3D0);
     virtual ~Control();
 =

 public slots:
@@ -48,8 +48,8 @@ private:
 class ControlFactory : public HardwareManipulatorFactory
 {
 public:
-    inline virtual HardwareManipulator *create(QObject *parent)
-        { return new Control(ruleFile(), parent); }
+    inline virtual HardwareManipulator *create(SimRules *sr, QObject *pare=
nt)
+        { return new Control(ruleFile(), sr, parent); }
 };
 =

 =

diff --git a/src/controlbase.ui b/src/controlbase.ui
index bdaf3b4..a0468f2 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -1300,6 +1300,76 @@ p, li { white-space: pre-wrap; }
        </item>
       </layout>
      </widget>
+     <widget class=3D"QWidget" name=3D"tab_5" >
+      <attribute name=3D"title" >
+       <string>USSD</string>
+      </attribute>
+      <layout class=3D"QVBoxLayout" >
+       <property name=3D"spacing" >
+        <number>6</number>
+       </property>
+       <property name=3D"leftMargin" >
+        <number>9</number>
+       </property>
+       <property name=3D"topMargin" >
+        <number>9</number>
+       </property>
+       <property name=3D"rightMargin" >
+        <number>9</number>
+       </property>
+       <property name=3D"bottomMargin" >
+        <number>9</number>
+       </property>
+       <item>
+        <layout class=3D"QGridLayout" >
+         <item row=3D"0" column=3D"0" >
+          <widget class=3D"QCheckBox" name=3D"chkAskResponse" >
+           <property name=3D"text" >
+            <string>Request response</string>
+           </property>
+           <property name=3D"checked" >
+            <bool>true</bool>
+           </property>
+          </widget>
+         </item>
+         <item row=3D"0" column=3D"1" >
+          <widget class=3D"QLineEdit" name=3D"leUSSDString" >
+           <property name=3D"inputMask" >
+            <string/>
+           </property>
+           <property name=3D"maxLength" >
+            <number>120</number>
+           </property>
+          </widget>
+         </item>
+         <item row=3D"0" column=3D"2" >
+          <widget class=3D"QPushButton" name=3D"pbSendUSSD" >
+           <property name=3D"text" >
+            <string>Send</string>
+           </property>
+          </widget>
+         </item>
+         <item row=3D"1" column=3D"1" >
+          <widget class=3D"QLabel" name=3D"lblResponse" >
+           <property name=3D"toolTip" >
+            <string>User response</string>
+           </property>
+           <property name=3D"text" >
+            <string></string>
+           </property>
+          </widget>
+         </item>
+         <item row=3D"1" column=3D"2" >
+          <widget class=3D"QPushButton" name=3D"pbCancelUSSD" >
+           <property name=3D"text" >
+            <string>Cancel session</string>
+           </property>
+          </widget>
+         </item>
+        </layout>
+       </item>
+      </layout>
+     </widget>
     </widget>
    </item>
    <item>
diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index b5d4465..61b98f3 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -26,6 +26,8 @@
 #include <qcbsmessage.h>
 #include <qgsmcodec.h>
 #include <qwsppdu.h>
+#include <qatutils.h>
+#include <phonesim.h>
 =

 #define NIBBLE_MAX 15
 #define TWO_BYTE_MAX 65535
@@ -36,8 +38,8 @@
 #define ONE_CHAR 1
 #define HEX_BASE 16
 =

-HardwareManipulator::HardwareManipulator(QObject *parent)
-        : QObject(parent)
+HardwareManipulator::HardwareManipulator(SimRules *sr, QObject *parent)
+        : QObject(parent), rules(sr)
 {
 }
 =

@@ -275,3 +277,16 @@ void HardwareManipulator::sendVMNotify( int type, int =
count, const QList<QVMMess
 =

     sendSMS( m );
 }
+
+void HardwareManipulator::sendUSSD( bool cancel, bool response,
+		const QString &content )
+{
+    QTextCodec *codec =3D QAtUtils::codec( rules->variable("SCS") );
+    /* TODO: if rules->variable("USD") =3D=3D "0" then return */
+    if (cancel)
+        emit unsolicitedCommand( "+CUSD: 2" );
+    else
+        emit unsolicitedCommand( "+CUSD: " +
+                        QString::number( response ? 1 : 0 ) + ",\"" +
+                        QAtUtils::quote( content, codec ) + "\",0" );
+}
diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index 64a8d8e..7b59167 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -26,12 +26,13 @@
 =

 class QSMSMessage;
 class QVMMessage;
+class SimRules;
 class HardwareManipulator : public QObject
 {
 Q_OBJECT
 =

 public:
-    HardwareManipulator(QObject *parent=3D0);
+    HardwareManipulator(SimRules *sr, QObject *parent=3D0);
     QSMSMessageList & getSMSList();
 =

 public slots:
@@ -41,6 +42,7 @@ public slots:
     virtual void constructSMSMessage(const int type, const QString &sender=
, const QString &serviceCenter, const QString &text);
     virtual void sendSMS( const QSMSMessage& m );
     virtual void sendVMNotify( int type, int count, const QList<QVMMessage=
> &received, const QList<QVMMessage> &deleted, const QString &mailbox );
+    virtual void sendUSSD( bool cancel, bool response, const QString &cont=
ent );
 =

 signals:
     void unsolicitedCommand(const QString &cmd);
@@ -60,14 +62,15 @@ protected:
 =

 private:
     QSMSMessageList SMSList;
+    SimRules *rules;
 };
 =

 class HardwareManipulatorFactory
 {
 public:
     virtual ~HardwareManipulatorFactory() {};
-    inline virtual HardwareManipulator *create(QObject *p)
-	    { return new HardwareManipulator(p); }
+    inline virtual HardwareManipulator *create(SimRules *sr, QObject *p)
+	    { return new HardwareManipulator(sr, p); }
 =

     QString ruleFile() const { return ruleFilename; }
     void setRuleFile(const QString& filename) { ruleFilename =3D filename;=
 }
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 885ff9f..a1d3546 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -503,7 +503,7 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
     machine =3D 0;
 =

     if (hmf)
-        machine =3D hmf->create(0);
+        machine =3D hmf->create(this, 0);
 =

     if (machine) {
         connect(machine, SIGNAL(unsolicitedCommand(QString)),
-- =

1.6.1


--===============8774237227918108027==--

