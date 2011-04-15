Content-Type: multipart/mixed; boundary="===============1625695535853397457=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] callmanager: change state of waiting call
Date: Fri, 15 Apr 2011 14:29:44 +0200
Message-ID: <1302870584-20431-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1625695535853397457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

becomes incoming when all active and held are released

---
 src/callmanager.cpp |   25 +++++++++++++++++++++----
 src/callmanager.h   |    3 +++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index be17b83..929c182 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -409,6 +409,9 @@ void CallManager::hangupConnected()
         }
     }
     callList =3D newCallList;
+
+    if ( !hasCall( CallState_Held ) )
+        waitingToIncoming();
 }
 =

 void CallManager::hangupHeld()
@@ -423,6 +426,9 @@ void CallManager::hangupHeld()
         }
     }
     callList =3D newCallList;
+
+    if ( !hasCall( CallState_Active ) )
+        waitingToIncoming();
 }
 =

 void CallManager::hangupConnectedAndHeld()
@@ -438,6 +444,7 @@ void CallManager::hangupConnectedAndHeld()
         }
     }
     callList =3D newCallList;
+    waitingToIncoming();
 }
 =

 void CallManager::hangupCall( int id )
@@ -508,10 +515,6 @@ bool CallManager::chld1()
         // We only have active calls - hang them up.
         hangupConnected();
         return true;
-    } else if ( hasCall( CallState_Active ) ) {
-        // We only have active calls - hang them up.
-        hangupConnected();
-        return true;
     } else if ( ( id =3D idForDialing() ) >=3D 0 ) {
         // We have a dialing call.
         hangupCall(id);
@@ -544,6 +547,10 @@ bool CallManager::chld1x( int x )
         }
     }
     callList =3D newCallList;
+
+    if ( !hasCall( CallState_Active )  && !hasCall( CallState_Held ) )
+        waitingToIncoming();
+
     return found;
 }
 =

@@ -709,6 +716,16 @@ void CallManager::dialingToAlerting()
     sendState( callList[index] );
 }
 =

+void CallManager::waitingToIncoming()
+{
+	int index =3D indexForId( idForState( CallState_Waiting ) );
+	if ( index < 0 )
+		return;
+
+    callList[index].state =3D CallState_Incoming;
+    sendState( callList[index] );
+}
+
 void CallManager::dialBack()
 {
     startIncomingCall( "1234567", "7654321", "Alice", true );
diff --git a/src/callmanager.h b/src/callmanager.h
index 90cb9bd..5876c87 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -121,6 +121,9 @@ private slots:
     // Transition the active dialing call to alerting.
     void dialingToAlerting();
 =

+    // Transition the waiting call to incoming.
+    void waitingToIncoming();
+
     // Handle dial-backs.
     void dialBack();
     void dialBackWithHangup5();
-- =

1.7.1


--===============1625695535853397457==--

