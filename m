Content-Type: multipart/mixed; boundary="===============2475952786104170804=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] phonesim: Refactor SimApplication api, add a UI.
Date: Fri, 09 Apr 2010 08:44:15 +0200
Message-ID: <1270795455-7067-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2475952786104170804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Try to move all the AT parsing / generating out of applications, just send
ready envelopes, terminal responses, commands between the application
and the SimRules class.
---
 src/control.cpp             |   35 +++++++++++
 src/control.h               |    1 +
 src/controlbase.ui          |   71 ++++++++++++++++++++++
 src/hardwaremanipulator.cpp |   42 +++++++++++++
 src/hardwaremanipulator.h   |    7 ++
 src/phonesim.cpp            |  138 +++++++++++++++++++++++++++++++++++++++=
----
 src/phonesim.h              |    6 ++
 src/simapplication.cpp      |  137 ++++++++++++++-------------------------=
---
 src/simapplication.h        |   27 +++++----
 9 files changed, 349 insertions(+), 115 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index c14909f..34a228f 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -49,6 +49,7 @@ public:
 =

     void handleFromData( const QString& );
     void handleToData( const QString& );
+    void handleNewApp();
 =

 private slots:
     void sendSQ();
@@ -70,6 +71,9 @@ private slots:
     void sendEVMNotify();
     void sendUSSD();
     void cancelUSSD();
+    void simInsertRemove();
+    void simAppStart();
+    void simAppAbort();
 =

 signals:
     void unsolicitedCommand(const QString &);
@@ -134,12 +138,17 @@ ControlWidget::ControlWidget(const QString &ruleFile,=
 Control *parent)
     connect(ui->pbNotifyUDHEnhanced, SIGNAL(clicked()), this, SLOT(sendEVM=
Notify()));
     connect(ui->pbSendUSSD, SIGNAL(clicked()), this, SLOT(sendUSSD()));
     connect(ui->pbCancelUSSD, SIGNAL(clicked()), this, SLOT(cancelUSSD()));
+    connect(ui->cbSimInserted, SIGNAL(clicked()), this, SLOT(simInsertRemo=
ve()));
+    connect(ui->pbStart, SIGNAL(clicked()), this, SLOT(simAppStart()));
+    connect(ui->pbAbort, SIGNAL(clicked()), this, SLOT(simAppAbort()));
 =

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
     ui->twMessageList->setHorizontalHeaderLabels( headers );
     ui->twMessageList->verticalHeader()->hide();
 =

+    handleNewApp();
+
     show();
 }
 =

@@ -473,3 +482,29 @@ void ControlWidget::cancelUSSD()
     ui->lblResponse->setText( "" );
     ui->leUSSDString->setText( "" );
 }
+
+void ControlWidget::simInsertRemove()
+{
+    p->setSimPresent( ui->cbSimInserted->isChecked() );
+}
+
+void ControlWidget::handleNewApp()
+{
+    ui->lblApplicationName->setText( "Current application: " +
+            p->getSimAppName() );
+}
+
+void Control::handleNewApp()
+{
+    widget->handleNewApp();
+}
+
+void ControlWidget::simAppStart()
+{
+    p->simAppStart();
+}
+
+void ControlWidget::simAppAbort()
+{
+    p->simAppAbort();
+}
diff --git a/src/control.h b/src/control.h
index e8b20a9..32db57e 100644
--- a/src/control.h
+++ b/src/control.h
@@ -36,6 +36,7 @@ public slots:
     void handleFromData( const QString& );
     void handleToData( const QString& );
     void setPhoneNumber( const QString& );
+    void handleNewApp();
 =

 protected:
     virtual void warning( const QString&, const QString& );
diff --git a/src/controlbase.ui b/src/controlbase.ui
index a0468f2..eca1898 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -1370,6 +1370,77 @@ p, li { white-space: pre-wrap; }
        </item>
       </layout>
      </widget>
