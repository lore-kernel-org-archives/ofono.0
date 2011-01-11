Content-Type: multipart/mixed; boundary="===============2719298292092807181=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/6] phonesim: Add DisplayText test cases
Date: Tue, 11 Jan 2011 16:16:07 +0200
Message-ID: <1294755370-12442-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294755370-12442-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2719298292092807181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/conformancesimapplication.cpp |  519 +++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h              |    6 +
 2 files changed, 525 insertions(+), 0 deletions(-)

diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
index ecc47fb..dbc433a 100644
--- a/src/conformancesimapplication.cpp
+++ b/src/conformancesimapplication.cpp
@@ -37,6 +37,41 @@ const QString ConformanceSimApplication::getName()
     return "Conformance SIM Application";
 }
 =

+#define ConformanceMenu_DisplayText 1
+
+#define NormalMenu_1_1    1
+#define NormalMenu_1_2    2
+#define NormalMenu_1_3    3
+#define NormalMenu_1_4    4
+#define NormalMenu_1_5    5
+#define NormalMenu_1_6    6
+#define NormalMenu_1_7    7
+#define NormalMenu_1_8    8
+#define NormalMenu_1_9    9
+#define NormalMenu_1_10   10
+#define NormalMenu_1_11   11
+#define NormalMenu_Main   12
+
+#define IconMenu_1A     1
+#define IconMenu_2A     2
+#define IconMenu_3A     3
+#define IconMenu_4A     4
+#define IconMenu_5A     5
+#define IconMenu_6A     6
+#define IconMenu_Main   7
+
+#define Display_Text_Normal              1
+#define Display_Text_No_Response         2
+#define Display_Text_Extension_Text      3
+#define Display_Text_Sustained_Text_1    4
+#define Display_Text_Sustained_Text_2    5
+#define Display_Text_Sustained_Text_3    6
+#define Display_Text_Icon                7
+#define Display_Text_UCS2_Cyrillic       8
+#define Display_Text_Variable_Time_Out   9
+#define Display_Text_Attribute          10
+#define Display_Text_Main               11
+
 void ConformanceSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -45,6 +80,10 @@ void ConformanceSimApplication::mainMenu()
 =

     cmd.setType( QSimCommand::SetupMenu );
 =

