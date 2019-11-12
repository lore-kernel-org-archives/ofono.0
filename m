Content-Type: multipart/mixed; boundary="===============4565427309173509748=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 03/13] Port old-style connects
Date: Tue, 12 Nov 2019 22:37:09 +0100
Message-ID: <20191112213719.9309-4-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4565427309173509748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Update CXX Standard to 14 to be able to use qOverload()
---
 configure.ac        |  4 +--
 src/callmanager.cpp | 22 ++++++-------
 src/control.cpp     | 77 +++++++++++++++++++++------------------------
 src/phonesim.cpp    | 56 +++++++++++++++++----------------
 src/phonesim.h      |  3 +-
 5 files changed, 80 insertions(+), 82 deletions(-)

diff --git a/configure.ac b/configure.ac
index e339691..5cc4545 100644
--- a/configure.ac
+++ b/configure.ac
@@ -25,8 +25,8 @@ AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-opt=
imization],
 PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Script Qt5DBus Q=
t5Widgets, dummy=3Dyes,
 						AC_MSG_ERROR(Qt is required))

-# Needed for Qt 5.7
-CXXFLAGS=3D"$CXXFLAGS --std=3Dgnu++11"
+# Needed for qOverload
+CXXFLAGS=3D"$CXXFLAGS --std=3Dgnu++14"

 AC_SUBST(QT_CFLAGS)
 AC_SUBST(QT_LIBS)
diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index 1995c6d..fbdb179 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -33,11 +33,11 @@ CallManager::CallManager( QObject *parent )

     hangupTimer =3D new QTimer(this);
     hangupTimer->setSingleShot(true);
-    connect( hangupTimer, SIGNAL(timeout()), this, SLOT(hangupTimeout()) );
+    connect( hangupTimer, &QTimer::timeout, this, &CallManager::hangupTime=
out );

     ringTimer =3D new QTimer(this);
     ringTimer->setSingleShot(true);
-    connect( ringTimer, SIGNAL(timeout()), this, SLOT(sendNextRing()) );
+    connect( ringTimer, &QTimer::timeout, this, &CallManager::sendNextRing=
 );
 }

 CallManager::~CallManager()
@@ -92,19 +92,19 @@ bool CallManager::command( const QString& cmd )
         // Check for special dial-back numbers.
         if ( number =3D=3D "199" ) {
             send( "NO CARRIER" );
-            QTimer::singleShot( 5000, this, SLOT(dialBack()) );
+            QTimer::singleShot( 5000, this, &CallManager::dialBack );
             return true;
         } else if ( number =3D=3D "1993" ) {
             send( "NO CARRIER" );
-            QTimer::singleShot( 30000, this, SLOT(dialBack()) );
+            QTimer::singleShot( 30000, this, &CallManager::dialBack );
             return true;
         } else if ( number =3D=3D "177" ) {
             send( "NO CARRIER" );
-            QTimer::singleShot( 2000, this, SLOT(dialBackWithHangup5()) );
+            QTimer::singleShot( 2000, this, &CallManager::dialBackWithHang=
up5 );
             return true;
         } else if ( number =3D=3D "166" ) {
             send( "NO CARRIER" );
-            QTimer::singleShot( 1000, this, SLOT(dialBackWithHangup4()) );
+            QTimer::singleShot( 1000, this, &CallManager::dialBackWithHang=
up4 );
             return true;
         } else if ( number =3D=3D "155" ) {
             send( "BUSY" );
@@ -156,11 +156,11 @@ bool CallManager::command( const QString& cmd )

         // Automatic accept of calls
         if ( number =3D=3D "6789" ) {
-            QTimer::singleShot( 1000, this, SLOT(dialingToConnected()) );
+            QTimer::singleShot( 1000, this, &CallManager::dialingToConnect=
ed );
         } else if ( number.startsWith( "05123" ) ) {
-            QTimer::singleShot( 1000, this, SLOT(dialingToConnected()) );
+            QTimer::singleShot( 1000, this, &CallManager::dialingToConnect=
ed );
         } else if ( number.startsWith( "06123" ) ) {
-            QTimer::singleShot( 1000, this, SLOT(dialingToAlerting()) );
+            QTimer::singleShot( 1000, this, &CallManager::dialingToAlertin=
g );
         }

     // Data call - phone number 696969
@@ -726,7 +726,7 @@ void CallManager::dialingToConnected()
         temp =3D temp.replace( "05123" , "" );
         int timeout =3D temp.toInt( &ok, 10 );
         timeout =3D ok ? timeout * 1000 : 10000;
-        QTimer::singleShot( timeout, this, SLOT(hangup()) );
+        QTimer::singleShot( timeout, this, &CallManager::hangup );
     }
 }