+     <widget class=3D"QWidget" name=3D"tab_6" >
+      <attribute name=3D"title" >
+       <string>SIM</string>
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
+        <widget class=3D"QGroupBox" name=3D"gbCard" >
+         <property name=3D"title" >
+          <string>Card</string>
+         </property>
+         <layout class=3D"QVBoxLayout" >
+          <item>
+           <widget class=3D"QCheckBox" name=3D"cbSimInserted" >
+            <property name=3D"text" >
+             <string>Card inserted</string>
+            </property>
+            <property name=3D"checked" >
+             <bool>true</bool>
+            </property>
+           </widget>
+          </item>
+         </layout>
+        </widget>
+       </item>
+       <item>
+        <widget class=3D"QGroupBox" name=3D"gbSATK" >
+         <property name=3D"title" >
+          <string>Application</string>
+         </property>
+         <layout class=3D"QHBoxLayout" >
+          <item>
+           <widget class=3D"QPushButton" name=3D"pbStart" >
+            <property name=3D"text" >
+             <string>Start</string>
+            </property>
+           </widget>
+          </item>
+          <item>
+           <widget class=3D"QPushButton" name=3D"pbAbort" >
+            <property name=3D"text" >
+             <string>Abort</string>
+            </property>
+           </widget>
+          </item>
+          <item>
+           <widget class=3D"QLabel" name=3D"lblApplicationName" >
+            <property name=3D"toolTip" >
+             <string>Shows current selected application's name</string>
+            </property>
+           </widget>
+          </item>
+         </layout>
+        </widget>
+       </item>
+      </layout>
+     </widget>
     </widget>
    </item>
    <item>
diff --git a/src/hardwaremanipulator.cpp b/src/hardwaremanipulator.cpp
index 61b98f3..f7b13e9 100644
--- a/src/hardwaremanipulator.cpp
+++ b/src/hardwaremanipulator.cpp
@@ -28,6 +28,7 @@
 #include <qwsppdu.h>
 #include <qatutils.h>
 #include <phonesim.h>
+#include <simapplication.h>
 =

 #define NIBBLE_MAX 15
 #define TWO_BYTE_MAX 65535
@@ -56,6 +57,7 @@ void HardwareManipulator::warning( const QString &title, =
const QString &message)
 =

 void HardwareManipulator::setPhoneNumber( const QString& )
 {
+    simPresent =3D true;
 }
 =

 QString PS_toHex( const QByteArray& binary );
@@ -290,3 +292,43 @@ void HardwareManipulator::sendUSSD( bool cancel, bool =
response,
                         QString::number( response ? 1 : 0 ) + ",\"" +
                         QAtUtils::quote( content, codec ) + "\",0" );
 }
+
+bool HardwareManipulator::getSimPresent()
+{
+    return simPresent;
+}
+
+void HardwareManipulator::setSimPresent( bool present )
+{
+    simPresent =3D present;
+}
+
+QString HardwareManipulator::getSimAppName()
+{
+    SimApplication *app =3D rules->simApplication();
+
+    if (app)
+        return app->getName();
+
+    return "None";
+}
+
+void HardwareManipulator::handleNewApp()
+{
+}
+
+void HardwareManipulator::simAppStart()
+{
+    SimApplication *app =3D rules->simApplication();
+
+    if (app)
+        return app->start();
+}
+
+void HardwareManipulator::simAppAbort()
+{
+    SimApplication *app =3D rules->simApplication();
+
+    if (app)
+        return app->abort();
+}
diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index 7b59167..6571c06 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -34,6 +34,8 @@ Q_OBJECT
 public:
     HardwareManipulator(SimRules *sr, QObject *parent=3D0);
     QSMSMessageList & getSMSList();
+    bool getSimPresent();
+    QString getSimAppName();
 =

 public slots:
     virtual void handleFromData( const QString& );
@@ -43,6 +45,10 @@ public slots:
     virtual void sendSMS( const QSMSMessage& m );
     virtual void sendVMNotify( int type, int count, const QList<QVMMessage=
> &received, const QList<QVMMessage> &deleted, const QString &mailbox );
     virtual void sendUSSD( bool cancel, bool response, const QString &cont=
ent );
+    virtual void setSimPresent( bool present );
+    virtual void simAppStart();
+    virtual void simAppAbort();
+    virtual void handleNewApp();
 =

 signals:
     void unsolicitedCommand(const QString &cmd);
