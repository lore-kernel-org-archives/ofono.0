Content-Type: multipart/mixed; boundary="===============5765109466886522043=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH] Simulate send ss command in sim app
Date: Thu, 09 Sep 2010 23:47:17 +0800
Message-ID: <1284047237-5012-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5765109466886522043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |  700 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |   16 ++
 2 files changed, 716 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 6ca03d9..dad9635 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -280,6 +280,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_Finance    8
 #define MainMenu_Browser    9
 #define MainMenu_DTMF       10
+#define MainMenu_SendSS     11
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -290,6 +291,46 @@ const QString DemoSimApplication::getName()
 #define CallsMenu_Disconnect    2
 #define CallsMenu_Hold          3
 =

+#define SendSSMenu_CB       1
+#define SendSSMenu_CF       2
+#define SendSSMenu_CW       3
+#define SendSSMenu_CLIP     4
+#define SendSSMenu_CLIR     5
+#define SendSSMenu_CoLP     6
+#define SendSSMenu_CoLR     7
+
+#define CBMenu_Registration     1
+#define CBMenu_Activation       2
+#define CBMenu_Interrogation    3
+#define CBMenu_Deactivation     4
+#define CBMenu_Erasure          5
+
+#define CFMenu_Registration     1
+#define CFMenu_Activation       2
+#define CFMenu_Interrogation    3
+#define CFMenu_Deactivation     4
+#define CFMenu_Erasure          5
+
+#define CWMenu_Activation       1
+#define CWMenu_Interrogation    2
+#define CWMenu_Deactivation     3
+
+#define CLIPMenu_Activation       1
+#define CLIPMenu_Interrogation    2
+#define CLIPMenu_Deactivation     3
+
+#define CLIRMenu_Activation       1
+#define CLIRMenu_Interrogation    2
+#define CLIRMenu_Deactivation     3
+
+#define CoLPMenu_Activation       1
+#define CoLPMenu_Interrogation    2
+#define CoLPMenu_Deactivation     3
+
+#define CoLRMenu_Activation       1
+#define CoLRMenu_Interrogation    2
+#define CoLRMenu_Deactivation     3
+
 void DemoSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -338,6 +379,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "DialTones" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_SendSS );
+    item.setLabel( "Send SS" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -432,6 +477,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_SendSS:
+        {
+            sendSendSSMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -970,3 +1021,652 @@ void DemoSimApplication::browserMenu( const QSimTerm=
inalResponse& resp )
         endSession();
     }
 }
