Content-Type: multipart/mixed; boundary="===============7414539281218051721=="
MIME-Version: 1.0
From: ext-arun.1.ravindran@nokia.com
Subject: [PATCH] Simulation of MT release of call to special number
Date: Fri, 17 Sep 2010 11:16:57 +0300
Message-ID: <1284711417-25424-1-git-send-email-ext-arun.1.ravindran@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7414539281218051721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>

---
 src/callmanager.cpp |   17 +++++++++++++++++
 src/callmanager.h   |    3 +++
 src/default.xml     |    1 +
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index 5336d27..06f426d 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -643,6 +643,17 @@ void CallManager::dialingToConnected()
     // Transition the call to its new state.
     callList[index].state =3D CallState_Active;
     sendState( callList[index] );
+    // If the dialed number starts with 05123, disconnect the
+    // call after xx seconds, where xx is part of the dial string
+    // as 05123xx
+    if( callList[index].number.startsWith( "05123" ) ) {
+        bool ok;
+        QString temp =3D callList[index].number;
+        temp =3D temp.replace( "05123" , "" );
+        int timeout =3D temp.toInt( &ok, 10 );
+        timeout =3D ok ? timeout * 1000: 10000;
+        QTimer::singleShot( timeout, this, SLOT(hangup()) );
+    }
 }
 =

 void CallManager::dialingToAlerting()
@@ -686,6 +697,12 @@ void CallManager::hangupTimeout()
     }
 }
 =

+void CallManager::hangup()
+{
+    send ( "NO CARRIER" );
+    hangupConnected();
+}
+
 void CallManager::sendNextRing()
 {
     if ( idForIncoming() >=3D 0 ) {
diff --git a/src/callmanager.h b/src/callmanager.h
index 875687e..3dd01cd 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -128,6 +128,9 @@ private slots:
     // Send the next RING indication for incoming calls.
     void sendNextRing();
 =

+    // Hangup the connected call after xx seconds
+    void hangup();
+
 private:
     QList<CallInfo> callList;
     QTimer *connectTimer;
diff --git a/src/default.xml b/src/default.xml
index ef8ac83..135bad3 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -7,6 +7,7 @@
 <!-- Note: dialing 177 will cause a dialback to simulate an incoming call,=
 and hangup after 5 seconds -->
 <!-- Note: dialing 166 will accept the incoming call and hangup up after 5=
 seconds-->
 <!-- Note: dialing 155 will elicit a 'BUSY' response from the recipient-->
+<!-- Note: dialing 05123xx cause an MT disconnect of the connected call af=
ter xx seconds-->
 =

 <!-- Initialize state variables -->
 =

-- =

1.7.0.4


--===============7414539281218051721==--

