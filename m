Content-Type: multipart/mixed; boundary="===============6946387018245444694=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 4/6] phonesim: Add Get Inkey test cases
Date: Tue, 11 Jan 2011 16:16:08 +0200
Message-ID: <1294755370-12442-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294755370-12442-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6946387018245444694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/conformancesimapplication.cpp |  501 +++++++++++++++++++++++++++++++++=
+++-
 src/simapplication.h              |    7 +
 2 files changed, 507 insertions(+), 1 deletions(-)

diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
index dbc433a..663fbe1 100644
--- a/src/conformancesimapplication.cpp
+++ b/src/conformancesimapplication.cpp
@@ -38,6 +38,7 @@ const QString ConformanceSimApplication::getName()
 }
 =

 #define ConformanceMenu_DisplayText 1
+#define ConformanceMenu_GetInkey    2
 =

 #define NormalMenu_1_1    1
 #define NormalMenu_1_2    2
@@ -72,6 +73,18 @@ const QString ConformanceSimApplication::getName()
 #define Display_Text_Attribute          10
 #define Display_Text_Main               11
 =

+#define GetInkeyMenu_Normal              1
+#define GetInkeyMenu_No_Response         2
+#define GetInkeyMenu_Cyrillic_Display_1  3
+#define GetInkeyMenu_Cyrillic_Display_2  4
+#define GetInkeyMenu_Cyrillic_Entry      5
+#define GetInkeyMenu_YesNo_Response      6
+#define GetInkeyMenu_Icon                7
+#define GetInkeyMenu_Help                8
+#define GetInkeyMenu_Variable_Timeout    9
+#define GetInkeyMenu_Text_Attribute     10
+#define GetInkeyMenu_Main               11
+
 void ConformanceSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -84,6 +97,10 @@ void ConformanceSimApplication::mainMenu()
     item.setLabel( "Display Text" );
     items +=3D item;
 =

+    item.setIdentifier( ConformanceMenu_GetInkey );
+    item.setLabel( "Get Inkey" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -98,6 +115,12 @@ void ConformanceSimApplication::mainMenuSelection( int =
id )
         }
         break;
 =

