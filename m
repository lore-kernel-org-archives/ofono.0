Content-Type: multipart/mixed; boundary="===============6471236750251528290=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] phonesim: Add SIM Polling commands to sim app menu.
Date: Sun, 21 Nov 2010 16:51:36 +0100
Message-ID: <1290354698-15749-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1290354698-15749-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6471236750251528290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |   66 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 9742fd9..290ec2a 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -287,6 +287,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_Language   12
 #define MainMenu_SendUSSD   13
 #define MainMenu_SendSMS    14
+#define MainMenu_Polling    15
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -352,6 +353,11 @@ enum SendSMSMenuItems {
 	SendSMS_SetContents,
 };
 =

+enum PollingMenuItems {
+	Polling_Off =3D 1,
+	Polling_30s,
+};
+
 void DemoSimApplication::mainMenu()
 {
     QSimCommand cmd;
@@ -416,6 +422,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Send SMS request" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_Polling );
+    item.setLabel( "SIM Polling" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -534,6 +544,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_Polling:
+        {
+            sendPollingMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -1978,3 +1994,53 @@ void DemoSimApplication::sendSMSSetTextResp( const Q=
SimTerminalResponse& resp )
     smsText =3D resp.text();
     sendSMSMenu();
 }
+
+void DemoSimApplication::sendPollingMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Polling Menu" );
+
+    item.setIdentifier( Polling_Off );
+    item.setLabel( "Polling Off" );
+    items +=3D item;
+
+    item.setIdentifier( Polling_30s );
+    item.setLabel( "Poll Interval of 30s" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(pollingMenuResp(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::pollingMenuResp( const QSimTerminalResponse& resp=
 )
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
+    case Polling_Off:
+        cmd.setType( QSimCommand::PollingOff );
+        cmd.setDestinationDevice( QSimCommand::ME );
+        command( cmd, this, SLOT(endSession()) );
+        break;
+
+    case Polling_30s:
+        cmd.setType( QSimCommand::PollInterval );
+        cmd.setDuration( 30000 );
+        cmd.setDestinationDevice( QSimCommand::ME );
+        command( cmd, this, SLOT(endSession()) );
+        break;
+    }
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index 326c4dc..1d6293f 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -117,6 +117,8 @@ protected slots:
     void smsMenuResp( const QSimTerminalResponse& resp );
     void smsSetDestResp( const QSimTerminalResponse& resp );
     void smsSetTextResp( const QSimTerminalResponse& resp );
+    void sendPollingMenu();
+    void pollingMenuResp( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.1.86.g0e460.dirty


--===============6471236750251528290==--

