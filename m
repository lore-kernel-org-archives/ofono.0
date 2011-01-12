Content-Type: multipart/mixed; boundary="===============3770900874586535946=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Add CDIP support
Date: Wed, 12 Jan 2011 09:07:12 -0200
Message-ID: <1294830432-6618-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3770900874586535946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With CDIP phonesim can tell the Called Line Identification within the
RING comand according to 27.007 section 7.9.
---
 src/callmanager.cpp       |   21 +++++++++++++++------
 src/callmanager.h         |    8 +++++---
 src/control.cpp           |    8 ++++++--
 src/control.h             |    2 +-
 src/default.xml           |   19 +++++++++++++++++++
 src/hardwaremanipulator.h |    2 +-
 src/phonesim.cpp          |    4 ++--
 7 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index d746333..be17b83 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -326,6 +326,11 @@ void CallManager::emitRing(const CallInfo &info)
         else
             str +=3D "\\n\\n+CLIP: " + QAtUtils::encodeNumber( info.number=
 ) + ",,,,0";
 =

+        if (info.calledNumber.isNull())
+            ;
+        else
+            str +=3D "\\n\\n+CDIP: " + QAtUtils::encodeNumber( info.called=
Number ) + ",,,";
+
         if (info.name.isNull())
             ;
 	else if (info.name.isEmpty())
