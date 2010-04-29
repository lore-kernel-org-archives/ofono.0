Content-Type: multipart/mixed; boundary="===============9012729529326192593=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] phonesim: Time out +CSIM when no SIM present.
Date: Thu, 29 Apr 2010 13:38:56 +0200
Message-ID: <1272541136-19892-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9012729529326192593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Send an ERROR after some time from receiving a AT+CSIM when card
is not inserted.  Implement cancelling pending commands.
---
 src/phonesim.cpp |   25 ++++++++++++++++++++++++-
 src/phonesim.h   |   10 ++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index d5d7d87..65f7ac7 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -545,6 +545,7 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
     currentChannel =3D 1;
     incomingUsed =3D 0;
     lineUsed =3D 0;
+    pending =3D NULL;
     defaultToolkitApp =3D toolkitApp =3D new DemoSimApplication( this, thi=
s );
     connect( _callManager, SIGNAL(controlEvent(QSimControlEvent)),
              toolkitApp, SLOT(controlEvent(QSimControlEvent)) );
@@ -839,6 +840,9 @@ void SimRules::tryReadCommand()
 =

 void SimRules::destruct()
 {
+    if ( pending )
+        delete pending;
+
     if ( toolkitApp !=3D defaultToolkitApp )
         delete toolkitApp;
     delete defaultToolkitApp;
@@ -915,6 +919,19 @@ SimState *SimRules::state( const QString& name ) const
     return 0;
 }
 =

+class TimeoutCommand : public SimRules::PendingCommand, protected QObject {
+    QString response;
+    virtual void timerEvent(QTimerEvent *evt) {
+        rules.respond( response );
+        delete this;
+    }
+public:
+    TimeoutCommand( SimRules &r, QString rsp, int secs =3D 20 ) :
+            SimRules::PendingCommand(r), QObject(), response(rsp) {
+        startTimer( secs * 1000 );
+    }
+};
+
 bool SimRules::simCsimOk( const QByteArray& payload )
 {
     unsigned char sw1 =3D 0x90;
@@ -955,8 +972,11 @@ bool SimRules::simCommand( const QString& cmd )
     if ( !cmd.startsWith( "AT+CSIM=3D" ) )
         return false;
 =

-    if ( getMachine() && !getMachine()->getSimPresent() )
+    /* If no card inserted, just time out */
+    if ( getMachine() && !getMachine()->getSimPresent() ) {
+        new TimeoutCommand( *this, "ERROR" );
         return true;
+    }
 =

     // Extract the binary payload of the AT+CSIM command.
     int comma =3D cmd.indexOf( QChar(',') );
@@ -1067,6 +1087,9 @@ bool SimRules::simCommand( const QString& cmd )
 =

 void SimRules::command( const QString& cmd )
 {
+    if ( pending )
+        delete pending;
+
     if(getMachine())
         getMachine()->handleToData(cmd);
 =

diff --git a/src/phonesim.h b/src/phonesim.h
index cb7a5e1..6e35147 100644
--- a/src/phonesim.h
+++ b/src/phonesim.h
@@ -284,6 +284,14 @@ public:
     SimApplication *simApplication() const { return toolkitApp; }
     void setSimApplication( SimApplication *app );
 =

+    class PendingCommand {
+    public:
+        PendingCommand( SimRules &r ) : rules(r) { r.pending =3D this; }
+        virtual ~PendingCommand() { rules.pending =3D NULL; }
+    protected:
+        SimRules &rules;
+    };
+
 signals:
     void returnQueryVariable( const QString&, const QString & );
     void returnQueryState( const QString& );
@@ -358,6 +366,8 @@ private:
     CallManager *_callManager;
 =

     bool simCsimOk( const QByteArray& payload );
+
+    PendingCommand *pending;
 };
 =

 =

-- =

1.6.1


--===============9012729529326192593==--

