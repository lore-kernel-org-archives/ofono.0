Content-Type: multipart/mixed; boundary="===============7378045759192951876=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 2/5] callmanager: Remote hangup slot
Date: Wed, 18 May 2011 15:33:27 +0200
Message-ID: <1305725610-32602-3-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305725610-32602-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7378045759192951876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/callmanager.cpp |   23 +++++++++++++++++++++++
 src/callmanager.h   |    3 +++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index fb132b5..a9fe171 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -445,6 +445,29 @@ void CallManager::hangupCall( int id )
     chld1x( id );
 }
 =

+void CallManager::hangupRemote( int id )
+{
+    int index =3D indexForId( id );
+    if ( index >=3D 0 )
+    {
+        if ( callList[index].state =3D=3D CallState_Dialing ||
+                callList[index].state =3D=3D CallState_Alerting )
+        {
+            hangupTimer->stop();
+        }
+        callList[index].state =3D CallState_Hangup;
+        sendState( callList[index] );
+
+        callList.removeAt( index );
+
+        if ( !hasCall( CallState_Active ) && !hasCall( CallState_Held ) )
+            waitingToIncoming();
+
+        send ( "NO CARRIER" );
+        emit callStatesChanged( &callList );
+    }
+}
+
 bool CallManager::acceptCall()
 {
     int id =3D idForIncoming();
diff --git a/src/callmanager.h b/src/callmanager.h
index ff3ac30..c34e7fd 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -106,6 +106,9 @@ public slots:
     // Transition the active dialing call to alerting.
     void dialingToAlerting();
 =

+    // Simulate a remote hangup.
+    void hangupRemote( int id );
+
 signals:
     // Send a response to a command.
     void send( const QString& line );
-- =

1.7.1


--===============7378045759192951876==--