@@ -63,6 +69,7 @@ protected:
 private:
     QSMSMessageList SMSList;
     SimRules *rules;
+    bool simPresent;
 };
 =

 class HardwareManipulatorFactory
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index a1d3546..d363c29 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -544,10 +544,11 @@ SimRules::SimRules( int fd, QObject *p,  const QStrin=
g& filename, HardwareManipu
     currentChannel =3D 1;
     incomingUsed =3D 0;
     lineUsed =3D 0;
-    defaultToolkitApp =3D toolkitApp =3D new DemoSimApplication( this );
-    toolkitApp->setSimRules( this );
+    defaultToolkitApp =3D toolkitApp =3D new DemoSimApplication( this, thi=
s );
     connect( _callManager, SIGNAL(controlEvent(QSimControlEvent)),
              toolkitApp, SLOT(controlEvent(QSimControlEvent)) );
+    if ( machine )
+        machine->handleNewApp();
 =

     // Load the simulator rules into memory as a DOM-like tree.
     SimXmlHandler *handler =3D new SimXmlHandler();
@@ -857,8 +858,10 @@ void SimRules::setSimApplication( SimApplication *app )
     if ( toolkitApp !=3D defaultToolkitApp )
         delete toolkitApp;
     toolkitApp =3D ( app ? app : defaultToolkitApp );
-    toolkitApp->setSimRules( this );
     toolkitApp->start();
+
+    if ( getMachine() )
+        getMachine()->handleNewApp();
 }
 =

 void SimRules::switchTo(const QString& name)
@@ -890,23 +893,111 @@ SimState *SimRules::state( const QString& name ) con=
st
     return 0;
 }
 =

