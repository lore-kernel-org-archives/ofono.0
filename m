Content-Type: multipart/mixed; boundary="===============9000669394868453146=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/2] Add CNAP support
Date: Tue, 07 Dec 2010 16:33:11 -0200
Message-ID: <1291746792-8061-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9000669394868453146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With CNAP phonesim can tell the Caller Name within the RING comand
---
 src/callmanager.cpp       |   16 +++++++++-------
 src/callmanager.h         |    5 +++--
 src/control.cpp           |    4 ++--
 src/control.h             |    2 +-
 src/controlbase.ui        |   16 ++++++++++++++++
 src/default.xml           |   19 +++++++++++++++++++
 src/hardwaremanipulator.h |    2 +-
 src/phonesim.cpp          |    4 ++--
 8 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index dddc5ae..03fd341 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -302,7 +302,8 @@ bool CallManager::command( const QString& cmd )
     return true;
 }
 =

-void CallManager::startIncomingCall( const QString& number, bool dialBack )
+void CallManager::startIncomingCall( const QString& number,
+				const QString& name, bool dialBack )
 {
     // Bail out if there is already an incoming call.
     if ( idForIncoming() >=3D 0 ) {
@@ -328,7 +329,8 @@ void CallManager::startIncomingCall( const QString& num=
ber, bool dialBack )
     if ( info.state =3D=3D CallState_Waiting ) {
         emit unsolicited( "+CCWA: " + QAtUtils::encodeNumber( number ) + "=
,1" );
     } else {
-        emit unsolicited( "RING\\n\\n+CLIP: " + QAtUtils::encodeNumber( nu=
mber ) );
+        emit unsolicited( "RING\\n\\n+CLIP: " + QAtUtils::encodeNumber( nu=
mber )
+				+ "\\n\\n+CNAP: \"" + name + "\"" );
     }
 =

     // Announce the incoming call using Ericsson-style state notifications.
@@ -339,9 +341,9 @@ void CallManager::startIncomingCall( const QString& num=
ber, bool dialBack )
     ringTimer->start(2000);
 }
 =

-void CallManager::startIncomingCall( const QString& number )
+void CallManager::startIncomingCall( const QString& number , const QString=
& name )
 {
-    startIncomingCall( number, false );
+    startIncomingCall( number, name, false );
 }
 =

 void CallManager::hangupAll()
@@ -670,18 +672,18 @@ void CallManager::dialingToAlerting()
 =

 void CallManager::dialBack()
 {
-    startIncomingCall( "1234567", true );
+    startIncomingCall( "1234567", "Alice", true );
 }
 =

 void CallManager::dialBackWithHangup5()
 {
-    startIncomingCall( "1234567", true );
+    startIncomingCall( "1234567", "Bob", true );
     hangupTimer->start( 5000 );
 }
 =

 void CallManager::dialBackWithHangup4()
 {
-    startIncomingCall( "1234567", true );
+    startIncomingCall( "1234567", "Mallory", true );
     hangupTimer->start( 4000 );
 }
 =

diff --git a/src/callmanager.h b/src/callmanager.h
index 3dd01cd..a2de574 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -93,8 +93,9 @@ public:
 =

 public slots:
     // Start an incoming call simulation.
-    void startIncomingCall( const QString& number, bool dialBack );
-    void startIncomingCall( const QString& number );
+    void startIncomingCall( const QString& number, const QString& name,
+						bool dialBack );
+    void startIncomingCall( const QString& number, const QString& name );
 =

 signals:
     // Send a response to a command.
diff --git a/src/control.cpp b/src/control.cpp
index 75dae98..49f9f04 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -119,7 +119,7 @@ Control::Control(const QString& ruleFile, SimRules *sr,=
 QObject *parent)
         << SIGNAL(command(QString))
         << SIGNAL(variableChanged(QString,QString))
         << SIGNAL(switchTo(QString))
-        << SIGNAL(startIncomingCall(QString));
+        << SIGNAL(startIncomingCall(QString, QString));
 =

     foreach (QByteArray sig, proxySignals)
         connect(widget, sig, this, sig);
@@ -281,7 +281,7 @@ void ControlWidget::sendSMSDatagram()
 =

 void ControlWidget::sendCall()
 {
-    emit startIncomingCall( ui->leCaller->text() );
+    emit startIncomingCall( ui->leCaller->text() , ui->leCallerName->text(=
) );
 }
 =

 void ControlWidget::handleFromData( const QString& cmd )
diff --git a/src/control.h b/src/control.h
index 64a7af7..767baa3 100644
--- a/src/control.h
+++ b/src/control.h
@@ -101,7 +101,7 @@ signals:
     void command(const QString &);
     void variableChanged(const QString &, const QString &);
     void switchTo(const QString &);
-    void startIncomingCall(const QString &);
+    void startIncomingCall(const QString &, const QString &);
 =

 protected:
     void closeEvent(QCloseEvent *event);
diff --git a/src/controlbase.ui b/src/controlbase.ui
index 2c91f95..76abd4b 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -141,6 +141,22 @@
              <widget class=3D"QLineEdit" name=3D"leCaller"/>
             </item>
             <item>
+             <widget class=3D"QLabel" name=3D"lblCallerName">
+              <property name=3D"text">
+               <string>Caller Na&amp;me</string>
+              </property>
+              <property name=3D"alignment">
+               <set>Qt::AlignBottom|Qt::AlignLeading|Qt::AlignLeft</set>
+              </property>
+              <property name=3D"buddy">
+               <cstring>leCallerName</cstring>
+              </property>
+             </widget>
+            </item>
+            <item>
+             <widget class=3D"QLineEdit" name=3D"leCallerName"/>
+            </item>
+            <item>
              <layout class=3D"QHBoxLayout">
               <property name=3D"spacing">
                <number>6</number>
diff --git a/src/default.xml b/src/default.xml
index 0fd0182..3f800c1 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -1373,6 +1373,25 @@
 </chat>
 =

 <chat>
+    <!-- Query calling line identifier presentation mode -->
+    <command>AT+CNAP?</command>
+    <response>+CNAP: ${NAP},1\n\nOK</response>
+</chat>
+
+<chat>
+    <!-- Query supported calling line identifier presentation modes -->
+    <command>AT+CNAP=3D?</command>
+    <response>+CNAP: (0,1)\n\nOK</response>
+</chat>
+
+<chat>
+    <!-- Set calling line identifier presentation mode -->
+    <command>AT+CNAP=3D*</command>
+    <response>OK</response>
+    <set name=3D"NAP" value=3D"*"/>
+</chat>
+
+<chat>
     <!-- Query calling line identication restriction mode -->
     <command>AT+CLIR?</command>
     <response>+CLIR: ${LIR},${LIR_STATUS}\n\nOK</response>
diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index fe5968f..d8ab11e 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -55,7 +55,7 @@ signals:
     void command(const QString &cmd);
     void variableChanged(const QString &n, const QString &v);
     void switchTo(const QString &cmd);
-    void startIncomingCall(const QString &number);
+    void startIncomingCall(const QString &number, const QString &name);
 =

 protected:
     virtual QString constructCBMessage(const QString &messageCode, int geo=
graphicalScope, const QString &updateNumber, const QString &channel,
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 89089b2..8ca5b23 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -526,8 +526,8 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
              this, SLOT(dialCheck(QString,bool&)) );
 =

     if ( machine ) {
-        connect( machine, SIGNAL(startIncomingCall(QString)),
-                 _callManager, SLOT(startIncomingCall(QString)) );
+        connect( machine, SIGNAL(startIncomingCall(QString,QString)),
+                 _callManager, SLOT(startIncomingCall(QString,QString)) );
     }
 =

     connect(this,SIGNAL(readyRead()),
-- =

1.7.3.2


--===============9000669394868453146==--

