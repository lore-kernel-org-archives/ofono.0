Content-Type: multipart/mixed; boundary="===============7928558218010225628=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/2] simapplication: Add a new SIM applet dedicated to BIP
 commands
Date: Tue, 22 Mar 2011 14:10:13 +0100
Message-ID: <1300799413-4479-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7928558218010225628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |  161 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 2 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 14fa8c0..e4e93ae 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -291,6 +291,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_Timers     16
 #define MainMenu_Refresh    17
 #define MainMenu_LocalInfo  18
+#define MainMenu_BIP        19
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -349,6 +350,12 @@ const QString DemoSimApplication::getName()
 #define LocalInfoMenu_Time  1
 #define LocalInfoMenu_Lang  2
 =

+#define BIPMenu_OpenChannel      1
+#define BIPMenu_CloseChannel     2
+#define BIPMenu_ReceiveData      3
+#define BIPMenu_SendData         4
+#define BIPMenu_GetChannelStatus 5
+
 enum SendSMSMenuItems {
 	SendSMS_Unpacked =3D 1,
 	SendSMS_Packed,
@@ -448,6 +455,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Provide Local Information" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_BIP );
+    item.setLabel( "BIP commands" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -590,6 +601,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_BIP:
+        {
+            sendBIPMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -2351,3 +2368,147 @@ void DemoSimApplication::localInfoMenu( const QSimT=
erminalResponse& resp )
         endSession();
     }
 }
+
+void DemoSimApplication::BIPMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case BIPMenu_OpenChannel:
+            {
+        	QByteArray bearerDesc;
+        	QByteArray uti;
+        	QByteArray destAddress;
+        	QByteArray apn;
+
+        	bearerDesc +=3D 0x02;
+        	bearerDesc +=3D 0x03;
+        	bearerDesc +=3D 0x04;
+        	bearerDesc +=3D 0x03;
+        	bearerDesc +=3D 0x04;
+        	bearerDesc +=3D 0x1F;
+        	bearerDesc +=3D 0x02;
+
+        	uti +=3D 0x01;
+        	uti +=3D 0xAD;
+        	uti +=3D 0x9C;
+
+        	destAddress +=3D 0x21;
+        	destAddress +=3D 0x01;
+        	destAddress +=3D 0x01;
+        	destAddress +=3D 0x01;
+               	destAddress +=3D 0x01;
+
+               	apn +=3D 0x06;
+               	apn +=3D 0x54;
+               	apn +=3D 0x65;
+               	apn +=3D 0x73;
+               	apn +=3D 0x74;
+               	apn +=3D 0x47;
+               	apn +=3D 0x70;
+               	apn +=3D 0x02;
+               	apn +=3D 0x72;
+               	apn +=3D 0x73;
+
+        	cmd.setType( QSimCommand::OpenChannel );
+                cmd.setQualifier( QSimCommand::OpenchannelImmediate );
+                cmd.setText("Open ID");
+                cmd.setBearerDesc(bearerDesc);
+                cmd.setBufferSize(1400);
+                cmd.setApn(apn);
+                cmd.setUserLogin("UserLog");
+                cmd.setUserPassword("UserPwd");
+                cmd.setUti(uti);
+                cmd.setDestAddress(destAddress);
+                command( cmd, this, SLOT(sendBIPMenu()) );
+            }
+            break;
+
+            case BIPMenu_ReceiveData:
+            {
+         	cmd.setType( QSimCommand::ReceiveData );
+                cmd.setDestinationDevice( QSimCommand::Channel1 );
+                cmd.setText("Receive Data 1");
+                cmd.setDataLength(200);
+                command( cmd, this, SLOT(sendBIPMenu()) );
+            }
+            break;
+
+            case BIPMenu_SendData:
+            {
+        	QByteArray data;
+
+        	data +=3D 0x01;
+        	data +=3D 0x02;
+        	data +=3D 0x03;
+        	data +=3D 0x04;
+        	data +=3D 0x05;
+
+        	cmd.setType( QSimCommand::SendData );
+                cmd.setDestinationDevice( QSimCommand::Channel1 );
+                cmd.setText("Send Data 1");
+                cmd.addExtensionField( 0x36, data );
+                command( cmd, this, SLOT(sendBIPMenu()) );
+            }
+            break;
+
+            case BIPMenu_CloseChannel:
+            {
+		cmd.setType( QSimCommand::CloseChannel );
+		cmd.setDestinationDevice( QSimCommand::Channel1 );
+		cmd.setText("Close ID 1");
+		command( cmd, this, SLOT(sendBIPMenu()) );
+            }
+            break;
+
+            case BIPMenu_GetChannelStatus:
+            {
+		cmd.setType( QSimCommand::GetChannelStatus );
+		command( cmd, this, SLOT(sendBIPMenu()) );
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
+void DemoSimApplication::sendBIPMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "BIP commands Menu" );
+
+    item.setIdentifier( BIPMenu_OpenChannel );
+    item.setLabel( "Open channel" );
+    items +=3D item;
+
+    item.setIdentifier( BIPMenu_CloseChannel );
+    item.setLabel( "Close channel" );
+    items +=3D item;
+
+    item.setIdentifier( BIPMenu_ReceiveData );
+    item.setLabel( "Receive data" );
+    items +=3D item;
+
+    item.setIdentifier( BIPMenu_SendData );
+    item.setLabel( "Send data" );
+    items +=3D item;
+
+    item.setIdentifier( BIPMenu_GetChannelStatus );
+    item.setLabel( "Get channel status" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(BIPMenu(QSimTerminalResponse)) );
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index 61250e5..b41c781 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -130,6 +130,8 @@ protected slots:
     void refreshMenuResp( const QSimTerminalResponse& resp );
     void sendLocalInfoMenu();
     void localInfoMenu( const QSimTerminalResponse& resp );
+    void sendBIPMenu();
+    void BIPMenu( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.1


--===============7928558218010225628==--

