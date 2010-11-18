Content-Type: multipart/mixed; boundary="===============3554385167343538965=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] Simulate provide local info command
Date: Thu, 18 Nov 2010 18:43:19 +0800
Message-ID: <1290076999-27809-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3554385167343538965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |  263 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 2 files changed, 265 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 7dc580f..901c5b9 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -284,6 +284,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_SendSS     11
 #define MainMenu_Language   12
 #define MainMenu_SendUSSD   13
+#define MainMenu_LocalInfo  14
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -342,6 +343,24 @@ const QString DemoSimApplication::getName()
 #define SendUSSD_Error      4
 #define SendUSSD_Main       5
 =

+#define LocalInfoMenu_Loc               1
+#define LocalInfoMenu_IMEI              2
+#define LocalInfoMenu_NMR               3
+#define LocalInfoMenu_Time              4
+#define LocalInfoMenu_Lang              5
+#define LocalInfoMenu_TimingAdvance     6
+#define LocalInfoMenu_Tech              7
+#define LocalInfoMenu_ESN               8
+#define LocalInfoMenu_IMEISV            9
+#define LocalInfoMenu_SearchMode        10
+#define LocalInfoMenu_Battery           11
+#define LocalInfoMenu_MEID              12
+#define LocalInfoMenu_WSID              13
+#define LocalInfoMenu_Broadcast         14
+#define LocalInfoMenu_Techs             15
+#define LocalInfoMenu_Locs              16
+#define LocalInfoMenu_NMRs              17
+
 void DemoSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -402,6 +421,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Send USSD" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_LocalInfo );
+    item.setLabel( "Provide Local Information" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -514,6 +537,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_LocalInfo:
+        {
+            sendLocalInfoMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -1832,3 +1861,237 @@ void DemoSimApplication::USSDMenu( const QSimTermin=
alResponse& resp )
         endSession();
     }
 }
+
+void DemoSimApplication::sendLocalInfoMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Provide Local Information" );
+
+    item.setIdentifier( LocalInfoMenu_Loc );
+    item.setLabel( "Location Information" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_IMEI );
+    item.setLabel( "IMEI" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_NMR );
+    item.setLabel( "Network Measurement results" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_Time );
+    item.setLabel( "Date, time and time zone" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_Lang );
+    item.setLabel( "Language setting" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_TimingAdvance );
+    item.setLabel( "Timing Advance" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_Tech );
+    item.setLabel( "Access Technology" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_ESN );
+    item.setLabel( "ESN" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_IMEISV );
+    item.setLabel( "IMEISV" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_SearchMode );
+    item.setLabel( "Search Mode" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_Battery );
+    item.setLabel( "Charge State of the Battery" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_MEID );
+    item.setLabel( "MEID" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_WSID );
+    item.setLabel( "WSID" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_Broadcast );
+    item.setLabel( "Broadcast Network information" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_Techs );
+    item.setLabel( "Multiple Access Technologies" );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_Locs );
+    item.setLabel( "Location Information for multiple access technologies"=
 );
+    items +=3D item;
+
+    item.setIdentifier( LocalInfoMenu_NMRs );
+    item.setLabel( "Network Measurement results for multiple access techno=
logies" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(localInfoMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::localInfoMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case LocalInfoMenu_Loc:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x00 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_IMEI:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x01 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_NMR:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x02 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_Time:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x03 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_Lang:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x04 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_TimingAdvance:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x05 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_Tech:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x06 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_ESN:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x07 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_IMEISV:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x08 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_SearchMode:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x09 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_Battery:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x0A );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_MEID:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x0B );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_WSID:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x0C );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_Broadcast:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x0D );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_Techs:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x0E );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_Locs:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x0F );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
+            }
+            break;
+
+            case LocalInfoMenu_NMRs:
+            {
+                cmd.setType( QSimCommand::ProvideLocalInformation );
+                cmd.setQualifier( 0x10 );
+                command( cmd, this, SLOT(sendLocalInfoMenu()) );
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
diff --git a/src/simapplication.h b/src/simapplication.h
index 9d147ee..933635c 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -113,6 +113,8 @@ protected slots:
     void languageMenu( const QSimTerminalResponse& resp );
     void sendUSSDMenu();
     void USSDMenu( const QSimTerminalResponse& resp );
+    void sendLocalInfoMenu();
+    void localInfoMenu ( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.2.3


--===============3554385167343538965==--

