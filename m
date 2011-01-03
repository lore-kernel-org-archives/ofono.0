Content-Type: multipart/mixed; boundary="===============9181168470245680206=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 1/5] phonesim: Add conformance test to main menu
Date: Mon, 03 Jan 2011 12:09:20 +0200
Message-ID: <1294049364-6621-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294049364-6621-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9181168470245680206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: badrjee <badrjee@badrjee-laptop.(none)>

---
 src/simapplication.cpp |   50 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simapplication.h   |    2 +
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index 14fa8c0..47b33b0 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -291,6 +291,7 @@ const QString DemoSimApplication::getName()
 #define MainMenu_Timers     16
 #define MainMenu_Refresh    17
 #define MainMenu_LocalInfo  18
+#define MainMenu_Conformance 19
 =

 #define SportsMenu_Chess        1
 #define SportsMenu_Painting     2
@@ -349,6 +350,8 @@ const QString DemoSimApplication::getName()
 #define LocalInfoMenu_Time  1
 #define LocalInfoMenu_Lang  2
 =

+#define ConformanceMenu_Main        20
+
 enum SendSMSMenuItems {
 	SendSMS_Unpacked =3D 1,
 	SendSMS_Packed,
@@ -448,6 +451,10 @@ void DemoSimApplication::mainMenu()
     item.setLabel( "Provide Local Information" );
     items +=3D item;
 =

+    item.setIdentifier( MainMenu_Conformance );
+    item.setLabel( "Conformance Test Cases" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -590,6 +597,12 @@ void DemoSimApplication::mainMenuSelection( int id )
         }
         break;
 =

+        case MainMenu_Conformance:
+        {
+            sendConformanceMenu();
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
@@ -2351,3 +2364,40 @@ void DemoSimApplication::localInfoMenu( const QSimTe=
rminalResponse& resp )
         endSession();
     }
 }
+
+void DemoSimApplication::sendConformanceMenu()
+{
+    QSimCommand cmd;
+    QSimMenuItem item;
+    QList<QSimMenuItem> items;
+
+    cmd.setType( QSimCommand::SelectItem );
+    cmd.setTitle( "Conformance Test Cases" );
+
+    item.setIdentifier( ConformanceMenu_Main );
+    item.setLabel( "Return to main menu" );
+    items +=3D item;
+
+    cmd.setMenuItems( items );
+
+    command( cmd, this, SLOT(ConformanceMenu(QSimTerminalResponse)) );
+}
+
+void DemoSimApplication::ConformanceMenu( const QSimTerminalResponse& resp=
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
+        default:
+            endSession();
+        break;
+    }
+}
diff --git a/src/simapplication.h b/src/simapplication.h
index cd93f7e..ab6a134 100644
--- a/src/simapplication.h
+++ b/src/simapplication.h
@@ -130,6 +130,8 @@ protected slots:
     void refreshMenuResp( const QSimTerminalResponse& resp );
     void sendLocalInfoMenu();
     void localInfoMenu( const QSimTerminalResponse& resp );
+    void sendConformanceMenu();
+    void ConformanceMenu( const QSimTerminalResponse& resp );
 =

 private:
     int sticksLeft;
-- =

1.7.0.4


--===============9181168470245680206==--