@@ -750,7 +750,7 @@ void CallManager::dialingToAlerting()
         temp =3D temp.replace( "06123" , "" );
         int timeout =3D temp.toInt( &ok, 10 );
         timeout =3D ok ? timeout * 1000 : 10000;
-        QTimer::singleShot( timeout, this, SLOT(dialingToConnected()) );
+        QTimer::singleShot( timeout, this, &CallManager::dialingToConnecte=
d );
     }
 }

diff --git a/src/control.cpp b/src/control.cpp
index 1ea5294..d4732b7 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -63,34 +63,34 @@ ControlWidget::ControlWidget(const QString &ruleFile, C=
ontrol *parent)

     bus.registerObject("/", script, QDBusConnection::ExportAllSlots);

-    connect(ui->hsSignalQuality, SIGNAL(valueChanged(int)), this, SLOT(sen=
dSQ()));
-    connect(ui->hsBatteryCharge, SIGNAL(valueChanged(int)), this, SLOT(sen=
dBC()));
-    connect(ui->hsBatteryCharging, SIGNAL(stateChanged(int)), this, SLOT(c=
hargingChanged(int)));
-    connect(ui->pbSelectOperator, SIGNAL(clicked()), this, SLOT(sendOPS())=
);
-    connect(ui->pbRegistration, SIGNAL(clicked()), this, SLOT(sendREG()));
-    connect(ui->pbSendCellBroadcast, SIGNAL(clicked()), this, SLOT(sendCBM=
()));
-    connect(ui->pbSendSMSMessage, SIGNAL(clicked()), this, SLOT(sendSMSMes=
sage()));
-    connect(ui->pbFile, SIGNAL(clicked()), this, SLOT(selectFile()));
-    connect(ui->pbSendSMSDatagram, SIGNAL(clicked()), this, SLOT(sendSMSDa=
tagram()));
-    connect(ui->pbIncomingCall, SIGNAL(clicked()), this, SLOT(sendCall()));
-    connect(ui->openSpecButton, SIGNAL(clicked()), this, SLOT(resetTransla=
tor()));
-    connect(ui->atCheckBox, SIGNAL(clicked()), this, SLOT(atChanged()));
-    connect(ui->pbAddMessage, SIGNAL(clicked()), this, SLOT(addVoicemail()=
));
-    connect(ui->pbRemoveMessage, SIGNAL(clicked()), this, SLOT(delVoicemai=
l()));
-    connect(ui->pbNotifyUDH, SIGNAL(clicked()), this, SLOT(sendVMNotify())=
);
-    connect(ui->pbNotifyUDHEnhanced, SIGNAL(clicked()), this, SLOT(sendEVM=
Notify()));
-    connect(ui->pbSendUSSD, SIGNAL(clicked()), this, SLOT(sendUSSD()));
-    connect(ui->pbCancelUSSD, SIGNAL(clicked()), this, SLOT(cancelUSSD()));
-    connect(ui->cbSimInserted, SIGNAL(clicked()), this, SLOT(simInsertRemo=
ve()));
-    connect(ui->pbStart, SIGNAL(clicked()), this, SLOT(simAppStart()));
-    connect(ui->pbAbort, SIGNAL(clicked()), this, SLOT(simAppAbort()));
-    connect(ui->pbReset, SIGNAL(clicked()), this, SLOT(modemSilentReset())=
);
-    connect(ui->pbSendGNSSData, SIGNAL(clicked()), this, SLOT(sendGNSSData=
()));
-    connect(ui->pbGNSSDefault, SIGNAL(clicked()), this, SLOT(setDefaultGNS=
SData()));
-    connect(ui->pbSendNotif, SIGNAL(clicked()), this, SLOT(sendCSSN()));
-    connect(ui->pbAlerting, SIGNAL(clicked()), this, SLOT(setStateAlerting=
()));
-    connect(ui->pbActive, SIGNAL(clicked()), this, SLOT(setStateConnected(=
)));
-    connect(ui->pbHangup, SIGNAL(clicked()), this, SLOT(setStateHangup()));
+    connect(ui->hsSignalQuality, &QSlider::valueChanged, this, &ControlWid=
get::sendSQ);
+    connect(ui->hsBatteryCharge, &QSlider::valueChanged, this, &ControlWid=
get::sendBC);
+    connect(ui->hsBatteryCharging, &QCheckBox::stateChanged, this, &Contro=
lWidget::chargingChanged);
+    connect(ui->pbSelectOperator, &QPushButton::clicked, this, &ControlWid=
get::sendOPS);
+    connect(ui->pbRegistration, &QPushButton::clicked, this, &ControlWidge=
t::sendREG);
+    connect(ui->pbSendCellBroadcast, &QPushButton::clicked, this, &Control=
Widget::sendCBM);
+    connect(ui->pbSendSMSMessage, &QPushButton::clicked, this, &ControlWid=
get::sendSMSMessage);
+    connect(ui->pbFile, &QPushButton::clicked, this, &ControlWidget::selec=
tFile);
+    connect(ui->pbSendSMSDatagram, &QPushButton::clicked, this, &ControlWi=
dget::sendSMSDatagram);
+    connect(ui->pbIncomingCall, &QPushButton::clicked, this, &ControlWidge=
t::sendCall);
+    connect(ui->openSpecButton, &QPushButton::clicked, this, &ControlWidge=
t::resetTranslator);
+    connect(ui->atCheckBox, &QCheckBox::clicked, this, &ControlWidget::atC=
hanged);
+    connect(ui->pbAddMessage, &QPushButton::clicked, this, &ControlWidget:=
:addVoicemail);
+    connect(ui->pbRemoveMessage, &QPushButton::clicked, this, &ControlWidg=
et::delVoicemail);
+    connect(ui->pbNotifyUDH, &QPushButton::clicked, this, &ControlWidget::=
sendVMNotify);
+    connect(ui->pbNotifyUDHEnhanced, &QPushButton::clicked, this, &Control=
Widget::sendEVMNotify);
+    connect(ui->pbSendUSSD, &QPushButton::clicked, this, &ControlWidget::s=
endUSSD);
+    connect(ui->pbCancelUSSD, &QPushButton::clicked, this, &ControlWidget:=
:cancelUSSD);
+    connect(ui->cbSimInserted, &QCheckBox::clicked, this, &ControlWidget::=
simInsertRemove);
+    connect(ui->pbStart, &QPushButton::clicked, this, &ControlWidget::simA=
ppStart);
+    connect(ui->pbAbort, &QPushButton::clicked, this, &ControlWidget::simA=
ppAbort);
+    connect(ui->pbReset, &QPushButton::clicked, this, &ControlWidget::mode=
mSilentReset);
+    connect(ui->pbSendGNSSData, &QPushButton::clicked, this, &ControlWidge=
t::sendGNSSData);
+    connect(ui->pbGNSSDefault, &QPushButton::clicked, this, &ControlWidget=
::setDefaultGNSSData);
+    connect(ui->pbSendNotif, &QPushButton::clicked, this, &ControlWidget::=
sendCSSN);
+    connect(ui->pbAlerting, &QPushButton::clicked, this, &ControlWidget::s=
etStateAlerting);
+    connect(ui->pbActive, &QPushButton::clicked, this, &ControlWidget::set=
StateConnected);
+    connect(ui->pbHangup, &QPushButton::clicked, this, &ControlWidget::set=
StateHangup);

     QStringList headers;
     headers << "Sender" << "Priority" << "Notification Status";
