Content-Type: multipart/mixed; boundary="===============3427894503709089923=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] phonesim: Extend STK menu for BIP commands sanity testing
Date: Mon, 04 Jul 2011 18:26:00 +0200
Message-ID: <1309796760-27584-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3427894503709089923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For sanity testing regarding the BIP commands, the BIP  menu is enriched wi=
th the Open channel TCP and Open channel UDP items.
For both, the destination adress is set as the locahost port '12348'
With a TCP/UDP server listen to this destination address (like netcat), it'=
s possible to check the connection (for TCP) and the data exchange (sending=
/receiving).
---
 src/simapplication.cpp |  126 +++++++++++++++++++++++++++++++++++++++-----=
----
 1 files changed, 103 insertions(+), 23 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 119d7b2..f098b8a 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -350,11 +350,13 @@ const QString DemoSimApplication::getName()
 #define LocalInfoMenu_Time  1
 #define LocalInfoMenu_Lang  2
 =

-#define BIPMenu_OpenChannel      1
-#define BIPMenu_CloseChannel     2
-#define BIPMenu_ReceiveData      3
-#define BIPMenu_SendData         4
-#define BIPMenu_GetChannelStatus 5
+#define BIPMenu_OpenChannel_TCP        1
+#define BIPMenu_OpenChannel_UDP        2
+#define BIPMenu_CloseChannel           3
+#define BIPMenu_ReceiveData            4
+#define BIPMenu_SendData_Immediately   5
+#define BIPMenu_SendData_Store         6
+#define BIPMenu_GetChannelStatus       7
 =

 enum SendSMSMenuItems {
 	SendSMS_Unpacked =3D 1,
@@ -2377,7 +2379,7 @@ void DemoSimApplication::BIPMenu( const QSimTerminalR=
esponse& resp )
     if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
 	switch ( resp.menuItem() ) {
 =

-            case BIPMenu_OpenChannel:
+            case BIPMenu_OpenChannel_TCP:
             {
                 QByteArray bearerDesc;
                 QByteArray uti;
@@ -2392,14 +2394,64 @@ void DemoSimApplication::BIPMenu( const QSimTermina=
lResponse& resp )
                 bearerDesc +=3D 0x1F;
                 bearerDesc +=3D 0x02;
 =

-                uti +=3D 0x01;
-                uti +=3D 0xAD;
-                uti +=3D 0x9C;
+                uti +=3D 0x02; /* TCP, UICC in client mode, remote connect=
ion */
+                uti +=3D 0x30;
+                uti +=3D 0x3C; /* port 12348 */
 =

                 destAddress +=3D 0x21;
+                destAddress +=3D 0x7F; /* local host 127.0.0.1 */
+                destAddress +=3D (char) 0x00;
+                destAddress +=3D (char) 0x00;
                 destAddress +=3D 0x01;
-                destAddress +=3D 0x01;
-                destAddress +=3D 0x01;
+
+                apn +=3D 0x06;
+                apn +=3D 0x54;
+                apn +=3D 0x65;
+                apn +=3D 0x73;
+                apn +=3D 0x74;
+                apn +=3D 0x47;
+                apn +=3D 0x70;
+                apn +=3D 0x02;
+                apn +=3D 0x72;
+                apn +=3D 0x73;
+
+                cmd.setType( QSimCommand::OpenChannel );
+                cmd.setQualifier( QSimCommand::OpenChannelImmediate );
+                cmd.setText("Open channel TCP");
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
+            case BIPMenu_OpenChannel_UDP:
+            {
+                QByteArray bearerDesc;
+                QByteArray uti;
+                QByteArray destAddress;
+                QByteArray apn;
+
+                bearerDesc +=3D 0x02;
+                bearerDesc +=3D 0x03;
+                bearerDesc +=3D 0x04;
+                bearerDesc +=3D 0x03;
+                bearerDesc +=3D 0x04;
+                bearerDesc +=3D 0x1F;
+                bearerDesc +=3D 0x02;
+
+                uti +=3D 0x01; /* UDP, UICC in client mode, remote connect=
ion */
+                uti +=3D 0x30;
+                uti +=3D 0x3C; /* port 12348 */
+
+                destAddress +=3D 0x21;
+                destAddress +=3D 0x7F; /* local host 127.0.0.1 */
+                destAddress +=3D (char) 0x00;
+                destAddress +=3D (char) 0x00;
                 destAddress +=3D 0x01;
 =

                 apn +=3D 0x06;
@@ -2415,7 +2467,7 @@ void DemoSimApplication::BIPMenu( const QSimTerminalR=
esponse& resp )
 =

                 cmd.setType( QSimCommand::OpenChannel );
                 cmd.setQualifier( QSimCommand::OpenChannelImmediate );
-                cmd.setText("Open ID");
+                cmd.setText("Open channel UDP");
                 cmd.setBearerDesc(bearerDesc);
                 cmd.setBufferSize(1400);
                 cmd.setApn(apn);
@@ -2437,19 +2489,39 @@ void DemoSimApplication::BIPMenu( const QSimTermina=
lResponse& resp )
             }
             break;
 =

-            case BIPMenu_SendData:
+            case BIPMenu_SendData_Immediately:
             {
                 QByteArray data;
 =

-                data +=3D 0x01;
-                data +=3D 0x02;
-                data +=3D 0x03;
-                data +=3D 0x04;
-                data +=3D 0x05;
+                data +=3D 0x61;
+                data +=3D 0x62;
+                data +=3D 0x63;
+                data +=3D 0x64;
+                data +=3D 0x65;
 =

+                cmd.setQualifier( QSimCommand::SendDataImmediately );
                 cmd.setType( QSimCommand::SendData );
                 cmd.setDestinationDevice( QSimCommand::Channel1 );
-                cmd.setText("Send Data 1");
+                cmd.setText("Send Data Immediately");
+                cmd.addExtensionField( 0x36, data );
+                command( cmd, this, SLOT(sendBIPMenu()) );
+            }
+            break;
+
+            case BIPMenu_SendData_Store:
+            {
+                QByteArray data;
+
+                data +=3D 0x31;
+                data +=3D 0x32;
+                data +=3D 0x33;
+                data +=3D 0x34;
+                data +=3D 0x35;
+
+                cmd.setQualifier( QSimCommand::SendDataStoreData );
+                cmd.setType( QSimCommand::SendData );
+                cmd.setDestinationDevice( QSimCommand::Channel1 );
+                cmd.setText("Store Data");
                 cmd.addExtensionField( 0x36, data );
                 command( cmd, this, SLOT(sendBIPMenu()) );
             }
@@ -2489,8 +2561,12 @@ void DemoSimApplication::sendBIPMenu()
     cmd.setType( QSimCommand::SelectItem );
     cmd.setTitle( "BIP commands Menu" );
 =

-    item.setIdentifier( BIPMenu_OpenChannel );
-    item.setLabel( "Open channel" );
+    item.setIdentifier( BIPMenu_OpenChannel_TCP );
+    item.setLabel( "Open channel - TCP in client mode" );
+    items +=3D item;
+
+    item.setIdentifier( BIPMenu_OpenChannel_UDP );
+    item.setLabel( "Open channel - UDP in client mode" );
     items +=3D item;
 =

     item.setIdentifier( BIPMenu_CloseChannel );
@@ -2501,8 +2577,12 @@ void DemoSimApplication::sendBIPMenu()
     item.setLabel( "Receive data" );
     items +=3D item;
 =

-    item.setIdentifier( BIPMenu_SendData );
-    item.setLabel( "Send data" );
+    item.setIdentifier( BIPMenu_SendData_Immediately );
+    item.setLabel( "Send data - Immediately" );
+    items +=3D item;
+
+    item.setIdentifier( BIPMenu_SendData_Store );
+    item.setLabel( "Send data - Store" );
     items +=3D item;
 =

     item.setIdentifier( BIPMenu_GetChannelStatus );
-- =

1.7.1


--===============3427894503709089923==--

