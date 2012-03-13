Content-Type: multipart/mixed; boundary="===============0672340117497677548=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] phonesim: Fix AT+CHLD=1x
Date: Tue, 13 Mar 2012 15:33:15 +0100
Message-ID: <1331649195-23257-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0672340117497677548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AT+CHLD=3D1x should only hangup active call
---
 src/callmanager.cpp |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index dfa2b9e..7208100 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -441,7 +441,21 @@ void CallManager::hangupConnectedAndHeld()
 =

 void CallManager::hangupCall( int id )
 {
-    chld1x( id );
+    QList<CallInfo> newCallList;
+    for ( int index =3D 0; index < callList.size(); ++index ) {
+	if ( callList[index].id =3D=3D id ) {
+	    callList[index].state =3D CallState_Hangup;
+	    sendState( callList[index] );
+	} else {
+	    newCallList +=3D callList[index];
+	}
+    }
+    callList =3D newCallList;
+
+    if ( !hasCall( CallState_Active ) && !hasCall( CallState_Held ) )
+	waitingToIncoming();
+
+    emit callStatesChanged( &callList );
 }
 =

 void CallManager::hangupRemote( int id )
@@ -491,8 +505,10 @@ bool CallManager::chld0()
 {
     // If there is an incoming call, then that is the one to hang up.
     int id =3D idForIncoming();
-    if ( id >=3D 0 )
-        return chld1x( id );
+    if ( id >=3D 0 ) {
+        hangupCall( id );
+        return true;
+    }
 =

     // Bail out if no held calls.
     if ( !hasCall( CallState_Held ) )
@@ -540,24 +556,18 @@ bool CallManager::chld1()
 =

 bool CallManager::chld1x( int x )
 {
-    QList<CallInfo> newCallList;
-    bool found =3D false;
     for ( int index =3D 0; index < callList.size(); ++index ) {
-        if ( callList[index].id =3D=3D x ) {
-            callList[index].state =3D CallState_Hangup;
-            sendState( callList[index] );
-            found =3D true;
-        } else {
-            newCallList +=3D callList[index];
+        if ( callList[index].id =3D=3D x && callList[index].state =3D=3D C=
allState_Active) {
+            hangupCall( x );
+            return true;
         }
     }
-    callList =3D newCallList;
 =

     if ( !hasCall( CallState_Active ) && !hasCall( CallState_Held ) )
-        waitingToIncoming();
+	waitingToIncoming();
 =

     emit callStatesChanged( &callList );
-    return found;
+    return false;
 }
 =

 bool CallManager::chld2()
-- =

1.7.1


--===============0672340117497677548==--

