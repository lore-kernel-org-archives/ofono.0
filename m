Content-Type: multipart/mixed; boundary="===============0943914370173181488=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/2] Add support to CNAP ss command
Date: Tue, 07 Dec 2010 16:33:12 -0200
Message-ID: <1291746792-8061-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291746792-8061-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0943914370173181488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simapplication.cpp |   80 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 62bbe9d..bd650a4 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -307,6 +307,7 @@ const QString DemoSimApplication::getName()
 #define SendSSMenu_CLIR     5
 #define SendSSMenu_CoLP     6
 #define SendSSMenu_CoLR     7
+#define SendSSMenu_CNAP     8
 =

 #define CBMenu_Activation       1
 #define CBMenu_Interrogation    2
@@ -338,6 +339,10 @@ const QString DemoSimApplication::getName()
 #define CoLRMenu_Interrogation    2
 #define CoLRMenu_Deactivation     3
 =

+#define CNAPMenu_Activation       1
+#define CNAPMenu_Interrogation    2
+#define CNAPMenu_Deactivation     3
+
 #define Language_Specific       1
 #define Language_Non_Specific   2
 #define Language_Main           3
@@ -1143,6 +1148,10 @@ void DemoSimApplication::sendSendSSMenu()
     item.setLabel( "CLIP (Calling Line Identification Presentation)" );
     items +=3D item;
 =

+    item.setIdentifier( SendSSMenu_CNAP );
+    item.setLabel( "CNAP (Calling Name Identification Presentation)" );
+    items +=3D item;
+
     item.setIdentifier( SendSSMenu_CLIR );
     item.setLabel( "CLIR (Calling Line Identification Restriction)" );
     items +=3D item;
@@ -1741,6 +1750,77 @@ void DemoSimApplication::CoLRMenu( const QSimTermina=
lResponse& resp )
     }
 }
 =

+void DemoSimApplication::sendCNAPMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "CNAP" );
+
+    item.setIdentifier( CNAPMenu_Activation );
+    item.setLabel( "Activation" );
+    items +=3D item;
+
+    item.setIdentifier( CNAPMenu_Interrogation );
+    item.setLabel( "Interrogation" );
+    items +=3D item;
+
+    item.setIdentifier( CNAPMenu_Deactivation );
+    item.setLabel( "Deactivation" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(CNAPMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::CNAPMenu( const QSimTerminalResponse& resp )
+{
+    QSimCommand cmd;
+
+    if ( resp.result() =3D=3D QSimTerminalResponse::Success ) {
+        switch ( resp.menuItem() ) {
+
+            case CNAPMenu_Activation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*300#" );
+                command( cmd, this, SLOT(sendCNAPMenu()) );
+            }
+            break;
+
+            case CNAPMenu_Interrogation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "*#300#" );
+                command( cmd, this, SLOT(sendCNAPMenu()) );
+            }
+            break;
+
+            case CNAPMenu_Deactivation:
+            {
+                cmd.setType( QSimCommand::SendSS );
+                cmd.setDestinationDevice( QSimCommand::Network );
+                cmd.setNumber( "#300#" );
+                command( cmd, this, SLOT(sendCNAPMenu()) );
+            }
+            break;
+
+            default:
+                endSession();
+                break;
+        }
+    } else if ( resp.result() =3D=3D QSimTerminalResponse::BackwardMove ) {
+        sendSendSSMenu();
+    } else {
+        endSession();
+    }
+}
+
 void DemoSimApplication::sendLanguageMenu()
 {
     QSimCommand cmd;
diff --git a/src/simapplication.h b/src/simapplication.h
index df36bbb..75e23cc 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -111,6 +111,8 @@ protected slots:
     void CoLPMenu( const QSimTerminalResponse& resp );
     void sendCoLRMenu();
     void CoLRMenu( const QSimTerminalResponse& resp );
+    void sendCNAPMenu();
+    void CNAPMenu( const QSimTerminalResponse& resp );
     void sendLanguageMenu();
     void languageMenu( const QSimTerminalResponse& resp );
     void sendUSSDMenu();
-- =

1.7.3.2


--===============0943914370173181488==--