+bool SimRules::simCsimOk( const QByteArray& payload )
+{
+    unsigned char sw1 =3D 0x90;
+    unsigned char sw2 =3D 0x00;
+    QByteArray resp =3D payload;
+
+    if ( toolkitApp ) {
+        QByteArray cmd =3D toolkitApp->fetch();
+        if ( !cmd.isEmpty() )
+            sw1 =3D 0x91;
+            sw2 =3D cmd.size();
+    }
+
+    resp +=3D sw1;
+    resp +=3D sw2;
+    respond( "+CSIM: " + QString::number( resp.size() * 2 ) + "," +
+                           QAtUtils::toHex( resp ) + "\\n\\nOK" );
+
+    return true;
+}
 =

 bool SimRules::simCommand( const QString& cmd )
 {
+    /* Process SIM toolkit begin and end commands by forcing the
+     * app back to the main menu.  */
+    if ( cmd =3D=3D "AT*TSTB" || cmd =3D=3D "AT*TSTE" ) {
+        if ( !toolkitApp ) {
+            respond( "ERROR" );
+            return true;
+        }
+
+        respond( "OK" );
+        toolkitApp->abort();
+        return true;
+    }
+
     // If not AT+CSIM, then this is not a SIM toolkit command.
     if ( !cmd.startsWith( "AT+CSIM=3D" ) )
         return false;
 =

+    if ( getMachine() && !getMachine()->getSimPresent() )
+        return true;
+
     // Extract the binary payload of the AT+CSIM command.
     int comma =3D cmd.indexOf( QChar(',') );
     if ( comma < 0 )
         return false;
     QByteArray param =3D QAtUtils::fromHex( cmd.mid(comma + 1) );
-    if ( param.length() < 5 || param[0] !=3D (char)0xA0 )
+
+    if ( param.length() < 4 ) {
+        /* Wrong length */
+        respond( "+CSIM: 4,6700\\n\\nOK" );
         return false;
+    }
+
+    if ( param[0] !=3D (char)0xA0 ) {
+        /* CLA not supported */
+        respond( "+CSIM: 4,6800\\n\\nOK" );
+        return false;
+    }
 =

     // Determine what kind of command we are dealing with.
-    if ( param[1] =3D=3D (char)0x2C && param[4] =3D=3D (char)0x10 && param=
.size() >=3D 21 ) {
+    // Check for TERMINAL PROFILE, FETCH, TERMINAL RESPONSE,
+    // ENVELOPE and UNBLOCK CHV packets.
+    if ( param[1] =3D=3D (char)0x10 ) {
+        /* Abort the SIM application and force it to return to the main me=
nu. */
+        if ( toolkitApp )
+            toolkitApp->abort();
+
+        /* Download of a TERMINAL PROFILE.  We respond with a simple OK,
+         * on the assumption that what we were sent was valid.  */
+        return simCsimOk( QByteArray() );
+    } else if ( param[1] =3D=3D (char)0x12 ) {
+        if ( !toolkitApp ) {
+            respond( "+CSIM: 4,6F00\\n\\nOK" );
+            return true;
+        }
+
+        /* Fetch the current command contents. */
+        QByteArray resp =3D toolkitApp->fetch( true );
+        if ( resp.isEmpty() ) {
+            /* We weren't expecting a FETCH. */
+            respond( "+CSIM: 4,6F00\\n\\nOK" );
+            return true;
+        }
+
+        return simCsimOk( resp );
+    } else if ( param.length() >=3D 5 && param[1] =3D=3D (char)0x14 ) {
+        if ( !toolkitApp ) {
+            respond( "+CSIM: 4,6F00\\n\\nOK" );
+            return true;
+        }
+
+        /* Process a TERMINAL RESPONSE message. */
+        QSimTerminalResponse resp =3D
+            QSimTerminalResponse::fromPdu( param.mid(5) );
+
+        if ( toolkitApp->response( resp ) )
+            return simCsimOk( QByteArray() );
+
+        /* Response to the wrong type of command. */
+        respond( "+CSIM: 4,6F00\\n\\nOK" );
+        return true;
+    } else if ( param.length() >=3D 5 && param[1] =3D=3D (char)0x2c &&
+                    param[4] =3D=3D (char)0x10 && param.size() >=3D 21 ) {
         // UNBLOCK CHV command, for resetting a PIN using a PUK.
         QString pinName =3D "PINVALUE";
         QString pukName =3D "PUKVALUE";
@@ -924,13 +1015,32 @@ bool SimRules::simCommand( const QString& cmd )
             respond( "+CSIM: 4,9804\\n\\nOK" );
         } else {
             setVariable( pinName, QString::fromUtf8( pinValue ) );
-            respond( "+CSIM: 4,9000\\n\\nOK" );
+            simCsimOk( QByteArray() );
+        }
+
+        return true;
+    } else if ( param.length() >=3D 5 && param[1] =3D=3D (char)0xC2 ) {
+        /* ENVELOPE */
+        if ( !toolkitApp ) {
+            respond( "+CSIM: 4,6F00\\n\\nOK" );
+            return true;
         }
+
+        QSimEnvelope env =3D QSimEnvelope::fromPdu( param.mid(5) );
+        if ( toolkitApp->envelope( env ) )
+            return simCsimOk( QByteArray() );
+
+        /* Envelope not supported or current command doesn't allow envelop=
es. */
+        respond( "+CSIM: 4,6F00\\n\\nOK" );
         return true;
+    } else if ( param[1] =3D=3D (char)0xf2 ) {
+        /* STATUS command, for now ignore the parameters */
+        return simCsimOk( QByteArray() );
     }
 =

     // Don't know this SIM command.
-    return false;
+    respond( "+CSIM: 4,6D00\\n\\nOK" );
+    return true;
 }
 =

 void SimRules::command( const QString& cmd )
@@ -943,10 +1053,6 @@ void SimRules::command( const QString& cmd )
         return;
 =

     // Process SIM toolkit related commands with the current SIM applicati=
on.
-    if ( toolkitApp && toolkitApp->execute( cmd ) )
-        return;
-
-    // Process other SIM commands sent via AT+CSIM.
     if ( simCommand( cmd ) )
         return;
 =

