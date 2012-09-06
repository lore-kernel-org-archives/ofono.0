Content-Type: multipart/mixed; boundary="===============7494125794473246095=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2] phonesim: Extend STK conformance menu with Setup Call items
Date: Thu, 06 Sep 2012 16:43:02 +0200
Message-ID: <1346942582-4873-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7494125794473246095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/conformancesimapplication.cpp |  247 +++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h              |    2 +
 2 files changed, 249 insertions(+)

diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
index a2bd3af..fd146f4 100644
--- a/src/conformancesimapplication.cpp
+++ b/src/conformancesimapplication.cpp
@@ -41,6 +41,7 @@ const QString ConformanceSimApplication::getName()
 #define ConformanceMenu_GetInkey    2
 #define ConformanceMenu_GetInput    3
 #define ConformanceMenu_MoreTime    4
+#define ConformanceMenu_SetupCall   5
 =

 #define NormalMenu_1_1    1
 #define NormalMenu_1_2    2
@@ -101,6 +102,20 @@ const QString ConformanceSimApplication::getName()
 #define GetInputMenu_Text_Attribute     11
 #define GetInputMenu_Main               12
 =

+#define SetupCall_Confirmed                1
+#define SetupCall_Long_AID                 2
+#define SetupCall_Subaddress_Not_Supported 3
+#define SetupCall_Rejected                 4
+#define SetupCall_Putting_On_Hold          5
+#define SetupCall_Disconnect_Others        6
+#define SetupCall_If_Not_Busy              7
+#define SetupCall_On_Hold_Not_allowed      8
+#define SetupCall_Max_Dialing_Number       9
+#define SetupCall_Two_AID                 10
+#define SetupCall_Basic_icon              11
+#define SetupCall_Self_basic_icon         12
+#define SetupCall_Basic_icon_during_call  13
+
 void ConformanceSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -126,6 +141,10 @@ void ConformanceSimApplication::mainMenu()
     item.setLabel( "More Time" );
     items +=3D item;
 =

+    item.setIdentifier( ConformanceMenu_SetupCall );
+    item.setLabel( "Setup Call" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -162,6 +181,12 @@ void ConformanceSimApplication::mainMenuSelection( int=
 id )
         }
         break;
 =

+        case ConformanceMenu_SetupCall:
+        {
+            sendSetupCallMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -1746,3 +1771,225 @@ void ConformanceSimApplication::GetInputIconMenu( c=
onst QSimTerminalResponse& re
         break;
     }
 }