@@ -338,7 +343,8 @@ void CallManager::emitRing(const CallInfo &info)
 }
 =

 void CallManager::startIncomingCall( const QString& number,
-				const QString& name, bool dialBack )
+                                     const QString& calledNumber,
+                                     const QString& name, bool dialBack )
 {
     // Bail out if there is already an incoming call.
     if ( idForIncoming() >=3D 0 ) {
@@ -356,6 +362,7 @@ void CallManager::startIncomingCall( const QString& num=
ber,
         info.state =3D CallState_Incoming;
     }
     info.number =3D number;
+    info.calledNumber =3D calledNumber;
     info.incoming =3D true;
     info.dialBack =3D dialBack;
     info.name =3D name;
@@ -371,9 +378,11 @@ void CallManager::startIncomingCall( const QString& nu=
mber,
     ringTimer->start(2000);
 }
 =

-void CallManager::startIncomingCall( const QString& number , const QString=
& name )
+void CallManager::startIncomingCall( const QString& number,
+                                     const QString& calledNumber,
+                                     const QString& name )
 {
-    startIncomingCall( number, name, false );
+    startIncomingCall( number, calledNumber, name, false );
 }
 =

 void CallManager::hangupAll()
@@ -702,18 +711,18 @@ void CallManager::dialingToAlerting()
 =

 void CallManager::dialBack()
 {
-    startIncomingCall( "1234567", "Alice", true );
+    startIncomingCall( "1234567", "7654321", "Alice", true );
 }
 =

 void CallManager::dialBackWithHangup5()
 {
-    startIncomingCall( "1234567", "Bob", true );
+    startIncomingCall( "1234567", "7654321", "Bob", true );
     hangupTimer->start( 5000 );
 }
 =

 void CallManager::dialBackWithHangup4()
 {
-    startIncomingCall( "1234567", "Mallory", true );
+    startIncomingCall( "1234567", "7654321", "Mallory", true );
     hangupTimer->start( 4000 );
 }
 =

diff --git a/src/callmanager.h b/src/callmanager.h
index f29bdce..90cb9bd 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -39,6 +39,7 @@ struct CallInfo
     int         id;
     CallState   state;
     QString     number;
+    QString     calledNumber;
     bool        incoming;
     bool        dialBack;
     QString     name;
@@ -94,9 +95,10 @@ public:
 =

 public slots:
     // Start an incoming call simulation.
-    void startIncomingCall( const QString& number, const QString& name,
-						bool dialBack );
-    void startIncomingCall( const QString& number, const QString& name );
+    void startIncomingCall( const QString& number, const QString& calledNu=
mber,
+                                const QString& name, bool dialBack );
+    void startIncomingCall( const QString& number, const QString& calledNu=
mber,
+                                const QString& name );
 =

 signals:
     // Send a response to a command.
diff --git a/src/control.cpp b/src/control.cpp
index 68c5584..b70de30 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -119,7 +119,7 @@ Control::Control(const QString& ruleFile, SimRules *sr,=
 QObject *parent)
         << SIGNAL(command(QString))
         << SIGNAL(variableChanged(QString,QString))
         << SIGNAL(switchTo(QString))
-        << SIGNAL(startIncomingCall(QString, QString));
+        << SIGNAL(startIncomingCall(QString, QString, QString));
 =

     foreach (QByteArray sig, proxySignals)
         connect(widget, sig, this, sig);
@@ -282,15 +282,19 @@ void ControlWidget::sendSMSDatagram()
 void ControlWidget::sendCall()
 {
     QString number;
+    QString calledNumber;
     QString name;
 =

     if (ui->cbCaller->isChecked())
         number =3D ui->leCaller->text();
 =

+    if (ui->cbCalledLine->isChecked())
+        calledNumber =3D ui->leCalledLine->text();
+
     if (ui->cbCallerName->isChecked())
         name =3D ui->leCallerName->text();
 =

-    emit startIncomingCall( number, name );
+    emit startIncomingCall( number, calledNumber, name );
 }
 =

 void ControlWidget::handleFromData( const QString& cmd )
diff --git a/src/control.h b/src/control.h
index 767baa3..2c14863 100644
--- a/src/control.h
+++ b/src/control.h
@@ -101,7 +101,7 @@ signals:
     void command(const QString &);
     void variableChanged(const QString &, const QString &);
     void switchTo(const QString &);
-    void startIncomingCall(const QString &, const QString &);
+    void startIncomingCall(const QString &, const QString &, const QString=
 &);
 =

 protected:
     void closeEvent(QCloseEvent *event);
diff --git a/src/default.xml b/src/default.xml
index 4491705..14796d2 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -1373,6 +1373,25 @@
 </chat>
 =

 <chat>
+    <!-- Query called line identifier presentation mode -->
+    <command>AT+CDIP?</command>
+    <response>+CDIP: ${DIP},1\n\nOK</response>
+</chat>
+
+<chat>
+    <!-- Query supported called line identifier presentation modes -->
+    <command>AT+CDIP=3D?</command>
+    <response>+CDIP: (0,1)\n\nOK</response>
+</chat>
+
+<chat>
+    <!-- Set called line identifier presentation mode -->
+    <command>AT+CDIP=3D*</command>
+    <response>OK</response>
+    <set name=3D"DIP" value=3D"*"/>
+</chat>
+
+<chat>
     <!-- Query calling line identifier presentation mode -->
     <command>AT+CNAP?</command>
     <response>+CNAP: ${NAP},1\n\nOK</response>
diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index d8ab11e..2176900 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -55,7 +55,7 @@ signals:
     void command(const QString &cmd);
     void variableChanged(const QString &n, const QString &v);
     void switchTo(const QString &cmd);
-    void startIncomingCall(const QString &number, const QString &name);
+    void startIncomingCall(const QString &number, const QString &called_nu=
mber, const QString &name);
 =

 protected:
     virtual QString constructCBMessage(const QString &messageCode, int geo=
graphicalScope, const QString &updateNumber, const QString &channel,
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 8ca5b23..a51e591 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -526,8 +526,8 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
              this, SLOT(dialCheck(QString,bool&)) );
 =

     if ( machine ) {
-        connect( machine, SIGNAL(startIncomingCall(QString,QString)),
-                 _callManager, SLOT(startIncomingCall(QString,QString)) );
+        connect( machine, SIGNAL(startIncomingCall(QString,QString,QString=
)),
+                 _callManager, SLOT(startIncomingCall(QString,QString,QStr=
ing)) );
     }
 =

     connect(this,SIGNAL(readyRead()),
-- =

1.7.3.5


--===============3770900874586535946==--