@@ -120,19 +120,14 @@ Control::Control(const QString& ruleFile, SimRules *s=
r, QObject *parent)
         : HardwareManipulator(sr, parent),
         widget(new ControlWidget(ruleFile, this))
 {
-    QList<QByteArray> proxySignals;
-    proxySignals
-        << SIGNAL(unsolicitedCommand(QString))
-        << SIGNAL(command(QString))
-        << SIGNAL(variableChanged(QString,QString))
-        << SIGNAL(switchTo(QString))
-        << SIGNAL(startIncomingCall(QString, QString, QString))
-        << SIGNAL(stateChangedToAlerting())
-        << SIGNAL(stateChangedToConnected())
-        << SIGNAL(stateChangedToHangup(int));
-
-    foreach (QByteArray sig, proxySignals)
-        connect(widget, sig, this, sig);
+    connect(widget, &ControlWidget::unsolicitedCommand, this, &Control::un=
solicitedCommand);
+    connect(widget, &ControlWidget::command, this, &Control::command);
+    connect(widget, &ControlWidget::variableChanged, this, &Control::varia=
bleChanged);
+    connect(widget, &ControlWidget::switchTo, this, &Control::switchTo);
+    connect(widget, &ControlWidget::startIncomingCall, this, &Control::sta=
rtIncomingCall);
+    connect(widget, &ControlWidget::stateChangedToAlerting, this, &Control=
::stateChangedToAlerting);
+    connect(widget, &ControlWidget::stateChangedToConnected, this, &Contro=
l::stateChangedToConnected);
+    connect(widget, &ControlWidget::stateChangedToHangup, this, &Control::=
stateChangedToHangup);
 }

 Control::~Control()
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index ba99fd0..1fd3c15 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -31,6 +31,7 @@
 #include <qbytearray.h>
 #include <qregexp.h>
 #include <qdebug.h>
+#include <qglobal.h>

 #define PHONEBOOK_NLENGTH 32
 #define PHONEBOOK_TLENGTH 16
@@ -362,8 +363,8 @@ bool SimChat::command( const QString& cmd )

             timer->setSingleShot( true );

