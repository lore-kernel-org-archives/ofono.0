Content-Type: multipart/mixed; boundary="===============5945255555085199586=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH v2 1/6] callmanager: Add signal on call status change
Date: Mon, 02 May 2011 11:17:13 +0200
Message-ID: <1304327838-11164-2-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1304327838-11164-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5945255555085199586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/callmanager.cpp |   22 ++++++++++++++++++++++
 src/callmanager.h   |    3 +++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index 585a3ac..0ede2ad 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -149,6 +149,8 @@ bool CallManager::command( const QString& cmd )
         info.dialBack =3D false;
         callList +=3D info;
 =

+        emit callStatesChanged( &callList );
+
         // Advertise the call state change and then return to command mode.
         sendState( info );
         send( "OK" );
@@ -176,6 +178,8 @@ bool CallManager::command( const QString& cmd )
                 info.dialBack =3D false;
                 callList +=3D info;
 =

+                emit callStatesChanged( &callList );
+
                 // Advertise the call state change and then return to comm=
and mode.
                 sendState( info );
                 send( "CONNECT 19200" );
@@ -369,6 +373,7 @@ void CallManager::startIncomingCall( const QString& num=
ber,
     callList +=3D info;
 =

     emitRing(info);
+    emit callStatesChanged( &callList );
 =

     // Announce the incoming call using Ericsson-style state notifications.
     sendState( info );
@@ -395,6 +400,7 @@ void CallManager::hangupAll()
     connectTimer->stop();
     alertingTimer->stop();
     hangupTimer->stop();
+    emit callStatesChanged( &callList );
 }
 =

 void CallManager::hangupConnected()
@@ -412,6 +418,8 @@ void CallManager::hangupConnected()
 =

     if ( !hasCall( CallState_Held ) )
         waitingToIncoming();
+
+    emit callStatesChanged( &callList );
 }
 =

 void CallManager::hangupHeld()
@@ -429,6 +437,8 @@ void CallManager::hangupHeld()
 =

     if ( !hasCall( CallState_Active ) )
         waitingToIncoming();
+
+    emit callStatesChanged( &callList );
 }
 =

 void CallManager::hangupConnectedAndHeld()
@@ -445,6 +455,7 @@ void CallManager::hangupConnectedAndHeld()
     }
     callList =3D newCallList;
     waitingToIncoming();
+    emit callStatesChanged( &callList );
 }
 =

 void CallManager::hangupCall( int id )
@@ -466,11 +477,13 @@ bool CallManager::acceptCall()
         changeGroup( CallState_Active, CallState_Held );
         callList[index].state =3D CallState_Active;
         sendState( callList[index] );
+        emit callStatesChanged( &callList );
         return true;
     } else {
         // Only held calls, or no other calls, so just make the incoming c=
all active.
         callList[index].state =3D CallState_Active;
         sendState( callList[index] );
+        emit callStatesChanged( &callList );
         return true;
     }
 }
@@ -500,6 +513,7 @@ bool CallManager::chld1()
         int index =3D indexForId(id);
         callList[index].state =3D CallState_Active;
         sendState( callList[index] );
+        emit callStatesChanged( &callList );
         return true;
     } else if ( hasCall( CallState_Held ) ) {
         // Hangup the active calls and activate the held ones.
@@ -508,6 +522,7 @@ bool CallManager::chld1()
             if ( callList[index].state =3D=3D CallState_Held ) {
                 callList[index].state =3D CallState_Active;
                 sendState( callList[index] );
+                emit callStatesChanged( &callList );
             }
         }
         return true;
@@ -551,6 +566,7 @@ bool CallManager::chld1x( int x )
     if ( !hasCall( CallState_Active ) && !hasCall( CallState_Held ) )
         waitingToIncoming();
 =

+    emit callStatesChanged( &callList );
     return found;
 }
 =

@@ -570,6 +586,7 @@ bool CallManager::chld2()
         int index =3D indexForId( id );
         callList[index].state =3D CallState_Active;
         sendState( callList[index] );
+        emit callStatesChanged( &callList );
         return true;
     } else if ( hasCall( CallState_Active ) && hasCall( CallState_Held ) )=
 {
         // Swap the active and held calls.
@@ -620,6 +637,7 @@ bool CallManager::chld2x( int x )
             // No active calls, so make just this call active.
             callList[index].state =3D CallState_Active;
             sendState( callList[index] );
+            emit callStatesChanged( &callList );
         }
         return true;
     } else if ( callList[index].state =3D=3D CallState_Active ) {
@@ -634,6 +652,7 @@ bool CallManager::chld2x( int x )
                     return false;
                 callList[index2].state =3D CallState_Held;
                 sendState( callList[index2] );
+                emit callStatesChanged( &callList );
             }
         }
         return true;
@@ -691,6 +710,7 @@ void CallManager::dialingToConnected()
     // Transition the call to its new state.
     callList[index].state =3D CallState_Active;
     sendState( callList[index] );
+    emit callStatesChanged( &callList );
     // If the dialed number starts with 05123, disconnect the
     // call after xx seconds, where xx is part of the dial string
     // as 05123xx
@@ -714,6 +734,7 @@ void CallManager::dialingToAlerting()
     // Transition the call to its new state.
     callList[index].state =3D CallState_Alerting;
     sendState( callList[index] );
+    emit callStatesChanged( &callList );
 }
 =

 void CallManager::waitingToIncoming()
@@ -856,6 +877,7 @@ void CallManager::changeGroup( CallState oldState, Call=
State newState )
             sendState( callList[index] );
         }
     }
+    emit callStatesChanged( &callList );
 }
 =

 void CallManager::sendState( const CallInfo& info )
diff --git a/src/callmanager.h b/src/callmanager.h
index 5876c87..228e26c 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -114,6 +114,9 @@ signals:
     // Send a call control event.
     void controlEvent( const QSimControlEvent& event );
 =

+    // Send calls list on status change
+    void callStatesChanged( QList<CallInfo> *list );
+
 private slots:
     // Transition the active dialing or alerting call to connected.
     void dialingToConnected();
-- =

1.7.1


--===============5945255555085199586==--

