Content-Type: multipart/mixed; boundary="===============5194127685251435146=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] callmanager: Remove connect and alert timers
Date: Thu, 12 May 2011 14:55:25 +0200
Message-ID: <1305204925-4687-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5194127685251435146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/callmanager.cpp |   29 -----------------------------
 src/callmanager.h   |    2 --
 2 files changed, 0 insertions(+), 31 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index 8085056..fb132b5 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -31,14 +31,6 @@ CallManager::CallManager( QObject *parent )
     _multipartyLimit =3D -1;
     numRings =3D 0;
 =

-    connectTimer =3D new QTimer(this);
-    connectTimer->setSingleShot(true);
-    connect( connectTimer, SIGNAL(timeout()), this, SLOT(dialingToConnecte=
d()) );
-
-    alertingTimer =3D new QTimer(this);
-    alertingTimer->setSingleShot(true);
-    connect( alertingTimer, SIGNAL(timeout()), this, SLOT(dialingToAlertin=
g()) );
-
     hangupTimer =3D new QTimer(this);
     hangupTimer->setSingleShot(true);
     connect( hangupTimer, SIGNAL(timeout()), this, SLOT(hangupTimeout()) );
@@ -155,10 +147,6 @@ bool CallManager::command( const QString& cmd )
         sendState( info );
         send( "OK" );
 =

-        // Start timers to transition the dialing call to alerting and con=
nected.
-        alertingTimer->start(2500);
-        connectTimer->start(3000);
-
     // Data call - phone number 696969
     } else if ( cmd.startsWith( "ATD" ) ) {
         // Data call setup.
@@ -183,10 +171,6 @@ bool CallManager::command( const QString& cmd )
                 // Advertise the call state change and then return to comm=
and mode.
                 sendState( info );
                 send( "CONNECT 19200" );
-
-                // Start timers to transition the dialing call to alerting=
 and connected.
-                alertingTimer->start(2500);
-                connectTimer->start(3000);
                 } else {
                 // If not a data line
                 emit send( "NO CARRIER" );
@@ -397,8 +381,6 @@ void CallManager::hangupAll()
         sendState( callList[index] );
     }
     callList.clear();
-    connectTimer->stop();
-    alertingTimer->stop();
     hangupTimer->stop();
     emit callStatesChanged( &callList );
 }
@@ -533,8 +515,6 @@ bool CallManager::chld1()
     } else if ( ( id =3D idForDialing() ) >=3D 0 ) {
         // We have a dialing call.
         hangupCall(id);
-        connectTimer->stop();
-        alertingTimer->stop();
         hangupTimer->stop();
         return true;
     } else {
@@ -550,8 +530,6 @@ bool CallManager::chld1x( int x )
         if ( callList[index].id =3D=3D x ) {
             if ( callList[index].state =3D=3D CallState_Dialing ||
                  callList[index].state =3D=3D CallState_Alerting ) {
-                connectTimer->stop();
-                alertingTimer->stop();
                 hangupTimer->stop();
             }
             callList[index].state =3D CallState_Hangup;
@@ -700,10 +678,6 @@ bool CallManager::chld4()
 =

 void CallManager::dialingToConnected()
 {
-    // Stop timers in case they are still active
-    alertingTimer->stop();
-    connectTimer->stop();
-
     // Find the currently dialing or alerting call.
     int index =3D indexForId( idForState( CallState_Dialing ) );
     if ( index < 0 )
@@ -730,9 +704,6 @@ void CallManager::dialingToConnected()
 =

 void CallManager::dialingToAlerting()
 {
-    // Stop the timer in case it is still active
-    alertingTimer->stop();
-
     // Find the currently dialing or alerting call.
     int index =3D indexForId( idForState( CallState_Dialing ) );
     if ( index < 0 )
diff --git a/src/callmanager.h b/src/callmanager.h
index c953a7d..ff3ac30 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -143,8 +143,6 @@ private slots:
 =

 private:
     QList<CallInfo> callList;
-    QTimer *connectTimer;
-    QTimer *alertingTimer;
     QTimer *hangupTimer;
     QTimer *ringTimer;
     bool _holdWillFail;
-- =

1.7.1


--===============5194127685251435146==--