+
+void DemoSimApplication::sendSendSSMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Send SS" );
+
+    item.setIdentifier( SendSSMenu_CB );
+    item.setLabel( "CB (Call Barring)" );
+    items +=3D item;
+
+    item.setIdentifier( SendSSMenu_CF );
+    item.setLabel( "CF (Call Forwarding)" );
+    items +=3D item;
+
+    item.setIdentifier( SendSSMenu_CW );
+    item.setLabel( "CW (Call Waiting)" );
+    items +=3D item;
+
+    item.setIdentifier( SendSSMenu_CLIP );
+    item.setLabel( "CLIP (Calling Line Idnetification Presentation)" );
+    items +=3D item;
+
+    item.setIdentifier( SendSSMenu_CLIR );
+    item.setLabel( "CLIR (Calling Line Identification Restriction)" );
+    items +=3D item;
+
+    item.setIdentifier( SendSSMenu_CoLP );
+    item.setLabel( "CoLP (Connected Line Identification Presentation)" );
+    items +=3D item;
+
+    item.setIdentifier( SendSSMenu_CoLR );
+    item.setLabel( "CoLR (Connected Line Identification Restriction)" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(sendSSMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::sendSSMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case SendSSMenu_CB:
+            {
+                sendCBMenu();
+            }
+            break;
+
+            case SendSSMenu_CF:
+            {
+                sendCFMenu();
+            }
+            break;
+
+            case SendSSMenu_CW:
+            {
+                sendCWMenu();
+            }
+            break;
+
+            case SendSSMenu_CLIP:
+            {
+                sendCLIPMenu();
+            }
+            break;
+
+            case SendSSMenu_CLIR:
+            {
+                sendCLIRMenu();
+            }
+            break;
+
+            case SendSSMenu_CoLP:
+            {
+                sendCoLPMenu();
+            }
+            break;
+
+            case SendSSMenu_CoLR:
+            {
+                sendCoLRMenu();
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
+
+void DemoSimApplication::sendCBMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "CB" );
+
+    item.setIdentifier( CBMenu_Registration );
+    item.setLabel( "Registration" );
+    items +=3D item;
+
+    item.setIdentifier( CBMenu_Activation );
+    item.setLabel( "Activation" );
+    items +=3D item;
+
+    item.setIdentifier( CBMenu_Interrogation );
+    item.setLabel( "Interrogation" );
+    items +=3D item;
+
+    item.setIdentifier( CBMenu_Deactivation );
+    item.setLabel( "Deactivation" );
+    items +=3D item;
+
+    item.setIdentifier( CBMenu_Erasure );
+    item.setLabel( "Erasure" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(CBMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::CBMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case CBMenu_Registration:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "**33#" );
+                command( cmd, this, SLOT(sendCBMenu()) );
+            }
+            break;
+
+            case CBMenu_Activation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*33#" );
+                command( cmd, this, SLOT(sendCBMenu()) );
+            }
+            break;
+
+            case CBMenu_Interrogation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*#33#" );
+                command( cmd, this, SLOT(sendCBMenu()) );
+            }
+                break;
+
+            case CBMenu_Deactivation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "#33#" );
+                command( cmd, this, SLOT(sendCBMenu()) );
+            }
+            break;
+
+            case CBMenu_Erasure:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "##33#" );
+                command( cmd, this, SLOT(sendCBMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSendSSMenu();
+    } else {
+        endSession();
+    }
+}
+
+void DemoSimApplication::sendCFMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "CF" );
+
+    item.setIdentifier( CFMenu_Registration );
+    item.setLabel( "Registration" );
+    items +=3D item;
+
+    item.setIdentifier( CFMenu_Activation );
+    item.setLabel( "Activation" );
+    items +=3D item;
+
+    item.setIdentifier( CFMenu_Interrogation );
+    item.setLabel( "Interrogation" );
+    items +=3D item;
+
+    item.setIdentifier( CFMenu_Deactivation );
+    item.setLabel( "Deactivation" );
+    items +=3D item;
+
+    item.setIdentifier( CFMenu_Erasure );
+    item.setLabel( "Erasure" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(CFMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::CFMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case CFMenu_Registration:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "**002#" );
+                command( cmd, this, SLOT(sendCFMenu()) );
+            }
+            break;
+
+            case CFMenu_Activation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*002#" );
+                command( cmd, this, SLOT(sendCFMenu()) );
+            }
+            break;
+
+            case CFMenu_Interrogation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*#002#" );
+                command( cmd, this, SLOT(sendCFMenu()) );
+            }
+            break;
+
+            case CFMenu_Deactivation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "#002#" );
+                command( cmd, this, SLOT(sendCFMenu()) );
+            }
+            break;
+
+            case CFMenu_Erasure:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "##002#" );
+                command( cmd, this, SLOT(sendCFMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSendSSMenu();
+    } else {
+        endSession();
+    }
+}
+
+void DemoSimApplication::sendCWMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "CW" );
+
+    item.setIdentifier( CWMenu_Activation );
+    item.setLabel( "Activation" );
+    items +=3D item;
+
+    item.setIdentifier( CWMenu_Interrogation );
+    item.setLabel( "Interrogation" );
+    items +=3D item;
+
+    item.setIdentifier( CWMenu_Deactivation );
+    item.setLabel( "Deactivation" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(CWMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::CWMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case CWMenu_Activation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*43#" );
+                command( cmd, this, SLOT(sendCWMenu()) );
+            }
+            break;
+
+            case CWMenu_Interrogation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*#43#" );
+                command( cmd, this, SLOT(sendCWMenu()) );
+            }
+            break;
+
+            case CWMenu_Deactivation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "#43#" );
+                command( cmd, this, SLOT(sendCWMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSendSSMenu();
+    } else {
+        endSession();
+    }
+}
+
+void DemoSimApplication::sendCLIPMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "CLIP" );
+
+    item.setIdentifier( CLIPMenu_Activation );
+    item.setLabel( "Activation" );
+    items +=3D item;
+
+    item.setIdentifier( CLIPMenu_Interrogation );
+    item.setLabel( "Interrogation" );
+    items +=3D item;
+
+    item.setIdentifier( CLIPMenu_Deactivation );
+    item.setLabel( "Deactivation" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(CLIPMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::CLIPMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case CLIPMenu_Activation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*30#" );
+                command( cmd, this, SLOT(sendCLIPMenu()) );
+            }
+            break;
+
+            case CLIPMenu_Interrogation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*#30#" );
+                command( cmd, this, SLOT(sendCLIPMenu()) );
+            }
+            break;
+
+            case CLIPMenu_Deactivation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "#30#" );
+                command( cmd, this, SLOT(sendCLIPMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSendSSMenu();
+    } else {
+        endSession();
+    }
+}
+
+void DemoSimApplication::sendCLIRMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "CLIR" );
+
+    item.setIdentifier( CLIRMenu_Activation );
+    item.setLabel( "Activation" );
+    items +=3D item;
+
+    item.setIdentifier( CLIRMenu_Interrogation );
+    item.setLabel( "Interrogation" );
+    items +=3D item;
+
+    item.setIdentifier( CLIRMenu_Deactivation );
+    item.setLabel( "Deactivation" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(CLIRMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::CLIRMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case CLIRMenu_Activation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*31#" );
+                command( cmd, this, SLOT(sendCLIRMenu()) );
+            }
+            break;
+
+            case CLIRMenu_Interrogation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*#31#" );
+                command( cmd, this, SLOT(sendCLIRMenu()) );
+            }
+            break;
+
+            case CLIRMenu_Deactivation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "#31#" );
+                command( cmd, this, SLOT(sendCLIRMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSendSSMenu();
+    } else {
+        endSession();
+    }
+}
+
+void DemoSimApplication::sendCoLPMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "CoLP" );
+
+    item.setIdentifier( CoLPMenu_Activation );
+    item.setLabel( "Activation" );
+    items +=3D item;
+
+    item.setIdentifier( CoLPMenu_Interrogation );
+    item.setLabel( "Interrogation" );
+    items +=3D item;
+
+    item.setIdentifier( CoLPMenu_Deactivation );
+    item.setLabel( "Deactivation" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(CoLPMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::CoLPMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case CoLPMenu_Activation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*76#" );
+                command( cmd, this, SLOT(sendCoLPMenu()) );
+            }
+            break;
+
+            case CoLPMenu_Interrogation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*#76#" );
+                command( cmd, this, SLOT(sendCoLPMenu()) );
+            }
+            break;
+
+            case CoLPMenu_Deactivation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "#76#" );
+                command( cmd, this, SLOT(sendCoLPMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSendSSMenu();
+    } else {
+        endSession();
+    }
+}
+
+void DemoSimApplication::sendCoLRMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "CoLR" );
+
+    item.setIdentifier( CoLRMenu_Activation );
+    item.setLabel( "Activation" );
+    items +=3D item;
+
+    item.setIdentifier( CoLRMenu_Interrogation );
+    item.setLabel( "Interrogation" );
+    items +=3D item;
+
+    item.setIdentifier( CoLRMenu_Deactivation );
+    item.setLabel( "Deactivation" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(CoLRMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::CoLRMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case CoLRMenu_Activation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*77#" );
+                command( cmd, this, SLOT(sendCoLRMenu()) );
+            }
+            break;
+
+            case CoLRMenu_Interrogation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*#77#" );
+                command( cmd, this, SLOT(sendCoLRMenu()) );
+            }
+            break;
+
+            case CoLRMenu_Deactivation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "#77#" );
+                command( cmd, this, SLOT(sendCoLRMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSendSSMenu();
+    } else {
+        endSession();
+    }
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index adaf2c2..0f67317 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -93,6 +93,22 @@ protected slots:
     void sendBrowserMenu();
     void browserMenu( const QSimTerminalResponse& resp );
     void sendDTMF();
+    void sendSendSSMenu();
+    void sendSSMenu( const QSimTerminalResponse& resp );
+    void sendCBMenu();
+    void CBMenu( const QSimTerminalResponse& resp );
+    void sendCFMenu();
+    void CFMenu( const QSimTerminalResponse& resp );
+    void sendCWMenu();
+    void CWMenu( const QSimTerminalResponse& resp );
+    void sendCLIPMenu();
+    void CLIPMenu( const QSimTerminalResponse& resp );
+    void sendCLIRMenu();
+    void CLIRMenu( const QSimTerminalResponse& resp );
+    void sendCoLPMenu();
+    void CoLPMenu( const QSimTerminalResponse& resp );
+    void sendCoLRMenu();
+    void CoLRMenu( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.0.4


--===============5765109466886522043==--

