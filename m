Content-Type: multipart/mixed; boundary="===============4725876581792636385=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] phonesim: Simulate a Send DTMF command in sim app.
Date: Wed, 08 Sep 2010 19:54:35 +0200
Message-ID: <1283968475-4848-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4725876581792636385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qsimcommand.cpp    |    6 ++++--
 src/simapplication.cpp |   23 +++++++++++++++++++++++
 src/simapplication.h   |    1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index 770925f..9a9a169 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -815,7 +815,8 @@ void QSimCommand::setHasHelp( bool value )
 =

     Applies to: \c DisplayText, \c GetInkey, \c GetInput, \c SendSS, \c Se=
ndSMS,
     \c SendUSSD, \c PlayTone, \c ServiceSearch, \c GetServiceInformation,
-    \c RetrieveMultimediaMessage, \c SubmitMultimediaMessage.
+    \c RetrieveMultimediaMessage, \c SubmitMultimediaMessage, \c RunATComm=
and,
+    \c SendDTMF, \c LaunchBrowser, \c SetupIdleModeText, \c SetupCall.
 =

     \sa setText()
 */
@@ -830,7 +831,8 @@ QString QSimCommand::text() const
 =

     Applies to: \c DisplayText, \c GetInkey, \c GetInput, \c SendSS, \c Se=
ndSMS,
     \c SendUSSD, \c PlayTone, \c ServiceSearch, \c GetServiceInformation,
-    \c RetrieveMultimediaMessage, \c SubmitMultimediaMessage.
+    \c RetrieveMultimediaMessage, \c SubmitMultimediaMessage, \c RunATComm=
and,
+    \c SendDTMF, \c LaunchBrowser, \c SetupIdleModeText, \c SetupCall.
 =

     \sa text()
 */
diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index fe6e183..6ca03d9 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -279,6 +279,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_IconsSE    7
 #define MainMenu_Finance    8
 #define MainMenu_Browser    9
+#define MainMenu_DTMF       10
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -333,6 +334,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Web Browser" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_DTMF );
+    item.setLabel( "DialTones" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -421,6 +426,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_DTMF:
+        {
+            sendDTMF();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -751,6 +762,18 @@ void DemoSimApplication::toneMenu( const QSimTerminalR=
esponse& resp )
     }
 }
 =

+void DemoSimApplication::sendDTMF()
+{
+    QSimCommand cmd;
+
+    cmd.setType( QSimCommand::SendDTMF );
+    cmd.setDestinationDevice( QSimCommand::Network );
+    cmd.setNumber( "1p234ppp5" );
+    cmd.setText( "Sending DTMFs to network" );
+
+    command( cmd, this, SLOT(endSession()) );
+}
+
 void DemoSimApplication::sendIconMenu()
 {
     QSimCommand cmd;
diff --git a/src/simapplication.h b/src/simapplication.h
index 75abd0b..adaf2c2 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -92,6 +92,7 @@ protected slots:
     void displayTextResponse( const QSimTerminalResponse& resp );
     void sendBrowserMenu();
     void browserMenu( const QSimTerminalResponse& resp );
+    void sendDTMF();
 =

 private:
     int sticksLeft;
-- =

1.7.1.86.g0e460.dirty


--===============4725876581792636385==--