+
+void ConformanceSimApplication::sendSetupCallMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Setup Call (Icon support)" );
+
+    item.setIdentifier( SetupCall_Confirmed );
+    item.setLabel( "Call confirmed and connected" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Long_AID );
+    item.setLabel( "Long first alpha identifier" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Subaddress_Not_Supported );
+    item.setLabel( "Called party subaddress not supported" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Rejected );
+    item.setLabel( "Call rejected by the user" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Putting_On_Hold );
+    item.setLabel( "Putting all other calls on hold" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Disconnect_Others );
+    item.setLabel( "Disconnecting all other calls" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_If_Not_Busy );
+    item.setLabel( "Only if not currently busy on another call" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_On_Hold_Not_allowed );
+    item.setLabel( "Call hold is not allowed" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Max_Dialing_Number );
+    item.setLabel( "Max dialing number string, no alpha" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Two_AID );
+    item.setLabel( "Two alpha identifiers" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Basic_icon );
+    item.setLabel( "Basic icon" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Self_basic_icon );
+    item.setLabel( "Self-explanatory basic icon" );
+    items +=3D item;
+
+    item.setIdentifier( SetupCall_Basic_icon_during_call );
+    item.setLabel( "Icon during setup call" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(SetupCallMenu(QSimTerminalResponse)) );
+}
+
+void ConformanceSimApplication::SetupCallMenu( const QSimTerminalResponse&=
 resp )
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
+    switch ( resp.menuItem() ) {
+        case SetupCall_Confirmed:
+        case SetupCall_If_Not_Busy:
+        case SetupCall_Rejected:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "Not busy" );
+            cmd.setNumber( "+012340123456p1p2" );
+            cmd.setDisposition( QSimCommand::IfNoOtherCalls );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        case SetupCall_Long_AID:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "Three types are defined: - set up a call, but on=
ly "
+                      "if not currently busy on another call; - set up a c=
all"
+                      ", putting all other calls (if any) on hold; - set u=
p a"
+                      " call, disconnecting all other calls (if any) first=
."
+                      " For each of these types," );
+            cmd.setNumber( "+01" );
+            cmd.setDisposition( QSimCommand::IfNoOtherCalls );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        case SetupCall_Subaddress_Not_Supported:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "Called party" );
+            cmd.setNumber( "+012340123456p1p2" );
+            cmd.setSubAddress ("9595959595");
+            cmd.setDisposition( QSimCommand::IfNoOtherCalls );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        case SetupCall_Putting_On_Hold:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "On hold" );
+            cmd.setNumber( "+012340123456p1p2" );
+            cmd.setDisposition( QSimCommand::PutOnHold );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        case SetupCall_On_Hold_Not_allowed:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "On hold" );
+            cmd.setNumber( "+0123401234" );
+            cmd.setDisposition( QSimCommand::PutOnHold );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        case SetupCall_Disconnect_Others:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "Disconnect" );
+            cmd.setNumber( "+012340123456p1p2" );
+            cmd.setDisposition( QSimCommand::Disconnect );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        case SetupCall_Max_Dialing_Number:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setNumber( "+01234567890123456789012345678901" );
+            cmd.setDisposition( QSimCommand::Disconnect );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        case SetupCall_Two_AID:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "CONFIRMATION" );
+            cmd.setOtherText( "CALL" );
+            cmd.setNumber( "+012340123456p1p2" );
+            cmd.setDisposition( QSimCommand::Disconnect );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+         }
+         break;
+
+        case SetupCall_Basic_icon:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "Set up call Icon 3.1.1" );
+            cmd.setNumber( "+012340123456p1p2" );
+            cmd.setIconId( 1 );
+            cmd.setIconSelfExplanatory( false );
+            cmd.setDisposition( QSimCommand::IfNoOtherCalls );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        case SetupCall_Self_basic_icon:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "Set up call Icon 3.2.1" );
+            cmd.setNumber( "+012340123456p1p2" );
+            cmd.setIconId( 1 );
+            cmd.setIconSelfExplanatory( true );
+            cmd.setDisposition( QSimCommand::IfNoOtherCalls );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        case SetupCall_Basic_icon_during_call:
+        {
+            cmd.setType( QSimCommand::SetupCall );
+            cmd.setDestinationDevice( QSimCommand::Network );
+            cmd.setText( "Set up call Icon 3.4.1" );
+            cmd.setNumber( "+012340123456p1p2" );
+            cmd.setIconId( 1 );
+            cmd.setIconSelfExplanatory( true );
+            cmd.setOtherText( "Set up call Icon 3.4.2" );
+            cmd.setOtherIconId( 1 );
+            cmd.setOtherIconSelfExplanatory( true );
+            cmd.setDisposition( QSimCommand::IfNoOtherCalls );
+            command( cmd, this, SLOT(sendSetupCallMenu()) );
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index 54ef103..f5b54b5 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -174,6 +174,8 @@ protected slots:
     void sendGetInputNormalMenu();
     void sendGetInputIconMenu();
     void GetInputIconMenu( const QSimTerminalResponse& resp );
+    void sendSetupCallMenu();
+    void SetupCallMenu( const QSimTerminalResponse& resp );
 };
 =

 #endif
-- =

1.7.9.5


--===============7494125794473246095==--

