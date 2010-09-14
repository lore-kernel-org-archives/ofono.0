Content-Type: multipart/mixed; boundary="===============0923150267207816368=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] phonesim: simulate language notification in sim app
Date: Tue, 14 Sep 2010 15:27:55 -0700
Message-ID: <1284503275-21395-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0923150267207816368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qsimcommand.cpp    |   11 ++++++++
 src/simapplication.cpp |   68 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 3 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index 9a9a169..9746592 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -3280,6 +3280,17 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpt=
ions options ) const
         }
         break;
 =

+        case LanguageNotification:
+        {
+            if ( qualifier & 0x01 ) {
+                data +=3D (char)0xAD;
+                data +=3D (char)0x02;
+                data +=3D (char)0x73;
+                data +=3D (char)0x65;
+            }
+        }
+        break;
+
         default: break;
     }
 =

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 4af510b..a54ec10 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -281,6 +281,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_Browser    9
 #define MainMenu_DTMF       10
 #define MainMenu_SendSS     11
+#define MainMenu_Language   12
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -329,6 +330,10 @@ const QString DemoSimApplication::getName()
 #define CoLRMenu_Interrogation    2
 #define CoLRMenu_Deactivation     3
 =

+#define Language_Specific       1
+#define Language_Non_Specific   2
+#define Language_Main           3
+
 void DemoSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -381,6 +386,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Send SS" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_Language );
+    item.setLabel( "Language Notification" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -481,6 +490,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_Language:
+        {
+            sendLanguageMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -1642,3 +1657,56 @@ void DemoSimApplication::CoLRMenu( const QSimTermina=
lResponse& resp )
         endSession();
     }
 }
+
+void DemoSimApplication::sendLanguageMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Language Notification" );
+
+    item.setIdentifier( Language_Specific );
+    item.setLabel( "Specific Language" );
+    items +=3D item;
+
+    item.setIdentifier( Language_Non_Specific );
+    item.setLabel( "Non-Specific Language" );
+    items +=3D item;
+
+    item.setIdentifier( Language_Main );
+    item.setLabel( "Return to main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(languageMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::languageMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        cmd.setDestinationDevice( QSimCommand::ME );
+        cmd.setSourceDevice( QSimCommand::SIM );
+        cmd.setType( QSimCommand::LanguageNotification );
+
+        // Item selected.
+        switch ( resp.menuItem() ) {
+        case Language_Specific:
+            cmd.setQualifier( 1 );
+            command( cmd, this, SLOT(sendLanguageMenu()) );
+            break;
+        case Language_Non_Specific:
+            cmd.setQualifier( 0 );
+            command( cmd, this, SLOT(sendLanguageMenu()) );
+            break;
+        default:
+            endSession();
+            break;
+        }
+    } else
+        endSession();
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index 0f67317..fc57423 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -109,6 +109,8 @@ protected slots:
     void CoLPMenu( const QSimTerminalResponse& resp );
     void sendCoLRMenu();
     void CoLRMenu( const QSimTerminalResponse& resp );
+    void sendLanguageMenu();
+    void languageMenu( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.0.4


--===============0923150267207816368==--

