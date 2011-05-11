Content-Type: multipart/mixed; boundary="===============5002900117734309889=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 3/5] callmanager: Change call state management slots
Date: Wed, 11 May 2011 13:46:45 +0200
Message-ID: <1305114407-23796-4-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305114407-23796-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5002900117734309889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/callmanager.cpp |    7 +++++++
 src/callmanager.h   |   12 ++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index 0ede2ad..8085056 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -700,6 +700,10 @@ bool CallManager::chld4()
 =

 void CallManager::dialingToConnected()
 {
+    // Stop timers in case they are still active
+    alertingTimer->stop();
+    connectTimer->stop();
+
     // Find the currently dialing or alerting call.
     int index =3D indexForId( idForState( CallState_Dialing ) );
     if ( index < 0 )
@@ -726,6 +730,9 @@ void CallManager::dialingToConnected()
 =

 void CallManager::dialingToAlerting()
 {
+    // Stop the timer in case it is still active
+    alertingTimer->stop();
+
     // Find the currently dialing or alerting call.
     int index =3D indexForId( idForState( CallState_Dialing ) );
     if ( index < 0 )
diff --git a/src/callmanager.h b/src/callmanager.h
index 228e26c..c953a7d 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -100,6 +100,12 @@ public slots:
     void startIncomingCall( const QString& number, const QString& calledNu=
mber,
                                 const QString& name );
 =

+    // Transition the active dialing or alerting call to connected.
+    void dialingToConnected();
+
+    // Transition the active dialing call to alerting.
+    void dialingToAlerting();
+
 signals:
     // Send a response to a command.
     void send( const QString& line );
@@ -118,12 +124,6 @@ signals:
     void callStatesChanged( QList<CallInfo> *list );
 =

 private slots:
-    // Transition the active dialing or alerting call to connected.
-    void dialingToConnected();
-
-    // Transition the active dialing call to alerting.
-    void dialingToAlerting();
-
     // Transition the waiting call to incoming.
     void waitingToIncoming();
 =

-- =

1.7.1


--===============5002900117734309889==--

