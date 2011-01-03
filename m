Content-Type: multipart/mixed; boundary="===============0385372647921978483=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 3/5] phonesim: Add GetInkey conformance test cases
Date: Mon, 03 Jan 2011 12:09:22 +0200
Message-ID: <1294049364-6621-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294049364-6621-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0385372647921978483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: badrjee <badrjee@badrjee-laptop.(none)>

---
 src/simapplication.cpp |  505 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    7 +
 2 files changed, 512 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 8e71127..3f90203 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -351,6 +351,7 @@ const QString DemoSimApplication::getName()
 #define LocalInfoMenu_Lang  2
 =

 #define ConformanceMenu_DisplayText 1
+#define ConformanceMenu_GetInkey    2
 #define ConformanceMenu_Main        20
 =

 #define NormalMenu_1_1    1
@@ -386,6 +387,18 @@ const QString DemoSimApplication::getName()
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
 enum SendSMSMenuItems {
 	SendSMS_Unpacked =3D 1,
 	SendSMS_Packed,
@@ -2412,6 +2425,10 @@ void DemoSimApplication::sendConformanceMenu()
     item.setLabel( "Display Text" );
     items +=3D item;
 =

+    item.setIdentifier( ConformanceMenu_GetInkey );
+    item.setLabel( "Get Inkey" );
+    items +=3D item;
+
     item.setIdentifier( ConformanceMenu_Main );
     item.setLabel( "Return to main menu" );
     items +=3D item;
@@ -2440,6 +2457,12 @@ void DemoSimApplication::ConformanceMenu( const QSim=
TerminalResponse& resp )
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
             endSession();
         break;
@@ -2925,3 +2948,485 @@ void DemoSimApplication::DisplayTextIconMenu(
         break;
     }
 }
+
+void DemoSimApplication::sendGetInkeyMenu()
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
+void DemoSimApplication::sendGetInkeyNormalMenu()
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
+void DemoSimApplication::sendGetInkeyIconMenu()
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
+void DemoSimApplication::sendHelpInfo( const QSimTerminalResponse& resp )
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
+void DemoSimApplication::GetInkeyMenu( const QSimTerminalResponse& resp )
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
+            command( cmd, this, SLOT(sendGetInkeyNormalMenu()) );
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
+        case GetInkeyMenu_Main:
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
+void DemoSimApplication::GetInkeyNormalMenu( const QSimTerminalResponse& r=
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
+void DemoSimApplication::GetInkeyIconMenu( const QSimTerminalResponse& res=
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
\ No newline at end of file
diff --git a/src/simapplication.h b/src/simapplication.h
index ce7dfe3..f8545fc 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -138,6 +138,13 @@ protected slots:
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
 =

 private:
     int sticksLeft;
-- =

1.7.0.4


--===============0385372647921978483==--

