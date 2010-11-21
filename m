Content-Type: multipart/mixed; boundary="===============5609984859574988578=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] phonesim: Add Send Short Message commands to sim app menu.
Date: Sun, 21 Nov 2010 16:51:35 +0100
Message-ID: <1290354698-15749-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5609984859574988578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |  148 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/simapplication.h   |    5 ++
 2 files changed, 152 insertions(+), 1 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 7dc580f..9742fd9 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -21,6 +21,7 @@
 #include <qatutils.h>
 #include <qdebug.h>
 #include <QTextCodec>
+#include "qsmsmessage.h"
 =

 class SimApplicationPrivate
 {
@@ -258,7 +259,8 @@ void SimApplication::endSession()
 }
 =

 DemoSimApplication::DemoSimApplication( SimRules *rules, QObject *parent )
-    : SimApplication( rules, parent )
+    : SimApplication( rules, parent ), smsDestNumber( "12345" ),
+    smsText( "Hello" )
 {
 }
 =

@@ -284,6 +286,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_SendSS     11
 #define MainMenu_Language   12
 #define MainMenu_SendUSSD   13
+#define MainMenu_SendSMS    14
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -342,6 +345,13 @@ const QString DemoSimApplication::getName()
 #define SendUSSD_Error      4
 #define SendUSSD_Main       5
 =

+enum SendSMSMenuItems {
+	SendSMS_Unpacked =3D 1,
+	SendSMS_Packed,
+	SendSMS_SetDestination,
+	SendSMS_SetContents,
+};
+
 void DemoSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -402,6 +412,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Send USSD" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_SendSMS );
+    item.setLabel( "Send SMS request" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -514,6 +528,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_SendSMS:
+        {
+            sendSMSMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -1832,3 +1852,129 @@ void DemoSimApplication::USSDMenu( const QSimTermin=
alResponse& resp )
         endSession();
     }
 }
+
+void DemoSimApplication::sendSMSMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Send SMS" );
+
+    item.setIdentifier( SendSMS_Unpacked );
+    item.setLabel( "Unpacked" );
+    items +=3D item;
+
+    item.setIdentifier( SendSMS_Packed );
+    item.setLabel( "Packed text" );
+    items +=3D item;
+
+    item.setIdentifier( SendSMS_SetDestination );
+    item.setLabel( "Set destination (" + smsDestNumber + ")" );
+    items +=3D item;
+
+    item.setIdentifier( SendSMS_SetContents );
+    item.setLabel( "Set content text" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(smsMenuResp(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::smsMenuResp( const QSimTerminalResponse& resp )
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
+    case SendSMS_Unpacked:
+        break;
+
+    case SendSMS_Packed:
+        cmd.setSmsPacking( true );
+        break;
+
+    case SendSMS_SetDestination:
+        cmd.setType( QSimCommand::GetInput );
+        cmd.setText( "Enter recipient number" );
+        cmd.setWantDigits( true );
+        cmd.setMinimumLength( 2 );
+        cmd.setMaximumLength( 20 );
+        cmd.setDefaultText( smsDestNumber );
+        command( cmd, this, SLOT(smsSetDestResp(QSimTerminalResponse)) );
+        return;
+
+    case SendSMS_SetContents:
+        cmd.setType( QSimCommand::GetInput );
+        cmd.setText( "Enter message text" );
+        cmd.setMaximumLength( 100 );
+        cmd.setDefaultText( smsText );
+        command( cmd, this, SLOT(smsSetTextResp(QSimTerminalResponse)) );
+        return;
+    }
+
+    QSMSMessage sms;
+    sms.setValidityPeriod( -1 );
+    sms.setMessageClass( 2 );
+    sms.setProtocol( 0 );
+    sms.setRecipient( smsDestNumber );
+    sms.setText( smsText );
+    sms.setForceGsm( false );
+    sms.setBestScheme( QSMS_8BitAlphabet );
+    sms.setDataCodingScheme( 0xf6 );
+
+    cmd.setType( QSimCommand::SendSMS );
+    cmd.setText( "Sending an SMS to our friends at " + smsDestNumber );
+    cmd.setNumber( "123" );
+    cmd.addExtensionField( 0x8b, sms.toPdu().mid( 1 ) );
+    cmd.setDestinationDevice( QSimCommand::Network );
+
+    command( cmd, this, SLOT(endSession()) );
+}
+
+void DemoSimApplication::smsSetDestResp( const QSimTerminalResponse& resp )
+{
+    if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSMSMenu();
+
+        return;
+    }
+
+    if ( resp.result() !=3D QSimTerminalResponse::Success ) {
+        /* Unknown response - just go back to the main menu. */
+        endSession();
+
+        return;
+    }
+
+    smsDestNumber =3D resp.text();
+    sendSMSMenu();
+}
+
+void DemoSimApplication::smsSetTextResp( const QSimTerminalResponse& resp )
+{
+    if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSMSMenu();
+
+        return;
+    }
+
+    if ( resp.result() !=3D QSimTerminalResponse::Success ) {
+        /* Unknown response - just go back to the main menu. */
+        endSession();
+
+        return;
+    }
+
+    smsText =3D resp.text();
+    sendSMSMenu();
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index 9d147ee..326c4dc 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -113,10 +113,15 @@ protected slots:
     void languageMenu( const QSimTerminalResponse& resp );
     void sendUSSDMenu();
     void USSDMenu( const QSimTerminalResponse& resp );
+    void sendSMSMenu();
+    void smsMenuResp( const QSimTerminalResponse& resp );
+    void smsSetDestResp( const QSimTerminalResponse& resp );
+    void smsSetTextResp( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
     bool immediateResponse;
+    QString smsDestNumber, smsText;
 };
 =

 #endif
-- =

1.7.1.86.g0e460.dirty


--===============5609984859574988578==--