+        case ConformanceMenu_GetInkey:
+        {
+            sendGetInkeyMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -579,4 +602,480 @@ void ConformanceSimApplication::DisplayTextIconMenu(
             endSession();
         break;
     }
-}
\ No newline at end of file
+}
+
+void ConformanceSimApplication::sendGetInkeyMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Get Inkey" );
+
+    item.setIdentifier( GetInkeyMenu_Normal );
+    item.setLabel( "Normal" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_No_Response );
+    item.setLabel( "No response from user" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_Cyrillic_Display_1 );
+    item.setLabel( "UCS2 display in Cyrillic" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_Cyrillic_Display_2 );
+    item.setLabel( "max. length UCS2 display in Cyrillic" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_Cyrillic_Entry );
+    item.setLabel( "UCS2 entry in Cyrillic" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_YesNo_Response );
+    item.setLabel( "Yes/No response for the input" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_Icon );
+    item.setLabel( "Display of icon" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_Help );
+    item.setLabel( "Help Information" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_Variable_Timeout );
+    item.setLabel( "Variable Time out" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_Text_Attribute );
+    item.setLabel( "Support of Text Attribute" );
+    items +=3D item;
+
+    item.setIdentifier( GetInkeyMenu_Main );
+    item.setLabel( "Return to main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(GetInkeyMenu(QSimTerminalResponse)) );
+}
+
+void ConformanceSimApplication::sendGetInkeyNormalMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Get Inkey (Normal)" );
+
+    item.setIdentifier( NormalMenu_1_1 );
+    item.setLabel( "Digits only for character set, unpacked 8-bit" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_2 );
+    item.setLabel( "Digits only for character set, packed text string" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_3 );
+    item.setLabel( "Backward move" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_4 );
+    item.setLabel( "Abort" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_5 );
+    item.setLabel( "SMS default alphabet for character set, unpacked 8-bit=
" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_6 );
+    item.setLabel( "Max length for the Text String, successful" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_Main );
+    item.setLabel( "Return to Get Inkey main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(GetInkeyNormalMenu(QSimTerminalResponse)) );
+}
+
+void ConformanceSimApplication::sendGetInkeyIconMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Get Inkey (Icon support)" );
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
+    item.setLabel( "Colour icon, non self-explanatory, successful" );
+    items +=3D item;
+
+    item.setIdentifier( IconMenu_5A );
+    item.setLabel( "basic icon, null text string, unsuccessful" );
+    items +=3D item;
+
+    item.setIdentifier( IconMenu_6A );
+    item.setLabel( "basic icon, empty text string, unsuccessful" );
+    items +=3D item;
+
+    item.setIdentifier( IconMenu_Main );
+    item.setLabel( "Return to Get Inkey main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(GetInkeyIconMenu(QSimTerminalResponse)) );
+}
+
+void ConformanceSimApplication::sendHelpInfo( const QSimTerminalResponse& =
resp )
+{
+    if ( resp.result() =3D=3D QSimTerminalResponse::HelpInformationRequest=
ed ) {
+            QSimCommand cmd;
+
+            cmd.setType( QSimCommand::DisplayText );
+            cmd.setDestinationDevice( QSimCommand::Display );
+            cmd.setClearAfterDelay( false );
+            cmd.setText( "Help information" );
+            command( cmd, this, SLOT(GetInkeyMenu(QSimTerminalResponse)) );
+    } else
+            endSession();
+}
+
+void ConformanceSimApplication::GetInkeyMenu( const QSimTerminalResponse& =
resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.command().type() =3D=3D QSimCommand::DisplayText &&
+                resp.result() =3D=3D QSimTerminalResponse::Success ) {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setHasHelp( true );
+            cmd.setText( "Enter \"+\"" );
+            command( cmd, this, SLOT(sendGetInkeyMenu()) );
+            return;
+    }
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
+        case GetInkeyMenu_Normal:
+        {
+            sendGetInkeyNormalMenu();
+        }
+        break;
+
+        case GetInkeyMenu_No_Response:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<TIME-OUT>" );
+            command( cmd, this, SLOT(sendGetInkeyMenu()) );
+        }
+        break;
+
+        case GetInkeyMenu_Cyrillic_Display_1:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
+            cmd.setText( codec->toUnicode( "=C3=90=C2=97=C3=90=C2=94=C3=90=
=C2=A0=C3=90=C2=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=90=C2=
=A3=C3=90=C2=99=C3=90=C2=A2=C3=90=C2=95" ) );
+            command( cmd, this, SLOT(sendGetInkeyMenu()),
+                    QSimCommand::UCS2Strings );
+        }
+        break;
+
+        case GetInkeyMenu_Cyrillic_Display_2:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
+            cmd.setText( codec->toUnicode( "=C3=90=C2=97=C3=90=C2=94=C3=90=
=C2=A0=C3=90=C2=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=90=C2=
=A3=C3=90=C2=99=C3=90=C2=A2=C3=90=C2=95=C3=90=C2=97=C3=90=C2=94=C3=90=C2=A0=
=C3=90=C2=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=90=C2=A3=C3=
=90=C2=99=C3=90=C2=A2=C3=90=C2=95"
+                                "=C3=90=C2=97=C3=90=C2=94=C3=90=C2=A0=C3=
=90=C2=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=90=C2=A3=C3=90=
=C2=99=C3=90=C2=A2=C3=90=C2=95=C3=90=C2=97=C3=90=C2=94=C3=90=C2=A0=C3=90=C2=
=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=90=C2=A3=C3=90=C2=99=
=C3=90=C2=A2=C3=90=C2=95"
+                                "=C3=90=C2=97=C3=90=C2=94=C3=90=C2=A0=C3=
=90=C2=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=90=C2=A3=C3=90=
=C2=99=C3=90=C2=A2=C3=90=C2=95=C3=90=C2=97=C3=90=C2=94=C3=90=C2=A0=C3=90=C2=
=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=90=C2=A3=C3=90=C2=99=
" ) );
+            command( cmd, this, SLOT(sendGetInkeyMenu()),
+                    QSimCommand::UCS2Strings );
+        }
+        break;
+
+        case GetInkeyMenu_Cyrillic_Entry:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits( false );
+            cmd.setUcs2Input( true );
+            cmd.setText( "Enter" );
+            command( cmd, this, SLOT(sendGetInkeyMenu()) );
+        }
+        break;
+
+        case GetInkeyMenu_YesNo_Response:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantYesNo( true );
+            cmd.setText( "Enter YES" );
+            command( cmd, this, SLOT(sendGetInkeyMenu()) );
+        }
+        break;
+
+        case GetInkeyMenu_Icon:
+        {
+            sendGetInkeyIconMenu();
+        }
+        break;
+
+        case GetInkeyMenu_Help:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setHasHelp( true );
+            cmd.setText( "Enter \"+\"" );
+            command( cmd, this, SLOT(sendHelpInfo(QSimTerminalResponse)) );
+        }
+        break;
+
+        case GetInkeyMenu_Variable_Timeout:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "Enter \"+\"" );
+            cmd.setDuration( 10000 );
+            command( cmd, this, SLOT(sendGetInkeyMenu()) );
+        }
+        break;
+
+        case GetInkeyMenu_Text_Attribute:
+        {
+            QByteArray ba;
+            ba.resize( 4 );
+            ba[0] =3D 0x00;
+            ba[1] =3D 0x09;
+            ba[2] =3D 0x00;
+            ba[3] =3D 0xB4;
+
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "Enter \"+\"" );
+            cmd.setTextAttribute( ba );
+            command( cmd, this, SLOT(sendGetInkeyMenu()) );
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
+}
+
+void ConformanceSimApplication::GetInkeyNormalMenu( const QSimTerminalResp=
onse& resp )
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
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "Enter \"+\"" );
+            command( cmd, this, SLOT(sendGetInkeyNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_2:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "Enter \"0\"" );
+            command( cmd, this, SLOT(sendGetInkeyNormalMenu()),
+                    QSimCommand::PackedStrings );
+        }
+        break;
+
+        case NormalMenu_1_3:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<GO-BACKWARDS>" );
+            command( cmd, this, SLOT(sendGetInkeyNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_4:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<ABORT>" );
+            command( cmd, this, SLOT(sendGetInkeyNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_5:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(false);
+            cmd.setText( "Enter \"q\"" );
+            command( cmd, this, SLOT(sendGetInkeyNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_6:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(false);
+            cmd.setText( "Enter \"x\". This command instructs the ME to di=
splay "
+                         "text, and to expect the user to enter a single c=
haracter."
+                         " Any response entered by the user shall be passe=
d t" );
+            command( cmd, this, SLOT(sendGetInkeyNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_Main:
+        {
+            sendGetInkeyMenu();
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
+}
+
+void ConformanceSimApplication::GetInkeyIconMenu( const QSimTerminalRespon=
se& resp )
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
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<NO-ICON>" );
+            cmd.setIconId( 1 );
+            cmd.setIconSelfExplanatory( true );
+            command( cmd, this, SLOT(sendGetInkeyIconMenu()) );
+        }
+        break;
+
+        case IconMenu_2A:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<BASIC-ICON>" );
+            cmd.setIconId( 1 );
+            command( cmd, this, SLOT(sendGetInkeyIconMenu()) );
+        }
+        break;
+
+        case IconMenu_3A:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<NO-ICON>" );
+            cmd.setIconId( 2 );
+            cmd.setIconSelfExplanatory( true );
+            command( cmd, this, SLOT(sendGetInkeyIconMenu()) );
+        }
+        break;
+
+        case IconMenu_4A:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<COLOUR-ICON>" );
+            cmd.setIconId( 2 );
+            command( cmd, this, SLOT(sendGetInkeyIconMenu()) );
+        }
+        break;
+
+        case IconMenu_5A:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "" );
+            cmd.setIconId( 1 );
+            command( cmd, this, SLOT(sendGetInkeyIconMenu()) );
+        }
+        break;
+
+        case IconMenu_6A:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( QString() );
+            cmd.setIconId( 1 );
+            command( cmd, this, SLOT(sendGetInkeyIconMenu()) );
+        }
+        break;
+
+        case IconMenu_Main:
+        {
+            sendGetInkeyMenu();
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index edfa33f..0dcad38 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -156,6 +156,13 @@ protected slots:
     void sendDisplayTextNormalMenu();
     void sendDisplayTextIconMenu();
     void DisplayTextIconMenu( const QSimTerminalResponse& resp );
+    void sendGetInkeyMenu();
+    void GetInkeyMenu( const QSimTerminalResponse& resp );
+    void GetInkeyNormalMenu( const QSimTerminalResponse& resp );
+    void sendGetInkeyNormalMenu();
+    void sendGetInkeyIconMenu();
+    void GetInkeyIconMenu( const QSimTerminalResponse& resp );
+    void sendHelpInfo( const QSimTerminalResponse& resp );
 };
 =

 #endif
-- =

1.7.0.4


--===============6946387018245444694==--