@@ -1458,6 +1564,16 @@ void SimRules::respond( const QString& resp, int del=
ay, bool eol )
         getMachine()->handleFromData(QString(escaped));
 }
 =

+void SimRules::proactiveCommandNotify( const QByteArray& cmd )
+{
+    unsolicited( "*TCMD: " + QString::number( cmd.size() ) );
+}
+
+void SimRules::callControlEventNotify( const QSimControlEvent& evt )
+{
+    unsolicited( "*TCC: " + QString::number( (int) (evt.type()) ) +
+              "," + QAtUtils::toHex( evt.toPdu() ) );
+}
 =

 void SimRules::delayTimeout()
 {
diff --git a/src/phonesim.h b/src/phonesim.h
index d48b48e..cb7a5e1 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -31,6 +31,7 @@
 #include <qmap.h>
 #include <qtimer.h>
 #include <qpointer.h>
+#include <qsimcontrolevent.h>
 =

 #include <string.h>
 #include <stdlib.h>
@@ -307,6 +308,9 @@ public slots:
     // Send a response line.
     void respond( const QString& resp ) { respond( resp, 0 ); }
 =

+    void proactiveCommandNotify( const QByteArray& cmd );
+    void callControlEventNotify( const QSimControlEvent& event );
+
 private slots:
     void tryReadCommand();
     void destruct();
@@ -352,6 +356,8 @@ private:
     QMap< QString, SimPhoneBook * > phoneBooks;
 =

     CallManager *_callManager;
+
+    bool simCsimOk( const QByteArray& payload );
 };
 =

 =

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 09825ab..5212030 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -26,7 +26,6 @@ class SimApplicationPrivate
 public:
     SimApplicationPrivate()
     {
-        rules =3D 0;
         expectedType =3D QSimCommand::NoCommand;
         target =3D 0;
         slot =3D 0;
@@ -41,10 +40,11 @@ public:
     bool inResponse;
 };
 =

-SimApplication::SimApplication( QObject *parent )
+SimApplication::SimApplication( SimRules *rules, QObject *parent )
     : QObject( parent )
 {
     d =3D new SimApplicationPrivate();
+    d->rules =3D rules;
 }
 =

 SimApplication::~SimApplication()
@@ -80,8 +80,7 @@ void SimApplication::command( const QSimCommand& cmd,
     // the middle of processing a TERMINAL RESPONSE or ENVELOPE,
     // then delay the unsolicited notification until later.
     if ( d->rules && !d->inResponse ) {
-        d->rules->unsolicited
-            ( "*TCMD: " + QString::number( d->currentCommand.size() ) );
+        d->rules->proactiveCommandNotify( d->currentCommand );
     }
 }
 =

@@ -90,11 +89,8 @@ void SimApplication::command( const QSimCommand& cmd,
 */
 void SimApplication::controlEvent( const QSimControlEvent& event )
 {
-    if ( d->rules ) {
-        d->rules->unsolicited
-            ( "*TCC: " + QString::number( (int)(event.type()) ) +
-              "," + QAtUtils::toHex( event.toPdu() ) );
-    }
+    if ( d->rules )
+        d->rules->callControlEventNotify( event );
 }
 =

 /*!
@@ -160,99 +156,49 @@ void SimApplication::mainMenuHelpRequest( int id )
     mainMenu();
 }
 =

-void SimApplication::setSimRules( SimRules *rules )
+bool SimApplication::envelope( const QSimEnvelope& env )
 {
-    d->rules =3D rules;
-}
-
-bool SimApplication::execute( const QString& cmd )
-{
-    // Process SIM toolkit begin and end commands by forcing the app back =
to the main menu.
-    if ( cmd =3D=3D "AT*TSTB" || cmd =3D=3D "AT*TSTE") {
-        d->rules->respond( "OK" );
-        abort();
+    /* Process a menu selection ENVELOPE message.  We turn it into a
+     * QSimTerminalResponse to make it easier to process.  */
+    if ( env.type() =3D=3D QSimEnvelope::EventDownload )
         return true;
-    }
 =

