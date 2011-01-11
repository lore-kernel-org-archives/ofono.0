Content-Type: multipart/mixed; boundary="===============2349359389545694411=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 6/6] phonesim: Add MoreTime test case
Date: Tue, 11 Jan 2011 16:16:10 +0200
Message-ID: <1294755370-12442-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294755370-12442-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2349359389545694411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/conformancesimapplication.cpp |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
index f51d36c..5eb9d07 100644
--- a/src/conformancesimapplication.cpp
+++ b/src/conformancesimapplication.cpp
@@ -40,6 +40,7 @@ const QString ConformanceSimApplication::getName()
 #define ConformanceMenu_DisplayText 1
 #define ConformanceMenu_GetInkey    2
 #define ConformanceMenu_GetInput    3
+#define ConformanceMenu_MoreTime    4
 =

 #define NormalMenu_1_1    1
 #define NormalMenu_1_2    2
@@ -119,6 +120,10 @@ void ConformanceSimApplication::mainMenu()
     item.setLabel( "Get Input" );
     items +=3D item;
 =

+    item.setIdentifier( ConformanceMenu_MoreTime );
+    item.setLabel( "More Time" );
+    items +=3D item;
+
     cmd.setMenuItems( items );
 =

     command( cmd, 0, 0 );
@@ -126,6 +131,8 @@ void ConformanceSimApplication::mainMenu()
 =

 void ConformanceSimApplication::mainMenuSelection( int id )
 {
+    QSimCommand cmd;
+
     switch ( id ) {
         case ConformanceMenu_DisplayText:
         {
@@ -145,6 +152,14 @@ void ConformanceSimApplication::mainMenuSelection( int=
 id )
         }
         break;
 =

+        case ConformanceMenu_MoreTime:
+        {
+            cmd.setType( QSimCommand::MoreTime );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            command( cmd, this, SLOT(endSession()) );
+        }
+        break;
+
         default:
         {
             // Don't know what this item is, so just re-display the main m=
enu.
-- =

1.7.0.4


--===============2349359389545694411==--

