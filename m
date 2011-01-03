Content-Type: multipart/mixed; boundary="===============4375800685423363816=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 4/5] phonesim: Add GetInput conformance test cases
Date: Mon, 03 Jan 2011 12:09:23 +0200
Message-ID: <1294049364-6621-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294049364-6621-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4375800685423363816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: badrjee <badrjee@badrjee-laptop.(none)>

---
 src/simapplication.cpp |  642 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    6 +
 2 files changed, 648 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 3f90203..befe358 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -352,6 +352,7 @@ const QString DemoSimApplication::getName()
 =

 #define ConformanceMenu_DisplayText 1
 #define ConformanceMenu_GetInkey    2
+#define ConformanceMenu_GetInput    3
 #define ConformanceMenu_Main        20
 =

 #define NormalMenu_1_1    1
@@ -399,6 +400,19 @@ const QString DemoSimApplication::getName()
 #define GetInkeyMenu_Text_Attribute     10
 #define GetInkeyMenu_Main               11
 =

+#define GetInputMenu_Normal              1
+#define GetInputMenu_No_Response         2
+#define GetInputMenu_Cyrillic_Display_1  3
+#define GetInputMenu_Cyrillic_Display_2  4
+#define GetInputMenu_Cyrillic_Entry_1    5
+#define GetInputMenu_Cyrillic_Entry_2    6
+#define GetInputMenu_Default_Text_1      7
+#define GetInputMenu_Default_Text_2      8
+#define GetInputMenu_Icon                9
+#define GetInputMenu_Help               10
+#define GetInputMenu_Text_Attribute     11
+#define GetInputMenu_Main               12
+
 enum SendSMSMenuItems {
 	SendSMS_Unpacked =3D 1,
 	SendSMS_Packed,
@@ -2429,6 +2443,10 @@ void DemoSimApplication::sendConformanceMenu()
     item.setLabel( "Get Inkey" );
     items +=3D item;
 =

+    item.setIdentifier( ConformanceMenu_GetInput );
+    item.setLabel( "Get Input" );
+    items +=3D item;
+
     item.setIdentifier( ConformanceMenu_Main );
     item.setLabel( "Return to main menu" );
     items +=3D item;
@@ -2463,6 +2481,12 @@ void DemoSimApplication::ConformanceMenu( const QSim=
TerminalResponse& resp )
         }
         break;
 =

+        case ConformanceMenu_GetInput:
+        {
+            sendGetInputMenu();
+        }
+        break;
+
         default:
             endSession();
         break;
@@ -3429,4 +3453,622 @@ void DemoSimApplication::GetInkeyIconMenu( const QS=
imTerminalResponse& resp )
             endSession();
         break;
     }
