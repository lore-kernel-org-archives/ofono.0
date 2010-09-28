Content-Type: multipart/mixed; boundary="===============3228374887377551038=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] phonesim: simulate Send USSD in sim app
Date: Tue, 28 Sep 2010 04:09:30 -0700
Message-ID: <1285672170-12656-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1285672170-12656-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3228374887377551038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/default.xml        |   23 +++++++++-
 src/qsimcommand.cpp    |    6 ++-
 src/simapplication.cpp |  114 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 4 files changed, 142 insertions(+), 3 deletions(-)
 mode change 100644 =3D> 100755 src/simapplication.cpp

diff --git a/src/default.xml b/src/default.xml
index 135bad3..4287639 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -1955,7 +1955,28 @@
 </chat>
 =

 <chat>
-    <!-- Initiate USSD query that is not supported b the network -->
+    <!-- SAT initiated 7-Bit USSD query that is supported by the network -=
->
+    <command>AT+CUSD=3D1,"ABCD",240</command>
+    <response>+CUSD: 0,"USSD string received from SS",240\n\nOK</response>
+    <set name=3D"USD" value=3D"1"/>
+</chat>
+
+<chat>
+    <!-- SAT initiated 8-Bit USSD query that is supported by the network -=
->
+    <command>AT+CUSD=3D1,"41424344",68</command>
+    <response>+CUSD: 0,"5553534420737472696E672072656365697665642066726F6D=
205353",68\n\nOK</response>
+    <set name=3D"USD" value=3D"1"/>
+</chat>
+
+<chat>
+    <!-- SAT initiated UCS2 USSD query that is supported by the network -->
+    <command>AT+CUSD=3D1,"041704140420041004120421042204120423041904220415=
",72</command>
+    <response>+CUSD: 0,"005500530053004400200073007400720069006E0067002000=
720065006300650069007600650064002000660072006F006D002000530053",72\n\nOK</r=
esponse>
+    <set name=3D"USD" value=3D"1"/>
+</chat>
+
+<chat>
+    <!-- Initiate USSD query that is not supported by the network -->
     <command>AT+CUSD=3D1,*</command>
     <response>+CUSD: 4\n\nOK</response>
     <set name=3D"USD" value=3D"1"/>
diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index df2422c..44bdd9a 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -3162,8 +3162,10 @@ QByteArray QSimCommand::toPdu( QSimCommand::ToPduOpt=
ions options ) const
                 writeEFADN( data, text(), QSimCommand::NoPduOptions );
             if ( ( options & QSimCommand::PackedStrings ) !=3D 0 )
                 writeTextString( data, number(), options, 0xF08A );
-            else
-                writeTextString( data, number(), options, 0x408A );
+            else if ( ( options & QSimCommand::UCS2Strings ) !=3D 0 )
+                writeTextString( data, number(), options, 0x488A );
+            else // 8-Bit USSD
+                writeTextString( data, number(), options, 0x448A );
             writeIcon( data, iconId(), iconSelfExplanatory(), true );
             writeTextAttribute( data, textAttribute() );
         }
diff --git a/src/simapplication.cpp b/src/simapplication.cpp
old mode 100644
new mode 100755
index cc2094d..7dc580f
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -20,6 +20,7 @@
 #include "simapplication.h"
 #include <qatutils.h>
 #include <qdebug.h>
+#include <QTextCodec>
 =

 class SimApplicationPrivate
 {
@@ -282,6 +283,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_DTMF       10
 #define MainMenu_SendSS     11
 #define MainMenu_Language   12
+#define MainMenu_SendUSSD   13
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -334,6 +336,12 @@ const QString DemoSimApplication::getName()
 #define Language_Non_Specific   2
 #define Language_Main           3
 =

+#define SendUSSD_7Bit       1
+#define SendUSSD_8Bit       2
+#define SendUSSD_UCS2       3
+#define SendUSSD_Error      4
+#define SendUSSD_Main       5
+
 void DemoSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -390,6 +398,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Language Notification" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_SendUSSD );
+    item.setLabel( "Send USSD" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -496,6 +508,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_SendUSSD:
+        {
+            sendUSSDMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -1718,3 +1736,99 @@ void DemoSimApplication::languageMenu( const QSimTer=
minalResponse& resp )
         endSession();
     }
 }
+
+void DemoSimApplication::sendUSSDMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Send USSD" );
+
+    item.setIdentifier( SendUSSD_7Bit );
+    item.setLabel( "Send USSD - 7-Bit" );
+    items +=3D item;
+
+    item.setIdentifier( SendUSSD_8Bit );
+    item.setLabel( "Send USSD - 8-Bit" );
+    items +=3D item;
+
+    item.setIdentifier( SendUSSD_UCS2 );
+    item.setLabel( "Send USSD - UCS2" );
+    items +=3D item;
+
+    item.setIdentifier( SendUSSD_Error );
+    item.setLabel( "Send USSD - Return Error" );
+    items +=3D item;
+
+    item.setIdentifier( SendUSSD_Main );
+    item.setLabel( "Return to main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(USSDMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::USSDMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+
+        // Item selected.
+        switch ( resp.menuItem() ) {
+            case SendUSSD_7Bit:
+            {
+                cmd.setType( QSimCommand::SendUSSD );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setText( "7-bit USSD" );
+                cmd.setNumber( "ABCD" );
+                command( cmd, this, SLOT(sendUSSDMenu()),
+                         QSimCommand::PackedStrings );
+            }
+            break;
+
+            case SendUSSD_8Bit:
+            {
+                cmd.setType( QSimCommand::SendUSSD );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setText( "8-bit USSD" );
+                cmd.setNumber( "ABCD" );
+                command( cmd, this, SLOT(sendUSSDMenu()) );
+            }
+            break;
+
+            case SendUSSD_UCS2:
+            {
+                cmd.setType( QSimCommand::SendUSSD );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setText( "UCS2 USSD" );
+                QTextCodec *codec =3D QTextCodec::codecForName( "utf8" );
+                cmd.setNumber( codec->toUnicode( "=C3=90=C2=97=C3=90=C2=94=
=C3=90=C2=A0=C3=90=C2=90=C3=90=C2=92=C3=90=C2=A1=C3=90=C2=A2=C3=90=C2=92=C3=
=90=C2=A3=C3=90=C2=99=C3=90=C2=A2=C3=90=C2=95" ) );
+                command( cmd, this, SLOT(sendUSSDMenu()),
+                         QSimCommand::UCS2Strings );
+            }
+            break;
+
+            case SendUSSD_Error:
+            {
+                cmd.setType( QSimCommand::SendUSSD );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setText( "7-bit USSD" );
+                cmd.setNumber( "*100#" );
+                command( cmd, this, SLOT(sendUSSDMenu()),
+                         QSimCommand::PackedStrings );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else {
+        // Unknown response - just go back to the main menu.
+        endSession();
+    }
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index fc57423..9d147ee 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -111,6 +111,8 @@ protected slots:
     void CoLRMenu( const QSimTerminalResponse& resp );
     void sendLanguageMenu();
     void languageMenu( const QSimTerminalResponse& resp );
+    void sendUSSDMenu();
+    void USSDMenu( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.0.4


--===============3228374887377551038==--