-            connect(timer, SIGNAL(timeout()), this->state()->rules(),
-                    SLOT(delaySetVariable()));
+            connect(timer, &QTimer::timeout, this->state()->rules(),
+                    &SimRules::delaySetVariable);
             timer->start( delay );
         } else
             state()->rules()->setVariable( variable, val );
@@ -464,7 +465,7 @@ SimUnsolicited::SimUnsolicited( SimState *state, SimXml=
Node& e )

     timer =3D new QTimer( this );
     timer->setSingleShot( true );
-    connect( timer, SIGNAL(timeout()), this, SLOT(timeout()) );
+    connect( timer, &QTimer::timeout, this, &SimUnsolicited::timeout );
 }


@@ -527,35 +528,36 @@ SimRules::SimRules(qintptr fd, QObject *p,  const QSt=
ring& filename, HardwareMan
         machine =3D hmf->create(this, nullptr);

     if (machine) {
-        connect(machine, SIGNAL(unsolicitedCommand(QString)),
-                this, SLOT(unsolicited(QString)));
-        connect(machine, SIGNAL(command(QString)),
-                this, SLOT(command(QString)));
-        connect(machine, SIGNAL(variableChanged(QString,QString)),
-                this, SLOT(setVariable(QString,QString)));
-        connect(machine, SIGNAL(switchTo(QString)),
-                this, SLOT(switchTo(QString)));
+        connect(machine, &HardwareManipulator::unsolicitedCommand,
+                this, &SimRules::unsolicited);
+        connect(machine, &HardwareManipulator::command,
+                this, &SimRules::command);
+        connect(machine, &HardwareManipulator::variableChanged,
+                this, &SimRules::setVariable);
+        connect(machine, &HardwareManipulator::switchTo,
+                this, &SimRules::switchTo);
     }

+
     _callManager =3D new CallManager(this);
-    connect( _callManager, SIGNAL(send(QString)),
-             this, SLOT(respond(QString)) );
-    connect( _callManager, SIGNAL(unsolicited(QString)),
-             this, SLOT(unsolicited(QString)) );
-    connect( _callManager, SIGNAL(dialCheck(QString,bool&)),
-             this, SLOT(dialCheck(QString,bool&)) );
+    connect( _callManager, &CallManager::send,
+             this, qOverload<const QString &>( &SimRules::respond ) );
+    connect( _callManager, &CallManager::unsolicited,
+             this, &SimRules::unsolicited );
+    connect( _callManager, &CallManager::dialCheck,
+             this, &SimRules::dialCheck );

     if ( machine ) {
-        connect( machine, SIGNAL(startIncomingCall(QString,QString,QString=
)),
-                 _callManager, SLOT(startIncomingCall(QString,QString,QStr=
ing)) );
-        connect ( _callManager, SIGNAL( callStatesChanged( QList<CallInfo>=
 * ) ),
-                  machine, SLOT( callManagement( QList<CallInfo> * ) ) );
-        connect ( machine, SIGNAL( stateChangedToAlerting() ), _callManage=
r,
-                SLOT( dialingToAlerting() ) );
-        connect ( machine, SIGNAL( stateChangedToConnected() ), _callManag=
er,
-                SLOT( dialingToConnected() ) );
-        connect ( machine, SIGNAL( stateChangedToHangup( int ) ), _callMan=
ager,
-                SLOT( hangupRemote( int ) ) );
+        connect( machine, &HardwareManipulator::startIncomingCall, _callMa=
nager,
+                 qOverload<const QString &, const QString &, const QString=
 &>( &CallManager::startIncomingCall ) );
+        connect ( _callManager, &CallManager::callStatesChanged,
+                  machine, &HardwareManipulator::callManagement);
+        connect ( machine, &HardwareManipulator::stateChangedToAlerting, _=
callManager,
+                &CallManager::dialingToAlerting );
+        connect ( machine, &HardwareManipulator::stateChangedToConnected, =
_callManager,
+                &CallManager::dialingToConnected );
+        connect ( machine, &HardwareManipulator::stateChangedToHangup, _ca=
llManager,
+                &CallManager::hangupRemote );
     }

     connect(this,SIGNAL(readyRead()),
diff --git a/src/phonesim.h b/src/phonesim.h
index 65ea794..ac5084d 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -300,6 +300,8 @@ public slots:
     // Set a variable to a new value.
     void setVariable( const QString& name, const QString& value );

+    void delaySetVariable();
+
     // Switch to a new simulator state.
     void switchTo(const QString& name);

@@ -320,7 +322,6 @@ private slots:
     void tryReadCommand();
     void destruct();
     void delayTimeout();
-    void delaySetVariable();
     void dialCheck( const QString& number, bool& ok );

 private:
--
2.24.0

--===============4565427309173509748==--