+}
+
+void DemoSimApplication::sendGetInputMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Get Input" );
+
+    item.setIdentifier( GetInputMenu_Normal );
+    item.setLabel( "Normal" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_No_Response );
+    item.setLabel( "No response from user" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Cyrillic_Display_1 );
+    item.setLabel( "UCS2 display in Cyrillic" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Cyrillic_Display_2 );
+    item.setLabel( "max.length UCS2 display in Cyrillic" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Cyrillic_Entry_1 );
+    item.setLabel( "UCS2 entry in Cyrillic" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Cyrillic_Entry_2 );
+    item.setLabel( "max.length UCS2 entry in Cyrillic" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Default_Text_1 );
+    item.setLabel( "Default Text" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Default_Text_2 );
+    item.setLabel( "Default Text with max. length" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Icon );
+    item.setLabel( "Display of icon" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Help );
+    item.setLabel( "Help Information" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Text_Attribute );
+    item.setLabel( "Support of Text Attribute" );
+    items +=3D item;
+
+    item.setIdentifier( GetInputMenu_Main );
+    item.setLabel( "Return to main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(GetInputMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::sendGetInputNormalMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Get Input (Normal)" );
+
+    item.setIdentifier( NormalMenu_1_1 );
+    item.setLabel( "digits only, SMS default alphabet, echo text" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_2 );
+    item.setLabel( "digits only, SMS default alphabet, echo text, packed S=
MS" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_3 );
+    item.setLabel( "character set, SMS default alphabet, echo text" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_4 );
+    item.setLabel( "digits only, SMS default alphabet, hide text" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_5 );
+    item.setLabel( "digits only, SMS default alphabet, echo text" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_6 );
+    item.setLabel( "backwards move" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_7 );
+    item.setLabel( "abort" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_8 );
+    item.setLabel( "response length range 160-160" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_9 );
+    item.setLabel( "response length range 0-1" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_10 );
+    item.setLabel( "null length for the text string" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_1_11 );
+    item.setLabel( "empty text string" );
+    items +=3D item;
+
+    item.setIdentifier( NormalMenu_Main );
+    item.setLabel( "Return to Get Input main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(GetInputNormalMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::sendGetInputIconMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Get Input (Icon support)" );
+
+    item.setIdentifier( IconMenu_1A );
+    item.setLabel( "basic icon, self-explanatory, successful" );
+    items +=3D item;
+
+    item.setIdentifier( IconMenu_2A );
+    item.setLabel( "basic icon, non self-explanatory, successful" );
+    items +=3D item;
+
+    item.setIdentifier( IconMenu_3A );
+    item.setLabel( "Colour icon, self-explanatory, successful" );
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
+    item.setLabel( "Return to Get Input main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(GetInputIconMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::GetInputMenu( const QSimTerminalResponse& resp )
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
+        case GetInputMenu_Normal:
+        {
+            sendGetInputNormalMenu();
+        }
+        break;
+
+        case GetInputMenu_No_Response:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "<TIME-OUT>" );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 10 );
+            command( cmd, this, SLOT(sendGetInputMenu()) );
+        }
+        break;
+
+        case GetInputMenu_Cyrillic_Display_1:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setEcho( true );
+            cmd.setWantDigits( false );
+            QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
+            cmd.setText( codec->toUnicode( "=C3=90=C2=97=C3=90=C2=94=C3=90=
=C2=A0=C3=90=C2=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=90=C2=
=A3=C3=90=C2=99=C3=90=C2=A2=C3=90=C2=95" ) );
+            cmd.setMinimumLength( 5 );
+            cmd.setMaximumLength( 5 );
+            command( cmd, this, SLOT(sendGetInputMenu()),
+                    QSimCommand::UCS2Strings );
+        }
+        break;
+
+        case GetInputMenu_Cyrillic_Display_2:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setEcho( true );
+            cmd.setWantDigits( false );
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
+            cmd.setMinimumLength( 5 );
+            cmd.setMaximumLength( 5 );
+            command( cmd, this, SLOT(sendGetInputMenu()),
+                    QSimCommand::UCS2Strings );
+        }
+        break;
+
+        case GetInputMenu_Cyrillic_Entry_1:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits( false );
+            cmd.setUcs2Input( true );
+            cmd.setText( "Enter Hello" );
+            cmd.setMinimumLength( 12 );
+            cmd.setMaximumLength( 12 );
+            command( cmd, this, SLOT(sendGetInputMenu()) );
+        }
+        break;
+
+        case GetInputMenu_Cyrillic_Entry_2:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits( false );
+            cmd.setUcs2Input( true );
+            cmd.setText( "Enter Hello" );
+            cmd.setMinimumLength( 5 );
+            cmd.setMaximumLength(0xFF);
+            command( cmd, this, SLOT(sendGetInputMenu()) );
+        }
+        break;
+
+        case GetInputMenu_Default_Text_1:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "Enter 12345" );
+            cmd.setMinimumLength( 5 );
+            cmd.setMaximumLength( 5 );
+            cmd.setDefaultText( "12345" );
+            command( cmd, this, SLOT(sendGetInputMenu()) );
+        }
+        break;
+
+        case GetInputMenu_Default_Text_2:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "Enter:" );
+            cmd.setMinimumLength( 160 );
+            cmd.setMaximumLength( 160 );
+            cmd.setDefaultText( "***1111111111###***2222222222###***333333=
3333"
+                                "###***4444444444###***5555555555###***666=
6666"
+                                "666###***7777777777###***8888888888###***=
9999"
+                                "999999###***0000000000###" );
+            command( cmd, this, SLOT(sendGetInputMenu()) );
+        }
+        break;
+
+        case GetInputMenu_Icon:
+        {
+            sendGetInputIconMenu();
+        }
+        break;
+
+        case GetInputMenu_Help:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setHasHelp( true );
+            cmd.setText( "Enter 12345" );
+            cmd.setMinimumLength( 5 );
+            cmd.setMaximumLength( 5 );
+            command( cmd, this, SLOT(sendGetInputMenu()) );
+        }
+        break;
+
+        case GetInputMenu_Text_Attribute:
+        {
+            QByteArray ba;
+            ba.resize( 4 );
+            ba[0] =3D 0x00;
+            ba[1] =3D 0x0B;
+            ba[2] =3D 0x00;
+            ba[3] =3D 0xB4;
+
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "Enter 12345" );
+            cmd.setMinimumLength( 5 );
+            cmd.setMaximumLength( 5 );
+            cmd.setTextAttribute( ba );
+            command( cmd, this, SLOT(sendGetInputMenu()) );
+        }
+        break;
+
+        case GetInputMenu_Main:
+        {
+            sendConformanceMenu();
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
+}
+
+void DemoSimApplication::GetInputNormalMenu( const QSimTerminalResponse& r=
esp )
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
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "Enter 12345" );
+            cmd.setMinimumLength( 5 );
+            cmd.setMaximumLength( 5 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_2:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setPackedInput( true );
+            cmd.setText( "Enter 67*#+" );
+            cmd.setMinimumLength( 5 );
+            cmd.setMaximumLength( 5 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()),
+                    QSimCommand::PackedStrings );
+        }
+        break;
+
+        case NormalMenu_1_3:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits( false );
+            cmd.setEcho( true );
+            cmd.setText( "Enter AbCdE" );
+            cmd.setMinimumLength( 5 );
+            cmd.setMaximumLength( 5 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_4:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setUcs2Input( false );
+            cmd.setEcho( false );
+            cmd.setText( "Password 1<SEND>2345678" );
+            cmd.setMinimumLength( 4 );
+            cmd.setMaximumLength( 8 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_5:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "Enter 1..9,0..9,0(1)" );
+            cmd.setMinimumLength( 1 );
+            cmd.setMaximumLength( 20 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_6:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "<GO-BACKWARDS>" );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 8 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_7:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "<ABORT>" );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 8 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_8:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "***1111111111###***2222222222###***3333333333###=
***44"
+                         "44444444###***5555555555###***6666666666###***77=
77777"
+                         "777###***8888888888###***9999999999###***0000000=
000###" );
+            cmd.setMinimumLength( 160 );
+            cmd.setMaximumLength( 160 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_9:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "<SEND>" );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 1 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_10:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( QString() );
+            cmd.setMinimumLength( 1 );
+            cmd.setMaximumLength( 5 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_1_11:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setEcho( true );
+            cmd.setText( "" );
+            cmd.setMinimumLength( 1 );
+            cmd.setMaximumLength( 5 );
+            command( cmd, this, SLOT(sendGetInputNormalMenu()) );
+        }
+        break;
+
+        case NormalMenu_Main:
+        {
+            sendGetInputMenu();
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
+}
+
+void DemoSimApplication::GetInputIconMenu( const QSimTerminalResponse& res=
p )
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
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<NO-ICON>" );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 10 );
+            cmd.setIconId( 1 );
+            cmd.setIconSelfExplanatory( true );
+            command( cmd, this, SLOT(sendGetInputIconMenu()) );
+        }
+        break;
+
+        case IconMenu_2A:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<BASIC-ICON>" );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 10 );
+            cmd.setIconId( 1 );
+            command( cmd, this, SLOT(sendGetInputIconMenu()) );
+        }
+        break;
+
+        case IconMenu_3A:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<NO-ICON>" );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 10 );
+            cmd.setIconId( 2 );
+            cmd.setIconSelfExplanatory( true );
+            command( cmd, this, SLOT(sendGetInputIconMenu()) );
+        }
+        break;
+
+        case IconMenu_4A:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "<COLOUR-ICON>" );
+            cmd.setIconId( 2 );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 10 );
+            command( cmd, this, SLOT(sendGetInputIconMenu()) );
+        }
+        break;
+
+        case IconMenu_5A:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( "" );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 10 );
+            cmd.setIconId( 1 );
+            command( cmd, this, SLOT(sendGetInputIconMenu()) );
+        }
+        break;
+
+        case IconMenu_6A:
+        {
+            cmd.setType( QSimCommand::GetInput );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantDigits(true);
+            cmd.setText( QString() );
+            cmd.setMinimumLength( 0 );
+            cmd.setMaximumLength( 10 );
+            cmd.setIconId( 1 );
+            command( cmd, this, SLOT(sendGetInputIconMenu()) );
+        }
+        break;
+
+        case IconMenu_Main:
+        {
+            sendGetInputMenu();
+        }
+        break;
+
+        default:
+            endSession();
+        break;
+    }
 }
\ No newline at end of file
diff --git a/src/simapplication.h b/src/simapplication.h
index f8545fc..6894f78 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -145,6 +145,12 @@ protected slots:
     void sendGetInkeyIconMenu();
     void GetInkeyIconMenu( const QSimTerminalResponse& resp );
     void sendHelpInfo( const QSimTerminalResponse& resp );
+    void sendGetInputMenu();
+    void GetInputMenu( const QSimTerminalResponse& resp );
+    void GetInputNormalMenu( const QSimTerminalResponse& resp );
+    void sendGetInputNormalMenu();
+    void sendGetInputIconMenu();
+    void GetInputIconMenu( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.0.4


--===============4375800685423363816==--

