Content-Type: multipart/mixed; boundary="===============3706751184371648063=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] phonesim: Add SIM Refresh commands to sim app menu.
Date: Tue, 23 Nov 2010 14:34:46 +0100
Message-ID: <1290519286-25046-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1290519286-25046-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3706751184371648063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |  104 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 2 files changed, 106 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index d9e3b77..5f99490 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -289,6 +289,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_SendSMS    14
 #define MainMenu_Polling    15
 #define MainMenu_Timers     16
+#define MainMenu_Refresh    17
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -438,6 +439,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Timers" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_Refresh );
+    item.setLabel( "SIM Refresh" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -568,6 +573,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_Refresh:
+        {
+            sendRefreshMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -2215,3 +2226,96 @@ bool DemoSimApplication::envelope( const QSimEnvelop=
e& env )
 =

     return true;
 }
+
+void DemoSimApplication::sendRefreshMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "SIM Refresh menu" );
+
+    /* Use qualifier value + 1 for id */
+    item.setIdentifier( 1 );
+    item.setLabel( "NAA Initialization+Full File Change Notification" );
+    items +=3D item;
+
+    item.setIdentifier( 2 );
+    item.setLabel( "File Change Notification (EFmsisdn,EFecc,EFfdn)" );
+    items +=3D item;
+
+    item.setIdentifier( 3 );
+    item.setLabel( "NAA Initialization+File Change Notification" );
+    items +=3D item;
+
+    item.setIdentifier( 4 );
+    item.setLabel( "NAA Initialization" );
+    items +=3D item;
+
+    item.setIdentifier( 5 );
+    item.setLabel( "UICC Reset" );
+    items +=3D item;
+
+    item.setIdentifier( 6 );
+    item.setLabel( "NAA Application Reset" );
+    items +=3D item;
+
+    item.setIdentifier( 7 );
+    item.setLabel( "NAA Session Reset" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(refreshMenuResp(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::refreshMenuResp( const QSimTerminalResponse& resp=
 )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() !=3D QSimTerminalResponse::Success ) {
+        /* Unknown response - just go back to the main menu. */
+        endSession();
+
+        return;
+    }
+
+    /* Item selected. */
+
+    cmd.setType( QSimCommand::Refresh );
+    cmd.setQualifier( resp.menuItem() - 1 );
+    cmd.setDestinationDevice( QSimCommand::ME );
+    cmd.setText( "" );
+
+    if ( cmd.refreshType() =3D=3D QSimCommand::FileChange ||
+            cmd.refreshType() =3D=3D QSimCommand::InitAndFileChange ||
+            cmd.refreshType() =3D=3D QSimCommand::NaaSessionReset ) {
+        QByteArray files;
+        files +=3D (char) 0x03;
+        /* EFmsisdn */
+        files +=3D (char) 0x3f;
+        files +=3D (char) 0x00;
+        files +=3D (char) 0x7f;
+        files +=3D (char) 0xff;
+        files +=3D (char) 0x6f;
+        files +=3D (char) 0x40;
+        /* EFecc */
+        files +=3D (char) 0x3f;
+        files +=3D (char) 0x00;
+        files +=3D (char) 0x7f;
+        files +=3D (char) 0xff;
+        files +=3D (char) 0x6f;
+        files +=3D (char) 0xb7;
+        /* EFfdn */
+        files +=3D (char) 0x3f;
+        files +=3D (char) 0x00;
+        files +=3D (char) 0x7f;
+        files +=3D (char) 0xff;
+        files +=3D (char) 0x6f;
+        files +=3D (char) 0x3b;
+        cmd.addExtensionField( 0x92, files );
+    }
+
+    command( cmd, this, SLOT(endSession()) );
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index dbf061d..076a668 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -124,6 +124,8 @@ protected slots:
     void sendTimersMenu();
     void timersMenuResp( const QSimTerminalResponse& resp );
     void timersCmdResp( const QSimTerminalResponse& resp );
+    void sendRefreshMenu();
+    void refreshMenuResp( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.1.86.g0e460.dirty


--===============3706751184371648063==--