-    // If not AT+CSIM, then this is not a SIM toolkit command.
-    if ( !cmd.startsWith( "AT+CSIM=3D" ) )
+    if ( env.type() !=3D QSimEnvelope::MenuSelection )
+        /* Not supported */
         return false;
 =

-    // Extract the binary payload of the AT+CSIM command.
-    int comma =3D cmd.indexOf( QChar(',') );
-    if ( comma < 0 )
-        return false;
-    QByteArray param =3D QAtUtils::fromHex( cmd.mid(comma + 1) );
-    if ( param.length() < 5 || param[0] !=3D (char)0xA0 )
+    if ( d->expectedType !=3D QSimCommand::SetupMenu )
+        /* Envelope sent for the wrong type of command. */
         return false;
 =

-    // Check for TERMINAL PROFILE, FETCH, TERMINAL RESPONSE,
-    // and ENVELOPE packets.
-    if ( param[1] =3D=3D (char)0x10 ) {
-        // Download of a TERMINAL PROFILE.  We respond with a simple OK,
-        // on the assumption that what we were sent was valid.
-        d->rules->respond( "+CSIM: 4,9000\\n\\nOK" );
+    d->expectedType =3D QSimCommand::NoCommand;
+    d->currentCommand =3D QByteArray();
+    d->target =3D 0;
+    d->slot =3D 0;
+    if ( env.requestHelp() )
+        mainMenuHelpRequest( env.menuItem() );
+    else
+        mainMenuSelection( env.menuItem() );
 =

-        // Abort the SIM application and force it to return to the main me=
nu.
-        abort();
-    } else if ( param[1] =3D=3D (char)0x12 ) {
-        // Fetch the current command contents.
-        QByteArray resp =3D d->currentCommand;
-        if ( resp.isEmpty() ) {
-            // We weren't expecting a FETCH.
-            d->rules->respond( "+CSIM: 4,6F00\\n\\nOK" );
-            return true;
-        }
-        resp +=3D (char)0x90;
-        resp +=3D (char)0x00;
-        d->rules->respond( "+CSIM: " + QString::number( resp.size() * 2 ) =
+ "," +
-                           QAtUtils::toHex( resp ) + "\\n\\nOK" );
-    } else if ( param[1] =3D=3D (char)0x14 ) {
-        // Process a TERMINAL RESPONSE message.
-        QSimTerminalResponse resp;
-        resp =3D QSimTerminalResponse::fromPdu( param.mid(5) );
-        if ( resp.command().type() !=3D QSimCommand::NoCommand &&
-             resp.command().type() !=3D d->expectedType ) {
-            // Response to the wrong type of command.
-            d->rules->respond( "+CSIM: 4,6F00\\n\\nOK" );
-            return true;
-        }
-        response( resp );
-    } else if ( param[1] =3D=3D (char)0xC2 ) {
-        // Process a menu selection ENVELOPE message.  We turn it into a
-        // QSimTerminalResponse to make it easier to process.
-        QSimEnvelope env;
-        env =3D QSimEnvelope::fromPdu( param.mid(5) );
-        if ( env.type() =3D=3D QSimEnvelope::EventDownload ) {
-            d->rules->respond( "+CSIM: 4,9000\\n\\nOK" );
-            return true;
-        }
-        if ( env.type() !=3D QSimEnvelope::MenuSelection )
-            return false;
-        if ( d->expectedType !=3D QSimCommand::SetupMenu ) {
-            // Envelope sent for the wrong type of command.
-            d->rules->respond( "+CSIM: 4,6F00\\n\\nOK" );
-            return true;
-        }
-        d->rules->respond( "+CSIM: 4,9000\\n\\nOK" );
-        d->expectedType =3D QSimCommand::NoCommand;
+    return true;
+}
+
+QByteArray SimApplication::fetch( bool clear )
+{
+    QByteArray resp =3D d->currentCommand;
+
+    if ( clear )
         d->currentCommand =3D QByteArray();
-        d->target =3D 0;
-        d->slot =3D 0;
-        if ( env.requestHelp() )
-            mainMenuHelpRequest( env.menuItem() );
-        else
-            mainMenuSelection( env.menuItem() );
-    } else {
-        // This SIM command is not related to SIM toolkit - ignore it.
-        return false;
-    }
 =

