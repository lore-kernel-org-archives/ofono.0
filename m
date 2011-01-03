Content-Type: multipart/mixed; boundary="===============4458790071840165076=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 5/5] phonesim: Add MoreTime conformance test case
Date: Mon, 03 Jan 2011 12:09:24 +0200
Message-ID: <1294049364-6621-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294049364-6621-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4458790071840165076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: badrjee <badrjee@badrjee-laptop.(none)>

---
 src/simapplication.cpp |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/simapplication.cpp b/src/simapplication.cpp
index befe358..ff49e48 100644
--- a/src/simapplication.cpp
+++ b/src/simapplication.cpp
@@ -353,6 +353,7 @@ const QString DemoSimApplication::getName()
 #define ConformanceMenu_DisplayText 1
 #define ConformanceMenu_GetInkey    2
 #define ConformanceMenu_GetInput    3
+#define ConformanceMenu_MoreTime    4
 #define ConformanceMenu_Main        20
 =

 #define NormalMenu_1_1    1
@@ -2447,6 +2448,10 @@ void DemoSimApplication::sendConformanceMenu()
     item.setLabel( "Get Input" );
     items +=3D item;
 =

+    item.setIdentifier( ConformanceMenu_MoreTime );
+    item.setLabel( "More Time" );
+    items +=3D item;
+
     item.setIdentifier( ConformanceMenu_Main );
     item.setLabel( "Return to main menu" );
     items +=3D item;
@@ -2487,6 +2492,14 @@ void DemoSimApplication::ConformanceMenu( const QSim=
TerminalResponse& resp )
         }
         break;
 =

+        case ConformanceMenu_MoreTime:
+        {
+            cmd.setType( QSimCommand::MoreTime );
+            cmd.setDestinationDevice( QSimCommand::ME );
+            command( cmd, this, SLOT(sendConformanceMenu()) );
+        }
+        break;
+
         default:
             endSession();
         break;
-- =

1.7.0.4


--===============4458790071840165076==--

