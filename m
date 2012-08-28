Content-Type: multipart/mixed; boundary="===============0524677008031257521=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 2/2] phonesim: Add GET_INPUT test case
Date: Tue, 28 Aug 2012 15:24:58 +0200
Message-ID: <1346160298-11307-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346160298-11307-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0524677008031257521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This test case is used to check the immediate digit response flag.
---
 src/conformancesimapplication.cpp |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/src/conformancesimapplication.cpp b/src/conformancesimapplicat=
ion.cpp
index baf3538..a2bd3af 100644
--- a/src/conformancesimapplication.cpp
+++ b/src/conformancesimapplication.cpp
@@ -81,11 +81,12 @@ const QString ConformanceSimApplication::getName()
 #define GetInkeyMenu_Cyrillic_Display_2  4
 #define GetInkeyMenu_Cyrillic_Entry      5
 #define GetInkeyMenu_YesNo_Response      6
-#define GetInkeyMenu_Icon                7
-#define GetInkeyMenu_Help                8
-#define GetInkeyMenu_Variable_Timeout    9
-#define GetInkeyMenu_Text_Attribute     10
-#define GetInkeyMenu_Main               11
+#define GetInkeyMenu_ImmediateResponse   7
+#define GetInkeyMenu_Icon                8
+#define GetInkeyMenu_Help                9
+#define GetInkeyMenu_Variable_Timeout   10
+#define GetInkeyMenu_Text_Attribute     11
+#define GetInkeyMenu_Main               12
 =

 #define GetInputMenu_Normal              1
 #define GetInputMenu_No_Response         2
@@ -677,6 +678,10 @@ void ConformanceSimApplication::sendGetInkeyMenu()
     item.setLabel( "Yes/No response for the input" );
     items +=3D item;
 =

+    item.setIdentifier( GetInkeyMenu_ImmediateResponse );
+    item.setLabel( "Immediate response for the digit input" );
+    items +=3D item;
+
     item.setIdentifier( GetInkeyMenu_Icon );
     item.setLabel( "Display of icon" );
     items +=3D item;
@@ -887,6 +892,16 @@ void ConformanceSimApplication::GetInkeyMenu( const QS=
imTerminalResponse& resp )
         }
         break;
 =

+        case GetInkeyMenu_ImmediateResponse:
+        {
+            cmd.setType( QSimCommand::GetInkey );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            cmd.setWantImmediateResponse( true );
+            cmd.setText( "Enter 1" );
+            command( cmd, this, SLOT(sendGetInkeyMenu()) );
+        }
+        break;
+
         case GetInkeyMenu_Icon:
         {
             sendGetInkeyIconMenu();
-- =

1.7.9.5


--===============0524677008031257521==--