-    return true;
+    return resp;
 }
 =

-void SimApplication::response( const QSimTerminalResponse& resp )
+bool SimApplication::response( const QSimTerminalResponse& resp )
 {
+    if ( resp.command().type() !=3D QSimCommand::NoCommand &&
+         resp.command().type() !=3D d->expectedType )
+        return false;
+
     // Save the target information.
     QObject *target =3D d->target;
     const char *slot =3D d->slot;
@@ -284,7 +230,7 @@ void SimApplication::response( const QSimTerminalRespon=
se& resp )
 =

     // Answer the AT+CSIM command and send notification of the new command.
     if ( !d->rules )
-        return;
+        return false;////
     if ( d->currentCommand.isEmpty() || resp.command().type() =3D=3D QSimC=
ommand::SetupMenu ) {
         // No new command, so respond with a simple OK.
         d->rules->respond( "+CSIM: 4,9000\\n\\nOK" );
@@ -300,10 +246,12 @@ void SimApplication::response( const QSimTerminalResp=
onse& resp )
         d->rules->unsolicited
             ( "*TCMD: " + QString::number( d->currentCommand.size() ) );
     }
+
+    return true;
 }
 =

-DemoSimApplication::DemoSimApplication( QObject *parent )
-    : SimApplication( parent )
+DemoSimApplication::DemoSimApplication( SimRules *rules, QObject *parent )
+    : SimApplication( rules, parent )
 {
 }
 =

@@ -311,6 +259,11 @@ DemoSimApplication::~DemoSimApplication()
 {
 }
 =

+const QString DemoSimApplication::getName()
+{
+    return "Demo SIM Application";
+}
+
 #define MainMenu_News       1
 #define MainMenu_Sports     2
 #define MainMenu_Time       3
diff --git a/src/simapplication.h b/src/simapplication.h
index 3fd5bcb..1cfcbe4 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -31,41 +31,44 @@ class SimApplicationPrivate;
 class SimApplication : public QObject
 {
     Q_OBJECT
-    friend class SimRules;
 public:
-    SimApplication( QObject *parent =3D 0 );
+    SimApplication( SimRules *rules, QObject *parent =3D 0 );
     ~SimApplication();
 =

-    void command( const QSimCommand& cmd,
-                  QObject *target, const char *slot,
-                  QSimCommand::ToPduOptions options
-                        =3D QSimCommand::NoPduOptions );
+    virtual bool envelope( const QSimEnvelope& env );
+    virtual bool response( const QSimTerminalResponse& resp );
+    virtual QByteArray fetch( bool clear =3D false );
+
+    virtual const QString getName() =3D 0;
 =

 public slots:
-    void controlEvent( const QSimControlEvent& event );
     virtual void start();
     virtual void abort();
 =

 protected slots:
+    void command( const QSimCommand& cmd,
+                  QObject *target, const char *slot,
+                  QSimCommand::ToPduOptions options
+                        =3D QSimCommand::NoPduOptions );
+    void controlEvent( const QSimControlEvent& event );
+
     virtual void mainMenu() =3D 0;
     virtual void mainMenuSelection( int id );
     virtual void mainMenuHelpRequest( int id );
 =

 private:
     SimApplicationPrivate *d;
-
-    void setSimRules( SimRules *rules );
-    bool execute( const QString& cmd );
-    void response( const QSimTerminalResponse& resp );
 };
 =

 class DemoSimApplication : public SimApplication
 {
     Q_OBJECT
 public:
-    DemoSimApplication( QObject *parent =3D 0 );
+    DemoSimApplication( SimRules *rules, QObject *parent =3D 0 );
     ~DemoSimApplication();
 =

+    const QString getName();
+
 protected slots:
     void mainMenu();
     void mainMenuSelection( int id );
-- =

1.6.1


--===============2475952786104170804==--

