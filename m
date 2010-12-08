Content-Type: multipart/mixed; boundary="===============7624757899686206849=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] Simulate provide local info command in sim app
Date: Wed, 08 Dec 2010 15:18:27 +0800
Message-ID: <1291792707-4988-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7624757899686206849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |   68 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 62bbe9d..388b2ce 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -290,6 +290,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_Polling    15
 #define MainMenu_Timers     16
 #define MainMenu_Refresh    17
+#define MainMenu_LocalInfo  18
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -348,6 +349,9 @@ const QString DemoSimApplication::getName()
 #define SendUSSD_Error      4
 #define SendUSSD_Main       5
 =

+#define LocalInfoMenu_Time  1
+#define LocalInfoMenu_Lang  2
+
 enum SendSMSMenuItems {
 	SendSMS_Unpacked =3D 1,
 	SendSMS_Packed,
@@ -443,6 +447,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "SIM Refresh" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_LocalInfo );
+    item.setLabel( "Provide Local Information" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -579,6 +587,12 @@ void DemoSimApplication::mainMenuSelection( int id )
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
@@ -2319,3 +2333,57 @@ void DemoSimApplication::refreshMenuResp( const QSim=
TerminalResponse& resp )
 =

     command( cmd, this, SLOT(endSession()) );
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
diff --git a/src/simapplication.h b/src/simapplication.h
index df36bbb..45cfa84 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -126,6 +126,8 @@ protected slots:
     void timersCmdResp( const QSimTerminalResponse& resp );
     void sendRefreshMenu();
     void refreshMenuResp( const QSimTerminalResponse& resp );
+    void sendLocalInfoMenu();
+    void localInfoMenu( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.2.3


--===============7624757899686206849==--