+    item.setIdentifier( ConformanceMenu_DisplayText );
+    item.setLabel( "Display Text" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -53,6 +92,12 @@ void ConformanceSimApplication::mainMenu()
 void ConformanceSimApplication::mainMenuSelection( int id )
 {
     switch ( id ) {
+        case ConformanceMenu_DisplayText:
+        {
+            sendDisplayTextMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -61,3 +106,477 @@ void ConformanceSimApplication::mainMenuSelection( int=
 id )
         break;
     }
 }
+
+void ConformanceSimApplication::sendDisplayTextMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Display Text" );
+
+    item.setIdentifier( Display_Text_Normal );
+    item.setLabel( "Normal" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_No_Response );
+    item.setLabel( "Support of No response from user" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_Extension_Text );
+    item.setLabel( "Display of the extension text" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_Sustained_Text_1 );
+    item.setLabel( "Sustained text, unpacked 8-bit data" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_Sustained_Text_2 );
+    item.setLabel( "Sustained text, clear message after delay" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_Sustained_Text_3 );
+    item.setLabel( "Sustained text, wait for user MMI to clear" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_Icon );
+    item.setLabel( "Display of icon" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_UCS2_Cyrillic );
+    item.setLabel( "UCS2 display supported in Cyrillic" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_Variable_Time_Out );
+    item.setLabel( "Variable Time out" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_Attribute );
+    item.setLabel( "Support of Text Attribute" );
+    items +=3D item;
+
+    item.setIdentifier( Display_Text_Main );
+    item.setLabel( "Return to main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(DisplayTextMenu(QSimTerminalResponse)) );
+}
+
+void ConformanceSimApplication::sendDisplayTextNormalMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Display Text (Normal)" );
+
+    item.setIdentifier( NormalMenu_1_1 );
+    item.setLabel( "normal priority, Unpacked 8 bit data,successful" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_2 );
+    item.setLabel( "Unpacked 8 bit data,screen busy" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_3 );
+    item.setLabel( "high priority, Unpacked 8 bit data,successful" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_4 );
+    item.setLabel( "Packed, SMS default alphabet,successful" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_5 );
+    item.setLabel( "Clear message after delay,successful" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_6 );
+    item.setLabel( "Text string with 160 bytes,successful" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_7 );
+    item.setLabel( "Backward move, successful" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_8 );
+    item.setLabel( "session terminated by user" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_9 );
+    item.setLabel( "Null text string, successful" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_10 );
+    item.setLabel( "Empty text string, successful" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_Main );
+    item.setLabel( "Return to Display Text main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(DisplayTextNormalMenu(QSimTerminalResponse)) =
);
+}
+
+void ConformanceSimApplication::sendDisplayTextIconMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Display Text (Icon support)" );
+
+    item.setIdentifier( IconMenu_1A );
+    item.setLabel( "basic icon, self-explanatory, successful" );
+    items +=3D item;
+
+    item.setIdentifier( IconMenu_2A );
+    item.setLabel( "display of colour icon, successful" );
+    items +=3D item;
+
+    item.setIdentifier( IconMenu_3A );
+    item.setLabel( "basic icon, not self-explanatory, successful" );
+    items +=3D item;
+
+    item.setIdentifier( IconMenu_4A );
+    item.setLabel( "basic icon, empty text string, unsuccessful" );
+    items +=3D item;
+
+    item.setIdentifier( IconMenu_Main );
+    item.setLabel( "Return to Display Text main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(DisplayTextIconMenu(QSimTerminalResponse)) );
+}
+
+void ConformanceSimApplication::DisplayTextMenu( const QSimTerminalRespons=
e& resp )
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
+        case Display_Text_Normal:
+        {
+            sendDisplayTextNormalMenu();
+        }
+        break;
+
+        case Display_Text_No_Response:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "<TIME-OUT>" );
+            command( cmd, this, SLOT(sendDisplayTextMenu()) );
+        }
+        break;
+
+        case Display_Text_Extension_Text:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "This command instructs the ME to display a"
+                    " text message and/or an icon (see 6.5.4). "
+                    "It allows the SIM to define the priority"
+                    " of that message, and the text string format."
+                    " Two types of priority are defined:- display "
+                    " normal priority text and/");
+            command( cmd, this, SLOT(sendDisplayTextMenu()) );
+        }
+        break;
+
+        case Display_Text_Sustained_Text_1:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Toolkit Test 1" );
+            cmd.setImmediateResponse( true );
+            command( cmd, this, SLOT(sendDisplayTextMenu()) );
+        }
+        break;
+
+        case Display_Text_Sustained_Text_2:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( true );
+            cmd.setText( "Toolkit Test 2" );
+            cmd.setImmediateResponse( true );
+            command( cmd, this, SLOT(sendDisplayTextMenu()) );
+        }
+        break;
+
+        case Display_Text_Sustained_Text_3:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Toolkit Test 3" );
+            cmd.setImmediateResponse( true );
+            command( cmd, this, SLOT(sendDisplayTextMenu()) );
+        }
+        break;
+
+        case Display_Text_Icon:
+        {
+            sendDisplayTextIconMenu();
+        }
+        break;
+
+        case Display_Text_UCS2_Cyrillic:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
+            cmd.setText( codec->toUnicode( "=C3=90=C2=97=C3=90=C2=94=C3=90=
=C2=A0=C3=90=C2=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=90=C2=
=A3=C3=90=C2=99=C3=90=C2=A2=C3=90=C2=95" ) );
+            command( cmd, this, SLOT(sendDisplayTextMenu()),
+                    QSimCommand::UCS2Strings );
+        }
+        break;
+
+        case Display_Text_Variable_Time_Out:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "10 Second" );
+            cmd.setDuration( 10000 );
+            command( cmd, this, SLOT(sendDisplayTextMenu()) );
+        }
+        break;
+
+        case Display_Text_Attribute:
+        {
+            QByteArray ba;
+            ba.resize( 4 );
+            ba[0] =3D 0x00;
+            ba[1] =3D 0x10;
+            ba[2] =3D 0x00;
+            ba[3] =3D 0xB4;
+
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Text Attribute 1" );
+            cmd.setTextAttribute( ba );
+            command( cmd, this, SLOT(sendDisplayTextMenu()) );
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
+}
+
+void ConformanceSimApplication::DisplayTextNormalMenu(
+                    const QSimTerminalResponse& resp )
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
+        case NormalMenu_1_1:
+        case NormalMenu_1_2:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Toolkit Test 1" );
+            command( cmd, this, SLOT(sendDisplayTextNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_3:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setHighPriority( true );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Toolkit Test 2" );
+            command( cmd, this, SLOT(sendDisplayTextNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_4:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Toolkit Test 3" );
+            command( cmd, this, SLOT(sendDisplayTextNormalMenu()),
+                    QSimCommand::PackedStrings );
+        }
+        break;
+
+        case NormalMenu_1_5:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( true );
+            cmd.setText( "Toolkit Test 4" );
+            command( cmd, this, SLOT(sendDisplayTextNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_6:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "This command instructs the ME to display a"
+                    " text message. It allows the SIM to define"
+                    " the priority of that message, and the text"
+                    " string format. Two types of prio" );
+            command( cmd, this, SLOT(sendDisplayTextNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_7:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "<GO-BACKWARDS>" );
+            command( cmd, this, SLOT(sendDisplayTextNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_8:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "<ABORT>" );
+            command( cmd, this, SLOT(sendDisplayTextNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_9:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText("");
+            command( cmd, this, SLOT(sendDisplayTextNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_10:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( QString() );
+            command( cmd, this, SLOT(sendDisplayTextNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_Main:
+        {
+            sendDisplayTextMenu();
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
+}
+
+void ConformanceSimApplication::DisplayTextIconMenu(
+                    const QSimTerminalResponse& resp )
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
+        case IconMenu_1A:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Basic Icon" );
+            cmd.setIconId( 1 );
+            cmd.setIconSelfExplanatory( true );
+            command( cmd, this, SLOT(sendDisplayTextIconMenu()) );
+        }
+        break;
+
+        case IconMenu_2A:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Colour Icon" );
+            cmd.setIconId( 2 );
+            cmd.setIconSelfExplanatory( true );
+            command( cmd, this, SLOT(sendDisplayTextIconMenu()) );
+        }
+        break;
+
+        case IconMenu_3A:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Basic Icon" );
+            cmd.setIconId( 1 );
+            command( cmd, this, SLOT(sendDisplayTextIconMenu()) );
+        }
+        break;
+
+        case IconMenu_4A:
+        {
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( QString() );
+            cmd.setIconId( 1 );
+            command( cmd, this, SLOT(sendDisplayTextIconMenu()) );
+        }
+        break;
+
+        case IconMenu_Main:
+        {
+            sendDisplayTextMenu();
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
+}
\ No newline at end of file
diff --git a/src/simapplication.h b/src/simapplication.h
index 925baeb..edfa33f 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -150,6 +150,12 @@ public:
 protected slots:
     void mainMenu();
     void mainMenuSelection( int id );
+    void sendDisplayTextMenu();
+    void DisplayTextMenu( const QSimTerminalResponse& resp );
+    void DisplayTextNormalMenu( const QSimTerminalResponse& resp );
+    void sendDisplayTextNormalMenu();
+    void sendDisplayTextIconMenu();
+    void DisplayTextIconMenu( const QSimTerminalResponse& resp );
 };
 =

 #endif
-- =

1.7.0.4


--===============2719298292092807181==--

