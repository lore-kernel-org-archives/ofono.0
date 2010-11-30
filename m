Content-Type: multipart/mixed; boundary="===============4143666292621177374=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] Simulate provide local info command in sim app
Date: Tue, 30 Nov 2010 18:43:43 +0800
Message-ID: <1291113823-22575-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4143666292621177374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |   68 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 05ae21f..bc96a8c 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -288,6 +288,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_SendUSSD   13
 #define MainMenu_SendSMS    14
 #define MainMenu_Polling    15
+#define MainMenu_LocalInfo  16
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -346,6 +347,9 @@ const QString DemoSimApplication::getName()
 #define SendUSSD_Error      4
 #define SendUSSD_Main       5
 =

+#define LocalInfoMenu_Time  1
+#define LocalInfoMenu_Lang  2
+
 enum SendSMSMenuItems {
 	SendSMS_Unpacked =3D 1,
 	SendSMS_Packed,
@@ -426,6 +430,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "SIM Polling" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_LocalInfo );
+    item.setLabel( "Provide Local Information" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -550,6 +558,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_LocalInfo:
+        {
+            sendLocalInfoMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -2044,3 +2058,57 @@ void DemoSimApplication::pollingMenuResp( const QSim=
TerminalResponse& resp )
         break;
     }
 }
+
+void DemoSimApplication::sendLocalInfoMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Provide Local Information" );
+
+    item.setIdentifier( LocalInfoMenu_Time );
+    item.setLabel( "Date, time and time zone" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_Lang );
+    item.setLabel( "Language setting" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(localInfoMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::localInfoMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case LocalInfoMenu_Time:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x03 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_Lang:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x04 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else {
+        endSession();
+    }
+}
\ No newline at end of file
diff --git a/src/simapplication.h b/src/simapplication.h
index 4a2430f..6f90a1f 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -119,6 +119,8 @@ protected slots:
     void smsSetTextResp( const QSimTerminalResponse& resp );
     void sendPollingMenu();
     void pollingMenuResp( const QSimTerminalResponse& resp );
+    void sendLocalInfoMenu();
+    void localInfoMenu ( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.2.3


--===============4143666292621177374==--

